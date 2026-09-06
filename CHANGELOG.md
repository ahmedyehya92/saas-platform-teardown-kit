# Changelog

## 2026-09-06 — Decision-grade upgrade

### Why

The kit's reports answered "what does this product look like?" but not "is
this competitor a real threat?" They inventoried features and tech stack,
but had no methodology for user journeys, integration business logic,
hardware coverage, business scale, or concrete release artifacts — so those
report sections would have stayed empty even if headers had been added.
This upgrade adds real methodology to the playbooks (not just new template
headers) for each of those five areas, plus an honest "how we could see
this at all" layer.

Structural decisions were confirmed with the kit owner: journeys use the
hybrid model (walked per-platform during Phases 1–3, synthesized in Phase
4, consolidated in one report file); hardware uses a conditional playbook
(loaded only when a touchpoint is found); templates were renumbered for
decision-maker reading order.

### Methodology — `references/`

- **`01-intake-and-recon.md`** — Phase 0 now also produces: a per-surface
  access plan (use the self-serve trial vs. flag for the no-credential
  ladder vs. hard wall), a complete verified link inventory (the web
  platform's release artifact), an explicit hardware touchpoint check
  (binary outcome, recorded either way), and an early dispatch of the
  revenue/business-scale sweeps so numbers are ready at report time.
- **`02-web-platform-audit.md`** — now owns the CANONICAL no-credential
  access ladder (self-serve trial as Tier 0, then 7 rungs: demo videos →
  sales/conference material → help center → third-party screenshots →
  job-posting/ecosystem leaks → Wayback → public API docs), each with an
  evidence grade; a full user-journey methodology (onboarding, aha task,
  team setup, churn-risk, web-exclusive — with a fixed per-journey schema,
  persona tagging, and walked-vs-reconstructed labeling); and the required
  access-methods log. The old one-line "fall back to docs and demo videos"
  is gone.
- **`03-mobile-platform-audit.md`** — store-listing metadata treated as the
  formal release artifact (version/size/updated/min-OS/publisher, version
  history, direct-APK/sideload check); explicit no-APK/IPA-extraction
  constraint; mobile journey reconstruction method (store screenshots as
  onboarding sequence, help-center flows, review complaints as friction
  data); store permissions double as the hardware second-check; required
  access log.
- **`04-desktop-platform-audit.md`** — release-artifact table method (every
  OS × architecture with exact URL, version, size via HEAD request, date,
  release-notes link; missing architectures are findings), version-history
  mining from public update feeds (electron-builder `latest.yml`, GitHub
  Releases, Sparkle appcast) as a release-cadence signal, and desktop
  journeys (install/first-run, browser-OAuth login roundtrip,
  desktop-exclusive capabilities).
- **`05-integration-architecture.md`** — new "why" layer: every technical
  integration paired with the business objective it serves, vendor-stated
  (`Confirmed`, cited) or explicitly inferred (`Inferred`, reasoning chain
  shown) against a pattern library tied to observed evidence; new journey
  handoff synthesis and persona × platform matrix consolidating Phases 1–3.
- **`06-agy-search-playbook.md`** — eight new ready-made sweeps: revenue
  estimates (Owler/Craft/Growjo/PitchBook/LinkedIn), mobile app traction
  (Sensor Tower/data.ai/Appfigures), web traffic proxy (labeled as scale
  indicator, not revenue), public-filings check, customer-count claims,
  hardware FCC filings, changelog history, and Wayback availability — plus
  integrity rules (never merge estimates across sources; funding-multiple
  inference is a stage signal, not a figure).
- **`08-hardware-integrations.md`** (NEW, conditional) — loaded only when a
  hardware touchpoint is found; protocols, pairing flows, the platform
  pairing matrix (mobile-only pairing as the common gap), firmware/SDK
  update paths, certified-hardware lists, actual-manufacturer
  identification via FCC grantee/teardowns/import records, and business
  rationale per device family. Runs entirely on public filings and docs —
  no purchase, no firmware dumping.

### Templates — `assets/report-template/`

Renumbered for reading order; two files added. All new sections carry
structure AND the rules that fill them (method columns, tag columns,
evidence-basis columns), not empty headers.

- `00-INDEX.md` — at-a-glance gains hardware + estimated-scale rows and an
  access-methods-at-a-glance table.
- `01-overview-and-recon.md` — complete link inventory (11 surfaces, exact
  URLs, verified status), hardware-check finding, business-scale signals
  summary.
- `02/03/04-*.md` — each gains an "Access methods used" log; mobile and
  desktop gain release-artifact tables (per store / per OS×arch with
  version history); all three gain journey sections feeding 05.
- `05-user-journeys.md` (NEW) — all platforms × the five journey types with
  the full schema, evidence-basis legend, personas, cross-platform handoff
  map, persona × platform matrix.
- `06-hardware-integrations.md` (NEW) — per-device-family table (protocol,
  pairing matrix, firmware, manufacturer) or the explicit none-finding.
- `07-integration-architecture.md` (was 05) — adds the integration
  business-objective map (evidence → objective → tag & reasoning).
- `08-pricing-revenue-sources.md` (was 06) — adds source-by-source revenue
  estimates with inherent-reliability column, regulator-filing override,
  and a bottom-up estimate block that shows its math and assumptions.

### Orchestrator — `SKILL.md`

- Description extended to the new scope (journeys, business logic,
  hardware, revenue signals, release artifacts).
- Phases table: updated goals + the conditional hardware row; note on
  journey walking across Phases 1–3.
- Operating rules added: self-serve access is in scope / walls are not
  (with the ladder as the sanctioned fallback); access-methods log per
  platform; revenue figures carry their method; store-listing metadata is
  the mobile-binary ceiling; hardware gets an explicit answer.
- Definition of done grew from 8 to 14 checks, covering journeys,
  business-logic pairing, hardware, revenue method, release artifacts, and
  access logs.

### Constraints — unchanged, now stated where they're used

No real payment info; no bypassing auth/paywalls/rate limits/bot
protection; no scraping content you don't have a right to access; no
APK/IPA extraction or DRM/binary bypass (store-listing metadata is the
ceiling); every claim keeps its Confirmed/Reported/Inferred tag and
source. The access ladder is the sanctioned answer to gating — not a
workaround for it.
