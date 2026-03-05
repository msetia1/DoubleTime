"""
Sandbox — path validation and traversal prevention.

All file access in the MCP server goes through this module.
Ensures every resolved path stays within the docs root directory.
"""

import os


class SandboxError(Exception):
    """Raised when a path operation violates sandbox boundaries."""
    pass


class Sandbox:
    def __init__(self, docs_root: str):
        self.root = os.path.realpath(os.path.abspath(docs_root))
        if not os.path.isdir(self.root):
            raise SandboxError(f"Docs root does not exist: {self.root}")

    def resolve(self, relative_path: str) -> str:
        """
        Convert a relative path to an absolute one,
        ensuring it stays within docs_root.

        Raises SandboxError on traversal attempt or missing file.
        """
        if not relative_path or relative_path.strip() == "":
            raise SandboxError("Empty path")

        # Reject null bytes
        if "\x00" in relative_path:
            raise SandboxError("Null bytes in path")

        # Join and resolve — collapses ../ and follows symlinks
        candidate = os.path.realpath(
            os.path.join(self.root, relative_path)
        )

        # Critical check: must be within root
        if not (candidate == self.root or
                candidate.startswith(self.root + os.sep)):
            raise SandboxError(f"Path traversal blocked: {relative_path}")

        if not os.path.exists(candidate):
            raise SandboxError(f"File not found: {relative_path}")

        return candidate

    def list_all_files(self, extensions: tuple[str, ...] = (".md", ".txt")) -> list[dict]:
        """
        Walk docs root recursively, return metadata for matching files.

        Returns list of dicts with keys: path, size_bytes, modified, category.
        """
        results = []
        for dirpath, _, filenames in os.walk(self.root):
            for fname in sorted(filenames):
                if not any(fname.endswith(ext) for ext in extensions):
                    continue
                if fname.startswith("."):
                    continue
                full = os.path.join(dirpath, fname)
                rel = os.path.relpath(full, self.root)
                stat = os.stat(full)
                results.append({
                    "path": rel,
                    "size_bytes": stat.st_size,
                    "modified": stat.st_mtime,
                    "category": self._category(rel),
                })
        return results

    def _category(self, rel_path: str) -> str:
        """Extract category from subdirectory name, or 'root' for top-level files."""
        parts = rel_path.split(os.sep)
        return parts[0] if len(parts) > 1 else "root"
