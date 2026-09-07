# Oura — Platform Teardown

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## What this is

Oura (Oura Health Oy, Oulu, Finland, founded 2013) sells a screenless
titanium smart ring — currently Ring 5 at $399–499 — that measures sleep,
activity, stress, heart, temperature, and (with partners) glucose signals
from the finger 24/7. The hardware is the meter for a $5.99/month
membership that carries most of the insights, sold to consumers and, via
a separate sales-gated Enterprise Platform, to organizations from Amazon
to the US Open. Category peers: Ultrahuman, Samsung Galaxy Ring, Whoop,
and the wrist-worn incumbents (Apple, Garmin, Fitbit).

## At a glance

| | |
|---|---|
| Company | Oura Health Oy ("Oura Health Ltd") — private; confidential IPO filing reported by press |
| Founded / funding | 2013, Oulu — $875M+ Series E at ~$11B (2025-09-22); prior ~$5B Series D (2024-12) |
| Web app | Yes — https://cloud.ouraring.com ("Oura on the Web"; analytical complement) |
| Native mobile app | Yes, both — iOS https://apps.apple.com/us/app/oura/id1043837948 · Android https://play.google.com/store/apps/details?id=com.ouraring.oura |
| Native desktop app | No — none for any OS; browser web app is the vendor's official desktop path |
| Hardware integration | Yes — smart ring (BLE, Gen2/Gen3/Ring 4/Ring 5) + charger family (inductive); FCC trail 2015–2026 (see 06) |
| Public API | Yes — OAuth2 v2 API + webhooks at https://cloud.ouraring.com/docs; n8n node; no official SDK repos |
| Pricing | Ring $399–499 + membership $5.99/mo or $69.99/yr; free tier keeps 3 daily scores; Enterprise: contact sales |
| Estimated business scale | ~$1.0–1.35B/yr (bottom-up, hardware-dominated) vs >$1B company-claimed for 2025 — methods in 08 |
| Primary platform | Mobile — the app is mandatory for setup/pairing; web is the deliberate analytical complement (07) |

## How this was researched (access methods at a glance)

**Methodology:** Engine A (built-in WebSearch/WebFetch) ran all research
sweeps, sequentially, per the skill's engine-pick rule; `agy` was not
part of this run. **Tier 0 — static fetches only**: no browser was driven
(no Playwright, no agent-browser, no headless session), no account was
created, and no device was attached. `agent-browser` is installed on this
machine but was not invoked, by run scope. UI-behavior claims are
therefore `Reported`, never `Confirmed`. What static fetches directly
returned (page content, HTTP headers/CSP, Apple API JSON, FCC records,
status page) is marked `Confirmed`. Run window: 2026-09-07T02:27Z; 16 WebSearch + 36 WebFetch calls, plus header checks
(cURL) and GitHub API queries — 83 tool calls total including file reads
and report writes.

| Platform | Access method(s) used | Evidence grade | Why |
|---|---|---|---|
| Web | Static fetches of marketing/pricing/store/help/API-doc pages; HTTP header + CSP reads; vendor blog | vendor-documentary; Confirmed only for fetched content and headers | no browser this run; no account created (run scope) |
| Mobile | Apple iTunes Search/Lookup APIs + customer-reviews RSS (public JSON feeds); vendor Android changelog article; help center; search snippets after Play fetch failed twice | Confirmed for Apple-published data; vendor-documentary; Reported for Play metadata | store-listing metadata is the design ceiling; no device/emulator |
| Desktop | Searches for installers; careers/status-page checks; help center | Confirmed absence across checked surfaces | no client exists to audit |
| Hardware | FCC grantee database (fccid.io) fetched; teardown coverage (Becky Stern, iFixit, TechInsights); vendor sensor/charging pages | Confirmed for filings; Reported for teardowns | public-record filings + third-party teardowns; no device in hand |

This table is the report's honesty layer: it says how much of what
follows is verified truth versus secondhand reconstruction. Detail per
platform lives in each platform file's "Access methods used" section.

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

- **The ring is a mobile-only peripheral by design, and that's the moat.** Pairing, firmware, and daily capture live only in the phone app; the web app (same domain as the public API) is positioned as the analysis surface. No desktop client exists anywhere.
- **The subscription math says hardware is the real revenue engine.** Bottom-up membership math tops out around $270M/yr; the hardware run-rate is ~$840M–1.08B/yr. The $5.99 membership is the margin and retention layer, not the revenue line — and its free tier is a 3-score ghost of the product.
- **The churn cliff is engineered.** Cancel and you keep exactly three daily scores; no pause option exists; data stays saved and CSV-exportable — the web Membership Hub doubles as the win-back surface.
- **The FCC trail and teardowns confirm an unbroken hardware cadence** — grantee Oura Health Oy (2AD7V) filed in 2015, 2018, 2022, 2024, 2025, and three times in 2026 (rings + inductive chargers), consistent with the Ring 5 generation the store now sells. Teardown coverage says the ring is effectively unrepairable (sealed battery, cut-open casing).
- **A hardware support cliff is already documented:** Gen2 ring users are pinned to app 4.0.0 (Nov 2021); current 7.x weekly-release apps serve Gen3+ only.
- **The status page quietly scopes "All Systems Operational" to three API components** — no web-app or mobile component exists publicly, so "all systems" is narrower than it reads.

## Confidence & gaps

- **No live UI observation.** No browser, no account, no device this run —
  every in-app behavior, journey step, and the login form itself is
  reconstructed from vendor docs and store metadata (Reported), never
  walked. Per the skill's degradation rule this is stated, not papered
  over.
- **Google Play metadata is snippet-grade.** Two static fetch attempts of
  the Play listing failed (JS-heavy page); Android rating/reviews are
  Reported from search results, Android store size/age-rating not
  captured, and Android permission manifests were not observed. iOS
  metadata, by contrast, is Confirmed via Apple's public APIs.
- **API v2 endpoint enumeration unavailable statically.** The OpenAPI UI
  renders client-side; the v2 endpoint list is bounded here by third-party
  integration docs (n8n, community clients) and the status page's
  webhooks component, not by the primary spec.
- **Ring 4 per-finish prices not captured** (store page fetch truncated);
  Ring 5 prices are Confirmed.
- **Firmware release notes not found** — OTA firmware updates are
  documented as app-delivered, but no public firmware changelog exists.
- **Enterprise Platform internals not publicly documented** — sales-gated;
  admin/join mechanics inferred from marketing copy only.
- **Earliest Wayback capture not obtainable** — web.archive.org refused
  direct fetches; only the availability API (latest snapshot 2026-09-03)
  worked.
- **"Members" vs "rings sold"** — vendor's 5M+ member claim and the
  press's 5.5M units are different quantities; both are cited as claimed,
  neither is audited.
