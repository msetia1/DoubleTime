"""
search_docs tool — full-text search across all documentation.
"""

from lib.sandbox import Sandbox
from lib.search_engine import SearchIndex
from lib.markdown_parser import extract_title

# Module-level cache — index is built once per server lifetime
_index: SearchIndex | None = None


def _ensure_index(sandbox: Sandbox) -> SearchIndex:
    global _index
    if _index is not None:
        return _index

    _index = SearchIndex()
    for f in sandbox.list_all_files():
        full = sandbox.resolve(f["path"])
        with open(full, "r", encoding="utf-8", errors="replace") as fh:
            content = fh.read()
        _index.add_document(f["path"], content)
    _index.build()
    return _index


def handle(sandbox: Sandbox, arguments: dict) -> dict:
    query = arguments.get("query", "")
    top_k = min(arguments.get("top_k", 5), 20)

    if not query.strip():
        return {"query": query, "total_matches": 0, "results": []}

    index = _ensure_index(sandbox)
    raw_results = index.search(query, top_k=top_k)

    # Enrich with titles
    for r in raw_results:
        full = sandbox.resolve(r["path"])
        with open(full, "r", encoding="utf-8", errors="replace") as fh:
            head = fh.read(500)
        r["title"] = extract_title(head, r["path"].split("/")[-1])

    return {
        "query": query,
        "total_matches": len(raw_results),
        "results": raw_results,
    }
