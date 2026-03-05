"""
list_docs tool — returns a manifest of all documentation files.
"""

from datetime import datetime, timezone

from lib.sandbox import Sandbox
from lib.markdown_parser import extract_title


def handle(sandbox: Sandbox, arguments: dict) -> dict:
    category_filter = arguments.get("category")
    files = sandbox.list_all_files()

    if category_filter:
        files = [f for f in files if f["category"] == category_filter]

    results = []
    for f in files:
        full_path = sandbox.resolve(f["path"])
        with open(full_path, "r", encoding="utf-8", errors="replace") as fh:
            head = fh.read(500)  # Only read enough for title extraction

        title = extract_title(head, f["path"].split("/")[-1])

        results.append({
            "path": f["path"],
            "size_bytes": f["size_bytes"],
            "modified": datetime.fromtimestamp(
                f["modified"], tz=timezone.utc
            ).isoformat(),
            "title": title,
            "category": f["category"],
        })

    return {
        "docs_root": sandbox.root,
        "total": len(results),
        "files": results,
    }
