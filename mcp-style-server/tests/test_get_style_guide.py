"""
Tests for the get_style_guide tool.
"""

import os
import sys
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from tools.get_style_guide import handle

# A minimal styling.md for testing
SAMPLE_STYLE_DOC = """\
# Styling

This document defines a minimal styling system.

## Brand Palette

- #820263
- #D90368
- #2E294E

## Typography

Font family: Outfit (bundled)

Use Typography.swift tokens everywhere.

### Token Usage

- Hero metric: Typography.Token.heroMetric()
- Body: Typography.Token.body()

## Spacing and Layout

Spacing scale:
- 4: micro
- 8: tight
- 16: default padding

## Motion and Animation

Durations:
- Tap feedback: 0.12-0.18s
- State transitions: 0.20-0.30s
"""


@pytest.fixture
def project_with_style_guide(tmp_path):
    """Create a fake project with a docs/styling.md file."""
    docs_dir = tmp_path / "docs"
    docs_dir.mkdir()
    (docs_dir / "styling.md").write_text(SAMPLE_STYLE_DOC)
    return str(tmp_path)


class TestGetStyleGuide:
    def test_full_guide(self, project_with_style_guide):
        result = handle(project_with_style_guide, {})
        assert result["section"] is None
        assert "# Styling" in result["content"]
        assert "Brand Palette" in result["content"]
        assert "Typography" in result["content"]
        assert result["truncated"] is False

    def test_exact_section_match(self, project_with_style_guide):
        result = handle(project_with_style_guide, {"section": "Brand Palette"})
        assert result["content"] is not None
        assert "#820263" in result["content"]
        assert result["section"] == "Brand Palette"

    def test_case_insensitive_match(self, project_with_style_guide):
        result = handle(project_with_style_guide, {"section": "brand palette"})
        assert result["content"] is not None
        assert "#820263" in result["content"]

    def test_partial_match(self, project_with_style_guide):
        result = handle(project_with_style_guide, {"section": "spacing"})
        assert result["content"] is not None
        assert "Spacing scale" in result["content"]

    def test_section_not_found(self, project_with_style_guide):
        result = handle(project_with_style_guide, {"section": "Nonexistent"})
        assert result["content"] is None
        assert result["content_length"] == 0
        assert "Brand Palette" in result["available_sections"]
        assert "Typography" in result["available_sections"]

    def test_missing_style_guide(self, tmp_path):
        """If the styling.md file doesn't exist, return an error."""
        result = handle(str(tmp_path), {})
        assert "error" in result

    def test_typography_section_includes_subsections(self, project_with_style_guide):
        """## Typography should include its ### Token Usage subsection."""
        result = handle(project_with_style_guide, {"section": "Typography"})
        assert result["content"] is not None
        assert "Token Usage" in result["content"]
        assert "heroMetric" in result["content"]
