# Phase 4 — Integration Architecture

Goal: synthesize how web, mobile, and desktop relate to each other — and
WHY the product is wired that way. Technical topology alone ("shared auth,
same API domain") doesn't support decisions; every integration point also
needs the business objective a PM would give for building it that way.
This phase is synthesis over evidence gathered in Phases 0–3, plus a few
targeted lookups. Do not re-audit platforms; connect what's already known.

## Technical questions to resolve, each with evidence

1. **Shared account/auth?** Same login credentials and session model across
   platforms is the baseline expectation — confirm it (or find the
   exception, e.g. desktop requires a separate device-pairing code).

2. **Same backend?** Compare the API domain observed from the web app's
   network traffic (Phase 1) against any API domain referenced in mobile app
   store metadata, desktop update manifests, or public API docs. Matching
   domains across platforms is strong evidence of one shared backend;
   different domains suggest separate services or a BFF (backend-for-frontend)
   layer per platform.

3. **Sync model.** Real-time (websocket/push-based), periodic poll, or
   manual export/import? Status-page incident history (from Phase 0) often
   mentions "sync service" or "realtime service" outages — that's a direct,
   citable signal of the actual architecture, not marketing language.

4. **Push notification path.** If the mobile app requests notification
   permissions, that implies APNs (iOS) / FCM (Android) integration, which
   in turn implies a backend notification service that both mobile clients
   and (often) the web app's in-app notification center draw from. Note this
   as `Inferred` unless directly confirmed in docs.

5. **Public API / integrations surface.** Does a public API or webhook
   system exist? Is the product listed in Zapier/Make/n8n's app directories
   (search for this)? A product with a mature public API and an
   integrations marketplace has a materially different architecture posture
   (multi-tenant platform) than one without.

6. **What's the single source of truth?** For products where one platform is
   clearly primary (usually web) and others are companions, say so plainly
   — this is often the most useful sentence in the whole report for someone
   deciding whether they need the mobile app at all.

## The "why" layer: business-objective mapping

For every integration point the questions above surface — shared auth, sync
model, notification paths, each platform's existence and its exclusive
features, every journey handoff — pair the technical finding with the
business objective it serves. A manager deciding whether this product is a
threat reads the "why" column, not the topology. Two paths, in order:

1. **Stated rationale → `Confirmed`.** Vendors explain platform strategy
   more often than you'd expect. Mine, in this order:
   - Changelog entries ("now on iOS so you can approve requests from
     anywhere") — dated, specific, citable
   - App Store / Play listing descriptions ("capture receipts the moment
     you get them") — the mobile value prop in the vendor's own words
   - Engineering blog posts and launch posts (Product Hunt maker comments
     often state why a platform was built)
   - Help-center framing ("manage billing on the web, track expenses on
     mobile")
   - The marketing site's per-platform pitch pages
   - Job postings (a burst of mobile or desktop hiring is strategy in
     plain sight — `Inferred` even though the posting is real, because the
     strategy conclusion is yours)
   Cite the exact source next to the objective.

2. **Explicit inference → `Inferred`, with the reasoning shown.** When
   nothing is stated, infer against this pattern library, then TIE THE
   PATTERN TO THIS PRODUCT'S OBSERVED BEHAVIOR — a pattern with no observed
   evidence is a guess, not an inference:
   - **Companion mobile app →** capture at the moment of stimulus
     (photo/scan/voice), act or approve away from the desk, recover
     abandoned flows started on web. Evidence to look for: mobile-exclusive
     camera/scan/offline capabilities, push permissions, review complaints
     about what's missing (the missing part tells you what the app is FOR).
   - **Desktop app →** cut time-to-capture on the core loop (tray, global
     hotkeys), offline/latency tolerance, system-level integration
     (filesystem, native notifications). Evidence: which capabilities from
     Phase 3's beyond-the-browser table are actually present — a
     wrapper-only app means the "why" was distribution/brand presence, not
     capability.
   - **Web as source of truth →** administration, bulk work, billing,
     configuration. Evidence: journey handoffs that push users TO web for
     admin/billing even from native apps.
   - **Mobile-only hardware pairing →** field/workforce workflows.
     Evidence: pairing documentation living only in mobile help sections
     (cross-check `references/08-hardware-integrations.md` if hardware was
     found).

   Write the reasoning chain, not just the conclusion — the template's
   format is: "menu-bar app + global hotkey + no offline mode (Phase 3
   table) → the desktop app exists to cut time-to-capture on the core
   workflow, consistent with this category's retention being capture-
   latency-driven — `Inferred`."

Every row of the business-objective map (template
`07-integration-architecture.md`) is: integration point | technical
evidence | business objective | tag — `Confirmed` (vendor-stated, cited) or
`Inferred` (reasoning shown).

## Journey handoff & persona synthesis

Consolidate the per-platform journey findings from Phases 1–3 (each
playbook recorded handoffs and personas for exactly this moment):

- **Handoff map.** Every point where a journey crosses platforms — web→
  mobile deep links, QR "scan to install", mobile→web escape hatches for
  admin/billing, desktop login roundtrips through the browser. For each:
  is the handoff supported (deep link / QR / manual re-login), and where
  does it break? A broken handoff is a friction finding with a journey-
  level citation, which is worth more than any amount of "seamless sync"
  marketing copy.
- **Persona × platform matrix.** Which personas the product serves (from
  roles/permissions observed in team setup and from journey variants), and
  which platform primarily serves each — e.g. admin lives on web, end user
  lives on mobile, power user lives on desktop. This matrix is often the
  sharpest one-glance answer to "who is this product really for?"

## Output for this phase

The architecture narrative (not a literal system diagram unless you have
strong direct evidence for one), the platform × {auth model, data source,
sync behavior, notification path} table with each cell tagged Confirmed /
Reported / Inferred — PLUS the business-objective map, the journey handoff
map, and the persona × platform matrix. All of it lands in template
`07-integration-architecture.md`, with the handoff map and persona matrix
mirrored in `05-user-journeys.md`. If Phase 0 found hardware, the hardware
playbook's business-rationale findings join this map.
