#!/usr/bin/env python3
"""
CLI test client for the MCP Style Guidelines Server.

Spawns server.py as a subprocess and sends JSON-RPC requests.
Use this to manually verify the tools work before hooking up to an IDE.

Usage:
    python3 client.py guide                     # Full style guide
    python3 client.py guide "Brand Palette"     # Just the palette section
    python3 client.py tokens palette            # BrandPalette.swift source
    python3 client.py tokens typography         # Typography.swift source
    python3 client.py tokens button_style       # BrandedActionButtonStyle.swift source
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
    Spawn the server, perform the MCP handshake, call one tool, print result.

    This mimics what an IDE does:
    1. Start the server process
    2. Send initialize → get back server info
    3. Send initialized notification
    4. Send tools/call → get back the tool result
    5. Print and exit
    """
    server_dir = os.path.dirname(os.path.abspath(__file__))
    project_root = os.path.dirname(server_dir)

    env = os.environ.copy()
    env["PROJECT_ROOT"] = project_root

    proc = subprocess.Popen(
        [sys.executable, os.path.join(server_dir, "server.py")],
        stdin=subprocess.PIPE,
        stdout=subprocess.PIPE,
        stderr=subprocess.PIPE,
        env=env,
        text=True,
    )

    try:
        # Step 1: Initialize handshake
        init_req = make_request("initialize", {}, request_id=0)
        proc.stdin.write(json.dumps(init_req) + "\n")
        proc.stdin.flush()

        init_resp = json.loads(proc.stdout.readline())
        server_name = init_resp.get("result", {}).get("serverInfo", {}).get("name", "unknown")
        print(f"Connected to: {server_name}\n")

        # Step 2: Send "initialized" notification (no response expected)
        notif = {"jsonrpc": "2.0", "method": "initialized"}
        proc.stdin.write(json.dumps(notif) + "\n")
        proc.stdin.flush()

        # Step 3: Call the tool
        call_req = make_request("tools/call", {
            "name": tool_name,
            "arguments": arguments,
        }, request_id=1)
        proc.stdin.write(json.dumps(call_req) + "\n")
        proc.stdin.flush()

        resp = json.loads(proc.stdout.readline())

        # Print the result
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

        stderr_output = proc.stderr.read()
        if stderr_output:
            print(f"\n--- Server Log ---\n{stderr_output}", file=sys.stderr)


def main():
    if len(sys.argv) < 2:
        print(__doc__)
        sys.exit(1)

    command = sys.argv[1]

    if command == "guide":
        args = {}
        if len(sys.argv) >= 3:
            args["section"] = sys.argv[2]
        run_session("get_style_guide", args)

    elif command == "tokens":
        if len(sys.argv) < 3:
            print("Usage: client.py tokens <palette|typography|button_style>", file=sys.stderr)
            sys.exit(1)
        run_session("get_design_tokens", {"file": sys.argv[2]})

    else:
        print(f"Unknown command: {command}")
        print(__doc__)
        sys.exit(1)


if __name__ == "__main__":
    main()
