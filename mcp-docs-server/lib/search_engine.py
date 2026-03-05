"""
Search engine — lightweight in-memory TF-IDF search over doc contents.

No external dependencies. Rebuilt once per server lifetime from the docs root.
"""

import re
import math
from collections import Counter


def tokenize(text: str) -> list[str]:
    """Lowercase, split on non-alphanumeric, drop tokens shorter than 2 chars."""
    return [t for t in re.split(r"[^a-zA-Z0-9]+", text.lower()) if len(t) >= 2]


class SearchIndex:
    """In-memory TF-IDF-lite search index."""

    def __init__(self):
        self.docs: dict[str, str] = {}           # path → full content
        self.doc_tokens: dict[str, list[str]] = {}  # path → token list
        self.idf: dict[str, float] = {}

    def add_document(self, path: str, content: str):
        self.docs[path] = content
        self.doc_tokens[path] = tokenize(content)

    def build(self):
        """Compute IDF scores. Call after all documents are added."""
        n = len(self.docs)
        if n == 0:
            return

        df: Counter = Counter()
        for tokens in self.doc_tokens.values():
            unique = set(tokens)
            for t in unique:
                df[t] += 1

        self.idf = {
            t: math.log((n + 1) / (count + 1)) + 1
            for t, count in df.items()
        }

    def search(self, query: str, top_k: int = 5) -> list[dict]:
        """
        Search for query across all indexed documents.

        Returns list of dicts: path, score, snippets, matched_headings.
        Sorted by score descending, then path ascending for determinism.
        """
        query_tokens = tokenize(query)
        if not query_tokens:
            return []

        scores: dict[str, float] = {}
        for path, doc_tokens in self.doc_tokens.items():
            tf = Counter(doc_tokens)
            doc_len = len(doc_tokens) or 1
            score = 0.0
            for qt in query_tokens:
                if qt in tf:
                    term_tf = tf[qt] / doc_len
                    term_idf = self.idf.get(qt, 1.0)
                    score += term_tf * term_idf
            if score > 0:
                scores[path] = score

        # Sort by score desc, then path asc for deterministic ordering
        ranked = sorted(scores.items(), key=lambda x: (-x[1], x[0]))[:top_k]

        results = []
        for path, score in ranked:
            snippets = self._extract_snippets(path, query_tokens, max_snippets=3)
            matched_headings = self._matched_headings(path, query_tokens)
            results.append({
                "path": path,
                "score": round(score, 4),
                "snippets": snippets,
                "matched_headings": matched_headings,
            })
        return results

    def _extract_snippets(
        self, path: str, query_tokens: list[str],
        max_snippets: int = 3, context_chars: int = 80
    ) -> list[str]:
        """Extract text snippets around matching tokens."""
        content = self.docs[path]
        content_lower = content.lower()
        snippets = []
        seen_positions: set[int] = set()

        for qt in query_tokens:
            start = 0
            while len(snippets) < max_snippets:
                pos = content_lower.find(qt, start)
                if pos == -1:
                    break
                # Deduplicate overlapping regions
                bucket = pos // context_chars
                if bucket in seen_positions:
                    start = pos + len(qt)
                    continue
                seen_positions.add(bucket)

                snippet_start = max(0, pos - context_chars)
                snippet_end = min(len(content), pos + len(qt) + context_chars)
                snippet = "..." + content[snippet_start:snippet_end].replace("\n", " ") + "..."
                snippets.append(snippet)
                start = pos + len(qt)

        return snippets[:max_snippets]

    def _matched_headings(self, path: str, query_tokens: list[str]) -> list[str]:
        """Find headings in the doc that contain any query token."""
        from lib.markdown_parser import parse_headings

        content = self.docs[path]
        headings = parse_headings(content)
        matched = []
        for h in headings:
            title_lower = h["title"].lower()
            if any(qt in title_lower for qt in query_tokens):
                matched.append(h["title"])
        return matched
