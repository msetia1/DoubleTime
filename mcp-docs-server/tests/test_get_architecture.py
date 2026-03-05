"""
Tests for the get_architecture_overview tool.
"""

import os
import sys
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from lib.sandbox import Sandbox
from tools.get_architecture import handle


@pytest.fixture
def sandbox_with_arch(tmp_path):
    (tmp_path / "architecture.md").write_text(
        "# Architecture\n\nSystem structure.\n\n"
        "See spec.md for product rules. See data_flow.md for sequences."
    )
    (tmp_path / "spec.md").write_text("# Spec\n\nProduct rules.")
    (tmp_path / "data_flow.md").write_text("# Data Flow\n\nEvent sequences.")
    return Sandbox(str(tmp_path))


@pytest.fixture
def sandbox_without_arch(tmp_path):
    (tmp_path / "spec.md").write_text("# Spec\n\nProduct rules.")
    (tmp_path / "styling.md").write_text("# Styling\n\nVisual standards.")
    return Sandbox(str(tmp_path))


class TestGetArchitectureOverview:
    def test_canonical_found(self, sandbox_with_arch):
        result = handle(sandbox_with_arch, {})
        assert result["source"] == "canonical"
        assert "# Architecture" in result["content"]

    def test_related_docs_extracted(self, sandbox_with_arch):
        result = handle(sandbox_with_arch, {})
        assert "spec.md" in result["related_docs"]
        assert "data_flow.md" in result["related_docs"]

    def test_no_self_reference(self, sandbox_with_arch):
        result = handle(sandbox_with_arch, {})
        assert "architecture.md" not in result["related_docs"]

    def test_synthesized_fallback(self, sandbox_without_arch):
        result = handle(sandbox_without_arch, {})
        assert result["source"] == "synthesized"
        assert "Auto-Generated" in result["content"]
        assert "spec.md" in result["related_docs"]

    def test_synthesized_includes_doc_summaries(self, sandbox_without_arch):
        result = handle(sandbox_without_arch, {})
        assert "Spec" in result["content"]
        assert "Styling" in result["content"]

    def test_truncated_flag(self, sandbox_with_arch):
        result = handle(sandbox_with_arch, {})
        assert result["truncated"] is False
