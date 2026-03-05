"""
get_doc_section tool — retrieve a specific section or the whole doc.
"""

from lib.sandbox import Sandbox, SandboxError
from lib.markdown_parser import extract_section

MAX_CONTENT_LENGTH = 50_000  # ~50 KB cap per response


def handle(sandbox: Sandbox, arguments: dict) -> dict:
    path = arguments.get("path", "")
    heading = arguments.get("heading")

    try:
        full_path = sandbox.resolve(path)
    except SandboxError as e:
        return {"error": str(e)}

    with open(full_path, "r", encoding="utf-8", errors="replace") as f:
        content = f.read()

    truncated = False

    if heading:
        section, all_headings = extract_section(content, heading)
        if section is None:
            # Heading not found — return available headings for discovery
            return {
                "path": path,
                "heading": heading,
                "content": None,
                "content_length": 0,
                "available_headings": all_headings,
                "truncated": False,
            }
        if len(section) > MAX_CONTENT_LENGTH:
            section = section[:MAX_CONTENT_LENGTH]
            truncated = True
        return {
            "path": path,
            "heading": heading,
            "content": section,
            "content_length": len(section),
            "available_headings": None,
            "truncated": truncated,
        }
    else:
        # No heading specified — return whole doc
        if len(content) > MAX_CONTENT_LENGTH:
            content = content[:MAX_CONTENT_LENGTH]
            truncated = True
        return {
            "path": path,
            "heading": None,
            "content": content,
            "content_length": len(content),
            "available_headings": None,
            "truncated": truncated,
        }
