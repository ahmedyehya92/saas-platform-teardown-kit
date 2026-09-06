# Phase 4 — Integration Architecture

Goal: synthesize how web, mobile, and desktop actually relate to each other
— not repeat the marketing claim "seamlessly syncs everywhere" without
checking it.

This phase is synthesis over the evidence already gathered in Phases 0–3,
plus a few targeted lookups. Do not re-audit the platforms; connect what's
already known.

## Questions to resolve, each with evidence

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

## Output for this phase

A short architecture narrative (not a literal system diagram unless you have
strong direct evidence for one) plus a table: platform × {auth model, data
source, sync behavior, notification path}, each cell tagged Confirmed /
Reported / Inferred.
