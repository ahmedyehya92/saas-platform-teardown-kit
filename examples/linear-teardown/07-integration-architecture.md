# 07 — Integration Architecture

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Cross-platform summary

| Platform | Auth model | Data source / API domain | Sync behavior | Notification path |
|---|---|---|---|---|
| Web | Email magic link / Google / SAML SSO (all three live at signup) — Confirmed | The app IS linear.app (workspace URLs `linear.app/<slug>`); public GraphQL API documented at /developers with OAuth 2.0 + API keys — Confirmed (docs) | In-app changes render immediately; real-time architecture is company-design lore but was not directly verified this run — Inferred (multi-client immediacy observed on one client only) | In-app Inbox + unread badges — Confirmed (live); email for magic links — Confirmed |
| Mobile (iOS/Android) | "Requires an existing Linear account" — same account system as web — Confirmed (store copy) | Same backend per companion positioning + same workspace model — Inferred (no separate mobile API exists or is documented) | Push-fed ("instant notifications", configurable schedule) — Reported (vendor copy); FCM/APNs channel — Inferred (standard for push) | Push notifications — Reported (vendor copy) |
| Desktop (macOS/Windows) | Same linear.app account — Inferred (browser-auth roundtrip not observed live) | Packaged shell over the same web app (same version train, same workspace URLs) — Inferred (signals in 04) | Same as web (it is the web client) — Inferred | Native notifications expected of any packaged client; not documented — Inferred |

**Single source of truth: the web app.** Every other client is a lens on the same account: mobile is an explicit "companion" (vendor's word), desktop is a packaged shell of the same application, and the status page confirms one backend per region ("Linear application", "Linear API", "Integrations" × US/EU) — Confirmed ([linearstatus.com](https://linearstatus.com)). The region model explains the signup Region selector (EU default): customers pick data residency before their workspace exists, and the status topology shows the two regions are real deployments, not marketing — Confirmed.

## Integration business-objective map

| Integration point | Technical evidence | Business objective it serves | Tag & reasoning |
|---|---|---|---|
| Shared account across web/mobile/desktop | mobile listings: "requires an existing Linear account"; workspace URLs shared across clients | Zero-friction multi-device adoption — try on web, continue anywhere; no per-platform re-marketing | Inferred (reasoning: single account + companion framing; no vendor strategy doc cited) |
| EU/US region picker at workspace creation | live signup form defaults to EU; status page runs two real regions | Enterprise data-residency compliance unlocked at signup, not at sales call — removes an enterprise objection early | Confirmed for the artifacts (live form + status topology); the objective is Inferred (reasoning: residency is the standard reason to region-split a SaaS) |
| Mobile companion scoped to "away from keyboard" | store copy: file issues, notifications, update issues/projects/documents; no admin/billing claims | Keep the inbox moving when the desk is gone; protect the core loop's latency (triage happens on the phone, configuration stays on web) | Confirmed (vendor-stated scoping copy) |
| Desktop app with no exclusive capabilities | /download offers macOS/Windows only; no tray/hotkey/offline documented; ~200 MB shells (04) | Distribution and presence: occupy the dock, keep the brand one click from the engineer's whole day; cheap to maintain because it's the web app in a shell | Inferred (reasoning: wrapper-class app + shared version train = the "why" is presence, not capability) |
| Email magic-link auth (no passwords at signup) | live signup flow; SES sender domain | Removes password friction from the top of the funnel; SSO (SAML) held for Enterprise where buyers pay for it | Confirmed for the mechanism (walked live); objective Inferred |
| GitHub/GitLab integrations (code reviews in Linear, PR→issue automation, agent code context) | onboarding step promises all three explicitly; "Copy branch name" button on every issue; integration tiles live | Anchor Linear inside the engineering workflow so the issue tracker and the code move together — and feed the AI agent codebase context | Confirmed (vendor-stated payoffs in onboarding copy, walked live) |
| Slack two-way (issue creation from messages, thread sync, Asks intake) | Essentials slot; Asks tile; Slack step in onboarding | Capture work at the moment it's spoken about (Slack is where requests happen); Asks extends Linear into a helpdesk for Business tier | Confirmed for existence (live tiles); objective Inferred (reasoning: capture-at-source is the stated product pattern for intake) |
| Agent platform: Linear Agent + third-party agents (Codex, Cursor, Copilot, Devin, Factory, Sentry Agent) + AI clients via MCP | in-app Agents + AI-clients categories walked live; changelog ships agent features every 1–2 weeks; "agents installed across 95% of paid workspaces" | Reposition from tracker to execution layer — issues become jobs for machines; each agent integration deepens the moat (work product lives in Linear) | Confirmed (company-stated adoption figure + live catalog + changelog cadence) |
| AI-credits wallet (Stripe prepaid, coding sessions + Loops metered) | [docs/ai-credits](https://linear.app/docs/ai-credits) — Confirmed (fetched) | Monetize agent usage without repricing seats — seats stay predictable, machine usage passes through provider costs with margin | Confirmed (mechanism documented); objective Inferred (reasoning: usage-billing is the standard answer to variable AI costs) |
| Webhooks + public GraphQL API + OAuth | /developers surface: GraphQL, TS SDK, webhooks, OAuth 2.0, rate limiting, AIG | Platform strategy: make Linear the system of record that other tools and agents read/write — ecosystem pull, not just features | Confirmed (surface documented) |
| Zapier listing (9000+ app reach) | zapier.com/apps/linear/integrations | Long-tail automation coverage without building every connector | Confirmed (listing) |
| Data-warehouse sync (Fivetran, Airbyte, Google Sheets) + Insights on Business | integration tiles live; pricing copy | Make Linear data readable where executives already are — supports the up-tier motion to Business | Confirmed (tiles) / Reported (tiering) |
| Status page as separate property (linearstatus.com, incident.io on Vercel) | headers + CSP observed | Trust signaling for enterprise buyers; separate infra so status truth survives product outages | Confirmed (artifacts); objective Inferred |

## Narrative

Linear runs a **web-primary, companion-everything-else architecture with one account and one backend per region**. The web app is the product: it lives on the same domain as the marketing site, holds all administrative surfaces, and is the only platform where the full settings/integrations catalog exists. The macOS and Windows desktop clients are packaged shells of that same web application (shared version train 1.32.4, Electron-family signals, no documented exclusive capabilities) — they buy presence, not features. The mobile apps are the deliberate exception, built fully native (Swift/Kotlin per the vendor) and scoped by the vendor's own copy to "away from keyboard" work: inbox triage, filing from the share sheet, and — since July 2026 — steering agent coding sessions from the phone.

The integration posture is that of a platform, not an app: a public GraphQL API with OAuth and API keys, webhooks, a TypeScript SDK, an agent interaction spec for third-party agents, an MCP server for AI clients, and an in-app catalog of 12 integration categories including eight third-party coding agents. Every 1–2 weeks the changelog extends the same theme: capture work (Asks, Slack, email, customer-request integrations), turn it into issues, and hand execution to machines — with usage metered through a prepaid AI-credits wallet layered on per-seat pricing.

The evidence for "one backend" is circumstantial but convergent: one account system (mobile requires "an existing Linear account"), one workspace URL space across clients, one changelog for all platforms, and a status page describing exactly three subsystems (application, API, integrations) in two regions. What was not directly verified this run: the desktop login roundtrip, the mobile push channel's specific plumbing, and the realtime sync mechanism — each is labeled Inferred where it appears above.

## Public API & integration ecosystem

- **Public API:** yes — GraphQL; docs at https://linear.app/developers (+ /developers/graphql); auth via OAuth 2.0 or personal API keys; rate limiting documented; agent interaction guidelines published — Confirmed (docs fetched)
- **Webhooks:** yes — documented at /developers/webhooks — Confirmed (docs surface)
- **Official integrations marketplace:** https://linear.app/integrations — 72 listings across 12 categories, vendor-attributed ("By Linear" / third-party names); in-app settings catalog mirrors it with "Pre-installed" badges (Arc, email-to-issue, Loom, YouTube, Descript) — Confirmed (fetched + walked live)
- **Zapier:** yes — https://zapier.com/apps/linear/integrations (Linear connects to 9000+ Zapier apps); official `linear-zapier` repo public — Confirmed
- **Make / n8n listings:** not verified this run (targeted searches did not surface them) — honest gap, not a "no"

## Notable mismatches between marketing claims and observed reality

- **"The product development system for teams and agents" (homepage)** vs. a Free plan capped at 2 teams and 250 issues — the "teams" plural is a paid feature; the free tier is effectively single-team. Pricing copy — Reported (not hit live).
- **Desktop availability framing** ("Available for Mac, Windows…") vs. no Linux build at all in the release channels — a dev-tool shipping no Linux client is a real positioning cost; the browser absorbs it. Confirmed (absence observed).
- **"Fully native" mobile** vs. review-reported non-standard UX patterns and missing basics (drag-reorder, search placement) — native does not mean polished on every flow yet (Play reviews 2026-07-30, 2026-09-03). Third-party Reported.
- **Agent ubiquity claims** ("95% of paid workspaces" with agents installed) vs. agent *usage* economics — coding sessions and Loops require a prepaid credits wallet; "installed" is not "used". Both facts are confirmed; the gap is interpretive.
- **Onboarding rail's integration-first pitch** (GitHub, Slack steps before first use) vs. an evaluator skipping both — the product's strongest moments (PR automation, agent code context) are exactly the ones a solo trial cannot reach. Walked live — Confirmed.
