# DoubleTime MCP Documentation Server

An MCP (Model Context Protocol) server that exposes the project's `Docs/` folder as structured, searchable context to any MCP-compatible client (Cursor, Claude Desktop, etc.).

## Tools

| Tool | Description |
|------|-------------|
| `list_docs` | List all documentation files with metadata |
| `search_docs` | Full-text search across documentation |
| `get_doc_section` | Get a specific section by heading, or the whole doc |
| `get_architecture_overview` | Get the architecture overview or synthesized summary |

## Requirements

- Python 3.10+
- No external runtime dependencies (stdlib only)
- `pytest` for running tests

## Quick Start

```bash
# From the project root (DoubleTime/)

# Run the tests
pip install pytest
cd mcp-docs-server
python -m pytest tests/ -v

# Test with the CLI client
python3 mcp-docs-server/client.py list
python3 mcp-docs-server/client.py search "remainingMinutes"
python3 mcp-docs-server/client.py section architecture.md "State Management"
python3 mcp-docs-server/client.py arch
```

## Cursor Integration

Add to `.cursor/mcp.json` in your project root:

```json
{
  "mcpServers": {
    "doubletime-docs": {
      "command": "python3",
      "args": ["mcp-docs-server/server.py"],
      "env": {
        "DOCS_ROOT": "./Docs"
      }
    }
  }
}
```

Then restart Cursor. The tools will appear in the model's tool list.

## Architecture

```
mcp-docs-server/
├── server.py              # Entry point — stdio JSON-RPC loop
├── client.py              # CLI test client
├── lib/
│   ├── sandbox.py         # Path validation + traversal prevention
│   ├── markdown_parser.py # Heading extraction, section slicing
│   └── search_engine.py   # TF-IDF-lite search index
├── tools/
│   ├── list_docs.py       # list_docs handler
│   ├── search_docs.py     # search_docs handler
│   ├── get_doc_section.py # get_doc_section handler
│   └── get_architecture.py# get_architecture_overview handler
└── tests/
    ├── test_sandbox.py
    ├── test_list_docs.py
    ├── test_search_docs.py
    ├── test_get_doc_section.py
    └── test_get_architecture.py
```
