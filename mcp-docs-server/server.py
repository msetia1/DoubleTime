#!/usr/bin/env python3
"""
MCP Documentation Server for DoubleTime.

Reads JSON-RPC 2.0 over stdin, writes responses to stdout.
Debug/log output goes to stderr only.

Usage:
    DOCS_ROOT=./Docs python3 server.py
"""

import sys
import json
import os

from lib.sandbox import Sandbox, SandboxError
from tools import list_docs, search_docs, get_doc_section, get_architecture


# ── Configuration ──────────────────────────────────────────────────────────────

DOCS_ROOT = os.environ.get("DOCS_ROOT", "./Docs")

SERVER_INFO = {
    "name": "doubletime-docs",
    "version": "0.1.0",
}

PROTOCOL_VERSION = "2024-11-05"


# ── Tool Registry ────────────────────────────────────────────────────────────

TOOLS = {
    "list_docs": {
        "handler": list_docs.handle,
        "description": "List all documentation files with metadata",
        "inputSchema": {
            "type": "object",
            "properties": {
                "category": {
                    "type": "string",
                    "description": "Filter by subdirectory (e.g. 'games', 'llms')",
                },
            },
        },
    },
    "search_docs": {
        "handler": search_docs.handle,
        "description": "Full-text search across documentation with ranked results",
        "inputSchema": {
            "type": "object",
            "properties": {
                "query": {
                    "type": "string",
                    "description": "Search keywords or phrase",
                },
                "top_k": {
                    "type": "integer",
                    "description": "Max results to return (default 5, max 20)",
                },
            },
            "required": ["query"],
        },
    },
    "get_doc_section": {
        "handler": get_doc_section.handle,
        "description": "Get a specific section from a doc by heading, or the whole doc",
        "inputSchema": {
            "type": "object",
            "properties": {
                "path": {
                    "type": "string",
                    "description": "Relative path from docs root (e.g. 'architecture.md', 'games/crash.md')",
                },
                "heading": {
                    "type": "string",
                    "description": "Optional heading text to extract (case-insensitive partial match)",
                },
            },
            "required": ["path"],
        },
    },
    "get_architecture_overview": {
        "handler": get_architecture.handle,
        "description": "Get the architecture overview document or a synthesized summary",
        "inputSchema": {
            "type": "object",
            "properties": {},
        },
    },
}


# ── I/O Helpers ──────────────────────────────────────────────────────────────

def log(msg: str):
    """Log to stderr so stdout stays clean for JSON-RPC."""
    print(f"[mcp-docs] {msg}", file=sys.stderr, flush=True)


def send(response: dict):
    """Write JSON-RPC response to stdout."""
    data = json.dumps(response)
    sys.stdout.write(data + "\n")
    sys.stdout.flush()


# ── Request Handlers ────────────────────────────────────────────────────────

def handle_initialize(request_id):
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


def handle_tools_call(request_id, params: dict, sandbox: Sandbox):
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
        result = TOOLS[tool_name]["handler"](sandbox, arguments)
        send({
            "jsonrpc": "2.0",
            "id": request_id,
            "result": {
                "content": [
                    {"type": "text", "text": json.dumps(result, indent=2)}
                ],
            },
        })
    except SandboxError as e:
        send({
            "jsonrpc": "2.0",
            "id": request_id,
            "result": {
                "content": [
                    {"type": "text", "text": json.dumps({"error": str(e)})}
                ],
                "isError": True,
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

def main():
    log(f"Starting MCP docs server, DOCS_ROOT={DOCS_ROOT}")

    try:
        sandbox = Sandbox(DOCS_ROOT)
    except SandboxError as e:
        log(f"FATAL: {e}")
        sys.exit(1)

    log(f"Sandbox root resolved to: {sandbox.root}")

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
            # Notification — no response needed
            log("Client initialized")

        elif method == "tools/list":
            handle_tools_list(request_id)

        elif method == "tools/call":
            handle_tools_call(request_id, params, sandbox)

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
