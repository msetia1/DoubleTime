"""
Tests for the get_design_tokens tool.
"""

import os
import sys
import pytest

sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))

from tools.get_design_tokens import handle

SAMPLE_PALETTE = """\
import SwiftUI

enum BrandPalette {
    static let accentStart = Color(red: 0x82 / 255, green: 0x02 / 255, blue: 0x63 / 255)
    static let ink = Color(red: 0x2E / 255, green: 0x29 / 255, blue: 0x4E / 255)
}
"""

SAMPLE_TYPOGRAPHY = """\
import SwiftUI

enum Typography {
    enum Token {
        static func heroMetric() -> Font { .largeTitle }
        static func body() -> Font { .body }
    }
}
"""

SAMPLE_BUTTON_STYLE = """\
import SwiftUI

struct BrandedActionButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
"""


@pytest.fixture
def project_with_design_files(tmp_path):
    """Create a fake project with Core/Design/ Swift files."""
    design_dir = tmp_path / "Core" / "Design"
    design_dir.mkdir(parents=True)
    (design_dir / "BrandPalette.swift").write_text(SAMPLE_PALETTE)
    (design_dir / "Typography.swift").write_text(SAMPLE_TYPOGRAPHY)
    (design_dir / "BrandedActionButtonStyle.swift").write_text(SAMPLE_BUTTON_STYLE)
    return str(tmp_path)


class TestGetDesignTokens:
    def test_get_palette(self, project_with_design_files):
        result = handle(project_with_design_files, {"file": "palette"})
        assert result["file"] == "palette"
        assert "BrandPalette" in result["content"]
        assert "accentStart" in result["content"]

    def test_get_typography(self, project_with_design_files):
        result = handle(project_with_design_files, {"file": "typography"})
        assert result["file"] == "typography"
        assert "Typography" in result["content"]
        assert "heroMetric" in result["content"]

    def test_get_button_style(self, project_with_design_files):
        result = handle(project_with_design_files, {"file": "button_style"})
        assert result["file"] == "button_style"
        assert "BrandedActionButtonStyle" in result["content"]

    def test_unknown_file_key(self, project_with_design_files):
        result = handle(project_with_design_files, {"file": "nonexistent"})
        assert "error" in result
        assert "available_files" in result
        assert "palette" in result["available_files"]

    def test_missing_file_key(self, project_with_design_files):
        result = handle(project_with_design_files, {})
        assert "error" in result

    def test_file_not_on_disk(self, tmp_path):
        """If the Swift file doesn't exist on disk, return an error."""
        result = handle(str(tmp_path), {"file": "palette"})
        assert "error" in result
        assert "not found" in result["error"].lower()

    def test_returns_content_length(self, project_with_design_files):
        result = handle(project_with_design_files, {"file": "palette"})
        assert result["content_length"] == len(result["content"])
