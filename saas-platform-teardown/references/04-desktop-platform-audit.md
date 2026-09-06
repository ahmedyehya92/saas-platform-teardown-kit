# Phase 3 — Desktop Platform Audit

Goal: establish whether a native desktop app exists, what kind it is, and
what it adds over the browser.

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

3. **Compare desktop vs web feature-for-feature** where you can access both:
   menu bar/system tray presence, global keyboard shortcuts, offline mode,
   local filesystem access, native notifications, multi-window support,
   auto-launch on login. These are the capabilities a browser tab
   structurally can't offer, so their presence or absence is the real
   signal of *why* a desktop app exists versus being a thin wrapper.

4. **Note OS/architecture coverage**: Windows/macOS/Linux, and Intel vs
   Apple Silicon builds where relevant — this indicates engineering
   investment level in the desktop platform.

5. **If the "desktop app" is just the website in a wrapper** (no
   capabilities beyond what Phase 1 already found), say so explicitly. That
   is a legitimate and common finding, not a failure to dig deeper.

## Exit criteria

You can say: does a native desktop client exist, for which OSes, what
framework signals point to (if any), and what it can do that the browser
tab can't.
