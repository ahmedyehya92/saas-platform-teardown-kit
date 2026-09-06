# Phase 2 — Mobile Platform Audit

Goal: establish, with sources, whether native mobile apps exist and — if so
— what they can and can't do relative to web.

Playwright MCP can't drive a native mobile app, so this phase works from
store listings, changelogs, reviews, and (if you have a device/simulator in
the environment) direct install — most Claude Code environments won't, so
default to the store-listing method below.

## Steps

1. **Confirm existence per store.** Search the App Store and Google Play
   directly (`agy` or `web_search`: `"<product name>" site:apps.apple.com`,
   `"<product name>" site:play.google.com`). Absence after a real search is
   itself a finding — report "no native mobile app found" with the search
   terms used, don't just go silent on mobile.

2. **Pull structured listing data** (via an app-store review/listing CLI if
   one is installed, otherwise `web_fetch` the store page directly):
   - Description and screenshots (what the store screenshots emphasize often
     reveals the mobile-specific value prop, e.g. "scan receipts on the go")
   - Supported OS versions, app size, last update date
   - Permissions requested (Play Store "App info" / "Data safety" section;
     App Store "App Privacy" section) — a strong signal for mobile-only
     capabilities: camera, location, biometrics, contacts, push notifications
   - Version history / "What's New" entries — read the last 5–10 to build a
     mini feature timeline and catch recently added mobile-only capabilities

3. **Read a sample of reviews for feature signal**, not sentiment: users
   frequently complain "I can't do X on mobile that I can do on web" or ask
   for a feature by name. That's free feature-gap data. Cap this — a
   representative sample of recent reviews, not an exhaustive read.

4. **Classify the mobile app's role** against the web app using the recon
   dossier: `companion` (view/notify only), `full parity`, or `mobile-first
   extras` (has capabilities the web app lacks, e.g. widgets, offline mode,
   biometric unlock, camera capture). State which, with the evidence.

5. **If genuinely nothing else is available**, state the conclusion plainly:
   "This product has no native mobile app; mobile access is via responsive
   web only," and note whether that responsive web experience was already
   evaluated in Phase 1.

## Exit criteria

You can say, with sources: which app stores the product is on (or isn't),
what mobile-specific capabilities it has if any, and how mobile relates to
web in terms of feature parity.
