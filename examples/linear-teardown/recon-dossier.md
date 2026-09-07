# Recon Dossier — Linear (linear.app)

- **Teardown target:** https://linear.app
- **Product:** Linear — "the product development system for teams and agents"
- **Run date:** 2026-09-07 (all facts current as of this date; freshness noted per fact where it matters)
- **Engine:** Engine A (built-in WebSearch/WebFetch) — Phase 5 sweeps. `agy` present on PATH but excluded from this run by operator instruction; Engine A is the skill's default path.
- **Live-audit tier:** Playwright MCP browser (Phase 1).
- **Output discipline:** every fact = {claim, source URL, confidence}. Confidence labels: Confirmed (directly observed), Reported (third-party/press states), Inferred (reasoning shown).

---

## 1. Surface inventory (verified 2026-09-07)

| Surface | URL | Status | Verified how |
|---|---|---|---|
| Marketing home | https://linear.app/ | 200 | curl + Playwright |
| Web app login | https://linear.app/login | 200 | curl (301-consistent, no index) |
| Signup | https://linear.app/signup | 200, `noindex` | curl headers |
| Pricing | https://linear.app/pricing | 200 | WebFetch |
| Changelog | https://linear.app/changelog | 200 | curl |
| Integrations directory | https://linear.app/integrations | 200 | WebFetch |
| Developers/API | https://linear.app/developers | 200 | curl |
| Docs | https://linear.app/docs | 200 | curl |
| Download | https://linear.app/download | 200 | WebFetch |
| Mobile page | https://linear.app/mobile | 200 | WebFetch |
| Agents | https://linear.app/agents | 200 | curl |
| Asks | https://linear.app/asks | 200 | curl |
| Coding Sessions | https://linear.app/coding-sessions | 200 | curl |
| Customers | https://linear.app/customers | 200 | curl |
| Method (company philosophy) | https://linear.app/method | 200 | curl |
| Now (company blog) | https://linear.app/now | 200 | curl — note `/blog` 301-redirects to `/now` |
| Growth post (primary revenue source) | https://linear.app/now/sharing-growth-with-the-people-building-linear | 200 | WebFetch |
| Status page | https://linearstatus.com (reached from /status) | 200 | curl headers |
| GitHub org | https://github.com/linear | 200 | curl |
| iOS App Store | https://apps.apple.com/us/app/linear-mobile/id1645587184 | 200 | WebFetch |
| Google Play | https://play.google.com/store/apps/details?id=app.linear | listed on /mobile and /download; fetched in Phase 2 | WebFetch |
| macOS desktop build | https://releases.linear.app/mac | cited on /download | WebFetch |
| Windows desktop build | https://releases.linear.app/windows | cited on /download | WebFetch |

- {/blog redirects to /now, https://linear.app/blog → https://linear.app/now, Confirmed — curl -L}
- {404 findings from stale-memory URLs: apps.apple.com/id1500310952 and play.google.com/details?id=com.linear.app both 404; correct IDs are id1645587184 and app.linear — Confirmed, proves store IDs must come from live sources, not memory}

## 2. Tech-stack fingerprint (manual header/script inspection — no Wappalyzer-class tool installed)

**Marketing domain (linear.app):**
- {Cloudflare edge (server: cloudflare), origin behind Google infra (`via: 1.1 google`), Confirmed — response headers 2026-09-07}
- {Next.js-generated headers `x-nextjs-cache: HIT` + `x-vinext-cache: HIT` — "vinext" suggests a custom/variant Next runtime, Inferred from header naming, reasoning: proprietary header prefix appears nowhere in stock Next.js}
- {CSP allowlists `static.linear.app` and `static.linear.dev` for assets and Sentry ingest `o415358.ingest.sentry.io` → Sentry error monitoring on the marketing site, Confirmed — CSP header}
- {linearstatus.com: Vercel-hosted, built on incident.io (CSP names `status-page-...incident-io-team.vercel.app`), Confirmed — CSP/headers}

## 3. Company-level facts

- {Founded April 2019 by Karri Saarinen (CEO), Jori Lallo, Tuomas Artman, LinkedIn profile, Reported}
- {Series A $13M led by Sequoia, TechCrunch (via TechCrunch social post), Reported}
- {Series B $35M led by Accel, Sept 14 2023, ~$400M valuation, Forbes, Reported}
- {Series C $82M led by Accel at $1.25B valuation, 2025, TechCrunch/Traded (LinkedIn), Reported}
- {2026: $99M tender offer at $2.5B valuation; Accel and 01A participated, new investors Salesforce Ventures and S32; prior tender "last year" alongside Series C, https://linear.app/now/sharing-growth-with-the-people-building-linear, Confirmed (primary)}
- {Total equity funding ≈ $135M (13 + 35 + 82 + ~5 seed); a third-party estimate of $234.2M total funding (Getlatka) conflicts with the round-by-round press figures — treating the round-by-round sum as better-sourced and flagging the conflict, Reported}
- {ARR passed $100M "earlier this year" (2026), primary post, Confirmed (primary, company-stated)}
- {More than 40,000 companies pay for Linear, primary post, Confirmed (primary, company-stated)}
- {Net revenue retention 177%, primary post, Confirmed (primary, company-stated)}
- {Agents installed across 95% of paid Linear workspaces, primary post, Confirmed (primary, company-stated)}
- {Named customers on growth post: Salesforce, Figma, OpenAI, Cursor, Cognition, Ramp, Coinbase, Legora, Baseten, Confirmed (primary)}
- {Not publicly traded; no public filings found (checked via search, Sweep 11), Reported}

## 4. Pricing (from pricing page, Confirmed)

- Free $0: unlimited members, 2 teams, 250 issues, 10MB uploads; includes Agent platform and Linear Agent
- Basic $10/user/mo (yearly billing): 5 teams, unlimited issues, admin roles
- Business $16/user/mo: unlimited teams, private teams/guests, Triage Intelligence, Loops, Code Intelligence, Linear Insights, Linear Asks, Zendesk/Intercom integrations, dashboards, data warehouse sync
- Enterprise: custom, annual billing, SAML/SCIM, audit log, IP restrictions, HIPAA, SLA
- Add-ons: Salesforce integration (price not listed); AI features (Coding Sessions, Loops) require "AI credits" with pricing in docs
- {No monthly-billing prices shown on pricing page — yearly rates only, Confirmed}

## 5. Apps & distribution

- iOS: Linear Mobile, seller Linear Orbit Inc., v1.88.0 (updated ~5 days before 2026-09-07), 176.2 MB, requires iOS 18.0+, iPhone+iPad, free, 4.8★ (2.1K ratings), Business category, "companion to the Linear desktop app", requires existing account, App Store, Confirmed
- Android: Google Play id `app.linear`, listed on linear.app/mobile and /download — Confirmed for URL; metadata fetched in Phase 2
- Mobile built "fully native" — Swift (iOS) and Kotlin (Android) per linear.app/mobile, Confirmed (vendor-stated)
- Desktop: macOS `releases.linear.app/mac`, Windows `releases.linear.app/windows`; no Linux installers shown on /download; no Apple Silicon/Intel split shown on page — Confirmed (absence observed); deeper per-arch detail in Phase 3
- Desktop app availability claim on /download: "web, macOS, Windows, iOS, and Android" — Confirmed; note the site says "desktop app" (plural-OS) but the page lists only Mac/Windows

## 6. Hardware check (Phase 0 step 5, seconded by playbook 08)

- Landing page, pricing, mobile, and download pages: no physical device, reader, terminal, scanner, printer, wearable, sensor, kiosk, dongle, or beacon mentioned anywhere — Confirmed (absence observed on 6 key pages, 2026-09-07)
- Working answer for the hardware finding: **none found** — Linear is a pure software product; no FCC-ID search warranted (no plausible hardware filings). Per-surface pairing matrix in the report states "not applicable" per platform rather than "unchecked".

## 7. Per-surface access plan (Phase 0 step 4 triage)

| Surface | Access decision |
|---|---|
| Web app (linear.app) | Self-serve freemium (Free plan, email-only) → USE with disposable identity via Playwright |
| iOS app | Store-listing metadata only (skill ceiling: no IPA extraction). No iOS device in this environment — companion-app claims sourced from listing + vendor pages |
| Android app | Store-listing metadata only (no APK extraction) |
| macOS/Windows desktop | Installer URLs + release channels + changelog; no executable download/extraction in scope. Desktop jourms walked via live web app + official docs, labeled accordingly |
| Public API / webhooks | Public docs are open → read live, no credentials needed; GraphQL endpoint existence confirmed via docs |
| Enterprise/Salesforce add-on pricing | Contact-sales → flag; no-credential ladder applies, no misrepresentation to sales |
| Status page, changelog, GitHub | Public → fetch directly |
| Linearstatus.com | Public → headers + page fetch |

Signup requirements observed at triage: email-only self-serve (no card, no ID) → in scope.

## 8. Open questions carried into Phases 1-5

1. Exact desktop artifact inventory per OS/arch + version history (Phase 3)
2. API/webhook surface details (Phase 5 sweeps 5, 14)
3. Traffic proxies (sweep 10), filings confirmation (sweep 11), competitive set (sweep 15)
4. Live signup + journey behavior (Phase 1, Playwright)
5. Store-listing parity between iOS and Android listings (Phase 2)

---

## 9. Phase 1-5 sweep results (appended as gathered; dates 2026-09-07)

### Phase 1 live-web findings (Playwright, walked with disposable account <temp-mail burner address, redacted pre-publication>, workspace `teardown-example-audit`, team key TEA)
- {Signup offers exactly three methods: Continue with Google / email / SAML SSO, https://linear.app/signup, Confirmed (live DOM)}
- {Email signup = passwordless magic link ("What's your email address?" → link emailed); sender is `noreply-1c89f5e93bc84940516b2375@linear.app` via Amazon SES, Confirmed (live + inbox)}
- {Workspace creation form: Name, URL slug (linear.app/<slug>), Region selector defaulting to "European Union", Confirmed (live)}
- {Onboarding sequence: Set up your profile (name/title/photo) → Invite teammates (invite link + email invites) → Connect GitHub (code reviews in Linear, auto-assign from PRs, "code context for Linear AI") → Connect Slack (personal notifications DMs) → Subscribe to updates (changelog bi-weekly opt-in, onboarding emails on by default) → lands on /team/TEA/active with 4 seeded issues (TEA-1 Get familiar with Linear, TEA-2 Connect your tools, TEA-3 Import your data, TEA-4 Set up your teams), Confirmed (walked end-to-end)}
- {Sidebar: Inbox (unread badge), My issues, Agent (first-class), Projects, Views, More; per-team: Home/Issues/Projects/Views; "Try" nudges: Import issues (import-export settings), Invite people, Connect GitHub deep-links, Confirmed (live DOM)}
- {Issue detail: embedded onboarding video (3:59) with player controls, per-stage setup guides linking to /docs/how-to-use-linear-{small-teams|startups-mid-size-companies|large-scaling-companies}, join-slack + lu.ma live onboarding session links, Copy issue URL/ID/branch-name buttons, Work on issue, sub-issues, reactions, attachments, properties (status/priority/assignee), labels, project, activity feed, subscribers, Confirmed (live)}
- {@-mention autocomplete in composer lists "Linear — Agent" as a user-type mention target plus issue references; Confirmed (live DOM). Agent round-trip reply NOT observed live — my second fill overwrote the mention token before create (operator error); delegation documented from vendor docs instead, Reported}
- {Create-issue dialog reachable via global "c" hotkey; fields: team (locked TEA), title, description, status defaulting Todo/Backlog, priority, assignee, labels, "Create more" checkbox; drafts save automatically ("Save as draft" appears once dirty), Confirmed (live)}
- {Settings nav (full inventory): Personal (Preferences, Profile, Notifications, Code & reviews, Security & access, Connected accounts, Agent personalization); Issues (Labels, Templates, SLAs); Projects (Labels, Templates, Statuses, Updates); Features (AI & Agents, Initiatives, Documents, Customer requests, Releases, Pulse, Asks, Emojis, Integrations); Administration (Workspace, Teams, Members, Security, API, Applications, Billing, Usage & limits, Import & export), Confirmed (live DOM)}
- {In-app integrations catalog (settings page, live): 12 categories — Essentials (GitHub, Slack, GitLab, Figma, Intercom, Google Sheets), Agents (Codex, Cursor, GitHub Copilot, Factory, Sentry Agent, Devin, ChatPRD, Charlie + more), AI clients (Cursor MCP, ChatGPT, Claude, v0 by Vercel, Windsurf, Replit, Dust, Google ADK + more), Engineering (GitHub, GitLab, PagerDuty Triage Responsibility, Sentry, VS Code, Datadog, incident.io, Raycast + more), Linear crafted (incl. Notion, Linear Asks for Slack), Bug Reporting (Asks, Sentry, incident.io, Bird Eats Bug, Honeybadger, Jam, Vercel, Arc), Automations (Zapier, Create issues via email, Jira, Raycast, Fivetran, Circleback, Fillout, Harvest + more), Customer Experience (Zendesk, Intercom, Front, Salesforce, Attio, Gong, Productlane, Arkweaver + more), Collaboration (Slack, Asks, Notion, Discord, Glean, Attio, Productlane, Range + more), Media & Design (Figma, Claap, Descript, Loom, Miro, YouTube, Tella, Canva AI Connector, Screenpresso), Analytics (Airbyte, Google Sheets, Fivetran, Retool, Span, Jellyfish, Basedash, Hill Charts by Curious Lab), Security & Compliance (Cloudback, Fencer, Kawach AI, SecureSlate, Vanta, Drata, Orca Security, SimpleBackups) — several marked "Pre-installed" (Arc, Create issues via email, Descript, Loom, YouTube), Confirmed (live DOM 2026-09-07)}
- {Billing/API keys reachable by a free-plan single-user workspace admin (Settings → API, → Billing) — admin surface not gated behind paid plan in navigation, Confirmed (nav visibility; pages not modified)}

### Phase 2 mobile findings
- {Google Play: "Linear", developer Linear Orbit, Inc (matches iOS seller Linear Orbit, Inc.), 4.9 stars, ~1.23K reviews (1,098 five-star + 109 four-star displayed), 100K+ downloads, updated Sep 2, 2026, category Productivity, https://play.google.com/store/apps/details?id=app.linear, Confirmed (live Playwright DOM)}
- {Play description: "companion to the Linear desktop app... away from your keyboard: file issues on-the-go, stay up-to-date, instant notifications, update issues, projects, and documents from anywhere. Requires an existing Linear account.", Confirmed (listing text)}
- {Play "What's new": "Linear Mobile has arrived... fast, compact, and fully native Android application" — arrival phrasing suggests the Android app is recent; exact release date not shown, Reported (vendor wording)}
- {Review friction sample (3 recent): 5★ praises free tier vs "Jira/Atlassian... expensive subscription models"; 3★ (2026-07-30): non-standard mobile UX, search "buried", "faster for me to connect Claude to Linear and add issues through Claude" (AI handoff替代 mobile UI); 1★ (2026-09-03): no drag-reorder, Done issues "disappear" from filters, Confirmed (review text as displayed)}
- {iOS v1.88.0 (2026-09-02) vs Android listing without displayed version — parity per-store cannot be certified from listing alone; Reported}
- {No camera/location/contacts/Bluetooth/NFC/USB hardware-permission signals surfaced on either listing's summary sections — hardware check pass 2: none found, Confirmed (absence in listing data reviewed)}

### Phase 3 desktop findings
- {macOS: https://releases.linear.app/mac serves `Linear-1.32.4-universal.dmg`, 213,054,457 bytes (~203 MB), content-type application/x-apple-diskimage — **universal binary** (Intel + Apple Silicon in one), version 1.32.4, Confirmed (HTTP headers)}
- {Windows: https://releases.linear.app/windows serves `Linear Setup 1.32.4.exe`, 199,133,832 bytes (~190 MB), Confirmed (HTTP headers)}
- {No Linux build in the download channels checked; /download page lists only macOS + Windows + mobile, Confirmed (absence observed)}
- {electron-builder-standard update manifests (latest.yml / latest-mac.yml) 404 under releases.linear.app paths tried (mac/latest-mac.yml, win|windows/latest.yml, mac/stable/*) — update channel is custom, not the default electron-builder layout, Confirmed (404s)}
- {GitHub org github.com/linear: `linear/linear` (TypeScript, 1,587 stars, "Tools, SDKs and plugins for Linear", pushed 2026-09-07), plus linear-zapier, linear-airbyte-source, vscode extensions, linear-import, and an Electron Forge Google-Storage publisher repo (2022) — Electron-family signal, Confirmed (gh api)}
- {Desktop version 1.32.4 (2026-09-07) vs iOS 1.88.0 — separate versioning tracks per platform, Confirmed}
- {Desktop-app changelog mentions date back to at least 2019 (e.g., "New version for Linear desktop application", changelog 2019-06-20), Reported}
- {No dedicated desktop docs section found in /docs TOC (sections: Getting started, Account, AI, Your sidebar, Teams, Issues, Issue properties, Projects, Initiatives, Cycles, Views, Find and filter, Linear Asks, Integrations, Analytics, Administration, Importers) — desktop capabilities under-documented on vendor docs; desktop-specific extras (menu-bar icon, global shortcuts beyond in-app ⌘K command menu) NOT confirmed this run; third-party Raycast extension covers "create, search, modify issues from anywhere" per in-app integration copy, Confirmed for the gap + Raycast copy, Reported for any native extras}

### Phase 5 sweep results
1. Company facts — RAN: founded Apr 2019 (Karri Saarinen LinkedIn; Wayback earliest linear.app capture 2019-04-18 corroborates); three co-founders; funding timeline below; headcount ~50 (2023 Forbes "fewer than 50") and "30 open roles" on the 2026 growth post.
2. App store presence — RAN: iOS id1645587184 (Linear Mobile, Linear Orbit, Inc., v1.88.0, updated ~2026-09-02); Play id app.linear (Linear Orbit, Inc, 100K+, updated 2026-09-02). Same publisher both stores.
3. Desktop distribution — RAN: macOS universal DMG 1.32.4 + Windows Setup 1.32.4; no Linux.
4. Integrations directory — RAN: /integrations = 72 listings, 12 categories, "By Linear" vs third-party labels; in-app settings catalog (12 categories, pre-installed set); Zapier: linear integrates with 9000 apps (zapier.com/apps/linear/integrations). Make/n8n listings: not verified in this run (searches did not surface them) — gap flagged.
5. Public API — RAN: GraphQL (REST mentioned in migration contexts), docs at linear.app/developers (+ /developers/graphql), TypeScript SDK only (github.com/linear/tree/master/packages/sdk), OAuth 2.0 + personal API keys, webhooks supported (/developers/webhooks), rate-limiting docs, agent interaction guidelines (AIG); public schema via Apollo Studio referenced by docs.
6. Pricing tiers — RAN: Free/Basic $10/Business $16/Enterprise custom (yearly-billed per-seat); differentiators: team count, issues cap (Free 250), private teams+guests, Asks, Insights/dashboards, data-warehouse sync, Zendesk/Intercom, SAML/SCIM/audit log/HIPAA; AI features monetized separately via prepaid AI-credits wallet (docs/ai-credits: pooled workspace USD balance, Stripe top-up, coding sessions + Loops consume credits, opt-in).
7. Tech-stack corroboration — RAN: job postings (Senior/Staff Fullstack: "database models to GraphQL resolvers and UI components"; Product Engineer AI: "TypeScript... Browser, Node, GraphQL, PostgreSQL"; Solutions Eng: "OAuth2, GraphQL") at linear.app/careers + Sequoia job board (Node, GraphQL, TypeScript, Postgres); third-party breakdowns: platformchecker.com (TS+GraphQL+AWS), performance.dev (React, TS, MobX, Postgres, CDN; no RSC/no edge DB); Elixir→TypeScript migration history (Pragmatic Engineer / CTO Tuomas Artman commentary). Direct fingerprints: Cloudflare edge → Google infra origin, Next.js-family rendering (x-nextjs-cache + x-vinext-cache), Sentry monitoring, marketing assets on static.linear.app/linear.dev, status on Vercel+incident.io, email via Amazon SES.
8. Revenue/scale — RAN, kept separate per integrity rule: (a) company-stated: passed $100M ARR "earlier this year" (2026), 40,000+ paying companies, 177% NRR (primary post, linear.app/now/sharing-growth...); (b) third-party: Getlatka "$100M ARR 2026, up from $8.4M 2023, $2.5B valuation, total funding $234.2M" (conflicts with round-by-round ≈$135M — flagged); (c) rounds: seed ~$1.9-5M (2019, various — not separately verified), Series A $13M Sequoia (2020), Series B $35M Accel @ ~$400M (Sep 2023), Series C $82M Accel @ $1.25B (2025), $99M tender @ $2.5B (2026, Accel/01A + new Salesforce Ventures & S32).
9. Mobile traction — RAN: no Sensor Tower/Appfigures/data.ai estimates found in public results ("not found" per sweep rule); official store figures only: 100K+ Play installs, 2.1K iOS ratings.
10. Web traffic proxy — RAN: Similarweb (fetched 2026-09-07, July 2026 data): 9.4M visits/3 months, +9.35% MoM, 7:26 avg duration, 6.47 pages/visit, 31.98% bounce, 79.1% direct, Global rank #5,797, US #3,442, Category #114; top countries US 35.49%, India 8.82%, UK 5.15%. Traffic proxy, not revenue.
11. Public filings — RAN: no SEC/other public filings found for Linear Orbit, Inc.; privately held; app-store seller "Linear Orbit, Inc." is the legal entity. Earlier sweep hits for "Linear Systems" were unrelated industrial companies (disambiguation finding).
12. Customer-count claims — RAN: "More than 40,000 companies now pay for Linear" (exact wording, primary 2026 post); named customers: Salesforce, Figma, OpenAI, Cursor, Cognition, Ramp, Coinbase, Legora, Baseten.
13. Hardware filings — SKIPPED per playbook condition (Phase 0 found no hardware; two-pass store-permission check also negative). No FCC search warranted.
14. Changelog — RAN: linear.app/changelog, ~10 entries Jun 4–Sep 3 2026 (≈ one every 1-2 weeks). Recent: Sep 3 Priority inbox (agent-drafted projects, mobile doc editing, third-party app approvals); Aug 20 Coding sessions environments + browser testing + "lower, more transparent pricing" AI credits; Aug 13 Team initiatives + MCP Okta auth; Jul 30 Coding sessions on mobile (diff review, steer agent sessions) + Guided Reviews GA + GitHub Copilot; Jul 20 Loops (recurring agent work; Business/Enterprise); Jun 11 Coding sessions GA (Claude Code + Codex, "~30% of internal bugs auto-resolved"); Jun 4 Team documents.
15. Wayback — RAN (CDX API): earliest capture of linear.app 2019-04-18; snapshots span 2019→2026 (yearly collapse shown); corroborates launch year.
