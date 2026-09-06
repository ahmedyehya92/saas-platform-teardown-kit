---
name: saas-platform-teardown
description: This skill should be used when the user gives a SaaS product's landing page URL, homepage, or name and asks for a full teardown or deep-dive of how the product works across web, desktop, and mobile — including per-platform feature inventories, tech stack, pricing/plan mapping, and how the platforms integrate and sync — with a structured Markdown report as the deliverable. Trigger on phrases like "research this SaaS", "do a platform teardown of X", "map every feature of this product across web/mobile/desktop", "reverse-engineer how this app works everywhere", or a bare URL plus a request to understand the whole product.
---

# SaaS Platform Teardown

## Role

Act as a product-research engineer producing a due-diligence-grade teardown of
a SaaS product from nothing but its landing page URL. The deliverable is
Markdown documentation good enough that someone who has never seen the
product could explain, to a stakeholder, exactly what it does, on which
platforms, and how those platforms talk to each other.

## Before starting

Confirm what's available and degrade gracefully rather than stalling:

1. Check for live browser access, in this order:
   a. Playwright MCP tools (`mcp__playwright__browser_navigate`,
      `browser_snapshot`, etc.). If this session started before the server
      was registered, it won't be present — see (b).
   b. `agent-browser` CLI on `$PATH` (`agent-browser --version` via bash).
      Same audit capability, shell-driven.
   If both are absent, tell the user the web audit will be limited to static
   page fetches — no live app exploration — and continue anyway.
2. Check whether `agy` is on `$PATH` (`agy --version` via bash). If present,
   use it per `references/06-agy-search-playbook.md` for broad/fast-moving
   research — read that playbook's permissions section before the first
   sweep (a silently-empty answer means a blocked tool, not a finished
   search). If absent, fall back to the built-in web search tool for the
   same questions — slower, sequential, but functionally equivalent.
3. Check for `gh` (useful when the product has public repos) and a
   Wappalyzer-class tech detector (useful for stack fingerprinting). Neither
   is required to proceed.

Never wait on tool availability — note the gap in the final report's
methodology section and move on with the next-best method.

## Phases

Work through these in order. Each phase has its own reference playbook —
read the file with the `Read` tool immediately before starting that phase,
not all at once at the start. This keeps context focused and matches how
this skill was designed to be used.

| Phase | Goal | Playbook |
|---|---|---|
| 0 | Turn the URL into a map of every platform surface the product has | `references/01-intake-and-recon.md` |
| 1 | Live-explore and document the web app | `references/02-web-platform-audit.md` |
| 2 | Document the mobile apps (or confirm none exist) | `references/03-mobile-platform-audit.md` |
| 3 | Document the desktop app (or confirm none exists) | `references/04-desktop-platform-audit.md` |
| 4 | Synthesize how the platforms share data/accounts/notifications | `references/05-integration-architecture.md` |
| 5 (parallel/ongoing) | Fan out broad research questions | `references/06-agy-search-playbook.md` |
| 6 | Assemble and write the final report | `references/07-report-assembly.md` |

Phase 5 isn't sequential — dispatch `agy` sweeps as soon as Phase 0 gives you
concrete questions (company facts, app store presence, integrations
directory, pricing), so results are ready by the time Phases 1–4 need them
instead of blocking on them.

## Operating rules

- **Never sign up with real payment info, never scrape behind a paywall you
  don't have legitimate access to, and never attempt to bypass auth, rate
  limits, or bot protection.** Use free trials/demo modes/public sandbox
  accounts only, and stop if a platform requires payment or ID verification
  to go further. Document that a wall exists rather than working around it.
- **Attribute everything.** Every factual claim in the final report carries
  either a source URL or an explicit "Inferred from X" note. No claim should
  be traceable to nothing but the model's prior knowledge — this product's
  facts as of *today* are what matters, and training data goes stale.
- **Mark confidence.** Use exactly three labels in the report: `Confirmed`
  (directly observed — screenshot, DOM, API response, official doc),
  `Reported` (a secondary source states it — review, forum, press), and
  `Inferred` (deduced from indirect evidence — e.g., same session cookie
  domain across web and desktop implies shared auth backend).
- **Timestamp it.** SaaS products ship weekly. The report's header must
  record the research date, because "current" claims decay fast.
- **Prefer paraphrase over quotation** in the report body per normal
  copyright practice, even though this is internal research documentation.

## Definition of done

Before writing the final files, verify the draft actually answers all of:

- What does this product do, in one paragraph a non-technical person understands?
- Who is it for, and what does it cost at each tier?
- What can you do on web that you can't do on mobile, and vice versa? Same for desktop.
- Is there a native mobile app, a native desktop app, both, or neither — with sources?
- Do web/mobile/desktop share one account and sync in real time, or are they more separate than the marketing implies?
- What's the underlying tech stack, to the extent it's externally observable?
- What does the product integrate with, and is there a public API?
- Where does the confidence break down — what couldn't be verified, and why?

If any of these is unanswered, that's a gap to close or explicitly flag —
not a reason to pad the report with restated marketing copy.

## Output

Follow `references/07-report-assembly.md` for the file-count decision and
exact structure. Write to `./<product-slug>-teardown/` in the current
working directory and present the files — a report that's written but never
surfaced to the user is a wasted teardown.
