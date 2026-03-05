"""
Tests for the list_docs tool.
"""

import os
import sys
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from lib.sandbox import Sandbox
from tools.list_docs import handle


@pytest.fixture
def docs_sandbox(tmp_path):
    """Create a realistic mini docs directory."""
    (tmp_path / "spec.md").write_text("# Spec\n\nProduct rules.")
    (tmp_path / "architecture.md").write_text("# Architecture\n\nSystem structure.")
    (tmp_path / "games").mkdir()
    (tmp_path / "games" / "crash.md").write_text("# Crash Overview\n\nRising multiplier.")
    (tmp_path / "games" / "plinko.md").write_text("# Plinko Overview\n\nBall drop.")
    (tmp_path / ".DS_Store").write_text("junk")
    return Sandbox(str(tmp_path))


class TestListDocs:
    def test_lists_all_md_files(self, docs_sandbox):
        result = handle(docs_sandbox, {})
        assert result["total"] == 4
        paths = [f["path"] for f in result["files"]]
        assert "spec.md" in paths
        assert "architecture.md" in paths

    def test_includes_nested_files(self, docs_sandbox):
        result = handle(docs_sandbox, {})
        paths = [f["path"] for f in result["files"]]
        nested = [p for p in paths if "crash" in p]
        assert len(nested) == 1

    def test_category_filter(self, docs_sandbox):
        result = handle(docs_sandbox, {"category": "games"})
        assert result["total"] == 2
        for f in result["files"]:
            assert f["category"] == "games"

    def test_category_filter_no_match(self, docs_sandbox):
        result = handle(docs_sandbox, {"category": "nonexistent"})
        assert result["total"] == 0
        assert result["files"] == []

    def test_excludes_dotfiles(self, docs_sandbox):
        result = handle(docs_sandbox, {})
        paths = [f["path"] for f in result["files"]]
        assert ".DS_Store" not in paths

    def test_title_extraction(self, docs_sandbox):
        result = handle(docs_sandbox, {})
        titles = {f["path"]: f["title"] for f in result["files"]}
        assert titles["spec.md"] == "Spec"
        assert "Crash" in titles.get("games/crash.md", "")

    def test_has_metadata_fields(self, docs_sandbox):
        result = handle(docs_sandbox, {})
        for f in result["files"]:
            assert "size_bytes" in f
            assert "modified" in f
            assert "category" in f
            assert "title" in f
