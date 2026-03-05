#!/usr/bin/env python3
"""
CLI test client for the MCP Documentation Server.

Spawns server.py as a subprocess and sends JSON-RPC requests.

Usage:
    python3 client.py list [category]
    python3 client.py search <query> [top_k]
    python3 client.py section <path> [heading]
    python3 client.py arch
"""

import sys
import os
import json
import subprocess


def make_request(method: str, params: dict | None = None, request_id: int = 1) -> dict:
    """Build a JSON-RPC 2.0 request."""
    req = {
        "jsonrpc": "2.0",
        "id": request_id,
        "method": method,
    }
    if params is not None:
        req["params"] = params
    return req


def run_session(tool_name: str, arguments: dict):
    """
    Spawn the server, perform the MCP handshake, call one tool, and print the result.
    """
    server_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(server_dir)
    docs_root = os.path.join(project_root, "Docs")

    env = os.environ.copy()
    env["DOCS_ROOT"] = docs_root

    proc = subprocess.Popen(
        [sys.executable, os.path.join(server_dir, "server.py")],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        env=env,
        text=True,
    )

    try:
        # 1. Initialize
        init_req = make_request("initialize", {}, request_id=0)
        proc.stdin.write(json.dumps(init_req) + "\n")
        proc.stdin.flush()

        init_resp_line = proc.stdout.readline()
        init_resp = json.loads(init_resp_line)
        server_name = init_resp.get("result", {}).get("serverInfo", {}).get("name", "unknown")
        print(f"✓ Connected to: {server_name}\n")

        # 2. Send initialized notification
        notif = {"jsonrpc": "2.0", "method": "initialized"}
        proc.stdin.write(json.dumps(notif) + "\n")
        proc.stdin.flush()

        # 3. Call the tool
        call_req = make_request("tools/call", {
            "name": tool_name,
            "arguments": arguments,
        }, request_id=1)
        proc.stdin.write(json.dumps(call_req) + "\n")
        proc.stdin.flush()

        resp_line = proc.stdout.readline()
        resp = json.loads(resp_line)

        # Pretty-print the result
        if "result" in resp:
            content = resp["result"].get("content", [])
            for item in content:
                if item.get("type") == "text":
                    parsed = json.loads(item["text"])
                    print(json.dumps(parsed, indent=2))
        elif "error" in resp:
            print(f"ERROR: {resp['error']}", file=sys.stderr)

    finally:
        proc.stdin.close()
        proc.terminate()
        proc.wait(timeout=5)

        # Print server stderr for debugging
        stderr_output = proc.stderr.read()
        if stderr_output:
            print(f"\n--- Server Log ---\n{stderr_output}", file=sys.stderr)


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    command = sys.argv[1]

    if command == "list":
        args = {}
        if len(sys.argv) >= 3:
            args["category"] = sys.argv[2]
        run_session("list_docs", args)

    elif command == "search":
        if len(sys.argv) < 3:
            print("Usage: client.py search <query> [top_k]", file=sys.stderr)
            sys.exit(1)
        args = {"query": sys.argv[2]}
        if len(sys.argv) >= 4:
            args["top_k"] = int(sys.argv[3])
        run_session("search_docs", args)

    elif command == "section":
        if len(sys.argv) < 3:
            print("Usage: client.py section <path> [heading]", file=sys.stderr)
            sys.exit(1)
        args = {"path": sys.argv[2]}
        if len(sys.argv) >= 4:
            args["heading"] = sys.argv[3]
        run_session("get_doc_section", args)

    elif command == "arch":
        run_session("get_architecture_overview", {})

    else:
        print(f"Unknown command: {command}")
        print(__doc__)
        sys.exit(1)


if __name__ == "__main__":
    main()
