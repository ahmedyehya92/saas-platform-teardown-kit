# 01 — Overview & Recon

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Company

- **Legal entity:** Linear Orbit, Inc. (named as App Store seller and Google Play developer) — Confirmed ([App Store listing](https://apps.apple.com/us/app/linear-mobile/id1645587184), [Play listing](https://play.google.com/store/apps/details?id=app.linear))
- **Founded:** April 2019 by Karri Saarinen (CEO), Jori Lallo, Tuomas Artman — Reported ([LinkedIn profile](https://www.linkedin.com/in/karrisaarinen)); corroborated by the Wayback Machine's earliest linear.app capture on 2019-04-18 — Confirmed ([Wayback CDX](http://web.archive.org/cdx/search/cdx?url=linear.app))
- **Funding:** seed → Series A $13M led by Sequoia (2020) — Reported ([TechCrunch coverage](https://techcrunch.com)); Series B $35M led by Accel at ~$400M valuation (Sep 14, 2023), profitable at the time with fewer than 50 employees — Reported ([Forbes](https://www.forbes.com/sites/alexkonrad/2023/09/14/linear-developer-tools-raises-35-million-series-b/)); Series C $82M led by Accel at $1.25B valuation (2025) — Reported ([TechCrunch](https://techcrunch.com)); $99M tender offer at a $2.5B valuation in 2026 with Accel and 01A participating plus new investors Salesforce Ventures and S32 — Confirmed, company-stated ([Linear growth post](https://linear.app/now/sharing-growth-with-the-people-building-linear))
- **Ownership:** privately held; no SEC or other regulator filings found (searched 2026-09-07) — Reported (absence of results)
- **Headcount:** "fewer than 50" at Series B (2023) — Reported ([Forbes](https://www.forbes.com/sites/alexkonrad/2023/09/14/linear-developer-tools-raises-35-million-series-b/)); "30 open roles" on the 2026 growth post — Confirmed (company-stated, [growth post](https://linear.app/now/sharing-growth-with-the-people-building-linear))
- **Category peers:** Jira/Atlassian, Asana, monday.com, Shortcut, Height; Play "similar apps" shelf places it next to Confluence Cloud and monday.com — Confirmed (live [Play listing](https://play.google.com/store/apps/details?id=app.linear))

## Product positioning

- Live positioning (2026): "The product development system for teams and agents" — a shift from the classic "issue tracking for software teams" framing toward an agent-orchestration platform: issues, projects, documents, coding sessions, and AI agents (Linear Agent plus third-party agents from OpenAI Codex, Cursor, GitHub Copilot, Devin, Factory, Sentry) — Confirmed ([homepage](https://linear.app/), [integrations page](https://linear.app/integrations), [agents page](https://linear.app/agents))
- Built for software product teams first (small teams through enterprise; docs offer three setup guides split by company stage) — Confirmed (in-app seed issue TEA-1 links to all three, [docs guides](https://linear.app/docs/how-to-use-linear-small-teams))
- Claimed problem solved: speed and quality of the planning/building loop — from capturing customer requests to agent-executed code — vendor framing throughout the site; competitor comparisons come from reviewers positioning it against Jira's weight and price — Reported (review sample in 03)

## Complete link inventory (web release artifacts)

Every URL below was verified by fetching it on 2026-09-07 (curl status code or rendered fetch).

| Surface | Exact URL | Notes (verified / 404 / requires login) |
|---|---|---|
| Marketing site | https://linear.app/ | 200 — verified |
| Web app / login | https://linear.app/login | 200 — verified; `noindex` header observed on signup |
| Signup | https://linear.app/signup | 200 — verified; live-walked (email magic link) |
| Pricing | https://linear.app/pricing | 200 — verified |
| Docs | https://linear.app/docs | 200 — verified; TOC has no desktop-app section (noted in 04) |
| API reference | https://linear.app/developers (+ /developers/graphql, /developers/sdk, /developers/webhooks, /developers/oauth-2-0-authentication, /developers/rate-limiting) | 200 — verified |
| Status page | https://linearstatus.com (linked from /status) | 200 — verified; incident.io-hosted on Vercel |
| Blog | https://linear.app/now | 200 — verified; **/blog 301-redirects to /now** |
| Changelog / release notes | https://linear.app/changelog | 200 — verified; ~10 entries Jun 4–Sep 3 2026 |
| Community / forum | https://linear.app/join-slack | verified as in-app link target (Slack community invite); no standalone forum found |
| Customers | https://linear.app/customers | 200 — verified |
| Method (company philosophy) | https://linear.app/method | 200 — verified |
| Careers | https://linear.app/careers | 200 — verified (30 open roles cited on growth post) |
| Public GitHub org / repos | https://github.com/linear | verified via GitHub API; 14+ repos incl. `linear/linear` (SDK/tools, pushed 2026-09-07), linear-zapier, linear-airbyte-source, vscode extensions, linear-import |
| Mobile page | https://linear.app/mobile | 200 — verified |
| Agents page | https://linear.app/agents | 200 — verified |
| Asks page | https://linear.app/asks | 200 — verified |
| Coding Sessions page | https://linear.app/coding-sessions | 200 — verified |
| Download page | https://linear.app/download | 200 — verified |
| AI credits doc | https://linear.app/docs/ai-credits | 200 — verified |
| 404 finding | https://linear.app/docs/desktop | **404** — no dedicated desktop docs page (see 04) |
| Obsolete IDs found | `apps.apple.com/.../id1500310952`, `play.google.com/...?id=com.linear.app` | **404** — stale third-party references; live IDs are `id1645587184` / `app.linear` |

## Hardware touchpoint check

**No hardware integration found** — checked: marketing homepage nav/footer/copy, pricing-page SKUs (software tiers only, no device add-ons), docs nav (17 sections, no hardware), /download page, mobile store listing permission summaries on both stores (no Bluetooth/NFC/USB-accessory signals), and the agents/coding-sessions product pages. Linear is a pure software product; the closest "physical world" touchpoints are camera/photo capture for bug reports (OS-level, not proprietary hardware) — see 06 for the explicit none-finding.

## Business-scale signals (summary)

Full estimates, methods, and the bottom-up range are in 08.

| Signal | Value | Source | Tag |
|---|---|---|---|
| ARR milestone | passed $100M ARR "earlier this year" (2026) | company growth post | Confirmed (company-stated) |
| Customer count claim | "More than 40,000 companies now pay for Linear" | company growth post | Confirmed (company-stated) |
| Net revenue retention | 177% | company growth post | Confirmed (company-stated) |
| Agent adoption | Agents installed across "95% of paid Linear workspaces" | company growth post | Confirmed (company-stated) |
| Funding (latest) | $99M tender at $2.5B valuation (2026) | company growth post | Confirmed (company-stated) |
| Third-party revenue estimate | $100M ARR 2026, "$234.2M total funding" | Getlatka | Reported (algorithmic; funding figure conflicts with round-by-round ≈$135M — flagged in 08) |
| Monthly web visits | 9.4M visits over 3 months (July 2026), global rank #5,797 | Similarweb | Reported (scale indicator, not revenue) |
| Android installs | 100K+ | Google Play listing | Confirmed (store-stated) |

## Platform surfaces found

| Surface | URL | Notes |
|---|---|---|
| Marketing site | https://linear.app | Cloudflare edge → Google-infra origin (response headers) |
| Web app | https://linear.app/<workspace-slug>/... | app and marketing share the apex domain; login at /login |
| iOS app | https://apps.apple.com/us/app/linear-mobile/id1645587184 | Linear Mobile, requires iOS 18+ |
| Android app | https://play.google.com/store/apps/details?id=app.linear | 100K+ installs |
| Desktop (macOS) | https://releases.linear.app/mac | universal DMG, v1.32.4 |
| Desktop (Windows) | https://releases.linear.app/windows | Setup .exe, v1.32.4 |
| Desktop (Linux) | none found | absent from /download and release channels — finding, not a gap |
| API docs | https://linear.app/developers | GraphQL + TS SDK + webhooks + OAuth |
| Status page | https://linearstatus.com | US/EU regions × application/API/integrations |
| Public repos | https://github.com/linear | SDK, Zapier, Airbyte source, VS Code extensions, agent demos |
| Release channel host | https://releases.linear.app | serves signed installers directly |

## Tech stack signals (marketing site vs. app)

| Layer | Marketing site | App |
|---|---|---|
| Frontend framework | Next.js-family rendering (`x-nextjs-cache` + a custom `x-vinext-cache` header) — Inferred from header naming (the "vinext" prefix does not appear in stock Next.js); assets served from static.linear.app / static.linear.dev — Confirmed (CSP header) | Web app is a client-rendered SPA (app pages render after load, React-class hydration behavior) — Confirmed (observed live); job postings name TypeScript, React-class browser work, Node, GraphQL, PostgreSQL — Reported ([careers posting](https://linear.app/careers/cd5ae036-0223-427a-b038-ba16ef9dcb32), Sequoia job board) |
| Hosting/CDN | Cloudflare edge with Google-infra origin (`server: cloudflare`, `via: 1.1 google`) — Confirmed (headers) | Two-region deployment: US and EU application + API + integrations — Confirmed ([status page](https://linearstatus.com)); matches the EU-default region picker at signup — Confirmed (live signup form) |
| Analytics/monitoring | Sentry ingest endpoint in CSP — Confirmed (CSP header); Vercel insights + Google Analytics on the status page — Confirmed | — |
| Email | Amazon SES ("from" domain noreply-…@linear.app) — Confirmed (live signup email headers) | — |
| Desktop client | — | Electron-family — Inferred: Electron-Forge publisher repo owned by the org, NSIS-style "Setup <version>.exe" naming, ~200 MB installers, universal macOS binary (no public electron-builder manifest found; update channel is custom under releases.linear.app) |
| Mobile clients | — | "fully native" Swift (iOS) / Kotlin (Android) — Reported (vendor wording on [linear.app/mobile](https://linear.app/mobile)) |
| API layer | — | GraphQL endpoint (with TypeScript SDK); AI features metered through a prepaid credits wallet — Confirmed ([docs/ai-credits](https://linear.app/docs/ai-credits)) |
