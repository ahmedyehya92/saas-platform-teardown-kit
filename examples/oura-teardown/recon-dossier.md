# Recon dossier — Oura (ouraring.com)
Scratch file. Not part of the final report. Every later phase reads from here.
Run scope: Tier 0 simulation — static fetches only; no browser, no login. Engine A (built-in WebSearch/WebFetch). agy excluded per run scope.

## Surfaces (Phase 0 exit answers)
- Web app? YES — member web app "Oura on the Web" at https://cloud.ouraring.com (title observed in static fetch: "Oura on the web"; vendor blog names cloud.ouraring.com as the login URL).
- Native mobile apps? YES — iOS: https://apps.apple.com/us/app/oura/id1043837948 (bundle com.ouraring.oura). Android: https://play.google.com/store/apps/details?id=com.ouraring.oura (listing fetch degraded under Tier 0; bundle ID from search + own search-result snippet).
- Native desktop app? NO (per sweep 3 — support article says mobile-only sync; "Oura on the Web" is the desktop access path). Verify wording in Phase 3.
- API/developer docs? YES — https://cloud.ouraring.com/docs and https://cloud.ouraring.com/v2/docs; v1 removed 2024-01-22; OAuth2 (client ID/secret via /oauth/applications); Personal Access Tokens deprecated. Webhooks exist (status page component "API Webhooks").
- Help center? YES — https://support.ouraring.com (Zendesk Guide, "Oura Member Care"). Categories: Oura Products, Get Started, Troubleshooting, Orders, Account, Oura App.
- Status page? YES — https://status.ouraring.com (Atlassian Statuspage). Components: API V2 (99.57% 90d), API Webhooks (100%), Health Panels (100%). NOTE: no web-app component listed — status coverage is API-centric. Finding.
- Integrations? YES — https://ouraring.com/integrations: Apple HealthKit + Google Health Connect rails ("hundreds of health and fitness apps"); featured: Headspace, Strava (bidirectional), Natural Cycles (outbound temp data); select list: MyFitnessPal, Cronometer, Zero, Apollo, Talkspace. n8n node confirmed (https://n8n.io/integrations/oura/). No Zapier/Make native listing found in search (Reported).
- Store/commerce? Marketing shop at ouraring.com/store/... ; commerce API at api.commerce.ouraring.com (header prefetch). B2B: https://organizations.ouraring.com/
- Careers: https://ouraring.com/careers → Greenhouse https://job-boards.greenhouse.io/oura (110+ roles incl. Hardware 13, Supply Chain 25).
- GitHub: NO official product repos. Org github.com/ourahealth exists (created 2024-04-03), 0 public repos. github.com/oura is an unrelated user (blog oura.github.io). Third-party ecosystem: Python clients, MCP servers, Home Assistant integration.
- Changelog: lead = Zendesk support "Software Updates for Android" section (to verify in Phase 2).

## Hardware quick-check (step 5): YES — smart ring + charger
- FCC grantee Oura Health Oy, code 2AD7V, Oulu, Finland (registered 2015-02-05). Filings: 2AD7V-OURARING15001 (2015-12-16, "Wellness ring with BLE"), 2AD7V-OURA1801 (2018-05-18, ring w/ BLE), 2AD7V-OURA2101 (2022-04-19, ring), 2AD7V-OURA2401 (2025-09-18, ring), 2AD7V-OURA2402 (2024-07-25, charger), 2AD7V-OURA2501 (2025-11-19, charger), 2AD7V-OURA2601 (2026-03-19, "Wellness ring and app..."), 2AD7V-OURA2602 (2026-04-08, charger, inductive "WTP"), 2AD7V-OURA2603 (2026-05-12, charger). All "Original Equipment". Source: fccid.io/2AD7V (fetched).
- Teardowns: iFixit Oura Ring 2 (ifixit.com/Teardown/Oura+Ring+2+Teardown/135207); iFixit Ring 3 Charger Repair guide; TechInsights Ring 4 teardown blog; Becky Stern Gen2/Gen3 (beckystern.com, 2022-04-17); iFixit Ring 5 teardown reported via Reddit post (unrepairable, cut-apart casing).
- Hardware playbook 08 rides alongside Phases 1–3 (pairing matrix, sensors, battery/charging).

## Access plan per surface (Tier 0 — this run)
| Surface | Plan | Wall? |
|---|---|---|
| Marketing site | Static fetch (WebFetch) + header inspection via curl (static, no JS) | none |
| Web app | Static fetch only. JS shell observed; login UI not statically renderable. UI behavior stays Reported. Per run scope: NO account created. | login = account wall; not crossed (sanctioned no-credential ladder) |
| iOS listing | Apple iTunes Search/Lookup JSON API (public, static) | none |
| Android listing | play.google.com fetch failed (2 attempts); metadata via search snippets → Reported | bot protection, not crossed |
| API docs | Static fetch of docs pages | none |
| Help center | Static fetch of Zendesk articles | none |
| Status page | Static fetch | none |
| FCC | Static fetch of fccid.io grantee page | none |
| Enterprise/B2B | Static fetch only; demo-on-request not pursued (ladder) | sales wall not crossed |

## Facts (append per-fact lines as sweeps run)
### Company (sweep 1)
- Legal entity: Oura Health Oy / "Oura Health Ltd" (status page naming); HQ Oulu, Finland; careers copy: "team of over 700 Ouranians", offices SF, San Diego (Rancho Bernardo), Helsinki, Oulu. [careers page, Confirmed-vendor]
- Funding: Series D ~$5B valuation Dec 2024; Series E announced 2025-09-22: $875M (may exceed $900M) at ~$10.9B/$11B. Sources: TechCrunch article (fetched), Bloomberg.
- Revenue: 2024 ~$500M; 2025 expected >$1B; 2026 forecast >$1.5B — press-reported (TechCrunch citing company), NOT regulator-filed. Method: company statements to press.
- Units: 5.5M rings sold to date (2025-09), up from 2.5M (June 2024). [TechCrunch, Reported]
- IPO: confidentially filed with SEC (CNBC/Bloomberg/Routers press). [Reported]
- Member claim (vendor): "5+ Million members worldwide"; "86% of Oura Members see their health improve" (2026 survey); 50+ PhDs; accuracy: 99% HR, 98% HRV, 94% ovulation, 79% 4-stage sleep staging. [ouraring.com/why-oura, Confirmed-as-vendor-claim]

### Store listings (sweep 2)
- iOS: v7.23.1, released 2026-09-03, 4.86 avg / 292,573 ratings, seller "Oura Health Oy", 468,523,008 bytes, Free, Health & Fitness. Source: itunes.apple.com/search JSON (fetched).
- Android: listing title "Oura - Apps on Google Play", 4.7 stars, 38.9K reviews (search snippet; page fetch degraded). bundleId com.ouraring.oura.

### Desktop (sweep 3)
- No official desktop app; support article says sync is mobile-only; official desktop path is "Oura on the Web" (cloud.ouraring.com). Verify exact support-article wording in Phase 3.

### Integrations (sweep 4)
- HealthKit + Health Connect official rails; Strava bidirectional; Natural Cycles outbound (temp trend to FDA-cleared app); Headspace content-in-app; MyFitnessPal, Cronometer, Zero, Apollo, Talkspace listed. n8n official node. No Zapier/Make native found (Reported).

### API (sweep 5)
- Oura API v2 at cloud.ouraring.com; v1 removed 2024-01-22; OAuth2; PATs deprecated; webhooks component on status page; app review default "ten users" until review. [docs fetched]

### Pricing (sweep 6)
- Membership single tier: $5.99/mo or $69.99/yr (US; localized variants: EU €5.99, UK £5.99, CA$7.99, A$9.99, JP ¥999, CHF 5.99, RoW $6.99/$79); first month free; ring sold separately; 50+ metrics; Oura Advisor (AI companion); CSV export. [membership page, Confirmed-vendor]
- Hardware prices: to fetch in Phase 1 (Ring 4 / Ring 5 product pages).

### Tech stack (sweep 7)
- Marketing: Next.js (NEXT_LOCALE cookie, x-middleware-rewrite), CloudFront CDN, Segment CDP, Statsig flags, Imgix images, commerce API subdomain, i18n multi-locale (cs/da/de/...). [response headers, Confirmed]
- Web app: CloudFront; CSP reveals sentry.ingest.us.sentry.io, app.launchdarkly.com, cdn.segment.com, stackpath.bootstrapcdn.com, decagon.ai (AI chat widget), static.ouraring.com/static1.ouraring.com, moi.ouraring.com (form-action), Envoy gateway (x-envoy-upstream-service-time). [response headers + CSP, Confirmed]
- Mobile: historically React Native → moved toward fully native iOS/Android per third-party engineering accounts (Medium zoewave article; LinkedIn engineer post). [Reported]

### Revenue/business-scale (sweeps 8–12)
- Similarweb: global rank ~5,430→7,478 (3-month trend, July 2026); company revenue band $500M–$1B on Similarweb profile. [search snippets of similarweb.com — Reported, proxy only]
- App-traction estimates (Sensor Tower/data.ai/Appfigures): NOT FOUND in search for Oura-specific figures. Honest "not found".
- Filings: private company; confidential IPO filing reported. No 10-K/20-F.
- Customer counts: vendor "5+ million members"; press "5.5M rings sold"; "2.5M" June 2024 press baseline.

### Hardware (sweep 13)
- FCC trail above. Grantee code 2AD7V (NOT 2ABM7 — initial guess corrected by search; recorded to keep the claim trail honest).
- Wireless: BLE explicit in 2015/2018 filing descriptions; inductive "WTP" charging (2026 charger filings).
- Sensors: to detail in 06-hardware-integrations.md via /product/technology or /how-it-works fetch + help center pairing/compatibility articles.

### Wayback (sweep 15)
- Availability API: latest snapshot 2026-09-03 (available:true). CDX earliest-capture fetch REFUSED (web.archive.org blocked for direct fetch) — earliest date not obtainable this run. Playbook's Wayback exception partially satisfied.

## Timestamps
- Run start: 2026-09-07T01:53:34Z. (End recorded in report methodology.)
