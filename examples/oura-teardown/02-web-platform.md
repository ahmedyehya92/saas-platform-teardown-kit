# 02 — Web Platform

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Access methods used

**This run was Tier 0: static fetches of public pages only. No browser was
driven (no Playwright, no agent-browser, no headless session), no account
was created, and no network layer of the logged-in app was observed. Per
the skill's degradation rule, every UI-behavior claim in this section is
`Reported`, not `Confirmed`. What *is* `Confirmed` is what a static fetch
directly returns: page content, headers, CSP, API-doc text, and status-page
data.**

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| Static fetch of marketing pages (homepage, membership, store, integrations, why-oura) | positioning, pricing, partner names, store pricing | vendor-documentary (page content Confirmed as vendor-published; product behavior stays Reported) | no browser access this run; public pages are the primary surface |
| Static fetch + header/CSP read of cloud.ouraring.com | web app existence, title "Oura on the web", third-party services (Sentry, LaunchDarkly, Segment, Decagon) via CSP | live (headers directly observed) | app is JS-rendered; headers are the observable layer without a browser |
| Vendor blog post "Explore Oura on the Web" (2024-02-08) | the web app's differentiated features, in the vendor's words | vendor-documentary | rung 1 of the no-credential ladder |
| Help-center articles (Zendesk) | setup/billing/cancel flows, app-mandatory setup | vendor-documentary | rung 3 |
| API docs (cloud.ouraring.com/docs) | auth model, v1 sunset, app registration limits | vendor-documentary | rung 7 |
| Status page | live component list + uptime | vendor-operated status system (directly observed) | public infrastructure surface |

Not used this run (by run scope): disposable-identity signup, live DOM
walk, network-tab observation. Oura's web app is free only for ring
owners; signup is possible but the ring-pairing stage cannot proceed
without hardware, so a live account would have produced limited extra
ground truth — and this run's constraint forbids it.

## Navigation map

| Section | Purpose | Plan tier required |
|---|---|---|
| ouraring.com: Shop (Rings: Ring 5, Ring 4; accessories) | hardware commerce (cart, checkout) | none |
| ouraring.com: Your Health, Why Oura, How it Works, Health Radar, Blog | content marketing | none |
| ouraring.com: Membership | membership pricing page | none |
| ouraring.com: Integrations | partner directory | none |
| ouraring.com: Careers / Organizations | hiring, B2B lead-gen | none |
| cloud.ouraring.com | member web app: trends, comparisons, data export | Oura account + (for most data) active membership |

Navigation map is Confirmed from fetched pages; in-app navigation beyond
the login shell was not observable this run.

## User journeys (web)

All journeys in this section were **reconstructed from vendor docs** —
none was walked live (Tier 0). Full schema, personas, and the handoff map
are in [05-user-journeys.md](05-user-journeys.md).

| Journey | Persona | Evidence basis | Key friction observed |
|---|---|---|---|
| Onboarding / first-run | New member | reconstructed from help center (Set Up the Oura App / Set Up an Oura Ring) | Setup is app-only; web has no onboarding role; card/payment info required during app signup for membership |
| Core "aha" task | Member (any tier) | reconstructed from vendor web-app blog post | Web's "aha" is deliberately analytical (5-min-resolution charts, metric overlay), not the morning score check |
| Account & team setup | Member; Enterprise admin | reconstructed from account help article + organizations page | Consumer side is single-user; "team" exists only in the B2B Enterprise Platform (sales-gated, no public pricing) |
| Churn-risk moment | Member | reconstructed from membership help article + data-protection article | No pause option; cancel keeps only 3 daily scores; data retained + CSV export via "Membership Hub" |
| Web-exclusive flow | Power member / developer | reconstructed from web-app blog post + API docs | CSV export, 5-min HRV/RHR intervals, Pearson correlation overlay, longer time horizons, OAuth app registration |

## Feature inventory (web app — "Oura on the Web")

| Feature | Description | Plan tier | Confidence |
|---|---|---|---|
| Metric overlay + Pearson correlation | "Overlay any two metrics and see your Pearson correlation coefficient" | membership | Reported (vendor blog) |
| Higher-resolution data | HRV and resting heart rate "in 5-minute intervals" vs 15-minute intervals in the app | membership | Reported (vendor blog) |
| Point-level inspection | "Hover over individual points on your Trends graph to view specific values" | membership | Reported (vendor blog) |
| Data export | Export data for "more in-depth analyses"; CSV export via Membership Hub survives cancellation | membership (export retained after cancel) | Reported (vendor blog + membership help article) |
| Longer time horizons | "look at your data over longer periods of time than you can in the Oura App" | membership | Reported (vendor blog) |
| Login with Oura account | "log into Oura on the Web using your Oura account credentials" | account | Reported (vendor blog) |
| No ring syncing from web | Setup article makes the mobile app mandatory for pairing; web blog claims no sync capability | n/a | Inferred (absence in all vendor material + app-only setup docs; reasoning: every setup path documented runs through the mobile app) |
| Cannot be embedded | `frame-ancestors 'none'` in CSP | n/a | Confirmed (header) |

## Responsive behavior

Not observed this run — the web app renders client-side and no browser was
available. No claim is made about ~375px behavior. (Gap logged in 00-INDEX.)

## Observed API domain(s)

| Domain | Role | Evidence |
|---|---|---|
| cloud.ouraring.com | Member web app AND the public API host (OAuth2 endpoints, v2 API) — same origin | Confirmed (docs base URL + web app title on same host) |
| api.commerce.ouraring.com | Store/commerce backend (dns-prefetch from marketing site) | Confirmed (header) |
| static.ouraring.com / static1.ouraring.com | App static assets | Confirmed (CSP) |
| moi.ouraring.com | Form-action target in web app CSP; purpose unverified — flagged for follow-up | Confirmed (CSP); purpose Inferred (likely a first-party service, possibly localization/marketing; no public doc found) |
| sentry.ingest.us.sentry.io; app.launchdarkly.com; cdn.segment.com; decagon.ai | Error tracking; feature flags; analytics; AI chat widget | Confirmed (CSP) |
| status.ouraring.com components | "API V2", "API Webhooks", "Health Panels" — note: no web-app or mobile component is listed; status coverage is API-centric | Confirmed (status page fetch) |

## Screenshots

None captured — Tier 0 run (no browser). Every claim above instead carries
its access method and grade inline.
