"""
Tests for the search_docs tool.
"""

import os
import sys
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from lib.sandbox import Sandbox
from tools import search_docs


@pytest.fixture(autouse=True)
def reset_search_index():
    """Reset the cached search index between tests."""
    search_docs._index = None
    yield
    search_docs._index = None


@pytest.fixture
def docs_sandbox(tmp_path):
    (tmp_path / "spec.md").write_text(
        "# Spec\n\nremainingMinutes is the primary value. "
        "remainingMinutes is computed using floor rounding. "
        "remainingMinutes = (dailyAllowanceMinutes + bonusMinutesFromGames) - floor(usageMinutesToday)."
    )
    (tmp_path / "architecture.md").write_text(
        "# Architecture\n\n## State Management\n\nGlobal state uses Observable models.\n\n"
        "## Remaining Minutes Calculation\n\nremainingMinutes is derived."
    )
    (tmp_path / "styling.md").write_text(
        "# Styling\n\nTypography tokens. Brand palette. No remainingMinutes here... "
        "actually remainingMinutes appears once."
    )
    return Sandbox(str(tmp_path))


class TestSearchDocs:
    def test_basic_keyword_match(self, docs_sandbox):
        result = search_docs.handle(docs_sandbox, {"query": "remainingMinutes"})
        assert result["total_matches"] >= 1
        paths = [r["path"] for r in result["results"]]
        assert "spec.md" in paths

    def test_ranking_by_term_frequency(self, docs_sandbox):
        """Doc with more occurrences of the term should rank higher."""
        result = search_docs.handle(docs_sandbox, {"query": "remainingMinutes"})
        assert len(result["results"]) >= 2
        # spec.md mentions it 3 times, should rank first
        assert result["results"][0]["path"] == "spec.md"

    def test_no_results_for_garbage(self, docs_sandbox):
        result = search_docs.handle(docs_sandbox, {"query": "xyzzy123gibberish"})
        assert result["total_matches"] == 0
        assert result["results"] == []

    def test_top_k_limit(self, docs_sandbox):
        result = search_docs.handle(docs_sandbox, {"query": "remainingMinutes", "top_k": 1})
        assert len(result["results"]) <= 1

    def test_empty_query(self, docs_sandbox):
        result = search_docs.handle(docs_sandbox, {"query": ""})
        assert result["total_matches"] == 0

    def test_snippets_present(self, docs_sandbox):
        result = search_docs.handle(docs_sandbox, {"query": "remainingMinutes"})
        for r in result["results"]:
            assert isinstance(r["snippets"], list)

    def test_matched_headings(self, docs_sandbox):
        result = search_docs.handle(docs_sandbox, {"query": "remaining"})
        arch_result = [r for r in result["results"] if r["path"] == "architecture.md"]
        if arch_result:
            assert "Remaining Minutes Calculation" in arch_result[0]["matched_headings"]
