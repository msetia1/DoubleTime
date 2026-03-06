"""
get_design_tokens tool — returns the actual Swift source for a design file.

How it works:
1. The AI passes a file key: "palette", "typography", or "button_style"
2. We map that key to the real file path under Core/Design/
3. We read the file and return its contents

This is simpler than get_style_guide — no parsing needed. The AI wants
the raw Swift code so it can see exact color values, font names, etc.

If you add a new design file to Core/Design/ later, just add one entry
to the FILE_MAP dict below.
"""

import os


# Maps the short key the AI passes → the actual file path relative to PROJECT_ROOT.
# To add a new design file, just add a line here.
FILE_MAP = {
    "palette": os.path.join("Core", "Design", "BrandPalette.swift"),
    "typography": os.path.join("Core", "Design", "Typography.swift"),
    "button_style": os.path.join("Core", "Design", "BrandedActionButtonStyle.swift"),
}


def handle(project_root: str, arguments: dict) -> dict:
    """
    Main handler — called by server.py when the AI invokes this tool.

    Args:
        project_root: Absolute path to the DoubleTime project
        arguments: Dict with required "file" key ("palette", "typography", or "button_style")
    """
    file_key = arguments.get("file", "")

    # Validate the key
    if file_key not in FILE_MAP:
        return {
            "error": f"Unknown file: '{file_key}'",
            "available_files": list(FILE_MAP.keys()),
        }

    relative_path = FILE_MAP[file_key]
    full_path = os.path.join(project_root, relative_path)
    full_path = os.path.realpath(full_path)

    if not os.path.isfile(full_path):
        return {"error": f"File not found: {relative_path}"}

    with open(full_path, "r", encoding="utf-8") as f:
        content = f.read()

    return {
        "file": file_key,
        "path": relative_path,
        "content": content,
        "content_length": len(content),
    }
