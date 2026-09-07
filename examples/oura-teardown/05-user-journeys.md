# 05 — User Journeys

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

The decision-grade core of this report: what using this product actually
feels like, per platform — not what the feature list says it can do.

## Evidence-basis legend

Every journey below states how it is known:

- **Walked live** — performed in-app during this research (claims can be Confirmed)
- **Vendor-documented** — reconstructed from help center / official blog / docs (Reported, vendor-authored)
- **Third-party reported** — reconstructed from store reviews, forums (Reported, third-party)
- **Inferred** — deduced from indirect evidence, reasoning shown

**No journey in this report was walked live.** This run was Tier 0 —
static fetches only, no browser, no account, no device. Every journey is
reconstructed; the rung and source are named for each. Journeys are
reported at the granularity the sources support.

## Personas observed

- **Consumer member** — the core user: owns a ring, checks scores daily, pays $5.99/mo after the first free month. Served primarily by mobile.
- **Power member / self-quantifier** — wants raw data, correlations, exports. Served primarily by web + the public API.
- **Enterprise admin** — buys rings in bulk, reads the Enterprise Platform dashboard. Served by a separate sales-gated surface (organizations.ouraring.com); admin/join mechanics are not publicly documented — flagged.
- **Developer** — builds on the Oura API (OAuth2). Served by cloud.ouraring.com docs.

Team/role setup does not exist in the consumer product (one ring binds to
one account; "team" exists only in the B2B platform) — vendor-documented.

## 1. Onboarding / first-run

### Web

- **Persona:** Power member (post-signup)
- **Entry point:** https://cloud.ouraring.com → login with Oura account credentials
- **Steps:** 1. arrive at JS-rendered shell titled "Oura on the web" 2. log in with existing Oura account 3. land on trends/analysis views (per vendor blog)
- **Decision points:** none pre-login
- **Handoffs to another platform:** web has no onboarding role — account creation and ring pairing are mobile-only
- **Friction:** nothing until you already have an account; the web surface is useless for brand-new users
- **Evidence:** Vendor-documented (static fetch of the app shell — Confirmed it exists and its title; post-login layout from vendor blog — Reported)

### iOS

- **Persona:** Consumer member
- **Entry point:** App Store → app "Oura" (id1043837948)
- **Steps:** 1. download app, tap "Start" 2. enter email → verification link ("Set up account" button) 3. accept terms; optional tips/offers opt-in 4. billing address + payment method (membership purchase; PayPal/Visa/MC/Amex/Discover, HSA/FSA cards; UPI in India) 5. home address "required for sales tax calculations" 6. choose monthly ($5.99) or annual ($69.99) billing 7. pair the ring (charger → LED blinks blue → Bluetooth 5.0 pairing) 8. optional Apple Health / Health Connect linking 9. personalization: birth date, weight, height, sex assigned at birth, goals 10. first-night wear → Sleep/Readiness scores next morning
- **Decision points:** membership tier (monthly/annual); integration opt-ins; notification opt-ins (implied — Reported)
- **Handoffs to another platform:** "Send setup email" for account creation; web promoted for deeper analysis
- **Friction:** payment info required during signup (card wall for full features); scores need 1+ night; full baselines take weeks; Cycle Insights and Restorative Time need ~30–60 days of consecutive data
- **Evidence:** Vendor-documented (help center "Set Up the Oura App", "Set Up an Oura Ring", "Oura Membership")

### Android

- **Persona:** Consumer member
- **Entry point:** Google Play → "Oura" (`com.ouraring.oura`)
- **Steps:** same as iOS; Health Connect replaces HealthKit
- **Decision points:** same
- **Handoffs to another platform:** same
- **Friction:** same; plus a hardware support cliff — Gen2 ring users are pinned to app 4.0.0 (Nov 2021)
- **Evidence:** Vendor-documented (same help articles; "Set Up the Oura App" covers both platforms)

### Desktop

- **Persona:** Power member
- **Entry point:** browser → cloud.ouraring.com (no install exists)
- **Steps:** login → analysis surfaces
- **Evidence:** Vendor-documented; see 04

## 2. Core "aha" task end to end

*(consumer member; there is no admin variant in the consumer product)*

### Mobile (the daily surface)

- **Persona:** Consumer member
- **Steps:** 1. wake wearing the ring 2. open app → overnight capture syncs on open 3. read Sleep Score (contributors: time asleep, efficiency, restfulness, REM, deep sleep, latency, timing) and Readiness Score 4. tap through to insights/sessions 5. optional: tag habits (caffeine/alcohol), log meals, record workouts with live HR
- **Decision points:** act on advisor/suggestions; use advisor AI chat (membership)
- **Handoffs:** "see your trends on the web" pattern for deeper analysis
- **Friction:** reported — false workout auto-detection; Ring 4 connectivity complaints post-Ring 5; update hangs
- **Evidence:** Vendor-documented (help center score/category articles) + Third-party reported (Apple RSS reviews)

### Web (the analytical surface)

- **Persona:** Power member
- **Steps:** 1. login 2. open Trends 3. hover points for exact values 4. overlay two metrics → Pearson correlation 5. view HRV/RHR at 5-minute intervals 6. export CSV
- **Friction:** none documented; cannot pair/sync a ring from web
- **Evidence:** Vendor-documented (vendor blog "Explore Oura on the Web")

### Desktop

N/A — browser tab, same as Web.

## 3. Account & team setup

### Mobile (all account management is mobile-first)

- **Persona:** Consumer member
- **Steps:** 1. create account during app onboarding (email verification) 2. account = one ring binding; factory reset required to move a ring to another account 3. membership not transferable between accounts (prepaid codes bind to the first account created)
- **Friction:** "cannot be transferred to a different Oura account" (vendor docs) — an anti-resale/anti-gifting constraint that also blocks household sharing
- **Evidence:** Vendor-documented (Create and Manage an Oura Account; Set Up an Oura Ring)

### Web

- **Persona:** Member
- **Steps:** login with the same account credentials; CSV export via Membership Hub
- **Evidence:** Vendor-documented

### B2B (separate surface)

- **Persona:** Enterprise admin
- **Steps:** organizations.ouraring.com → "Contact us" → sales conversation → Enterprise Platform dashboard (role-based permissions, de-identification options, Enterprise API, CSV/JSON raw-data export)
- **Friction:** completely sales-gated — no self-serve pricing, no documented admin onboarding flow; claimed customers (Eli Lilly, Amazon, Mayo Clinic, Team USA/LA28, American Express, Google, Optum, Cigna, Johns Hopkins, etc.)
- **Evidence:** Vendor-documented (organizations page fetch); join mechanics not publicly documented — flagged in 00-INDEX gaps

## 4. Churn-risk moment

### Mobile

- **Persona:** Consumer member at renewal
- **What happens:** cancel any time; access continues until the billing period ends; no partial refunds for annual after the first month
- **Downgrade cliff:** without membership the app keeps exactly three daily scores (Readiness, Sleep, Activity), ring battery, and basic profile — every advanced feature (stress, cardiovascular age, VO2 Max, cycle insights, Advisor, glucose) goes dark
- **No pause:** "There is no option to 'pause' an Oura Membership" (vendor docs)
- **Data on exit:** "If you cancel your membership, and do not delete your account, all of your Oura data and account information will remain securely saved"; CSV export stays available via Membership Hub; account deletion removes data
- **Evidence:** Vendor-documented (Oura Membership article; How Oura Protects Your Data)

### Web

- **Persona:** same, on the analytical surface
- **What happens:** the web app is where the CSV export lives, so the web is effectively the churn-retention surface — a canceled member keeps enough web capability to come back with their data intact
- **Evidence:** Vendor-documented (membership article names Membership Hub export)

### Desktop

N/A — browser tab shares the above.

## 5. Platform-exclusive flows

- **Mobile-exclusive:** ring pairing + firmware updates (every documented pairing path starts in the app); live workout HR; Apple Watch companion/complications; widgets; airplane-mode capture; Advisor as app surface. **Why here:** the ring is a body-worn sensor; the phone is the always-present BLE gateway. Links to 07's business-objective map. Evidence: Vendor-documented.
- **Web-exclusive:** 5-minute-resolution charts, metric overlay with Pearson correlation, point-level inspection, CSV export, longer time horizons, OAuth app registration. **Why here:** screen real estate and analytics depth; keeps power users in the ecosystem after the daily-app habit forms. Evidence: Vendor-documented (web blog + API docs).
- **Desktop-exclusive:** none — no desktop client exists (see 04).
- **B2B-exclusive:** Enterprise Platform dashboard, role-based permissions, Enterprise API, raw CSV/JSON export. Evidence: Vendor-documented (organizations page).

## Cross-platform handoff map

| From → To | Trigger | Supported? | Breaks where | Evidence |
|---|---|---|---|---|
| Web → Mobile | "download the app" prompts during setup/marketing | manual (store badges; no deep-link/QR observed in fetched material) | no QR/install-handoff observed on marketing pages this run | Confirmed absence-of-evidence on fetched pages; flag for live verification |
| Mobile → Web | deeper analysis, CSV export | manual re-login with same credentials | no single-tap handoff observed (not testable without a device) | Vendor-documented (shared credentials); UX shape unverified |
| Desktop ↔ Web (login) | same browser surface | n/a | n/a | — |
| Ring ↔ Mobile | pairing | supported: charger LED → BLE → in-app flow | breaks by design for desktop/web (no pairing outside mobile) | Vendor-documented (setup articles) |
| Mobile ↔ HealthKit / Health Connect | opt-in during onboarding | supported (first-class rails) | direction control lives in OS permissions, not Oura UI | Vendor-documented (integrations page + setup article) |

## Persona × platform matrix

| Persona | Primary platform | Secondary | Evidence |
|---|---|---|---|
| Consumer member | Mobile (iOS/Android) | Web (trends/export) | app-mandatory setup; vendor framing of web as complement — Vendor-documented |
| Power member / self-quantifier | Web | Public API (OAuth2) | web-only analytics features; API docs — Vendor-documented |
| Enterprise admin | B2B dashboard (separate surface) | Member app (fleet of rings) | organizations page — Vendor-documented; dashboard itself not publicly documented — flagged |
| Developer | Web (docs at cloud.ouraring.com) | API + webhooks | docs fetch — Vendor-documented |
