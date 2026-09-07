# 01 — Overview & Recon

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Company

- **Name / legal entity:** Oura Health Oy; brands as "Oura"; status page names "Oura Health Ltd" — Confirmed (status page header, [status.ouraring.com](https://status.ouraring.com))
- **Founded:** 2013, Oulu, Finland, by Petteri Lahtela, Kari Kivelä, and Markku Koskela — Reported ([Oura Pulse Blog, history of Oura](https://ouraring.com/blog/history-of-oura/); [Wikipedia — Oura Health](https://en.wikipedia.org/wiki/Oura_Health)). Corroborated by the FCC grantee record: Oura Health Oy registered in the FCC database 2015-02-05 — Confirmed ([fccid.io grantee page](https://fccid.io/2AD7V))
- **CEO:** Tom Hale (since 2022; prior: Harpreet Singh Rai 2018–2021) — Reported ([Wikipedia — Oura Health](https://en.wikipedia.org/wiki/Oura_Health))
- **Ownership:** private; press reports a confidentially filed US IPO with the SEC — Reported (CNBC/Bloomberg via search; see 08)
- **Funding:** Series D at ~$5B valuation (Dec 2024); Series E announced 2025-09-22, $875M (reported as possibly exceeding $900M) at ~$10.9B/$11B — Reported ([TechCrunch](https://techcrunch.com/2025/09/22/oura-ring-maker-raising-875m-series-e-bringing-valuation-to-11b-report-says/), fetched)
- **Headcount:** "over 700 Ouranians" (own careers copy); 110+ open roles — Confirmed (careers page, [ouraring.com/careers](https://ouraring.com/careers))
- **Offices:** San Francisco, San Diego (Rancho Bernardo), Helsinki, Oulu — Confirmed (careers page)

## Product positioning

- One-liner (their words): "Smart Ring for Fitness, Stress, Sleep & Health"; hero: "The world's smallest smart ring" — Confirmed (homepage static fetch)
- What it claims to solve: sleep quality, stress, activity, heart health, women's health via a screenless ring worn 24/7; sells hardware + a recurring membership for insights
- Who it's built for: consumers (sleep/wellness/fitness/women's health) plus organizations via a separate B2B surface (Oura Enterprise Platform, "For Organizations") — Confirmed (homepage nav; [organizations.ouraring.com](https://organizations.ouraring.com/))
- Category peers: Ultrahuman Ring, Samsung Galaxy Ring, Whoop (band), Fitbit/Google, Garmin, Apple Watch — Reported (comparison contexts in press/teardown coverage)
- Positioning statement in-app: "Oura Ring is not a medical device and is for general wellness only" — Confirmed (iOS store description, Apple lookup API)

## Complete link inventory (web release artifacts)

Every URL below was verified by a static fetch during this run unless noted.

| Surface | Exact URL | Notes (verified / 404 / requires login) |
|---|---|---|
| Marketing site | https://ouraring.com | Verified (HTTP 200; multi-locale: /cs /da /de …) |
| Web app / login | https://cloud.ouraring.com | Verified — title "Oura on the web"; JS-rendered shell; login UI not statically observable; requires account |
| Signup | via web app login and mobile app ("Start" flow) | Mobile app signup documented in help center; card/payment info required during app signup (help center, see 05) |
| Pricing (membership) | https://ouraring.com/membership | Verified — $5.99/mo, $69.99/yr (US), localized variants |
| Hardware store | https://ouraring.com/store/rings/oura-ring-5 , /store/rings/oura-ring-4 | Verified — Ring 5 $399/$499 per finish; Ring 4 page live (exact per-finish prices truncated in this run's fetch) |
| Commerce API | https://api.commerce.ouraring.com | Observed in marketing-site header prefetch (dns-prefetch) — Confirmed (header) |
| Docs / API getting started | https://cloud.ouraring.com/docs | Verified — OAuth2 guide; v1 removed 2024-01-22; PATs deprecated |
| API reference (v2) | https://cloud.ouraring.com/v2/docs | Verified URL exists — JS-rendered OpenAPI shell; endpoint list not statically readable this run |
| OAuth app registration | https://cloud.ouraring.com/oauth/applications | Referenced by docs (requires Oura account) |
| Status page | https://status.ouraring.com | Verified — Atlassian Statuspage; components: API V2, API Webhooks, Health Panels |
| Help center | https://support.ouraring.com | Verified — Zendesk Guide ("Oura Member Care") |
| Changelog (mobile) | https://support.ouraring.com/hc/en-us/articles/10470796678035-Software-Updates-for-Android | Verified — dated version list; iOS equivalent not located this run (Apple lookup RSS used instead, see 03) |
| Blog | https://ouraring.com/blog | Verified via post URLs (e.g. /blog/oura-on-the-web/) |
| Integrations directory | https://ouraring.com/integrations | Verified — HealthKit/Health Connect rails + named partners |
| Careers | https://ouraring.com/careers → https://job-boards.greenhouse.io/oura | Verified — Greenhouse ATS |
| B2B | https://organizations.ouraring.com | Verified — "Contact us" CTA (sales-gated; no self-serve pricing shown) |
| Public GitHub org | https://github.com/ourahealth | Exists but 0 public repos — Confirmed (GitHub API); no official product code |
| Community / forum | none found | No official community forum surfaced in nav or search; third-party ecosystem on GitHub/Reddit instead |
| Legacy app host | https://app.ouraring.com | DNS does not resolve (ENOTFOUND) — finding: the web app lives only on cloud.ouraring.com |

## Hardware touchpoint check

**Hardware found — two device families**, full coverage in
[06-hardware-integrations.md](06-hardware-integrations.md):

- **Oura Ring** (smart ring; generations Gen2 / Gen3 / Ring 4 / Ring 5) — BLE per FCC filing descriptions and Bluetooth 5.0 requirement in setup docs
- **Ring charger** (dedicated accessory; inductive "WTP" charging per 2026 FCC filings; USB-power source)

## Business-scale signals (summary)

| Signal | Value | Source | Tag |
|---|---|---|---|
| Funding | $875M+ Series E at ~$11B (2025-09-22); prior ~$5B Series D Dec 2024 | TechCrunch (fetched) | Reported |
| Revenue | ~$500M (2024); >$1B expected (2025); >$1.5B forecast (2026) | company statements to press (TechCrunch) | Reported (company-claimed, not regulator-filed) |
| Units | 5.5M rings sold to date (2025-09); 2.5M as of June 2024 | TechCrunch | Reported |
| Members | "5+ Million members worldwide" | ouraring.com/why-oura | Confirmed as vendor claim (marketing) |
| Monthly web visits / rank | global rank ~5,430→7,478 over recent 3 months; revenue band $500M–$1B | Similarweb profile (search snippets; page not fetched) | Reported (scale indicator, not revenue) |
| App store scale | iOS: 4.86★, 292,573 ratings | Apple iTunes search/lookup API (fetched) | Confirmed (Apple-published data) |
| App store scale (Android) | 4.7★, 38.9K reviews | Google Play via search snippet (page fetch failed) | Reported |

## Platform surfaces found

| Surface | URL | Notes |
|---|---|---|
| Marketing site | https://ouraring.com | Next.js, CloudFront |
| Web app | https://cloud.ouraring.com | "Oura on the web" — analysis/export surface, login required |
| iOS app | https://apps.apple.com/us/app/oura/id1043837948 | v7.23.1 (2026-09-03) |
| Android app | https://play.google.com/store/apps/details?id=com.ouraring.oura | v7.23.0 (2026-08-25, vendor changelog); listing page fetch degraded this run |
| Desktop (macOS) | none | No native client; "Oura on the Web" is the official desktop path (see 04) |
| Desktop (Windows) | none | same |
| Desktop (Linux) | none | same |
| API docs | https://cloud.ouraring.com/docs ; /v2/docs | OAuth2; v2 current |
| Status page | https://status.ouraring.com | API-centric component list |
| Public repos | https://github.com/ourahealth (0 public repos) | Third-party SDK ecosystem instead (see 07) |

## Tech stack signals (marketing site vs. app)

| Layer | Marketing site | App (cloud.ouraring.com) |
|---|---|---|
| Frontend framework | Next.js — `NEXT_LOCALE` cookie + `x-middleware-rewrite` — Confirmed (response headers) | JS-rendered SPA shell; framework not identifiable from static fetch |
| Hosting/CDN | CloudFront (`x-cache`, `strict-origin-when-cross-origin`) — Confirmed | CloudFront behind an Envoy gateway (`x-envoy-upstream-service-time`) — Confirmed |
| Analytics / CDP | Segment (`cdn.segment.com` dns-prefetch) — Confirmed | Segment in CSP — Confirmed |
| Experimentation / flags | Statsig (`statsigStableId` cookie) — Confirmed | LaunchDarkly (`app.launchdarkly.com` in CSP) — Confirmed |
| Images / assets | Imgix (`ourahealth.imgix.net` dns-prefetch) — Confirmed | static.ouraring.com / static1.ouraring.com; stackpath.bootstrapcdn.com in CSP — Confirmed |
| Error tracking / support | — | Sentry (`sentry.ingest.us.sentry.io` in CSP) — Confirmed; Decagon AI chat widget (`decagon.ai` in CSP) — Confirmed |
| Commerce | `api.commerce.ouraring.com` prefetch; `cartId` cookie — Confirmed | — |
| Geo / i18n | `countryCode` / `currencyCode` cookies; multi-locale alternates — Confirmed | — |
| Notable other | `prodregistryv2.org` dns-prefetch — Confirmed (purpose unverified) | `moi.ouraring.com` in CSP form-action (purpose unverified); `frame-ancestors 'none'` (app cannot be iframed) — Confirmed |

Method note: no Wappalyzer-class tool was available this run; fingerprinting
was done by manually reading HTTP response headers and CSP of static
fetches — the playbook's sanctioned fallback.
