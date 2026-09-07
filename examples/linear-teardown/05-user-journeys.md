# 05 — User Journeys

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

The decision-grade core of this report: what using this product actually
feels like, per platform — not what the feature list says it can do.

## Evidence-basis legend

- **Walked live** — performed in-app during this research (web app, Playwright, disposable identity; claims Confirmed)
- **Vendor-documented** — reconstructed from official docs, changelog, store listings (Reported, vendor-authored)
- **Third-party reported** — from store reviews (Reported, third-party)
- **Inferred** — deduced from indirect evidence, reasoning shown

## Personas observed

- **Founder/evaluator-admin** — creates the workspace, configures teams/integrations, owns billing (the first user IS the admin: walked live — the onboarding rail hands admin duties to whoever signs up first)
- **End user (engineer/PM)** — lives in Inbox/My issues, files and closes issues, mentions agents
- **Agent-operator** — newer persona the 2026 product explicitly serves: delegates issues to Linear Agent or third-party agents (Codex, Cursor, Copilot, Devin), reviews coding sessions
- **Requester / external stakeholder** — files asks via Slack/email/Asks; does not live in the app (vendor framing on Asks + helpdesk integrations)

## 1. Onboarding / first-run

### Web — walked live

- **Persona:** Founder/evaluator-admin
- **Entry point:** https://linear.app/signup
- **Steps:** 1. Choose Continue with Google / email / SAML SSO (three buttons — the full auth surface, confirmed) → 2. email path: enter address → magic link arrives in seconds (Amazon SES sender) → 3. "Create a workspace": Name, URL slug (`linear.app/<slug>`), **Region combobox defaulting to European Union** → 4. five-step rail: Set up your profile (name/title/photo, skippable) → Invite teammates (invite link + email invites) → Connect GitHub (three stated payoffs: review code in Linear, auto-assign issues from PR activity, code context for Linear AI) → Connect Slack (personal notification DMs) → Subscribe to updates (changelog opt-in; onboarding emails pre-checked) → 5. land on `/team/<KEY>/active` with four seeded issues (TEA-1 Get familiar with Linear, TEA-2 Connect your tools, TEA-3 Import your data, TEA-4 Set up your teams)
- **Decision points:** skip each rail step (all honored); region choice (data residency — made before the workspace exists); which integrations to connect
- **Handoffs to another platform:** GitHub/Slack steps open third-party OAuth; onboarding video embedded in seed issue TEA-1 (3:59); setup guides link to docs sized by company stage; live onboarding session link (lu.ma)
- **Friction:** solo evaluator must dismiss two integration pitches; region default (EU) may surprise users expecting US defaults — residency is decided in seconds without explanation of consequences
- **Evidence:** walked live

### iOS / Android — vendor-documented

- **Persona:** End user
- **Entry point:** store install → app requires "an existing Linear account" (both listings)
- **Steps (reconstructed):** install → login with existing credentials → notification-permission ask (vendor copy leads with "instant notifications") → Inbox-first experience
- **Decision points:** notification schedule; share-sheet capture into bug report
- **Handoffs:** account creation itself is not claimed as a mobile surface → a phone-only evaluator must start on web (documented gap, not observed live)
- **Friction:** review-reported: search placement non-standard; no drag-reorder (Play reviews 2026-07-30, 2026-09-03)
- **Evidence:** vendor-documented (store listings, /mobile page); friction third-party reported

### Desktop — inferred

- **Persona:** End user / Agent-operator
- **Entry point:** installer from /download (macOS universal DMG, Windows Setup)
- **Steps:** not observed live this run; same account system as web (Inferred — shared `linear.app` account surfaces across all clients; mobile copy confirms "existing Linear account" requirement)
- **Friction:** none documentable — no desktop-exclusive first-run claims exist
- **Evidence:** inferred (reasoning: single-account product; desktop docs section absent)

## 2. Core "aha" task end to end

### Web — walked live (two variants)

- **End-user variant:** press `c` anywhere → composer: title → description → status/priority/assignee/labels as one-tap property buttons → "Create more" toggle for batch entry → issue appears instantly in the team's Active list with an ID (TEA-5) and timestamp. Drafts auto-save ("Save as draft" appears once dirty). Friction: none observed.
- **Agent-operator variant (2026 product):** in any text field, type `@` → mention menu offers **users ("Linear — Agent") and issues**; selecting the agent delegates work. The full delegation round-trip was not completed live (my second text fill overwrote the mention token before creating the issue — operator error, disclosed); delegation behavior is vendor-documented ([agent docs](https://linear.app/developers/agent-interaction-guidelines) — Reported). What IS confirmed live: the agent is a first-class mention target, a sidebar surface, and a floating chat button on every screen.
- **Persona:** End user / Agent-operator
- **Evidence:** walked live (end-user variant Confirmed; agent round-trip Reported)

### iOS / Android — vendor-documented

- File an issue from the lock screen of life: share screenshot → Linear → bug report with attachment; or quick-access composer; swipe Inbox items to snooze/delete — vendor copy on /mobile and listings (Reported)
- **Persona:** End user
- **Friction:** review-reported mobile UX costs (search, reorder)

### Desktop — inferred

- Identical to web (same app shell, same version train) — Inferred; no desktop-exclusive variant exists in evidence

## 3. Account & team setup

- **Web — walked live:** workspace = account root; team key auto-derived (TEA); settings nav exposes Members, Teams, Security, API keys, Billing to a free single-user admin (nav-visible — Confirmed; pages not modified). Region choice at creation is the residency decision. Team creation via Settings → "Your teams" → Create a team.
- **Mobile/desktop:** administration is not claimed as a native surface anywhere (listings scope mobile to AFK work) — settings/billing stay web — Inferred from scoping copy + absence in feature lists

## 4. Churn-risk moment

- **Web:** Free plan hard caps: 2 teams, 250 issues, 10 MB uploads (pricing page — Reported; cap not hit live this run). When hit, issue creation presumably blocks with an upgrade path — NOT observed; no evidence either way, no padding here.
- **Downgrade/cancellation flow:** not walked (requires a paid plan) — honest gap.
- **Mobile:** review-reported churn-risk signal — "issues marked Done completely disappear no matter the filters I try" (Play review 2026-09-03): a findability failure at the moment of task completion.
- **Desktop:** none distinct from web.

## 5. Platform-exclusive flows

- **Web-exclusive (bulk/admin):** the entire settings surface — integrations catalog (12 categories), API keys, billing, import/export, security, SLAs, usage limits — plus bulk issue ops and view configuration. Why web: admin density + keyboard-first triage (walked live — Confirmed for surface; the "why" mapped in 07)
- **Mobile-exclusive:** OS share-sheet capture (screenshot → issue), push notifications with schedule, and since Jul 30, 2026, coding-session diff review/steering from the phone — vendor-documented (Reported). Why mobile: moment-of-stimulus capture and away-from-desk steering of agents (07)
- **Desktop-exclusive:** none confirmed this run. The desktop app's differentiation claim is performance/presence wording on /download; no tray/hotkey/offline capability is documented (04). Why it exists anyway: 07's business-objective map (distribution + switching cost + the shell for deep links/notifications)
- **Cross-platform exclusive (the 2026 bet):** the agent surface itself — Linear Agent in-app, third-party agents via integrations, MCP for AI clients — spans web/desktop/mobile (changelog cross-platform entries) — Reported

## Cross-platform handoff map

| From → To | Trigger | Supported? | Breaks where | Evidence |
|---|---|---|---|---|
| Web → Mobile | /download page shows QR codes for both stores; "Get the app" prompts | QR + store link — Confirmed (page walked) | nothing observed | Confirmed |
| Mobile → Web | account creation; admin/billing not on mobile | manual (browser) — no deep-link handoff documented | evaluator must open linear.app/signup themselves — friction if they start phone-only | Reported (listing scoping copy) |
| Desktop ↔ Web (login) | desktop app ↔ same linear.app account | Inferred supported (shared account system) — browser-auth roundtrip NOT observed live this run | unknown — flagged in 04 | Inferred (reasoning: single-account product across all clients) |
| Slack/Email → Linear | Asks intake → issues | vendor-documented; integration tile live in-app | — | Reported + Confirmed (tile exists) |
| Git → Linear | PR/commit activity → issue status; "Copy branch name" on every issue | branch-name convention is a live feature button — Confirmed; PR automation vendor-documented | requires GitHub/GitLab connect | Confirmed + Reported |
| AI client → Linear | MCP server (Cursor, Claude, ChatGPT, v0, Windsurf, Replit) | vendor-documented; tiles live | requires OAuth/API key setup | Reported + Confirmed (tiles) |
| Web → Desktop/mobile (notifications) | in-app Inbox ↔ push/native notifications | Inferred from notification copy on mobile + status-page "application" components | not directly verified | Inferred |

## Persona × platform matrix

| Persona | Primary platform | Secondary | Evidence |
|---|---|---|---|
| Founder/evaluator-admin | Web (signup, settings, billing) | Desktop (same shell) | walked live — admin surface is web-only |
| End user (engineer/PM) | Desktop or Web (the working app) | Mobile (inbox/triage away from desk) | web walked live; desktop equivalence Inferred; mobile scoping vendor-stated |
| Agent-operator | Web/Desktop (delegate, review sessions) | Mobile (steer sessions since Jul 30, 2026) | changelog Reported; mention surface Confirmed live |
| Requester/stakeholder | Slack/email (Asks intake) | — (may never open the app) | vendor framing Reported; Asks tier-gated (Business) |
| Linux engineer | Web only | — | no Linux desktop build — Confirmed absence |
