# 03 — Mobile Platform

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Access methods used

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| Apple iTunes Search API + Lookup API (public JSON feeds) | full iOS metadata: version, size, min OS, ratings, release notes, full description | Confirmed (Apple-published data, directly fetched) | store pages are JS-heavy; the JSON feed is the static-fidelity source |
| Apple customer-reviews RSS feed | dated version timeline + friction signals from recent reviews | Reported (reviews are third-party; feed is Apple-published) | release-cadence reconstruction without a device |
| Google Play listing fetch (2 attempts, different URL forms) | FAILED both times (page render/truncation under static fetch) | n/a — degradation logged | Tier 0 constraint; no browser to render the Play page |
| Web search snippets for the Play listing | Android rating (4.7★, 38.9K reviews), bundle ID | Reported | fallback after fetch failure |
| Vendor changelog article "Software Updates for Android" (Zendesk) | dated Android version list (10 versions) + legacy-track fact | vendor-documentary | rung 3 |
| Help-center app articles | journeys, BLE requirement, platform minimums | vendor-documentary | rung 3 |
| APK/IPA extraction | NOT ATTEMPTED — store-listing metadata is the ceiling by design | n/a | skill operating rule |

## Existence

| Store | Listing found? | URL | Publisher |
|---|---|---|---|
| iOS App Store | Yes | https://apps.apple.com/us/app/oura/id1043837948 | "Oura Health Oy" — Confirmed (Apple lookup API). Matches Phase 0 legal entity: no white-label/agency finding. |
| Google Play | Yes | https://play.google.com/store/apps/details?id=com.ouraring.oura | "Oura Health" (snippet-graded); bundle `com.ouraring.oura` — Reported (Play page fetch degraded this run) |

## Release artifacts (store-listing metadata)

Store-listing metadata is the ceiling for mobile release data — no APK/IPA
extraction is attempted, by design.

| Store | Version | Size | Last updated | Min OS | Age rating |
|---|---|---|---|---|---|
| iOS App Store | 7.23.1 | 468,523,008 bytes (~447 MB) | 2026-09-03 | iOS 16.0 | 4+ |
| Google Play | 7.23.0 (per vendor changelog) | not captured (fetch degraded) | 2026-08-25 (per vendor changelog) | Android 11 with Google Play services (help docs) | not captured (fetch degraded) — flagged |

iOS metadata Confirmed via Apple lookup API. Android version/date are
vendor-documented (changelog article) — Reported-grade for the listing
itself because the Play page could not be fetched this run.

Direct APK / sideload distribution: none found (no public direct-APK link
surfaced in searches or vendor docs).

## Version history signal (last releases)

Android (vendor changelog article — vendor-documentary):

| Version | Date | Notable change |
|---|---|---|
| 7.23.0 | 2026-08-25 | "Small fixes, big improvements" |
| 7.22.1 | 2026-08-18 | minor |
| 7.22.0 | 2026-08-11 | minor |
| 7.21.1 | 2026-08-03 | minor |
| 7.20.0 | 2026-07-14 | minor |
| 7.19.2 | 2026-07-02 | minor |
| 7.19.1 | 2026-07-01 | minor |
| 7.19.0 | 2026-06-30 | minor |
| 7.18.1 | 2026-06-16 | minor |
| 7.18.0 | 2026-06-15 | minor |
| (i18n milestones) | 2026-04/05 | Added Portuguese, Polish, Hungarian, Greek (7.12.x, April); Hebrew (7.14.0, May 19) |

iOS (Apple reviews RSS — three versions observed in a 2-week window):
7.22.2 (in reviews from 2026-08-22), 7.23.0 (2026-08-25), 7.23.1
(2026-09-03). Latest iOS release notes: "Small fixes, big improvements—
Oura just got a little better." — Confirmed (Apple lookup API).

Release cadence read: **actively invested** — ~weekly point releases on
both platforms, localized builds adding six new languages in spring 2026,
and a dedicated vendor changelog page for Android.

Legacy track: the Gen2 ring's last supported app version is 4.0.0
(November 15, 2021) — current 7.x app targets Gen3+ rings only. This is a
de-facto hardware-driven support cliff, documented by the vendor.

## Permissions requested

Not directly observed this run: the Play listing fetch failed and the
Apple lookup feed does not return permission manifests. What is known:

| Permission / requirement | iOS | Android | Implied capability | Evidence |
|---|---|---|---|---|
| Bluetooth 5.0 device requirement | yes | yes | BLE ring pairing — cross-reference 06 | Confirmed (help docs, both platforms) |
| Google Play services | n/a | required | GCM/FCM-delivered notifications likely feasible | Confirmed (help docs); FCM Inferred (see 07) |
| Camera / biometric / BLE manifest entries | not captured this run — flagged | not captured this run — flagged | — | gap |

## Mobile-specific capabilities

Features present on mobile (or mobile-anchored) with no web equivalent:

- **Ring pairing and firmware updates** — mobile-app-only paths (help docs; corroborated by review complaints about in-app update hangs) — Reported (vendor docs + reviews)
- **Apple Watch companion app + complications** — separate iOS surface listed in help-center integration articles — Reported (help center category listing)
- **Android widgets** ("Oura Widgets" help article) — Reported (help center)
- **Live workout tracking / workout recording with live heart rate** — Reported (help center: "Record a Workout with Oura")
- **Airplane mode / offline capture** — Reported (help center article)
- **Push notifications** — app notifications documented in help-center app-settings articles; APNs/FCM transport is Inferred (see 07)
- **Metabolic / Health Radar / GLP-1 Insights / meals & glucose (Stelo by Dexcom)** — help-center category sections — Reported (vendor docs)
- **Oura Advisor** (AI health companion) — Reported (membership page + help sections)
- **EHR data import** (health records) — Reported (help-center category listing)

## User journeys (mobile)

All reconstructed — no device/emulator was attached this run. Full schema
and personas in [05-user-journeys.md](05-user-journeys.md).

| Journey | Reconstructed from | Key friction reported |
|---|---|---|
| Onboarding / first-run (incl. push-permission ask) | help center: Create and Manage an Oura Account; Set Up the Oura App | email verification + billing address + payment method are required during signup before membership benefits start; "requires credit card to use" is a recurring review complaint |
| Core "aha" task | help center: Sleep Score / Readiness Score articles | score requires at least one night's wear; full baselines take weeks; Cycle Insights/Restorative Time need ~30–60 days of data |
| Platform-exclusive flow | help center: Record a Workout; Apple Watch companion; widgets | false workout detection (yoga/desk work) recurring in reviews |
| Hand-off to web (admin/billing escape hatch) | membership article (CSV export via Membership Hub); web blog | membership management/billing surfaced in app; deep analysis + export pushed to web |

## Feature parity classification

**Mobile-first** (web is a deliberate analytical complement, not parity):

- Setup and pairing are possible only through the mobile app (both setup
  help articles begin with "Download the Oura App") — vendor-documented.
- The vendor's own web-app announcement frames web as a place to "compare
  data and identify larger trends that may not be apparent in your daily
  mobile app check-in" — i.e., the app is the daily surface, web is the
  deep-dive surface.
- Highest-resolution features (live HR, workout tracking, Advisor chat)
  are documented as app features.

Evidence grade: vendor-documentary (setup docs + vendor blog), Reported.

## Review-derived feature gaps

Feature signal only, from recent Apple RSS reviews (2026-08/09) — not a
sentiment summary:

- App update process hangs ("stuck in terminal load mode for updates")
- App freezes
- Signup friction: payment info required to start membership features
- False workout auto-detection (yoga/strength during desk-bound activity)
- Ring 4 users report degraded connectivity after Ring 5 launch
- Subscription fatigue on top of hardware cost (membership required for
  most insights)
