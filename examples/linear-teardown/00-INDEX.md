# Linear — Platform Teardown

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## What this is

Linear is a software product-development platform — issue tracking, projects, documents, and since 2026 an agent-execution layer (in-app Linear Agent, third-party coding agents, and a public API surface that AI clients connect to through MCP). It is built for software teams from startup to enterprise, positioned against Jira/Atlassian and Asana, and is in the middle of repositioning itself from "the tracker teams like" to "the system where agents do the work." A private company (Linear Orbit, Inc.), it passed a company-stated $100M ARR in 2026 at a $2.5B secondary valuation.

## At a glance

| | |
|---|---|
| Company | Linear Orbit, Inc. — private; founded April 2019 (Saarinen, Lallo, Artman) |
| Founded / funding | 2019; ~$135M equity across seed/A/B/C + $99M tender at $2.5B (2026) |
| Web app | Yes — https://linear.app (app and marketing share the apex domain) |
| Native mobile app | Yes — companion class: [iOS](https://apps.apple.com/us/app/linear-mobile/id1645587184) (v1.88.0, iOS 18+), [Android](https://play.google.com/store/apps/details?id=app.linear) (100K+ installs); fully native Swift/Kotlin |
| Native desktop app | Yes — [macOS](https://releases.linear.app/mac) universal DMG + [Windows](https://releases.linear.app/windows) Setup, both v1.32.4; no Linux |
| Hardware integration | None found (checked: marketing pages, pricing SKUs, docs nav, jobs, both stores' permissions) |
| Public API | Yes — GraphQL + webhooks + OAuth + TS SDK: https://linear.app/developers |
| Pricing | Free → $10 (Basic) → $16 (Business) → Enterprise custom, per user/yearly + AI-credits usage wallet |
| Estimated business scale | $100M ARR company-stated (2026); bottom-up range $48M–$154M from 40k customers × pricing (method in 08) |
| Primary platform | Web — every other client is a lens on the same account (per 07) |

## How this was researched (access methods at a glance)

| Platform | Access method(s) used | Evidence grade | Why |
|---|---|---|---|
| Web | Free-tier signup with a disposable identity, walked live in a real workspace (Playwright MCP) | live | email-only self-serve freemium existed |
| Mobile | Both store listings fetched/rendered; /mobile vendor page; 3-review sample | vendor-documentary + third-party | no device/emulator attached; store metadata is the skill's ceiling (no APK/IPA extraction) |
| Desktop | HEAD requests against the vendor release channel; GitHub API; changelog; docs | live (artifact facts) + vendor-documentary (behavior) | installer facts verifiable without executing binaries; no install performed in this environment |
| Business/integrations | 15 research sweeps (Engine A: built-in WebSearch/WebFetch), status page, pricing/docs/changelog fetches | mixed, tagged per claim | public primary sources preferred; conflicts flagged, never merged |

Full per-platform logs: sections 02/03/04's "Access methods used." Per-fact dossier: `recon-dossier.md` alongside this report.

## Contents

- [01 — Overview & Recon](01-overview-and-recon.md)
- [02 — Web Platform](02-web-platform.md)
- [03 — Mobile Platform](03-mobile-platform.md)
- [04 — Desktop Platform](04-desktop-platform.md)
- [05 — User Journeys](05-user-journeys.md)
- [06 — Hardware Integrations](06-hardware-integrations.md)
- [07 — Integration Architecture](07-integration-architecture.md)
- [08 — Pricing, Revenue & Sources](08-pricing-revenue-sources.md)

## Biggest takeaways

- **The web app is the product; everything else is a lens on it.** Mobile is a self-described "companion" for away-from-keyboard work (and the only fully native client — Swift/Kotlin), desktop is the web app in a ~200 MB shell with zero documented exclusive capabilities, and one account spans all of them. Region is chosen at workspace creation (EU default) because the US/EU split is real infrastructure, not marketing.
- **The 2026 story is agents, and it's measurable.** Agents are installed across "95% of paid workspaces" (company-stated), the changelog ships an agent capability every 1–2 weeks (coding sessions, Loops, priority inbox, mobile steering), and monetization shifted to a prepaid AI-credits wallet ($0.25/20-min coding session + model tokens) layered on $10/$16 seats — usage revenue that scales with machine work, not headcount.
- **Free tier is a funnel with teeth:** unlimited members but 2 teams / 250 issues / 10 MB uploads — the caps bite the workspace, not the seat count, which is how a 40,000-customer base (company-stated) coexists with a $10–16 seat price.
- **The desktop app is presence, not capability** — no tray, no global hotkey, no offline mode documented anywhere; the vendor delegated quick-capture to Raycast. Linux engineers get the browser and nothing else.
- **Marketing vs. observed gaps are real but small:** "teams" on the homepage starts at paid-tier team #3; "fully native" mobile ships non-standard UX (search placement, no drag-reorder per recent reviews); and the onboarding's best moments (PR automation, agent code context) are exactly what a solo trial must skip.

## Confidence & gaps

What could not be verified this run, and why:

- **Mobile journeys were not walked** — no device/emulator in this environment, and both apps require an existing account; everything mobile is vendor-documented or review-sourced, and says so.
- **The desktop app was never executed** — installer facts are header-verified, but the login roundtrip, first-run behavior, and native notification plumbing are Inferred, not observed. Electron-family is an inference with four converging signals, short of confirmation (custom update channel, no public manifest).
- **Real-time sync mechanism** — the multi-client immediacy is the product's core promise, but the transport (websocket/push specifics) was not directly verified; the status page confirms subsystems, not protocols.
- **Agent delegation round-trip** — the @-mention surface and agent surfaces are confirmed live, but the full delegate→reply cycle was not completed live (the test issue's mention token was overwritten during creation — operator error, disclosed in 02/05); delegation behavior is vendor-documented.
- **Churn-risk journey** — the 250-issue Free cap and cancellation flow were not reached without a paid plan; no evidence either way, no padding.
- **Changelog→desktop version mapping** — desktop releases carry no public per-version feed; the changelog is the dated record, version numbers on installers only.
- **Make/n8n directory listings, iOS/Android per-store version histories, Sensor Tower-class app revenue** — searched, not found; recorded as not-found rather than guessed.
- **Third-party revenue estimates conflict** — Getlatka's "$234.2M total funding" contradicts the round-by-round press sum (≈$135M); both are shown, neither merged (08).
