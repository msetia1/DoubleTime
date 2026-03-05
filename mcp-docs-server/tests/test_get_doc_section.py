"""
Tests for the get_doc_section tool.
"""

import os
import sys
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from lib.sandbox import Sandbox
from tools.get_doc_section import handle

SAMPLE_DOC = """\
# Architecture

Overview paragraph.

## State Management

State management uses SwiftUI + iOS 17 Observation.

- Global state lives in Core/State as @Observable models.
- Views consume global state via Environment.

### Global Models

AppModel is the root container.

## Lock / Unlock Policy and UX

Single Lock/Unlock control for restricted apps.

## Persistence

UserDefaults + Codable persist values.
"""


@pytest.fixture
def docs_sandbox(tmp_path):
    (tmp_path / "architecture.md").write_text(SAMPLE_DOC)
    (tmp_path / "spec.md").write_text("# Spec\n\nBasic spec content.")
    return Sandbox(str(tmp_path))


class TestGetDocSection:
    def test_exact_heading_match(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "architecture.md", "heading": "State Management"})
        assert result["content"] is not None
        assert "SwiftUI" in result["content"]
        assert result["heading"] == "State Management"

    def test_heading_not_found_returns_available(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "architecture.md", "heading": "Nonexistent"})
        assert result["content"] is None
        assert result["content_length"] == 0
        assert "State Management" in result["available_headings"]
        assert "Persistence" in result["available_headings"]

    def test_no_heading_returns_full_doc(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "architecture.md"})
        assert result["heading"] is None
        assert "# Architecture" in result["content"]
        assert "Persistence" in result["content"]

    def test_partial_heading_match(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "architecture.md", "heading": "lock policy"})
        assert result["content"] is not None
        assert "Lock/Unlock" in result["content"]

    def test_case_insensitive_match(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "architecture.md", "heading": "state management"})
        assert result["content"] is not None

    def test_invalid_path(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "nonexistent.md"})
        assert "error" in result

    def test_path_traversal_blocked(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "../etc/passwd"})
        assert "error" in result

    def test_truncation_flag(self, docs_sandbox):
        result = handle(docs_sandbox, {"path": "architecture.md"})
        assert result["truncated"] is False
