# 04 — Desktop Platform

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Access methods used

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| Web searches for a desktop download ("Oura desktop app mac/windows", "download") | no official installer anywhere | Reported (absence of evidence across searches) | playbook step 1 |
| Careers page / Greenhouse board (110+ roles) | no desktop-client engineering roles; hiring is mobile/hardware/AI-weighted | Confirmed (fetched) | a desktop team would leave hiring traces |
| Status page components | no desktop/updater component | Confirmed (fetched) | a shipping desktop client usually leaves update/status infrastructure |
| Help center ("Set Up the Oura App", app category) | desktop access explicitly routed to "Oura on the Web" (cloud.ouraring.com) | vendor-documentary | rung 3 |
| Static fetch of cloud.ouraring.com | the substitute "desktop" experience is a browser tab | Confirmed (title "Oura on the web") | — |

## Existence

**No native desktop app exists** — no macOS, Windows, or Linux client is
offered. This is a normal, reportable outcome for this product category,
not a hole in the research: a screenless BLE wearable has no
desktop-useful pairing path (BLE pairing is mobile-only; see 06), and the
vendor routes all non-mobile use to the browser app.

## Release artifacts (per OS and architecture)

| OS | Arch | Installer type | Direct download URL | Version | Size | Release date | Release notes URL | Notes |
|---|---|---|---|---|---|---|---|---|
| Windows | x64 | none | — | — | — | — | — | no native client |
| Windows | arm64 | none | — | — | — | — | — | |
| macOS | Apple Silicon | none | — | — | — | — | — | |
| macOS | Intel | none | — | — | — | — | — | |
| Linux | x64 | none | — | — | — | — | — | |

## Version history (from update feed / changelog)

N/A — no client, no update feed. The nearest analog is the web app
(cloud.ouraring.com), which has no public per-release changelog this run
could find; release artifact coverage for "desktop use" therefore resolves
to the mobile release artifacts in [03-mobile-platform.md](03-mobile-platform.md).

## Framework signals

N/A — no binary to fingerprint.

## Capabilities beyond the browser

| Capability | Present? | Evidence |
|---|---|---|
| System tray / menu bar | No client | — |
| Global keyboard shortcuts | No client | — |
| Offline mode | No client | — |
| Local filesystem access | No client | — |
| Native notifications | No client | — |
| Multi-window | No client | — |
| Auto-launch on login | No client | — |

## User journeys (desktop)

| Journey | Evidence basis | Key friction |
|---|---|---|
| Install → first-run | N/A — nothing to install | — |
| Login / account pairing | browser tab: "log into Oura on the Web using your Oura account credentials" — Reported (vendor blog) | same credentials as mobile; no re-onboarding |
| Core task via desktop-exclusive capability | none exists; web-exclusive features (CSV export, 5-min resolution, Pearson overlay) are the substitute "desktop" story | — |

## Comparison to web

There is no desktop app, so there is nothing to add beyond the browser
tab — and Oura does not even attempt a wrapper. The vendor's answer to
"can I use this at my desk" is the web app itself, and its differentiators
are analytical (5-minute-resolution HRV/RHR, metric correlation, CSV
export, longer time horizons) rather than desktop-native capabilities.
The charger, not a desktop client, is the only "desktop" hardware: it
plugs into a USB power source purely to charge the ring, with no data
role documented.
