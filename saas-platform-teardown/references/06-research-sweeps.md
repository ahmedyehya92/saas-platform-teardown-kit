# Phase 5 — Broad Research Sweeps

Fifteen ready-made sweeps answer the broad, fast-moving questions every
teardown needs — company facts, store listings, desktop distribution,
integration directories, pricing pages, revenue signals. They are
engine-agnostic: the same question, the same sourcing rules, the same
output discipline regardless of which engine runs them. Sweeps are not a
substitute for live DOM access in Phase 1; use them for facts that live in
text on the open web, not for live in-app behavior.

## Picking the engine (once, at Phase-5 dispatch)

Run `command -v agy` (bash) exactly once, when Phase 0 has produced the
concrete questions:

- **Absent → Engine A (built-in web search/fetch). This is the default
  path and the normal case — not a degraded mode.** Do not warn, do not
  block, do not ask the user. Run the sweeps sequentially inside your own
  tool loop.
- **Present → Engine B (`agy`, optional power path).** Same sweeps, fanned
  out as parallel headless shell jobs — freeing Claude Code's own
  web-search budget for the judgment-heavy synthesis work. Read the
  Engine B section (especially the permissions trap) before the first
  sweep.

Either way, record which engine ran the sweeps in the report's methodology
section.

**Honesty rule: pace differs by engine; quality must not.** An Engine A
report must not be visibly thinner on sourced claims than an Engine B one
would have been — Engine A costs more of your context, not less of the
reader's confidence.

## The 15 sweeps (engine-agnostic)

Fire once Phase 0 has a product name/domain. Work in priority order — the
first five unblock later phases, so they run first under either engine.
Sweep 13 is conditional by design: when Phase 0 found no hardware,
recording it as skipped-conditional in the sweep ledger is the correct
outcome, not a gap.

1. **Company facts** — "Find <product>'s parent company, founding year,
   funding stage/amount if public, and approximate headcount. Cite each
   fact to a specific source (Crunchbase, LinkedIn, official blog, press)."

2. **App store presence** — "Find the official iOS App Store and Google Play
   listing URLs for <product> (not a similarly-named unrelated app — verify
   by matching the developer/publisher name to <company>). Report each
   store's last-updated date and current version number."

3. **Desktop distribution** — "Find whether <product> ships a native
   desktop application for macOS, Windows, and/or Linux, and the direct
   download URL(s). If none exists, say so explicitly."

4. **Integrations directory** — "List <product>'s official integrations or
   app marketplace, and separately check whether <product> has a listing in
   Zapier's, Make's, and n8n's app directories. Report counts and a few
   named examples per source, with URLs."

5. **Public API** — "Does <product> have public developer/API documentation?
   Report the docs URL, authentication method described (API key/OAuth),
   and whether webhooks are supported."

6. **Pricing tiers** — "List <product>'s current pricing tiers, prices, and
   the 3–5 headline features that differ between tiers, from the official
   pricing page."

7. **Tech-stack corroboration** — "Search job postings and engineering blog
   posts from <company> for their web/mobile/desktop tech stack (framework
   names, languages, infra providers). Cite each claim to a specific
   posting or post."

8. **Revenue / business-scale estimates** — "Find revenue or ARR estimates
   for <company> from Owler, Craft.co, Growjo, and any PitchBook or press
   coverage of funding rounds. Report each funding round (amount, date,
   stage, lead investor) and LinkedIn's 'estimated revenue' band if
   visible. Return each estimate SEPARATELY with the source site named —
   do not average or merge them. Say 'not found' per source if absent."

9. **Mobile app traction** — "Find any public download or revenue estimates
   for <product>'s iOS and Android apps from Sensor Tower, data.ai
   (Similarweb), or Appfigures — usually via blog posts or press articles
   citing them. Report the figure, which app, the estimating firm, and the
   citing page URL."

10. **Web traffic proxy** — "Find Similarweb or SEMrush public estimates of
    monthly visits and global rank for <domain>. These are traffic
    proxies only — label them as scale indicators, not revenue."

11. **Public-filings check** — "Is <company> publicly traded, a subsidiary
    of a public company, or otherwise a regulator filer (SEC 10-K/20-F,
    Form 990)? If yes, name the filing and the revenue the latest filing
    states for the most recent fiscal year."

12. **Customer-count claims** — "Find public customer/team/logo counts for
    <product>: marketing-site claims ('trusted by N teams'), case studies,
    press releases, about pages. Report the number, the claim's exact
    wording, and the page it appears on."

13. **Hardware filings (only when Phase 0 found hardware)** — "Search the
    FCC ID database and fccid.io for wireless equipment authorization
    filings by <company> or branded '<product>' devices. Report FCC IDs,
    the grantee/manufacturer name on each filing, and the device type.
    Also check for iFixit or other teardown coverage of the hardware."

14. **Changelog / release-notes history** — "Find <product>'s changelog or
    release-notes page. Summarize the last 5–10 dated entries: version or
    date, platform affected (web/iOS/Android/desktop), and headline
    changes."

15. **Wayback availability** — "Check the Wayback Machine for snapshots of
    <url>: report the earliest capture date, the most recent capture date,
    and roughly how many captures exist."

Two integrity rules for the revenue sweeps specifically: never merge
estimates from different sources into one number (each figure keeps its
source; the report's revenue table does the comparison), and treat a
funding round as a fact with a revenue *multiple* attached to it — the
multiple is an assumption, so the output is a stage signal, not a figure.

Adjust wording per product, but keep the role/question/sourcing/output-shape
structure — that's what makes the answers usable without a second pass of
cleanup.

### Shared prompt skeleton (both engines)

Every research prompt specifies role, exact question, required sourcing,
and required output shape — vague prompts get vague, ungrounded answers
back. Template:

```
You are a product research analyst. Search the current web (today's date
matters — this product may have changed recently) and answer ONLY the
question below using information you can attribute to a real, named source.
If you cannot verify something, say "not found" rather than guessing.

QUESTION: <specific question>

Return ONLY valid JSON, no prose, no markdown fences, matching this shape:
{ "answer": "...", "sources": ["https://...", "..."], "confidence": "confirmed|reported|unverified" }
```

Output discipline, either engine: every fact a sweep yields is recorded as
{claim, source URL, confidence} and appended to the recon dossier as you
go — Phase 6 assembly merges notes, it does not re-search.

## Engine A — built-in web search/fetch (default, zero-install)

The built-in WebSearch/WebFetch tools run the same sweeps, sequentially.
The failure mode to design against is thin fan-out — many shallow queries
and few pinned sources. Instead:

- **Prioritize; don't fan out.** Company facts, app-store presence,
  desktop distribution, pricing, and revenue first — Phases 1–4 and the
  report's pricing/revenue files block on those. Changelog, traffic
  proxies, Wayback, and the rest run afterwards, or are consciously
  skipped and logged as skipped when the product makes them moot (no
  changelog page, no desktop app to check Wayback for, and so on).
- **1–3 well-formed queries per sweep.** Compose the query from the sweep
  text itself — product name, site restriction, estimator name — rather
  than firing many fragments. One query that names its sources beats five
  that don't.
- **WebFetch the source once you've found it.** A fetched primary page
  (the official pricing page, the store listing itself, the integrations
  directory) beats three search summaries of it — and the fetch upgrades
  the claim: you saw the page, not a description of the page.
- **Append per-fact lines to the recon dossier as you go** (claim, source
  URL, confidence) rather than holding facts in working memory for the
  whole run.
- **Wayback exception (sweep 15):** some fetchers refuse
  `web.archive.org` itself. The workaround is the availability API —
  `https://archive.org/wayback/available?url=<url>` — plus fetching a
  raw snapshot URL it returns; that yields earliest/recent capture dates
  and the archived page content without touching the blocked host.

## Engine B — `agy` (optional power path)

`agy` (Antigravity CLI) is Gemini-backed with grounded web search, and it's
scriptable headlessly. It is a power path, not a requirement — every sweep
above runs fine on Engine A; Engine B runs them in parallel and offloads
the raw search/browse tokens.

### Invocation (verified working as of agy 1.1.27, September 2026)

```bash
mkdir -p .agy-out && agy -p "PROMPT" --output-format stream-json \
  --model gemini-3.8-flash --effort medium \
  > .agy-out/<slug>.jsonl
```

Flag notes, so future drift is easy to diagnose:

- `-p` (print mode) is already non-interactive — there is NO
  `--non-interactive` flag; passing one aborts the run with
  `flags provided but not defined`.
- **Model-string aging rule:** the `--model` value is the perishable part
  of this block. The durable invariant is that `--model` REQUIRES a paired
  effort — either `--effort medium` or `--effort=medium` (both accepted);
  omitting it fails with `invalid model selection`. `medium` is the right
  default for research sweeps; drop to `low` for trivial lookups. When a
  future agy version 404s the pinned name, run `agy models` and pick the
  current flash-family entry.
- Long research prompts can exceed the default 5-minute wait; add
  `--print-timeout 10m` if a sweep is timing out.

### Permissions: the headless killer (read this before debugging "empty" answers)

Research prompts make agy call its own tools (`search_web`, `read_url`, …),
and in headless mode there is no one to approve them. A blocked run looks
like this — note the trap that status still says `SUCCESS`:

- stderr: `jetski: no output produced — a tool required the "read_url"
  permission that headless mode cannot prompt for, so it was auto-denied.`
- result event: `"status":"SUCCESS"` with `"response":""` (EMPTY)

So ALWAYS check the response is non-empty, not just the status. Two fixes,
in order of preference:

1. **Allow-rules (surgical).** `~/.gemini/antigravity-cli/settings.json` →
   `permissions.allow` contains `"search_web"`, `"read_url(*)"`,
   `"read_url_content(*)"`, `"read_resource(*)"`. GOTCHA: the permission
   name is `read_url`, which differs from the tool name `read_url_content`
   — the error message quotes the name to use. With these rules the plain
   invocation above just works.
2. **`--dangerously-skip-permissions` (any machine, blanket).** Auto-approves
   ALL agy tool use, including terminal execution — only use it when the
   allow-rules are missing and never feed untrusted page content into agy
   prompts, since injected instructions could drive those tools.

A third signature, prompt-shaped rather than permission-shaped: if stderr
quotes the `command` permission, the sweep tried to verify a URL by
shelling out (curl/HEAD) and was auto-denied — the retry is
deterministically empty. Sweeps should report URLs *as listed on the
page*, not probe them; verification by HEAD request belongs to the
platform-audit phases. Telling the model not to probe helps but is not
reliable (verified 2026-09: the desktop-distribution sweep kept reaching
for the shell even when told not to). The two dependable escapes: a
narrow `command` allow-rule (grants agy terminal execution — scope it
deliberately), or the documented per-sweep fallback below — rerun that
one question on the built-in search tools.

Run several sweeps as background bash jobs in parallel (`&` + `wait`, or
separate tool calls) rather than one at a time — this is the whole point
of shelling out to a second agent.

Parse the result with `jq`. The stream is NDJSON with three event types:
`init`, `step_update` (progress noise), and one final `result`. The answer
is `.result.response`, and `.result.status` is `SUCCESS` or `ERROR`:

```bash
# the answer text
jq -r 'select(.event=="result") | .result.response' .agy-out/<slug>.jsonl
# status check — and verify NON-EMPTY response (see permissions trap above)
jq -r 'select(.event=="result") | "\(.result.status) len=\(.result.response | length)"' \
  .agy-out/<slug>.jsonl
```

If a sweep fails or returns empty, retry once, then fall back to the
built-in web search/fetch tools for that question rather than stalling the
pipeline.
