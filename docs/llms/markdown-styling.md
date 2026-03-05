---
title: "Markdown Style Rules"
category: "llms"
description: "Hard constraints for markdown formatting in all docs: headings, lists, paragraphs, code blocks, emphasis, and prohibited patterns."
last_updated: "2026-02-25"
---

# Markdown Style Rules (Hard Constraints)

These rules MUST be followed exactly.

## Headings

- Always include a space after # symbols
- Always include a blank line before and after a heading
- Only one `#` (H1) per file; use `##` and deeper for all other section headings

## Section

Text immediately follows

## Lists

- Use hyphen (-) only
- One space after hyphen
- Blank line before and after lists

## Paragraphs

- Never run text directly after a heading
- Separate paragraphs with one blank line

## Code Blocks

- Always fenced with triple backticks
- Specify language when applicable

## Emphasis

- Use **bold** for emphasis
- Use _italics_ sparingly
- Do NOT use headings as emphasis

## Prohibited

- No trailing spaces
- No mixed list markers
- No inline headings
- No bare URLs (`https://…`); always use Markdown links like `[label](https://example.com)`
