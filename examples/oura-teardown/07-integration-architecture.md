# 07 — Integration Architecture

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Cross-platform summary

| Platform | Auth model | Data source / API domain | Sync behavior | Notification path |
|---|---|---|---|---|
| Mobile (primary) | Oura account (email + verification; created in-app) — Reported (vendor docs) | Ring via BLE → phone; then Oura cloud. Same API host family as web: cloud.ouraring.com hosts the public API; the app's own API endpoint was not observable without a live device this run — Inferred (shared origin + account) | Ring↔phone BLE sync on app open ("Tap Begin to sync data"); phone→cloud upload; scores computed server-side or client-side not distinguishable statically — Reported (vendor docs) for BLE sync; Inferred for cloud pipeline | In-app notifications documented; APNs/FCM implied by Google Play services requirement and push surfaces — Inferred (reasoning: Google Play services is a stated requirement, and notification settings exist in help docs; no doc names FCM) |
| Web | Same Oura account credentials — Confirmed (vendor blog: "log into Oura on the Web using your Oura account credentials") | Same host as the public API: cloud.ouraring.com (app + API same origin) — Confirmed (docs base URL = app URL); Health Panels component on status page — Confirmed | Server-side reads of cloud-stored ring data; no ring sync from web — Reported (vendor blog); 5-min-resolution series implies raw-ish retention — Inferred | None observed (in-app notification center not observable statically) |
| Desktop | none (no client) | n/a | n/a | n/a |
| Ring (hardware) | Bound to one Oura account; factory reset to rebind — Confirmed (vendor docs) | BLE to mobile app only — Confirmed (docs + BLE requirement) | Charger = power + pairing-state only; no data over charger documented — Confirmed (absence in docs; inductive WTP charging per FCC) | n/a |
| B2B (organizations.ouraring.com) | Separate enterprise surface; sales-gated ("Contact us"); role-based permissions + de-identification options documented — Confirmed (organizations page) | "Enterprise API to send data to external systems"; raw CSV/JSON export — Confirmed (organizations page) | Dashboard over member fleet; mechanics not publicly documented — flagged | n/a |

Each cell tagged per its evidence; everything not directly observed in a
fetched document is Reported or Inferred with reasoning.

## Integration business-objective map

| Integration point | Technical evidence | Business objective it serves | Tag & reasoning |
|---|---|---|---|
| Ring→mobile-only BLE pairing | All setup paths start in the app; web has no pairing | The phone is the free, always-present gateway; keeps hardware cost down (no Wi-Fi/cellular radio in the ring) and forces app install = daily-habit capture | Inferred (app-only docs + absence of any radio beyond BLE in filings) |
| Web app as analytical surface (5-min data, Pearson overlay, CSV export) | Vendor blog features; 5-min intervals vs 15 in app | Retain power users and give analysts a reason to keep the subscription; web is cheap to operate vs native clients | Confirmed objective (vendor blog frames web as deeper analysis "not apparent in your daily mobile app check-in"); chosen implementation Inferred |
| Apple HealthKit + Health Connect rails | "Powered by Apple HealthKit and Google Health Connect… syncs with hundreds of health and fitness apps" | Ecosystem interoperability: make Oura the wearable hub in either OS ecosystem, reducing switching cost TO Oura and FROM other apps | Confirmed (integrations page wording) |
| Strava (bidirectional) | Activities credit both ways per integrations page | Community/growth loop in the fitness segment: Oura workouts appear where athletes already are | Confirmed (partner page: credit + share both directions) |
| Natural Cycles (outbound) | Oura temperature trend feeds the FDA-cleared birth-control app | Enter regulated women's-health use cases without becoming a medical device themselves; partner carries the clearance | Confirmed (integrations page: FDA-cleared app uses Oura temperature trend) |
| Stelo by Dexcom (glucose pairing) | "Glucose biosensing with Stelo by Dexcom" on organizations page + glucose help sections | Metabolic-health expansion by partnering rather than building sensor #2 | Confirmed (vendor pages); strategic "why" Inferred |
| Headspace (content in-app) | Audio content featured in Oura App | Add consumable value to membership without content production; partnership revenue unknown | Confirmed (feature exists); economics Inferred |
| Public API v2 (OAuth2) + webhooks | docs; status page has an "API Webhooks" component at 100% uptime | Developer ecosystem as retention/geek-marketing; webhook component proves production push-integration traffic | Confirmed (docs + status page); objective Inferred |
| OAuth app default 10-user cap until review | docs: apps default to ten users, review for wider release | Abuse-control on a health-data API (OAuth dance replaces deprecated personal tokens; v1 shut off 2024-01-22) | Confirmed (docs); objective Inferred |
| Enterprise API + raw CSV/JSON export | organizations page | Land-and-expand B2B: health data into corporate wellness/insurers (Eli Lilly, Amazon, Optum, Cigna, Johns Hopkins named) | Confirmed (feature + named customers); deal shape Inferred |
| EHR import (app feature) | help-center category listing | Clinical-channel adoption (hospitals/clinics named customers) | Reported (help center); objective Inferred |
| n8n node; no Zapier/Make native | n8n node page fetched; Zapier/Make not found in searches | Serve the self-quantifier/automation niche cheaply via one node | Confirmed (n8n exists); absence Reported (search-based) |
| LaunchDarkly (app) + Statsig (marketing) | CSP + cookie | Fast experimentation without releases on both growth surfaces | Confirmed (headers); objective Inferred |
| Sentry + Decagon AI chat (app CSP) | CSP | Error-budget management + AI support deflection on the highest-stakes surface (member data) | Confirmed (CSP); objective Inferred |
| Status page covers only API components (API V2, Webhooks, Health Panels) — no web/mobile component | status page fetch | Public incident comms for developer/integration audience; consumer surfaces get in-app notices instead | Confirmed (component list); interpretation Inferred |

## Narrative

Oura is a mobile-first hardware SaaS with a single cloud brain. The ring
is a BLE peripheral that pairs only with the phone app; the phone is the
gateway, and everything lands in Oura's cloud on the same host that
serves the public API (cloud.ouraring.com). There is no desktop client —
the vendor's answer to desk use is the web app on that same domain, which
is deliberately positioned as the analytical complement: longer horizons,
higher-resolution series, correlations, and CSV export rather than
day-to-day capture. One account spans app and web with the same
credentials, and cancellation semantics confirm the single source of
truth: cancel the membership and your data stays saved, exportable as
CSV from the web-side Membership Hub, while the app downgrades to three
daily scores.

The second axis is the B2B surface, which is architecturally separate:
organizations.ouraring.com, an Enterprise Platform dashboard with
role-based permissions and de-identification, an Enterprise API, and raw
CSV/JSON export — completely sales-gated, with named customers from Eli
Lilly to the US Open. Consumer and enterprise thus share the data plane
but not the commercial plane.

Evidence for this topology under Tier 0 comes from static observation
rather than network tracing: the same-origin API/app host, OAuth docs,
status-page components (API V2, API Webhooks, Health Panels — note the
absence of any web-app or mobile component), the CSP's third-party
services (Sentry, LaunchDarkly, Segment, Decagon), and the vendor's own
documentation of setup and sync paths. What could NOT be observed
without a live account/device: actual sync latency, the mobile app's API
endpoints, and the B2B dashboard's internals.

## Public API & integration ecosystem

- **Public API:** Yes — Oura API v2 at https://cloud.ouraring.com/v2/docs; OAuth2 (client ID/secret via /oauth/applications); Personal Access Tokens deprecated; v1 removed 2024-01-22; new apps default to a ten-user cap until review — Confirmed (docs fetch)
- **Webhooks:** Yes — a dedicated "API Webhooks" component on the status page (100% uptime over the shown window) — Confirmed (status page); event/catalog details not enumerable statically (v2 docs render client-side) — flagged
- **Official integrations marketplace:** Yes, a curated partner page (not a self-serve directory): HealthKit, Health Connect, Strava, Natural Cycles, Headspace, MyFitnessPal, Cronometer, Zero, Apollo, Talkspace — Confirmed (integrations page)
- **n8n:** Yes — official "Oura" node (profile + summary operations) — Confirmed (n8n page fetch)
- **Zapier / Make:** No native Oura listing found in searches — Reported (absence via search)
- **Third-party ecosystem:** Python client (`hedgertronic/oura-ring`, OAuth2, v2), TypeScript client (`Pinta365/oura_api`), two MCP servers (115★, 38★), Grafana data visualiser — Confirmed (GitHub search results). No official Oura SDK repos (org has 0 public repos)
- **Home Assistant:** Oura is not in home-assistant/core (components directory returned 404 this run) — Confirmed absence in core; community custom components may exist elsewhere

## Notable mismatches between marketing claims and observed reality

- "5+ Million members worldwide" (why-oura) vs 5.5M **rings sold** (press) — units sold is not active members, and the membership page confirms a free tier exists below membership; treat "members" as a cumulative/hardware-adjacent claim, not MAU.
- Accuracy figures (99% HR, 98% HRV, 94% ovulation, 79% sleep staging) are vendor marketing claims against unspecified references; the store description simultaneously states the ring "is not a medical device and is for general wellness only."
- "The world's smallest smart ring" is positioning, not a spec benchmark.
- The status page's "All Systems Operational" scope covers only three API components — member-facing surfaces (web app, mobile) have no public status representation, so "all systems" is narrower than it reads.
- Careers copy says "over 700 Ouranians" while press coverage of a company at $1B revenue and 5.5M units would typically imply more; both are point-in-time claims from different dates.
