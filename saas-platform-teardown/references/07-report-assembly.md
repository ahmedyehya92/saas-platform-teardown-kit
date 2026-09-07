# Phase 6 — Report Assembly

## File-count decision

- **Single file** (`<product-slug>-teardown.md`) when the product is small
  enough that web+mobile+desktop+integration findings fit comfortably in one
  document a person would actually read top to bottom — roughly, when there's
  no native desktop app AND mobile is a thin companion AND there's no
  hardware. Use the template files' order below as section headers instead of
  separate files.
- **Multi-file** (a `<product-slug>-teardown/` folder using every file in
  `assets/report-template/`) when there's meaningful depth on 3+ platforms,
  hardware coverage, or reference-style consumption — likely to be read
  section-by-section rather than once end to end.

Default to multi-file for anything that made it through all four platform
phases with real findings — it's the more useful artifact and costs nothing
extra to produce once the research is done.

## Template files, in reading order

| File | Carries |
|---|---|
| `00-INDEX.md` | Executive summary, at-a-glance table, access-methods summary, links |
| `01-overview-and-recon.md` | Company, positioning, **complete verified link inventory**, hardware check, business-scale signals |
| `02-web-platform.md` | Access log, navigation, web journeys, features, API domains |
| `03-mobile-platform.md` | Access log, store release artifacts, version history, mobile journeys, parity |
| `04-desktop-platform.md` | Access log, per-OS/arch artifact table, version history, desktop journeys |
| `05-user-journeys.md` | All platforms × the five journey types, personas, handoff map, persona × platform matrix |
| `06-hardware-integrations.md` | Device families (protocol, pairing matrix, firmware, manufacturer) — or the explicit none-finding |
| `07-integration-architecture.md` | Cross-platform summary, **business-objective map**, narrative, API ecosystem |
| `08-pricing-revenue-sources.md` | Pricing tiers, **revenue estimates with method per figure**, source list |

`05` and `06` are never skipped: journeys are the report's decision-grade
core, and hardware gets an explicit "none found (checked where)" even when
empty. An absent section is a missing answer, not a negative finding.

## Assembly steps

1. Copy `assets/report-template/*.md` into the output location and fill each
   placeholder — do not leave template scaffolding text in the final output.
2. Every section file opens with:

   ```
   > Researched: <date>. Sources current as of this date; SaaS products
   > change frequently — verify anything decision-critical before acting on it.
   ```

3. Every factual bullet ends with a confidence tag and, where applicable, a
   link: `— Confirmed (screenshot, in-app)`, `— Reported ([G2 review](url))`,
   `— Inferred (shared session cookie domain across web and desktop)`.
4. **Access-log check:** every platform file (02/03/04) states which access
   methods produced its claims and their evidence grades, and `00-INDEX.md`
   summarizes them at a glance. A reader must be able to tell verified truth
   from secondhand reconstruction without re-deriving it. If a platform
   section has no access log, it is not done.
5. **Revenue method check:** every revenue/scale figure in 08 names its
   method and source; estimates are labeled estimates; the bottom-up range
   shows its math and assumptions; any regulator-filed figure is marked as
   filed, not estimated. A lone unsourced number is worse than no number —
   source it or cut it.
6. **Journey check:** every journey in 05 carries an evidence basis (walked
   live / reconstructed from which ladder rung), persona tags where the
   product serves multiple user types, and observed-or-reported friction.
   "Reconstructed" must never read as "walked."
7. `00-INDEX.md` is a one-screen executive summary plus links to every other
   file — write this LAST, once you know what the report actually contains.
8. `08-pricing-revenue-sources.md` ends with a flat list of every source URL
   used anywhere in the report, deduplicated — this is the report's
   bibliography and lets a reader audit any claim.

## Writing style for the report body

- Plain, declarative sentences. This is documentation, not marketing copy —
  avoid adjectives the product's own landing page would use ("powerful",
  "seamless", "effortless") unless directly quoting and attributing them as
  the company's own claim.
- Paraphrase all secondary-source content; never reproduce review text,
  article paragraphs, or store descriptions verbatim beyond a very short
  attributed phrase.
- Tables over prose wherever the content is naturally tabular (feature ×
  platform, plan × price, platform × sync behavior) — this is a reference
  document, not an essay.

## Final step

Write all files under `./<product-slug>-teardown/` in the current working
directory (or a single file at that path) and present them to the user. A
report that's written but never surfaced is not a completed teardown.
