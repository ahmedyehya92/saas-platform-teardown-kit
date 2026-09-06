# Phase 5 — Broad Research Sweeps via `agy`

`agy` (Antigravity CLI) is Gemini-backed with grounded web search, and it's
scriptable headlessly. That makes it the right tool for broad,
fast-to-parallelize research questions — company facts, store listings,
integration directories, pricing pages — freeing Claude Code's own
web-search budget for the judgment-heavy synthesis work. It is not a
substitute for Playwright's live DOM access in Phase 1; use it for facts
that live in text on the open web, not for live in-app behavior.

## Invocation pattern (verified against agy 1.1.27)

```bash
mkdir -p .agy-out && agy -p "PROMPT" --output-format stream-json \
  --model gemini-3.8-flash --effort medium \
  > .agy-out/<slug>.jsonl
```

Flag notes, so future drift is easy to diagnose:

- `-p` (print mode) is already non-interactive — there is NO
  `--non-interactive` flag; passing one aborts the run with
  `flags provided but not defined`.
- `--model gemini-3.8-flash` REQUIRES a paired effort — either
  `--effort medium` or `--effort=medium` (both accepted); omitting it fails
  with `invalid model selection`. `medium` is the right default for research
  sweeps; drop to `low` for trivial lookups. If the model name 404s on a
  future agy version, run `agy models` and pick the current flash-family
  entry.
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

1. **Allow-rules (surgical — configured on this machine already).**
   `~/.gemini/antigravity-cli/settings.json` → `permissions.allow` contains
   `"search_web"`, `"read_url(*)"`, `"read_url_content(*)"`,
   `"read_resource(*)"`. GOTCHA: the permission name is `read_url`, which
   differs from the tool name `read_url_content` — the error message quotes
   the name to use. With these rules the plain invocation above just works.
2. **`--dangerously-skip-permissions` (any machine, blanket).** Auto-approves
   ALL agy tool use, including terminal execution — only use it when the
   allow-rules are missing and never feed untrusted page content into agy
   prompts, since injected instructions could drive those tools.

Run several of these as background bash jobs in parallel (`&` + `wait`, or
separate tool calls) rather than one at a time — this is the whole point of
shelling out to a second agent.

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
built-in `web_search` tool for that question rather than stalling the
pipeline.

## Writing the prompt: treat `agy` as a subagent, not a search box

Every prompt sent to `agy` should specify role, exact question, required
sourcing, and required output shape — vague prompts get vague, ungrounded
answers back. Template:

```
You are a product research analyst. Search the current web (today's date
matters — this product may have changed recently) and answer ONLY the
question below using information you can attribute to a real, named source.
If you cannot verify something, say "not found" rather than guessing.

QUESTION: <specific question>

Return ONLY valid JSON, no prose, no markdown fences, matching this shape:
{ "answer": "...", "sources": ["https://...", "..."], "confidence": "confirmed|reported|unverified" }
```

## Ready-made sweeps to fire once Phase 0 has a product name/domain

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

Two integrity rules for the revenue sweeps specifically: never let `agy`
merge estimates from different sources into one number (each figure keeps
its source; the report's revenue table does the comparison), and treat a
funding round as a fact with a revenue *multiple* attached to it — the
multiple is an assumption, so the output is a stage signal, not a figure.

Adjust wording per product, but keep the role/question/sourcing/output-shape
structure — that's what makes `agy`'s answers usable without a second pass
of cleanup.
