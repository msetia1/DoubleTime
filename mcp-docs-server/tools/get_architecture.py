"""
get_architecture_overview tool — return canonical architecture doc or synthesize one.
"""

import re

from lib.sandbox import Sandbox, SandboxError
from lib.markdown_parser import extract_title

CANONICAL_PATH = "architecture.md"
MAX_CONTENT_LENGTH = 50_000


def handle(sandbox: Sandbox, arguments: dict) -> dict:
    # Try canonical file first
    try:
        full_path = sandbox.resolve(CANONICAL_PATH)
        with open(full_path, "r", encoding="utf-8", errors="replace") as f:
            content = f.read()

        truncated = len(content) > MAX_CONTENT_LENGTH
        if truncated:
            content = content[:MAX_CONTENT_LENGTH]

        related = _find_related_docs(content)

        return {
            "source": "canonical",
            "content": content,
            "related_docs": related,
            "truncated": truncated,
        }
    except SandboxError:
        pass

    # Fallback: synthesize from top-level docs
    return _synthesize(sandbox)


def _find_related_docs(content: str) -> list[str]:
    """Extract references to other .md files mentioned in the content."""
    # Match patterns like spec.md, data_flow.md, Docs/styling.md
    refs = re.findall(r"(?:Docs/)?(\w[\w/.-]*\.md)", content)
    # Normalize: strip Docs/ prefix if present
    cleaned = set()
    for r in refs:
        r = r.removeprefix("Docs/")
        if r != CANONICAL_PATH:  # Don't self-reference
            cleaned.add(r)
    return sorted(cleaned)


def _synthesize(sandbox: Sandbox) -> dict:
    """
    Build a summary by reading the first heading + first paragraph
    of each top-level doc.
    """
    files = sandbox.list_all_files()
    root_docs = [f for f in files if f["category"] == "root"]

    lines = ["# Architecture Overview (Auto-Generated)", ""]
    for f in root_docs:
        full = sandbox.resolve(f["path"])
        with open(full, "r", encoding="utf-8", errors="replace") as fh:
            head = fh.read(1000)

        title = extract_title(head, f["path"])

        # Get first non-empty, non-heading, non-separator line as summary
        summary_line = ""
        for line in head.split("\n"):
            stripped = line.strip()
            if stripped and not stripped.startswith("#") and not stripped.startswith("---"):
                summary_line = stripped
                break

        lines.append(f"## {title} (`{f['path']}`)")
        lines.append(summary_line)
        lines.append("")

    return {
        "source": "synthesized",
        "content": "\n".join(lines),
        "related_docs": [f["path"] for f in root_docs],
        "truncated": False,
    }
