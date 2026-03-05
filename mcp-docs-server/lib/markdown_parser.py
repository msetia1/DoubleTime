"""
Markdown parser — heading extraction, title detection, section slicing.

Used by get_doc_section and other tools to navigate markdown structure.
"""

import re


def extract_title(content: str, filename: str) -> str:
    """
    Extract document title.
    Priority: YAML frontmatter title > first H1 > filename.
    """
    # Try YAML frontmatter
    fm_match = re.match(r"^---\s*\n(.*?)\n---", content, re.DOTALL)
    if fm_match:
        for line in fm_match.group(1).split("\n"):
            if line.strip().startswith("title:"):
                return line.split(":", 1)[1].strip().strip("\"'")

    # Try first H1
    h1_match = re.search(r"^#\s+(.+)", content, re.MULTILINE)
    if h1_match:
        return h1_match.group(1).strip()

    # Fallback to filename
    return filename.replace(".md", "").replace(".txt", "").replace("-", " ").replace("_", " ").title()


def parse_headings(content: str) -> list[dict]:
    """
    Parse all markdown headings from content.

    Returns list of dicts:
        level: int (1-6)
        title: str
        start_line: int (0-indexed)
        end_line: int (0-indexed, inclusive)
    """
    lines = content.split("\n")
    headings = []

    for i, line in enumerate(lines):
        match = re.match(r"^(#{1,6})\s+(.+)", line)
        if match:
            headings.append({
                "level": len(match.group(1)),
                "title": match.group(2).strip(),
                "start_line": i,
                "end_line": None,
            })

    # Fill end_line: section ends when a heading of same or higher level
    # (lower number) appears, or at EOF
    for idx, h in enumerate(headings):
        for next_h in headings[idx + 1:]:
            if next_h["level"] <= h["level"]:
                h["end_line"] = next_h["start_line"] - 1
                break
        if h["end_line"] is None:
            h["end_line"] = len(lines) - 1

    return headings


def extract_section(content: str, heading_query: str) -> tuple[str | None, list[str]]:
    """
    Find a section by heading (case-insensitive).
    Tries exact match first, then substring match.

    Returns:
        (section_content, all_heading_titles)
        If no match: (None, all_heading_titles) for discovery.
    """
    headings = parse_headings(content)
    all_titles = [h["title"] for h in headings]
    lines = content.split("\n")

    query_lower = heading_query.lower()

    # Pass 1: exact match (case-insensitive)
    for h in headings:
        if h["title"].lower() == query_lower:
            section = "\n".join(lines[h["start_line"]:h["end_line"] + 1])
            return section.strip(), all_titles

    # Pass 2: substring match
    for h in headings:
        if query_lower in h["title"].lower():
            section = "\n".join(lines[h["start_line"]:h["end_line"] + 1])
            return section.strip(), all_titles

    # No match
    return None, all_titles
