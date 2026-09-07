# 04 — Desktop Platform

> Researched: <date>

## Access methods used

| Method | What it yielded | Evidence grade | Why used |
|---|---|---|---|
| e.g. Installed and walked (free tier) | live install + first-run journey | live | |
| e.g. Update feed (`latest.yml`) / GitHub Releases | version history | vendor-documentary | |

## Existence

If no native desktop app exists: state that explicitly. If it's just the
website in a wrapper with no added capability, state that explicitly too —
both are legitimate findings.

## Release artifacts (per OS and architecture)

Every combination the vendor offers, each with its exact direct download
URL, current version, file size (if the server returns no content length
— common on signed-URL redirectors — record "not disclosed", don't
guess), release date, and release-notes link. A
missing architecture (no Windows arm64, no Linux) is a finding about
engineering investment — record it in Notes.

| OS | Arch | Installer type | Direct download URL | Version | Size | Release date | Release notes URL | Notes |
|---|---|---|---|---|---|---|---|---|
| Windows | x64 | | | | | | | |
| Windows | arm64 | | | | | | | |
| macOS | Apple Silicon | | | | | | | |
| macOS | Intel | | | | | | | |
| Linux | x64 | deb/rpm/AppImage | | | | | | |

## Version history (from update feed / changelog — last 5–10)

Mined from a public update feed (electron-builder `latest.yml`, GitHub
Releases, Sparkle `appcast.xml`) or the vendor's changelog page.

| Version | Date | Notable change |
|---|---|---|
| | | |

Release cadence read: actively invested / coasting — one sentence with
evidence.

## Framework signals

Electron/Tauri/native — and what evidence points to it (update manifest,
open-source `package.json`, file sizes, etc.).

## Capabilities beyond the browser

| Capability | Present? | Evidence |
|---|---|---|
| System tray / menu bar | | |
| Global keyboard shortcuts | | |
| Offline mode | | |
| Local filesystem access | | |
| Native notifications | | |
| Multi-window | | |
| Auto-launch on login | | |

## User journeys (desktop)

Full schema, personas, and the handoff map are in 05.

| Journey | Evidence basis | Key friction |
|---|---|---|
| Install → first-run (what launches: window / tray / menu bar) | | |
| Login / account pairing (browser-OAuth roundtrip or device code) | | |
| Core task via desktop-exclusive capability (hotkey / tray / offline) | | |

## Comparison to web

One paragraph: what, concretely, does the desktop app add over the browser
tab — and if the answer is "nothing but a window," say so.
