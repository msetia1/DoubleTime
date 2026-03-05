"""
Tests for the sandbox module — path traversal prevention.
"""

import os
import tempfile
import pytest

# Adjust path so imports work from project root
import sys
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from lib.sandbox import Sandbox, SandboxError


@pytest.fixture
def sandbox(tmp_path):
    """Create a temp docs directory with some test files."""
    (tmp_path / "readme.md").write_text("# Readme")
    (tmp_path / "sub").mkdir()
    (tmp_path / "sub" / "nested.md").write_text("# Nested")
    (tmp_path / ".DS_Store").write_text("binary junk")
    (tmp_path / "notes.txt").write_text("Some notes")
    return Sandbox(str(tmp_path))


class TestResolve:
    def test_valid_file(self, sandbox, tmp_path):
        result = sandbox.resolve("readme.md")
        assert result == os.path.join(sandbox.root, "readme.md")

    def test_valid_nested_file(self, sandbox, tmp_path):
        result = sandbox.resolve("sub/nested.md")
        assert result.endswith("sub/nested.md")

    def test_parent_traversal_blocked(self, sandbox):
        with pytest.raises(SandboxError, match="Path traversal blocked"):
            sandbox.resolve("../etc/passwd")

    def test_absolute_path_blocked(self, sandbox):
        with pytest.raises(SandboxError, match="Path traversal blocked"):
            sandbox.resolve("/etc/passwd")

    def test_double_dot_in_middle_blocked(self, sandbox):
        with pytest.raises(SandboxError, match="Path traversal"):
            sandbox.resolve("sub/../../etc/passwd")

    def test_empty_path_blocked(self, sandbox):
        with pytest.raises(SandboxError, match="Empty path"):
            sandbox.resolve("")

    def test_null_byte_blocked(self, sandbox):
        with pytest.raises(SandboxError, match="Null bytes"):
            sandbox.resolve("file\x00.md")

    def test_nonexistent_file(self, sandbox):
        with pytest.raises(SandboxError, match="File not found"):
            sandbox.resolve("does_not_exist.md")

    def test_symlink_escape(self, sandbox, tmp_path):
        """Symlink inside docs root pointing outside should be blocked."""
        target = tempfile.mktemp()  # Path outside docs root
        with open(target, "w") as f:
            f.write("secret")
        try:
            link_path = tmp_path / "evil_link.md"
            os.symlink(target, str(link_path))
            with pytest.raises(SandboxError, match="Path traversal blocked"):
                sandbox.resolve("evil_link.md")
        finally:
            os.unlink(target)


class TestListAllFiles:
    def test_lists_md_and_txt(self, sandbox):
        files = sandbox.list_all_files()
        paths = [f["path"] for f in files]
        assert "readme.md" in paths
        assert "notes.txt" in paths

    def test_ignores_dotfiles(self, sandbox):
        files = sandbox.list_all_files()
        paths = [f["path"] for f in files]
        assert ".DS_Store" not in paths

    def test_includes_nested_files(self, sandbox):
        files = sandbox.list_all_files()
        paths = [f["path"] for f in files]
        nested = [p for p in paths if "nested" in p]
        assert len(nested) == 1

    def test_category_assignment(self, sandbox):
        files = sandbox.list_all_files()
        for f in files:
            if "/" in f["path"] or os.sep in f["path"]:
                assert f["category"] != "root"
            else:
                assert f["category"] == "root"

    def test_empty_directory(self, tmp_path):
        empty_dir = tmp_path / "empty"
        empty_dir.mkdir()
        s = Sandbox(str(empty_dir))
        files = s.list_all_files()
        assert files == []

    def test_invalid_root(self):
        with pytest.raises(SandboxError, match="does not exist"):
            Sandbox("/nonexistent/path/that/surely/does/not/exist")
