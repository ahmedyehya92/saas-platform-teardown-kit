# SaaS Platform Teardown Kit — for Claude Code

A drop-in research system that turns **one landing page URL** into a
structured, multi-file Markdown teardown of a SaaS product: what it does,
every feature and user journey on every platform (web / desktop / mobile),
how those platforms integrate — and the business logic behind those
choices — plus hardware coverage, business-scale/revenue signals, and
concrete release artifacts per platform.

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
│   ├── 01-intake-and-recon.md        # URL → surface map + access plan + hardware check
│   ├── 02-web-platform-audit.md      # live web audit + CANONICAL no-credential access ladder + journey schema
│   ├── 03-mobile-platform-audit.md   # store artifacts (no binary extraction), mobile journeys
│   ├── 04-desktop-platform-audit.md  # per-OS/arch release artifacts, version history, desktop journeys
│   ├── 05-integration-architecture.md# platform synthesis + business-objective mapping
│   ├── 06-research-sweeps.md         # prompt-engineered research sweeps incl. revenue
│   ├── 07-report-assembly.md         # how to write the final MD output
│   └── 08-hardware-integrations.md   # CONDITIONAL — loaded only if hardware is found
└── assets/report-template/           # the skeleton the final report is built from
    ├── 00-INDEX.md                   # executive summary + access-methods summary
    ├── 01-overview-and-recon.md      # + complete verified link inventory
    ├── 02-web-platform.md            # + access log, journeys
    ├── 03-mobile-platform.md         # + store artifact tables, access log, journeys
    ├── 04-desktop-platform.md        # + per-OS/arch artifact table, version history
    ├── 05-user-journeys.md           # all platforms × 5 journeys, personas, handoff map
    ├── 06-hardware-integrations.md   # device families — or the explicit none-finding
    ├── 07-integration-architecture.md# + business-objective map
    └── 08-pricing-revenue-sources.md # + revenue estimates with method per figure

mcp-config.example.json               # MCP servers this skill expects
setup.md                              # CLI installs + verification steps
CHANGELOG.md                          # what changed in this kit, and why
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
  fast-changing facts (app store data, pricing, revenue estimators,
  integrations directories) are swept with `agy` because it's
  Gemini-grounded and cheap to fan out in parallel from the shell. Claude
  Code does the synthesis, verification, and writing — the part that needs
  judgment.
- **Decision-grade, not feature-list-grade.** A teardown answers "is this
  product a real threat?": full user journeys per platform, business
  objectives behind every integration, explicit hardware answers,
  revenue/scale signals with methods, and release artifacts per platform —
  not just "an app exists."
- **No credentials is a methodology, not a dead end.** Self-serve trials are
  used when offered; genuinely gated products get the documented
  no-credential ladder (demo videos, help-center screenshots, reviews,
  Wayback, API docs) — and every platform section logs which methods
  produced its claims, so the reader can weigh verified truth against
  secondhand reconstruction.
- **Every claim is sourced or flagged.** The report template forces a
  Confirmed/Reported/Inferred distinction and a source link per section,
  because SaaS products change weekly and an undated, unsourced teardown is
  worthless in three months.
