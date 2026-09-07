# 04 — Desktop Platform

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Access methods used

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| HEAD requests against the vendor's release channel (`releases.linear.app/mac`, `/windows`) | exact installer filenames, versions, sizes, content types | live (Confirmed) | the sanctioned way to get artifact facts without downloading executables |
| Probe of standard electron-builder update manifests (`latest.yml` / `latest-mac.yml` candidates) | all 404 — custom update channel | live (Confirmed 404s) | playbook-specified Electron signal |
| GitHub org via API (`github.com/linear`) | repo inventory incl. Electron-Forge publisher repo | vendor-documentary (Confirmed) | `gh` available; repos are public |
| Changelog + docs fetch | desktop-app mentions, release cadence, docs coverage | vendor-documentary (Confirmed/Reported) | version-history source |
| Live install and first-run walk | **not performed** in this environment | — | journeys below are reconstructed from download-page copy, changelog, and web-app equivalence; labeled accordingly |

## Existence

Native desktop clients exist for **macOS and Windows only**. The /download page states availability "for web, macOS, Windows, iOS, and Android" — Linux is not mentioned and no Linux artifact was found in the release channels — Confirmed (absence observed 2026-09-07). This is a finding about platform investment: the largest dev-tool demographic (Linux) is served by the browser app only.

## Release artifacts (per OS and architecture)

| OS | Arch | Installer type | Direct download URL | Version | Size | Release date | Release notes URL | Notes |
|---|---|---|---|---|---|---|---|---|
| macOS | universal (Intel + Apple Silicon in one binary) | .dmg | https://releases.linear.app/mac | 1.32.4 | 213,054,457 bytes (~203 MB) | not published on the artifact (latest stable at research time) | https://linear.app/changelog | filename `Linear-1.32.4-universal.dmg`; content-type application/x-apple-diskimage — Confirmed (HTTP headers) |
| Windows | x64 (arch not separately labeled) | .exe (NSIS-style "Setup") | https://releases.linear.app/windows | 1.32.4 | 199,133,832 bytes (~190 MB) | not published on the artifact | https://linear.app/changelog | filename `Linear Setup 1.32.4.exe`; content-type application/x-msdos-program — Confirmed (headers). No arm64 Windows build surfaced — finding |
| Linux | — | — | none found | — | — | — | — | absent from /download and release channels — Confirmed (absence) |

No separate Intel/Apple Silicon downloads: macOS ships one universal binary (the filename says so). No per-artifact release date is exposed; the changelog is the dated record.

## Version history (from changelog — desktop-relevant line)

A public per-desktop version feed was not found (standard electron-builder manifests 404 under the paths probed: `mac/latest-mac.yml`, `win|windows/latest.yml`, `mac/stable/*`) — the update channel is custom under `releases.linear.app`. Dated desktop-adjacent entries from the changelog:

| Date | Notable change |
|---|---|
| Sep 3, 2026 | Priority inbox (app-wide; applies to desktop) |
| Aug 20, 2026 | Coding sessions: environments, browser testing, AI-credit repricing |
| Jul 30, 2026 | Coding sessions on mobile; GitHub Copilot integration |
| Jul 20, 2026 | Loops (recurring agent work) |
| Jun 11, 2026 | Coding sessions in Linear (Claude Code + Codex) |
| 2019-06-20 | earliest desktop-specific changelog entry surfaced this run ("New version for Linear desktop application") — the desktop client predates 2020 — Reported |

Release cadence read: actively invested — desktop rides a product cycle shipping roughly every 1–2 weeks (≈10 changelog entries Jun 4–Sep 3, 2026), and desktop and web share the version train (same changelog stream).

## Framework signals

- **Electron-family — Inferred**, reasoning shown: (1) the org owns an Electron-Forge Google-Storage publisher repo (pushed 2022); (2) Windows artifact is an NSIS-style `Setup <version>.exe`, electron-builder's default naming; (3) macOS ships a single ~203 MB universal .dmg — the size and shape of a Chromium-bundled shell, not a thin native client; (4) desktop and web share the same version train and UX (the app is the web app in a shell). No public electron-builder `latest.yml` was found (the vendor's update channel is custom), so this stops short of Confirmed.
- Mobile is the opposite bet: fully native Swift/Kotlin per the vendor ([linear.app/mobile](https://linear.app/mobile)) — Reported (vendor wording).

## Capabilities beyond the browser

| Capability | Present? | Evidence |
|---|---|---|
| System tray / menu bar | no evidence found this run | no docs section, no changelog entry found; not claimed on /download — honest gap (see below) |
| Global keyboard shortcuts | no evidence found (beyond in-app command menu/hotkeys, which the web app also has) | docs TOC has no desktop section; `linear.app/docs/desktop` is a **404** — Confirmed |
| Offline mode | no evidence found | not claimed on /download or in docs |
| Local filesystem access | standard attachment flows only | no desktop-exclusive filesystem claims found |
| Native notifications | expected (any packaged client) | not explicitly documented this run — Inferred from packaged-client nature; not asserted as verified |
| Multi-window | no evidence found | — |
| Auto-launch on login | no evidence found | — |

The honest headline: **Linear's desktop app documents no capability a browser tab structurally lacks.** Its value proposition is presence and performance ("A fast and focused experience to plan and build your product" — vendor copy on /download, Confirmed as wording), not desktop-exclusive power features. The Raycast integration ("create, search, and modify your issues from anywhere" — in-app integration copy, Confirmed) is the vendor-delegated answer to global quick-capture.

## User journeys (desktop)

Reconstructed (no live install in this environment). Full schema and handoff map in 05.

| Journey | Evidence basis | Key friction |
|---|---|---|
| Install → first-run | reconstructed from /download copy + universal DMG artifact facts (vendor-documentary) | not observed; expected to launch the standard app window (no tray/menu-bar claims found) |
| Login / account pairing | inferred: same account system as web (apps require "an existing Linear account" per mobile copy; workspace URLs are linear.app/<slug>) — browser-auth roundtrip is the pattern for this app family, but it was NOT observed live this run — Inferred (reasoning shown) | unverified; a device-code or separate desktop auth cannot be ruled out |
| Core task via desktop-exclusive capability | none exists in evidence — desktop has no exclusive capability surface this run could confirm | the "core task" journey on desktop is identical to web (same app, same version train) |

## Comparison to web

The desktop app is the web application in a packaged shell (same workspace URLs, same feature train, Electron-family signals, ~200 MB bundle). What it concretely adds over the browser tab, on this run's evidence: a docked presence, OS-window management, and whatever notification/deep-link plumbing the shell provides — none of which the vendor documents as desktop-exclusive features. If the decision at hand is "do we need the desktop app," the evidence-supported answer is: it is a convenience, not a capability, for macOS and Windows; Linux users lose nothing but the window chrome.
