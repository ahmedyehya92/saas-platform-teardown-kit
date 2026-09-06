# Phase 3 — Desktop Platform Audit

Goal: establish whether a native desktop app exists, what kind it is, and
what it adds over the browser; capture its release artifacts per
OS/architecture with version history; and walk (or reconstruct) its
journeys, install and first-run especially.

## Steps

1. **Look for a download page** from the recon dossier. If none was found in
   navigation/footer, search explicitly: `"<product name>" download` /
   `"<product name>" desktop app mac windows`. A SaaS with no desktop client
   at all is a normal, reportable outcome — don't force a finding.

2. **If a download exists, identify what kind of app it is** without
   necessarily installing it (installing is optional and environment
   permitting only):
   - File extension/type from the download link (`.dmg`/`.pkg` = macOS,
     `.exe`/`.msi` = Windows, `.AppImage`/`.deb`/`.rpm` = Linux)
   - Check for Electron/Tauri/native-toolkit signals: many
     Electron/electron-builder apps expose an auto-update manifest such as
     `<update-host>/latest.yml` or `/latest-mac.yml` — fetching one (if
     discoverable) confirms Electron and gives a live version number for
     free. Absence doesn't rule Electron out; treat this as one signal
     among several, not proof either way.
   - If the product or its shell is open-source, use `gh` to check the repo:
     `package.json` dependencies (`electron`, `tauri`, `react-native-*`),
     release assets per OS, and release-note history for a desktop feature
     timeline.

3. **Release artifacts — build the per-OS/architecture table.** For every
   OS/architecture combination the vendor offers, capture: exact direct
   download URL, current version, file size, release date, and the
   release-notes/changelog URL:
   - Windows: x64 and arm64 `.exe`/`.msi` as separate rows if both exist
   - macOS: Intel vs Apple Silicon `.dmg` (or a universal binary — say
     which), plus `.pkg` when offered
   - Linux: `.deb` / `.rpm` / AppImage / Flatpak / Snap — each its own row

   File size comes from the download page or a `curl -sI` HEAD request
   (`Content-Length`) against the direct link — no download needed. A
   missing architecture (no arm64 Windows build, no Linux at all) is a
   finding about engineering investment, not a hole in the table.

   **Version history, not just the latest version.** If installers are
   versioned or an update feed is public, mine it for a dated mini timeline
   of the last 5–10 releases: electron-builder's `latest.yml` /
   `latest-mac.yml` (current version, often with history), GitHub Releases
   tags and dates (`gh release list` if the repo is public), a Sparkle
   `appcast.xml` on macOS, or dated entries on the vendor's changelog page.
   Release cadence is itself a finding — it shows whether desktop is
   actively invested or coasting. If a feed 403s or requires auth, note
   that and move on; don't work around it.

4. **Compare desktop vs web feature-for-feature** where you can access
   both: does the desktop app expose everything the web app does, a subset,
   or anything extra? Cross-reference Phase 1's navigation map.

5. **Capabilities beyond the browser** — the reason a desktop app exists or
   doesn't. Check for each (from docs, changelog, help center, screenshots,
   or a live install):
   menu bar/system tray presence, global keyboard shortcuts, offline mode,
   local filesystem access, native notifications, multi-window support,
   auto-launch on login. These are the capabilities a browser tab
   structurally can't offer, so their presence or absence is the real
   signal of *why* a desktop app exists versus being a thin wrapper.

6. **Walk desktop journeys** — install is optional, but if you do install
   (free tier only, same access rules as Phase 1), walk:
   - **Install → first-run:** what launches — a window, a tray icon, a
     menu-bar app? What's the empty state?
   - **Login / account pairing:** watch for the browser-OAuth roundtrip —
     desktop apps commonly open the system browser and hand back via deep
     link. That roundtrip IS the web↔desktop auth integration; record it
     exactly (Phase 4 consumes it). A device-pairing code instead of OAuth
     is a different architecture — record that too.
   - **The core task via a desktop-exclusive capability:** global-hotkey
     capture, tray quick-action, offline usage.
   - Auto-launch and offline behavior.
   If not installing, reconstruct the same journeys from docs, changelog
   entries, help-center articles, and demo video (ladder rungs 1–3) — same
   schema as web journeys (entry point, steps, decision points, handoffs,
   friction, evidence basis, persona tag).

7. **If the "desktop app" is just the website in a wrapper** (no
   capabilities beyond what Phase 1 already found), say so explicitly. That
   is a legitimate and common finding, not a failure to dig deeper — and it
   feeds Phase 4's business-objective map (the "why" was distribution, not
   capability).

## Access-methods log (required output of this phase)

Fill the desktop access log (template `04-desktop-platform.md`): installed
and walked live / release feed only (`latest.yml`, GitHub Releases) /
docs + changelog / help center / demo video / review screenshots — what
each yielded, its evidence grade, and why. Update-feed data counts as
vendor-documentary grade. If you never verified the installer beyond its
URL, the log must say so — an un-fetched download link is `Reported`, not
`Confirmed`.

## Exit criteria

You can say: does a native desktop client exist, for which OSes and
architectures (with the artifact table: URL, version, size, date, release
notes), what its release cadence shows, what framework signals point to,
what it can do that the browser tab can't, and how its journeys behave —
with the access log saying how you know.
