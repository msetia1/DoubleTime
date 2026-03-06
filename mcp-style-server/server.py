#!/usr/bin/env python3
"""
MCP Style Guidelines Server for DoubleTime.

Reads JSON-RPC 2.0 over stdin, writes responses to stdout.
Debug/log output goes to stderr only (stdout must stay clean for the protocol).

Usage:
    PROJECT_ROOT=. python3 server.py
"""

import sys
import json
import os

from tools import get_style_guide, get_design_tokens


# ── Configuration ──────────────────────────────────────────────────────────────

# The IDE passes this env var so the server knows where the project lives.
# From PROJECT_ROOT we can find both docs/styling.md and Core/Design/*.swift.
PROJECT_ROOT = os.environ.get("PROJECT_ROOT", ".")

SERVER_INFO = {
    "name": "doubletime-style",
    "version": "0.1.0",
}

# This tells the IDE which version of the MCP protocol we speak.
PROTOCOL_VERSION = "2024-11-05"


# ── Tool Registry ────────────────────────────────────────────────────────────
#
# Each tool has:
#   - handler: the Python function that does the work
#   - description: what the AI sees when deciding whether to call this tool
#   - inputSchema: JSON Schema describing what parameters the tool accepts
#
# When the AI needs style info, it reads these descriptions and decides which
# tool to call and with what arguments.

TOOLS = {
    "get_style_guide": {
        "handler": get_style_guide.handle,
        "description": (
            "Get the DoubleTime style guide — colors, typography, spacing, "
            "motion, components, and accessibility rules. "
            "Returns the full guide or a specific section."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "section": {
                    "type": "string",
                    "description": (
                        "Optional section heading to extract, e.g. "
                        "'Brand Palette', 'Typography', 'Spacing and Layout', "
                        "'Motion and Animation'. Omit for the full guide."
                    ),
                },
            },
        },
    },
    "get_design_tokens": {
        "handler": get_design_tokens.handle,
        "description": (
            "Get the actual Swift source code for a DoubleTime design file. "
            "Returns the real implementation so you can reference exact color "
            "values, font tokens, and button styles."
        ),
        "inputSchema": {
            "type": "object",
            "properties": {
                "file": {
                    "type": "string",
                    "enum": ["palette", "typography", "button_style"],
                    "description": (
                        "Which design file to return: "
                        "'palette' (BrandPalette.swift), "
                        "'typography' (Typography.swift), or "
                        "'button_style' (BrandedActionButtonStyle.swift)"
                    ),
                },
            },
            "required": ["file"],
        },
    },
}


# ── I/O Helpers ──────────────────────────────────────────────────────────────
#
# Important: stdout is ONLY for JSON-RPC responses. Any debug/log output goes
# to stderr, otherwise it would corrupt the protocol stream.

def log(msg: str):
    """Log to stderr so stdout stays clean for JSON-RPC."""
    print(f"[mcp-style] {msg}", file=sys.stderr, flush=True)


def send(response: dict):
    """Write a JSON-RPC response to stdout."""
    data = json.dumps(response)
    sys.stdout.write(data + "\n")
    sys.stdout.flush()


# ── Request Handlers ────────────────────────────────────────────────────────
#
# These handle the 3 methods the IDE will call:
#   1. initialize — "hello, who are you and what can you do?"
#   2. tools/list — "what tools do you have?"
#   3. tools/call — "run this specific tool with these arguments"

def handle_initialize(request_id):
    """Respond to the handshake. Tell the IDE our name and capabilities."""
    send({
        "jsonrpc": "2.0",
        "id": request_id,
        "result": {
            "protocolVersion": PROTOCOL_VERSION,
            "serverInfo": SERVER_INFO,
            "capabilities": {
                "tools": {},
            },
        },
    })


def handle_tools_list(request_id):
    """Return the list of tools we offer, with their schemas."""
    tool_defs = []
    for name, spec in TOOLS.items():
        tool_defs.append({
            "name": name,
            "description": spec["description"],
            "inputSchema": spec["inputSchema"],
        })
    send({
        "jsonrpc": "2.0",
        "id": request_id,
        "result": {"tools": tool_defs},
    })


def handle_tools_call(request_id, params: dict):
    """Run a tool and return its result (or an error)."""
    tool_name = params.get("name")
    arguments = params.get("arguments", {})

    if tool_name not in TOOLS:
        send({
            "jsonrpc": "2.0",
            "id": request_id,
            "error": {
                "code": -32601,
                "message": f"Unknown tool: {tool_name}",
            },
        })
        return

    try:
        # Pass PROJECT_ROOT so the tool knows where to find files.
        result = TOOLS[tool_name]["handler"](PROJECT_ROOT, arguments)
        send({
            "jsonrpc": "2.0",
            "id": request_id,
            "result": {
                "content": [
                    {"type": "text", "text": json.dumps(result, indent=2)}
                ],
            },
        })
    except Exception as e:
        log(f"Error in {tool_name}: {e}")
        send({
            "jsonrpc": "2.0",
            "id": request_id,
            "error": {
                "code": -32603,
                "message": f"Internal error: {str(e)}",
            },
        })


# ── Main Loop ────────────────────────────────────────────────────────────────
#
# This is the core of the server. It reads one line at a time from stdin,
# parses it as JSON, checks the method, and dispatches to the right handler.
# It runs forever until the IDE closes stdin (kills the process).

def main():
    log(f"Starting MCP style server, PROJECT_ROOT={PROJECT_ROOT}")

    # Verify the project root exists
    root = os.path.realpath(os.path.abspath(PROJECT_ROOT))
    if not os.path.isdir(root):
        log(f"FATAL: PROJECT_ROOT does not exist: {root}")
        sys.exit(1)

    log(f"Project root resolved to: {root}")

    for line in sys.stdin:
        line = line.strip()
        if not line:
            continue

        try:
            request = json.loads(line)
        except json.JSONDecodeError as e:
            log(f"Invalid JSON: {e}")
            continue

        method = request.get("method")
        request_id = request.get("id")  # None for notifications
        params = request.get("params", {})

        log(f"← {method} (id={request_id})")

        if method == "initialize":
            handle_initialize(request_id)

        elif method == "initialized":
            # Notification from IDE — no response needed
            log("Client initialized")

        elif method == "tools/list":
            handle_tools_list(request_id)

        elif method == "tools/call":
            handle_tools_call(request_id, params)

        else:
            if request_id is not None:
                send({
                    "jsonrpc": "2.0",
                    "id": request_id,
                    "error": {
                        "code": -32601,
                        "message": f"Method not found: {method}",
                    },
                })


if __name__ == "__main__":
    main()
