# SaaS Platform Teardown Kit — for Claude Code

A drop-in research system that turns **one landing page URL** into a structured,
multi-file Markdown teardown of a SaaS product: what it does, every feature on
every platform (web / desktop / mobile), and how those platforms integrate.

This is not a single prompt. It's a **skill package** — a primary orchestrator
skill plus phase-specific reference playbooks — designed around how Claude
Code's Skills system actually works: metadata is loaded at startup, the
SKILL.md body loads when the task matches, and everything else (the
`references/` playbooks, the `assets/` templates) loads only when the
orchestrator explicitly points Claude at it. That's what makes this reliable
instead of a wall of instructions Claude has to hold in its head at once.

## What's in this kit

```
saas-platform-teardown/
├── SKILL.md                          # orchestrator — the entry point
├── references/
│   ├── 01-intake-and-recon.md        # turn a URL into a map of every surface
│   ├── 02-web-platform-audit.md      # live-explore the web app
│   ├── 03-mobile-platform-audit.md   # iOS/Android store + behavior audit
│   ├── 04-desktop-platform-audit.md  # native app / installer audit
│   ├── 05-integration-architecture.md# how the platforms share data
│   ├── 06-agy-search-playbook.md     # prompt-engineered agy CLI research
│   └── 07-report-assembly.md         # how to write the final MD output
└── assets/report-template/           # the skeleton the final report is built from
    ├── 00-INDEX.md
    ├── 01-overview-and-recon.md
    ├── 02-web-platform.md
    ├── 03-mobile-platform.md
    ├── 04-desktop-platform.md
    ├── 05-integration-architecture.md
    └── 06-pricing-and-sources.md

mcp-config.example.json               # MCP servers this skill expects
setup.md                              # CLI installs + verification steps
```

## Install

1. Copy `saas-platform-teardown/` into `~/.claude/skills/saas-platform-teardown/`
   (global) or `<project>/.claude/skills/saas-platform-teardown/` (project-local).
2. Merge `mcp-config.example.json` into your Claude Code MCP config
   (`claude mcp add ...` or your `.mcp.json`).
3. Follow `setup.md` to install the CLIs the skill shells out to.
4. Restart Claude Code (skills and MCP servers are only picked up at session
   start).

## Run it

```
> Do a full platform teardown of https://example-saas.com
```

or name it explicitly:

```
> Use the saas-platform-teardown skill on https://example-saas.com
```

Claude Code will match the request to `SKILL.md`'s description, then work
phase by phase through the reference playbooks, producing a Markdown report
folder under `./<product-slug>-teardown/` in your working directory.

## Design principles behind this kit

- **One skill, one job, progressive disclosure.** The orchestrator is short.
  Depth lives in `references/`, loaded on demand — this is the documented
  Claude Code pattern, not an improvised one.
- **Tools do what they're good at.** Live DOM/UI truth comes from Playwright
  MCP, not from guessing what a page looks like. Broad web knowledge and
  fast-changing facts (app store data, pricing, integrations directories)
  are swept with `agy` because it's Gemini-grounded and cheap to fan out in
  parallel from the shell. Claude Code does the synthesis, verification, and
  writing — the part that needs judgment.
- **Every claim is sourced or flagged.** The report template forces a
  Confirmed/Inferred distinction and a source link per section, because SaaS
  products change weekly and an undated, unsourced teardown is worthless in
  three months.
