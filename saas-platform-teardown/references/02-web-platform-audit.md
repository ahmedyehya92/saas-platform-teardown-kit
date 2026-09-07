# Phase 1 — Web Platform Audit

Goal: document what the web app actually does (not what the marketing copy
claims), walk its user journeys end to end, and record exactly how you were
able to see what you saw. This phase leans on live browser access for ground
truth — accessibility-tree snapshots and real DOM/network state instead of
inferring layout from a prompt.

## Browser tooling: pick whichever is actually available

Check in this order and use the first that works — do NOT skip the phase
just because one tool is missing:

1. **Playwright MCP** (preferred). Tools appear as `mcp__playwright__*`
   (`browser_navigate`, `browser_snapshot`, `browser_network_requests`,
   `browser_take_screenshot`, ...). Verify presence before relying on it —
   if a session shows none, run `claude mcp list | grep playwright` to
   check; it should report `✔ Connected`.
2. **`agent-browser` CLI** (fallback, verified installed). Same job,
   shell-based: `agent-browser open <url>`, `agent-browser snapshot`,
   `agent-browser screenshot <path>`, `agent-browser eval '<js>'`.
   It speaks accessibility-tree YAML like the MCP does, so the audit steps
   below translate 1:1 — just batch commands in single bash calls.
3. **Neither** → degrade gracefully: `WebFetch` the public pages, say so
   explicitly in the report's methodology section, and mark all UI claims
   `Reported` instead of `Confirmed`.

## Getting in: access triage and the no-credential ladder

Try the tiers in order. The ladder below is the CANONICAL version — the
mobile and desktop audits reuse it by reference, because every rung that
yields web screenshots of gated screens tends to yield mobile/desktop
screenshots of the same product too.

**Tier 0 — self-serve account. Always try this first; it is usually
sufficient.** If the vendor offers a free trial, freemium tier, or public
sandbox, sign up with a disposable identity and use it. A product with a
self-serve tier is NOT gated — never jump to secondhand sources while a
live trial is on the table. Two hard stops, per the operating rules: never
provide real payment details (a card-required "free" trial is a wall, not
a door), and stop at ID verification. Even with a live account, the ladder
below stays useful for screens your tier can't reach (higher-plan
features, admin-only areas) — don't pay to see them, reconstruct them.

**If the product is genuinely enterprise-gated / sales-call-only, work the
ladder top-down and log which rungs you used, per platform:**

- **Rung 1 — official motion.** Demo videos, recorded product tours (the
  vendor's YouTube channel, Wistia/Vidyard embeds on their site),
  interactive tour pages (Navattic-style), recorded webinars. Real UI in
  motion, but staged: the vendor chose what you see and what they skipped.
- **Rung 2 — sales & conference material.** Sales-call recordings,
  conference talks, webinar slide decks (vendor events/resources pages,
  YouTube, Speaker Deck, SlideShare). These often walk the exact evaluation
  flows a buyer sees, including admin screens vendors hide from marketing.
- **Rung 3 — help center / knowledge base.** Vendors screenshot gated
  screens in order to explain them. Help articles are usually the single
  richest no-account source, and they're typically sequenced per flow
  (set up your workspace → invite your team → configure X), which lets you
  reconstruct *journeys*, not just screens. Search the help center for the
  flows in the journey list below, article by article.
- **Rung 4 — third-party screenshots.** G2 / Capterra / TrustRadius reviews
  (reviewers embed in-app screenshots), Product Hunt launch threads and
  comments, Reddit and community-forum posts. Unstaged but fragmentary and
  rarely dated — good for corroboration and for friction, weak alone.
- **Rung 5 — employer & ecosystem leaks.** Job postings with product
  screenshots embedded; engineering blog posts walking through internal
  tooling built on the product's own API.
- **Rung 6 — history.** Wayback Machine snapshots of the app itself or its
  docs — partial and dated, and also your tool for pricing/feature
  archaeology ("what did tier 3 include last year").
- **Rung 7 — structure without UI.** Public API / developer docs. The API's
  data model bounds the feature surface: every endpoint and object is a
  feature that exists, and what's absent bounds the scope. No account
  needed, ever.

**Evidence grades the rungs produce** — use these in the access-methods log
and on every reconstructed journey:

| Grade | Produced by | Ceiling for claims |
|---|---|---|
| live | walked in-app (trial/freemium) | `Confirmed` |
| vendor-documentary | help center, official video/webinar, API docs, changelog | `Reported` (vendor-authored) |
| third-party | review screenshots, forums, Product Hunt, Reddit | `Reported` (third-party) |
| marketing-render | landing-page imagery | `Reported` (staged) — weakest; say so when it's all you have |

These grades feed the claim-confidence mapping in SKILL.md's Evidence
language section — a grade records how evidence was seen, a confidence
label records what the claim is worth.

The ladder is the sanctioned answer to "no credentials." It is not a
license to bypass auth, paywalls, or bot protection — never do that, on any
rung, for any platform.

## Steps

1. **Map the navigation** with `browser_navigate` + `browser_snapshot`.
   Record every top-level section, and for each one:
   - What it's for, in one sentence
   - Key actions available (create, import, share, export, automate...)
   - Anything gated behind a higher plan (cross-reference the pricing page)

2. **Test at multiple viewports.** Ask for snapshots/screenshots at desktop
   (≈1440px) and mobile-web (≈375px) widths. Note whether the web app itself
   is responsive — this matters for the integration-architecture phase,
   since "no native mobile app" often means "the web app is the mobile
   experience," which is a real, reportable fact.

3. **Watch the network layer where the MCP tooling allows it.** Note the API
   domain(s) called (e.g. `api.product.com` vs the app domain) — this is a
   primary signal for Phase 4's shared-backend analysis, and for whether a
   public API exists at all (compare against any documented API docs URL
   from Phase 0).

4. **Capture screenshots of 3–6 representative screens** — enough to
   illustrate the product in the final report. Journeys (below) add their
   own decision-point screenshots on top of this baseline set.

5. **Cross-reference pricing.** Fetch the pricing page and map observed
   features to plan tiers. Flag any feature seen in-app that pricing copy
   doesn't mention, or vice versa — these mismatches are useful findings.

## User journeys on web — walk these while access is hot

The report's decision-grade core is journeys, not feature lists. Walk all
five below on web; they are consolidated per platform in the report's
`05-user-journeys.md` and synthesized cross-platform in Phase 4.

1. **Onboarding / first-run** — from signup to the first moment of value:
   everything the product makes you do before you get anything (email
   verification, workspace creation, setup questions), and where it drops
   you afterward.
2. **The core "aha" task end to end** — the primary thing the product
   exists for, performed completely: create → use → see the payoff.
3. **Account & team setup** — inviting teammates, roles/permissions, org or
   workspace creation, identity configuration (SSO hints even when the SSO
   itself is enterprise-gated).
4. **A churn-risk moment** — two variants, both inside the trial's rules:
   (a) deliberately approach or hit a plan limit (seats, rows, runs —
   whatever the free/trial tier caps) and record the paywall UX: what gets
   blocked, what the nudge looks like, how hard the sell is; (b) walk the
   cancellation / delete-account flow all the way to its final
   confirmation and abort there. Never enter payment info to see past a
   wall.
5. **Any web-exclusive flow** — something the other platforms structurally
   can't do: bulk operations, workspace administration, billing, exports.

**Record the same schema for every journey** (the template enforces it):
entry point (exact URL/screen) · steps in order (numbered, what you
clicked) · decision points (branches offered to the user) · handoffs to
another platform (deep links, QR codes, "download the app" prompts —
Phase 4 needs every one of these) · friction points observed · evidence
basis (walked live / reconstructed from which rung) · persona tag.

**Personas:** if the product clearly serves distinct user types (admin vs.
end user vs. viewer vs. billing owner — check the roles offered in team
setup, or distinct navs visible in help-center screenshots), tag each
journey with its persona, and where variants differ (admin's journey 2 vs.
end user's journey 2), walk or reconstruct BOTH and label which is which.

With live access: actually perform each journey; screenshot at each
decision point. Without: reconstruct from help-center article order
(rung 3), demo-video timelines (rung 1 — cite timestamps), and review
screenshots (rung 4). Every reconstructed step is `Reported` with its
source, and the journeys writeup must say "reconstructed" — never imply
"walked."

## Access-methods log (required output of this phase)

Before leaving this phase, fill the web platform's access-methods log
(template `02-web-platform.md`): which methods were actually used, what
each yielded, its evidence grade, and why it was chosen ("self-serve trial
existed" / "enterprise-gated; help center public"). This log is how a
reader weighs how much of the web section is verified truth versus
secondhand reconstruction — a report that omits it is overstating itself.

## What to record per feature

For each notable feature: name, one-line description, which plan tier it
requires (`Confirmed` if seen gated in-app, `Reported` if only pricing copy
says so), and a screenshot reference if captured.

## Exit criteria

You can list the web app's primary navigation, walk (or reconstruct,
labeled as such) its five journeys, state which API domain it talks to,
and point to an access-methods log that says how you know each of those.
