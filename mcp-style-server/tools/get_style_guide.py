"""
get_style_guide tool — returns the DoubleTime style guide or a specific section.

How it works:
1. Reads docs/styling.md from the project
2. If a section name is provided (e.g. "Typography"), it finds that heading
   in the markdown and returns just that section
3. If no section is provided, returns the full document

The section matching is case-insensitive and supports partial matches,
so "typography" matches "## Typography" and "spacing" matches "## Spacing and Layout".
"""

import os
import re


# Maximum characters to return in a single response
MAX_CONTENT_LENGTH = 50_000

# Path to the style guide relative to PROJECT_ROOT
STYLE_GUIDE_PATH = os.path.join("docs", "styling.md")


def handle(project_root: str, arguments: dict) -> dict:
    """
    Main handler — called by server.py when the AI invokes this tool.

    Args:
        project_root: Absolute path to the DoubleTime project
        arguments: Dict with optional "section" key
    """
    section_query = arguments.get("section")

    # Build the full path to styling.md
    full_path = os.path.join(project_root, STYLE_GUIDE_PATH)
    full_path = os.path.realpath(full_path)

    if not os.path.isfile(full_path):
        return {"error": f"Style guide not found at {STYLE_GUIDE_PATH}"}

    with open(full_path, "r", encoding="utf-8") as f:
        content = f.read()

    # If no section requested, return the full document
    if not section_query:
        truncated = len(content) > MAX_CONTENT_LENGTH
        if truncated:
            content = content[:MAX_CONTENT_LENGTH]
        return {
            "path": STYLE_GUIDE_PATH,
            "section": None,
            "content": content,
            "content_length": len(content),
            "truncated": truncated,
        }

    # Try to extract the requested section
    section_text, all_headings = _extract_section(content, section_query)

    if section_text is None:
        # Section not found — return available headings so the AI can retry
        return {
            "path": STYLE_GUIDE_PATH,
            "section": section_query,
            "content": None,
            "content_length": 0,
            "available_sections": all_headings,
            "truncated": False,
        }

    truncated = len(section_text) > MAX_CONTENT_LENGTH
    if truncated:
        section_text = section_text[:MAX_CONTENT_LENGTH]

    return {
        "path": STYLE_GUIDE_PATH,
        "section": section_query,
        "content": section_text,
        "content_length": len(section_text),
        "available_sections": None,
        "truncated": truncated,
    }


def _extract_section(content: str, query: str) -> tuple:
    """
    Find a section in the markdown by heading.

    A "section" = everything from a heading line until the next heading of the
    same or higher level (e.g. ## Typography includes everything until the next ##).

    Returns (section_text, all_heading_titles).
    If no match: (None, all_heading_titles).
    """
    headings = _parse_headings(content)
    all_titles = [h["title"] for h in headings]
    lines = content.split("\n")
    query_lower = query.lower()

    # Pass 1: exact match (case-insensitive)
    for h in headings:
        if h["title"].lower() == query_lower:
            section = "\n".join(lines[h["start_line"]:h["end_line"] + 1])
            return section.strip(), all_titles

    # Pass 2: substring match (so "spacing" matches "Spacing and Layout")
    for h in headings:
        if query_lower in h["title"].lower():
            section = "\n".join(lines[h["start_line"]:h["end_line"] + 1])
            return section.strip(), all_titles

    return None, all_titles


def _parse_headings(content: str) -> list[dict]:
    """
    Parse all markdown headings and figure out where each section starts/ends.

    For example, in:
        ## Typography       (line 10)
        ...content...
        ## Spacing           (line 25)

    Typography's section is lines 10-24.
    """
    lines = content.split("\n")
    headings = []

    for i, line in enumerate(lines):
        match = re.match(r"^(#{1,6})\s+(.+)", line)
        if match:
            headings.append({
                "level": len(match.group(1)),  # ## = level 2, ### = level 3
                "title": match.group(2).strip(),
                "start_line": i,
                "end_line": None,
            })

    # Fill in end_line: a section ends when the next heading of same or
    # higher level appears (lower number = higher level in markdown)
    for idx, h in enumerate(headings):
        for next_h in headings[idx + 1:]:
            if next_h["level"] <= h["level"]:
                h["end_line"] = next_h["start_line"] - 1
                break
        if h["end_line"] is None:
            h["end_line"] = len(lines) - 1

    return headings
