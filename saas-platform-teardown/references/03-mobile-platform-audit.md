# Phase 2 — Mobile Platform Audit

Goal: establish, with sources, whether native mobile apps exist and — if so
— what they can and can't do relative to web; capture their release
artifacts from the store listings; and reconstruct their user journeys.

The live browser can't drive a native mobile app, and most environments
won't have a device or emulator attached, so this phase works
from store listings, changelogs, reviews, and the no-credential ladder
(canonical version: `references/02-web-platform-audit.md` — same rungs, same
evidence grades). If a device or emulator IS available and the product has
a self-serve free tier, a live install is legitimate and upgrades journey
claims from `Reported` to `Confirmed` — note it in the access log. Default
to the store-listing method.

## Steps

1. **Confirm existence per store.** Search the App Store and Google Play
   directly (`agy` or `web_search`: `"<product name>" site:apps.apple.com`,
   `"<product name>" site:play.google.com`). Absence after a real search is
   itself a finding — report "no native mobile app found" with the search
   terms used, don't just go silent on mobile.

2. **Pull structured listing data — these ARE the mobile release
   artifacts.** Via an app-store review/listing CLI if one is installed,
   otherwise fetch the store page directly:
   - Description and screenshots (what the store screenshots emphasize often
     reveals the mobile-specific value prop, e.g. "scan receipts on the go")
   - Supported OS versions, app size, last update date
   - Permissions requested (Play Store "App info" / "Data safety" section;
     App Store "App Privacy" section) — a strong signal for mobile-only
     capabilities: camera, location, biometrics, contacts, push
     notifications. Also re-run the Phase 0 hardware check here:
     Bluetooth/BLE, NFC, or USB-accessory permissions mean the app pairs
     with physical hardware, whether or not the marketing site said so —
     if this fires and the dossier doesn't already have hardware flagged,
     load `references/08-hardware-integrations.md`.
   - Version history / "What's New" entries — read the last 5–10 to build a
     dated mini timeline and catch recently added mobile-only capabilities.
   - The developer/publisher account name on each listing — if it doesn't
     match the company from Phase 0, that's a white-label or
     agency-built finding worth reporting.

   **Constraints — do not loosen these:** no APK extraction or downloads
   from APK-mirror sites, no IPA acquisition (that's jailbreak /
   enterprise-cert territory), no binary or DRM/protection analysis of any
   kind. Store-listing metadata is the full ceiling for mobile release
   data, and it is sufficient. One legitimate addition: check whether the
   vendor distributes a direct APK / sideload build for enterprise or
   Android-only distribution (their docs or download page); if the link is
   public, capture the link and its context — nothing more.

3. **Read a sample of reviews for feature signal**, not sentiment: users
   frequently complain "I can't do X on mobile that I can do on web" or ask
   for a feature by name. That's free feature-gap data — and each
   recurring complaint is a broken step in some journey; attribute it to
   that journey. Cap this — a representative sample of recent reviews, not
   an exhaustive read.

4. **Reconstruct mobile user journeys.** Same five journey types as web —
   onboarding/first-run, the core aha task, account & team setup, a
   churn-risk moment, and platform-exclusive flows — reconstructed because
   you usually can't walk them live:
   - Store-listing screenshots are often the onboarding sequence in
     disguise: first screens, empty states, permission asks, in that order.
   - Help-center mobile sections (ladder rung 3) document mobile flows
     screen by screen — usually the richest reconstruction source.
   - Review complaints are journey friction data ("forces you to the
     website to manage billing" is a handoff finding AND a friction point).
   - Demo videos (rung 1) frequently show the mobile app inside the
     vendor's cross-platform pitch.

   Mobile platform-exclusive journeys to look for specifically: push-
   permission onboarding, widget setup, offline capture flow, camera/scan
   capture, biometric unlock enablement, hardware pairing (if the Phase 0
   hardware check fired). Record each journey with the same schema as web
   (entry point, steps, decision points, handoffs — mobile journeys often
   hand OFF to web for admin/billing; capture exactly where, Phase 4 needs
   it), friction, and evidence basis. Everything is `Reported` unless a
   live install was performed.

5. **Classify the mobile app's role** against the web app using the recon
   dossier: `companion` (view/notify only), `full parity`, or `mobile-first
   extras` (has capabilities the web app lacks, e.g. widgets, offline mode,
   biometric unlock, camera capture). State which, with the evidence.

6. **If genuinely nothing else is available**, state the conclusion plainly:
   "This product has no native mobile app; mobile access is via responsive
   web only," and note whether that responsive web experience was already
   evaluated in Phase 1.

## Access-methods log (required output of this phase)

Fill the mobile platform's access log (template `03-mobile-platform.md`):
store listings (both stores searched?), help center, review screenshots,
demo videos, live install if performed — what each yielded, its evidence
grade, and why. If the product is enterprise-gated on mobile too, say
which ladder rungs produced whatever mobile truth exists; if the only
evidence is the store listing, say that — it bounds how much the section
can claim.

## Exit criteria

You can say, with sources: which app stores the product is on (or isn't),
its release artifacts per store (version, size, last updated, version
history, publisher), what mobile-specific capabilities it has, how mobile
relates to web in feature parity, and what its journeys look like — each
with its evidence basis labeled.
