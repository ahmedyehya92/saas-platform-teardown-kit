# Phase 6 — Report Assembly

## File-count decision

- **Single file** (`<product-slug>-teardown.md`) when the product is small
  enough that web+mobile+desktop+integration findings fit comfortably in one
  document a person would actually read top to bottom — roughly, when there's
  no native desktop app AND mobile is a thin companion. Use the single-file
  version of the template structure below as section headers instead of
  separate files.
- **Multi-file** (a `<product-slug>-teardown/` folder using every file in
  `assets/report-template/`) when there's meaningful depth on 3+ platforms,
  or when the report is likely to be referenced section-by-section rather
  than read once end to end.

Default to multi-file for anything that made it through all four platform
phases with real findings — it's the more useful artifact and costs nothing
extra to produce once the research is done.

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
4. `00-INDEX.md` is a one-screen executive summary plus links to every other
   file — write this LAST, once you know what the report actually contains.
5. `06-pricing-and-sources.md` ends with a flat list of every source URL
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
