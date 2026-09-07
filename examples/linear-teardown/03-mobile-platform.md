# 03 — Mobile Platform

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Access methods used

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| iOS App Store listing (fetched 2026-09-07) | release artifacts, privacy label, compatibility | vendor-documentary (Confirmed — fetched directly) | store metadata is the ceiling per operating rules; no IPA extraction attempted |
| Google Play listing (rendered via Playwright) | release artifacts, installs, rating distribution, what's-new | vendor-documentary (Confirmed — live DOM) | static fetch truncated; Playwright renders it |
| linear.app/mobile vendor page | positioning, native-tech claim | vendor-documentary (Confirmed — fetched) | primary source for platform strategy |
| Recent review sample (3 reviews read on Play) | feature-gap signal | third-party (Reported) | reviews are free feature-gap data per playbook |
| Live device walk | **not performed** — no iOS/Android device or emulator attached to this environment; apps require an existing Linear account | — | journeys below are reconstructed, never implied walked |

## Existence

| Store | Listing found? | URL | Publisher |
|---|---|---|---|
| iOS App Store | Yes | https://apps.apple.com/us/app/linear-mobile/id1645587184 | Linear (seller: Linear Orbit, Inc.) |
| Google Play | Yes | https://play.google.com/store/apps/details?id=app.linear | Linear Orbit, Inc |

Same legal publisher on both stores — no white-label or agency-built finding. (Stale IDs circulating in older third-party content — `id1500310952` / `com.linear.app` — 404.)

## Release artifacts (store-listing metadata)

Store-listing metadata is the ceiling for mobile release data — no APK/IPA extraction is attempted, by design.

| Store | Version | Size | Last updated | Min OS | Age rating |
|---|---|---|---|---|---|
| iOS App Store | 1.88.0 | 176.2 MB | ~2026-09-02 ("5 days ago" at research time) | iOS 18.0 / iPadOS 18.0 (iPhone + iPad) | 4+ |
| Google Play | not displayed on the listing | not displayed | Sep 2, 2026 | not displayed | Everyone (Productivity) |

Direct APK / sideload distribution: none found (checked linear.app/mobile and linear.app/download — both route Android installs to Google Play).

## Version history signal (last 5–10 releases)

Per-store per-version history is not exposed on either listing beyond the current release; the cross-platform changelog is the citable release timeline:

| Date | Platform | Notable change (from [changelog](https://linear.app/changelog)) |
|---|---|---|
| Sep 3, 2026 | mobile (incl.) | Priority inbox; mobile doc editing shipped |
| Jul 30, 2026 | mobile | Coding sessions on mobile — review diffs, steer agent sessions from phone; Guided Reviews GA |
| ~2026-2026 | mobile | Play "What's new" text: "Linear Mobile has arrived… fast, compact, and fully native Android application" — arrival phrasing suggests the Android app launched recently (exact date not stated on the listing) |

Release cadence read: actively invested — both stores updated the same week (Sep 2, 2026), and the last three changelog posts each carry a mobile-specific capability (priority inbox, doc editing, diff review), which reads as mobile being pulled along the agent roadmap rather than coasting.

## Permissions requested

| Permission | iOS | Android | Implied capability |
|---|---|---|---|
| Push notifications | yes (vendor copy: "instant notifications", configurable notification schedule) | yes (same copy on Play listing) | APNs / FCM backend path — Inferred (standard channel; not directly confirmed in docs this run) |
| Photo library / camera (bug-report capture) | implied by "share screenshots/photos to create issues or bug reports" (vendor copy) | same | OS-level image capture; not proprietary hardware |
| Bluetooth / NFC / USB accessory | none observed | none observed | hardware check pass 2: negative (see 06) |
| Data collected (iOS privacy label) | identity, user content, diagnostics — linked to identity | Play data-safety section present (details not expanded this run) | standard account-linked telemetry |

## Mobile-specific capabilities

- Push notifications with configurable notification schedule (vendor copy on /mobile) — Reported (vendor wording)
- Share-sheet intake: share screenshots/photos from the OS into issue/bug-report creation — Reported (vendor wording on [linear.app/mobile](https://linear.app/mobile))
- Swipe actions in Inbox (delete/snooze) — Reported (same source)
- Coding-session steering from the phone (review diffs, steer agent sessions) since Jul 30, 2026 — Reported ([changelog](https://linear.app/changelog))
- No widgets, offline mode, biometric unlock, or camera-scan claims found on either listing this run — absence noted (negative finding)

## User journeys (mobile)

Reconstructed (no live install performed). Full schema, personas, and handoff map in 05.

| Journey | Reconstructed from | Key friction reported |
|---|---|---|
| Onboarding / first-run | listing copy: "requires an existing Linear account"; companion positioning → first run is login (email magic link / SSO as on web), not account creation | account creation itself is web-only per both listings — a phone-only evaluator must start on web (handoff finding) |
| Core "aha" task (triage an issue away from desk) | /mobile feature list: Inbox with tap/swipe, quick-access issue composer, push notifications | reviewer complaint: search "buried under unintuitive menus"; non-standard UX patterns (Play review, 2026-07-30) |
| Platform-exclusive flow (phone-side agent steering) | changelog Jul 30, 2026: review diffs and steer coding sessions from mobile | newest flow; no review coverage yet this run |
| Hand-off to web (admin/billing escape hatch) | listing copy scopes mobile to AFK workflows ("file issues… update issues, projects, and documents"); administration/billing not claimed anywhere as mobile surfaces | inferred: admin/billing remains web/desktop (cross-ref 07); one reviewer: "it's faster for me to connect Claude to Linear and add issues through Claude" — an AI-side handoff substituting for mobile UX (Play review, 2026-07-30) |

## Feature parity classification

**Companion, trending toward parity on consumption flows** — the vendor's own words scope it: "Linear Mobile is a companion to the Linear desktop app, designed for on-demand workflows when you are away from your keyboard" (Play/App Store copy — Confirmed). Read/write extends beyond view-only (issues, projects, documents, project updates are all editable per vendor copy), but onboarding, administration, and billing are not claimed as mobile surfaces, and the 250-issue-class workflow depth (bulk ops, custom views, settings) has no mobile counterpart listed.

## Review-derived feature gaps

From a 3-review recent sample on Google Play (feature signal, not sentiment):

- Search discoverability: non-standard placement, "buried" menus (2026-07-30)
- No drag-to-reorder of issues on mobile (2026-09-03)
- Completed issues reportedly hard to find under filters (2026-09-03) — a churn-risk moment for mobile-first users
- Positive signal: free-tier sufficiency vs. "Jira/Atlassian… expensive subscription models" (2026-08-02) — pricing copy corroborated by a user
