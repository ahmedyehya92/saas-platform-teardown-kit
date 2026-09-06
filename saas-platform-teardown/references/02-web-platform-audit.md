# Phase 1 — Web Platform Audit

Goal: document what the web app actually does, not what the marketing copy
claims it does. This phase leans entirely on live browser access for
ground truth — accessibility-tree snapshots and real DOM/network state
instead of inferring layout from a prompt.

## Browser tooling: pick whichever is actually available

Check in this order and use the first that works — do NOT skip the phase
just because one tool is missing:

1. **Playwright MCP** (preferred). Tools appear as `mcp__playwright__*`
   (`browser_navigate`, `browser_snapshot`, `browser_network_requests`,
   `browser_take_screenshot`, ...). Verify presence before relying on it —
   if a session shows none, run `claude mcp list | grep playwright` to
   check; it should report `✔ Connected` (it is registered at user scope).
2. **`agent-browser` CLI** (fallback, verified installed). Same job,
   shell-based: `agent-browser open <url>`, `agent-browser snapshot`,
   `agent-browser screenshot <path>`, `agent-browser eval '<js>'`.
   It speaks accessibility-tree YAML like the MCP does, so the audit steps
   below translate 1:1 — just batch commands in single bash calls.
3. **Neither** → degrade gracefully: `WebFetch` the public pages, say so
   explicitly in the report's methodology section, and mark all UI claims
   `Reported` instead of `Confirmed`.

## Steps

1. **Get in.** If a free trial, freemium tier, or public demo/sandbox exists,
   use it. Never use real payment details. If the product requires payment
   or ID verification to see the app at all, stop here, note it as a hard
   wall in the report, and fall back to whatever is visible in the public
   docs, marketing screenshots, and demo videos instead.

2. **Map the navigation** with `browser_navigate` + `browser_snapshot`.
   Record every top-level section, and for each one:
   - What it's for, in one sentence
   - Key actions available (create, import, share, export, automate...)
   - Anything gated behind a higher plan (cross-reference the pricing page)

3. **Test at multiple viewports.** Ask for snapshots/screenshots at desktop
   (≈1440px) and mobile-web (≈375px) widths. Note whether the web app itself
   is responsive — this matters for the integration-architecture phase,
   since "no native mobile app" often means "the web app is the mobile
   experience," which is a real, reportable fact.

4. **Watch the network layer where the MCP tooling allows it.** Note the API
   domain(s) called (e.g. `api.product.com` vs the app domain) — this is a
   primary signal for Phase 4's shared-backend analysis, and for whether a
   public API exists at all (compare against any documented API docs URL
   from Phase 0).

5. **Capture screenshots of 3–6 representative screens** — enough to
   illustrate the product in the final report, not an exhaustive gallery.

6. **Cross-reference pricing.** Fetch the pricing page and map observed
   features to plan tiers. Flag any feature seen in-app that pricing copy
   doesn't mention, or vice versa — these mismatches are useful findings.

## What to record per feature

For each notable feature: name, one-line description, which plan tier it
requires (`Confirmed` if seen gated in-app, `Reported` if only pricing copy
says so), and a screenshot reference if captured.

## Exit criteria

You can list the web app's primary navigation, describe its core workflow
end-to-end, and know which API domain it talks to.
