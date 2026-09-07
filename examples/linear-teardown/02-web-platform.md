# 02 — Web Platform

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Access methods used

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| Live signup + in-app walk with a disposable identity (Playwright MCP, Free plan, email magic link) | onboarding flow, navigation map, issue creation, agent mention flow, full settings/integrations catalog, responsive check at 375px | live (Confirmed) | self-serve freemium tier exists and is email-only — the preferred method per operating rules |
| Static fetches of public marketing/pricing/docs/changelog pages | pricing table, changelog cadence, API docs surface | vendor-documentary (Confirmed where fetched directly) | no account needed; primary sources |
| HTTP header inspection (curl) + GitHub API | tech-stack signals, link-inventory verification | live (Confirmed) | no Wappalyzer-class tool installed; headers + gh are the sanctioned substitute |
| Free plan limits observed from pricing copy only | which features are Business/Enterprise-gated | vendor-documentary | single-user free workspace couldn't reach Business-gated surfaces (Asks, Insights, Loops, private teams) without upgrading — not crossed |

## Navigation map

Observed live in a fresh Free workspace (`teardown-example-audit`, team key `TEA`).

| Section | Purpose | Plan tier required |
|---|---|---|
| Inbox | notification stream with unread badge; Priority tab shipped Sep 3, 2026 | Free — Confirmed (visible in free workspace) |
| My issues | assigned/created/subscribed views | Free — Confirmed |
| Agent | in-app AI agent chat (sidebar item + floating Agent button with Chat history on every screen) | Free includes Agent platform and Linear Agent per pricing copy — Confirmed (visible on Free); usage metered via AI credits for coding sessions/Loops — Reported (docs) |
| Projects / Views | cross-team planning and saved views | Free — Confirmed |
| Team section (Home, Issues, Projects, Views) | per-team workspace with Active/Backlog/All issue views | Free — Confirmed |
| Issues: filters, display options, add new view | triage and list customization | Free — Confirmed |
| Import issues (settings/import-export) | importers (e.g., from Jira) | Free — Confirmed (nav-visible) |
| Settings → AI & Agents, Initiatives, Documents, Customer requests, Releases, Pulse, Asks, SLAs, Integrations, API, Billing, Usage & limits | feature and admin surface | nav-visible on Free; Business-gated features (Asks, Insights, Loops, private teams/guests) — Reported (pricing copy); Enterprise: SAML/SCIM, audit log, IP restrictions, HIPAA — Reported (pricing copy) |
| Settings → API | personal API keys | Free — Confirmed (nav-visible) |
| Settings → Billing | plan management | nav-visible on Free — Confirmed |

## User journeys (web)

Walked live (Playwright, disposable identity). Full schema, personas, and handoff map in 05.

| Journey | Persona | Evidence basis | Key friction observed |
|---|---|---|---|
| Onboarding / first-run | End user (also de-facto Admin: first user of a new workspace is the admin) | walked live | 5-step rail (Profile → Invite → GitHub → Slack → Newsletter); GitHub/Slack steps demand real OAuth of those vendors — a solo evaluator skips both; every skip is honored |
| Core "aha" task end to end (create + shape an issue) | End user | walked live | composer reachable via `c` hotkey; rich-text @-mention menu surfaces both users and the "Linear — Agent" AI as mention targets; priority/labels/project as one-tap property buttons |
| Account & team setup | Admin | walked live | workspace creation asks Name, URL slug, **Region (EU default)** — the data-residency decision is made before the workspace exists and is hard to revisit; team key (TEA) auto-derived from workspace name |
| Churn-risk moment (plan limit / cancel flow) | Admin | not walked (would require hitting the 250-issue Free cap or a paid plan) | Free cap is 250 issues / 2 teams / 10MB uploads — Reported (pricing copy); cancel/billing flow not observed this run |
| Web-exclusive flow | Admin | walked live (settings surface) | full integrations catalog, API keys, billing, import/export, security settings are web-app surfaces; the desktop app opens the same web app in a shell (see 04) |

## Feature inventory

| Feature | Description | Plan tier | Confidence |
|---|---|---|---|
| Issues with cycles/views/labels/priority | core tracker; Active/Backlog/All presets plus custom views | Free (2 teams, 250 issues) | Confirmed (live) |
| Linear Agent (in-app AI) | sidebar Agent chat + @-mention delegation in issues/projects; agent interactions are auditable | included on Free per pricing copy | Confirmed (mention menu + sidebar live); inclusion claim Confirmed (pricing page) |
| Coding Sessions | agent writes code in a sandboxed environment (Claude Code / Codex), reviewable as PRs; reviewable from mobile since Jul 30, 2026 | requires AI credits (prepaid wallet) | Reported ([changelog](https://linear.app/changelog), [docs/ai-credits](https://linear.app/docs/ai-credits)) |
| Loops | recurring agent work on schedule/event triggers | Business/Enterprise + AI credits | Reported ([changelog Jul 20, 2026](https://linear.app/changelog)) |
| Linear Asks | Slack/email intake → issues; helpdesk workflows | Business | Reported (pricing copy; integration tile live — Confirmed tile exists) |
| Linear Insights / dashboards / data-warehouse sync | analytics layer | Business | Reported (pricing copy) |
| Documents / Team documents / Projects / Initiatives | docs and cross-team planning objects; agent-assisted drafting ("Write with Agent", agent-drafted project updates) | free-tier visible surfaces; some agent assistance credit-metered | Confirmed (settings + changelog); gating mix Reported |
| Customer requests | link customer feedback (Gong, Attio, Intercom, Zendesk, Salesforce…) to issues | Business (Zendesk/Intercom per pricing) | Reported (pricing copy) |
| Triage Intelligence | AI triage of incoming issues | Business | Reported (pricing copy) |
| Integrations catalog | 12 categories in-app (Agents, AI clients, Engineering, Customer Experience, Automations, Media & Design, Analytics, Security & Compliance, Bug Reporting, Collaboration, Linear crafted, Essentials) with "Pre-installed" badges (Arc, email-to-issue, Loom, YouTube, Descript) | mixed; Zendesk/Intercom/Salesforce tier-gated per pricing | Confirmed (catalog walked live); tier gating Reported (pricing copy) |
| MCP server | connect Cursor/Claude/ChatGPT/v0/Windsurf/Replit/Dust/Google ADK; Okta-managed and enterprise MCP auth shipped Aug 13 / Jul 2, 2026 | — | Reported ([changelog](https://linear.app/changelog); integration tiles Confirmed live) |
| Import/export | importers + data export from settings | Free — nav-visible | Confirmed (nav) |
| Keyboard-first UX | global hotkeys (e.g., `c` = new issue), command menu | Free | Confirmed (hotkey worked live) |

## Responsive behavior

- At a 375px viewport, the **logged-in web app** renders its full layout with no horizontal overflow (scrollWidth == clientWidth == 375) — Confirmed (measured live). The desktop-class sidebar UX is squeezed rather than re-designed; no dedicated mobile-web layout was observed in-app.
- A logged-in visit to `https://linear.app/` redirects into the app (no marketing pass-through) — Confirmed (live redirect observed). The logged-out marketing site at 375px was not separately verified this run for the same reason.
- Verdict: responsive web works but is not the intended small-screen experience — the native companion app is (see 03).

## Observed API domain(s)

- The web app is served from `linear.app` itself (app and marketing share the apex domain; workspaces live at `linear.app/<workspace-slug>/...`) — Confirmed (URL space observed live).
- Developer platform documents a **GraphQL API**; docs at /developers/graphql with TypeScript SDK in `github.com/linear` (`packages/sdk`), OAuth 2.0 + personal API keys, webhooks, rate limiting, and agent interaction guidelines — Confirmed (docs fetched; the browser-visible traffic domain for app operations was not separately extracted this run — the public API is the citable backend surface).
- Release channel: `releases.linear.app` (desktop installers) — Confirmed (headers).
- Email: Amazon SES; error monitoring: Sentry (`o415358.ingest.sentry.io` in CSP) — Confirmed (headers/CSP).
- Status topology: US and EU regions, each with "Linear application", "Linear API", "Integrations" components — Confirmed ([linearstatus.com](https://linearstatus.com)).

## Screenshots

No image files captured this run (accessibility-tree snapshots retained in `.playwright-mcp/*.yml` during the session; DOM quotes above are from those snapshots). Claims that say "live" rest on those DOM snapshots, not on images.
