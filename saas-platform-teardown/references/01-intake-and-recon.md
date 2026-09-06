# Phase 0 — Intake & Recon

Goal: turn one URL into a dossier of every platform surface the product has,
so later phases know exactly what to go audit instead of guessing.

## Steps

1. **Fetch the landing page** with `web_fetch`. Extract:
   - Product name, one-line positioning, target customer
   - Nav/footer links: Pricing, Docs, Changelog/Release notes, Status page,
     Blog, Careers (job descriptions leak tech stack), Integrations/App
     marketplace, "Download" or "Get the app", API/Developer docs, Security
     page, Community/Forum
   - Any explicit platform badges ("Available on the App Store", "Get it on
     Google Play", "Download for Mac/Windows/Linux")

2. **Resolve every platform surface to a concrete URL:**
   - Web app login/signup URL (often different subdomain, e.g. `app.` or `my.`)
   - iOS App Store listing URL
   - Google Play listing URL
   - Desktop installer download links, per OS
   - Public API/developer docs URL
   - Public GitHub org/repos, if any
   - Status page (often `status.<domain>` or a statuspage.io/instatus URL —
     useful later for inferring backend architecture from incident history)

   If a link isn't in the footer, search for it: `"<product name>" app store`,
   `"<product name>" download mac`, `"<product name>" api docs`, etc. Use
   `agy` for this per the search playbook — it's faster to fan these out in
   parallel than to do them one `web_search` call at a time.

3. **Run a tech-stack fingerprint** on both the marketing domain and the app
   subdomain if one exists (they're often different stacks — e.g. a
   marketing site on Webflow/Next.js in front of an app on a completely
   different framework). Use whatever current Wappalyzer-class tool is
   available (CLI, MCP, or a manual look at response headers / script tags
   via `web_fetch` if no tool is installed). Note the two stacks separately.

4. **Establish company-level facts** via `agy` or `web_search`: founding
   year, funding/ownership if public, headcount signal (LinkedIn), and
   category peers — this grounds the "who is this for" framing later and
   costs almost nothing to gather now.

5. **Create the workspace** `./<product-slug>-teardown/` and **write the
   recon dossier** — a short scratch file (not part of the final
   report) at `./<product-slug>-teardown/recon-dossier.md` listing every URL
   and fact found above, each tagged with where it came from. Every later
   phase reads from this instead of re-deriving it.

## Exit criteria

Move to Phase 1 once you can answer: does this product have a web app
(virtually always yes), does it have native mobile apps (yes/no/unclear),
does it have a native desktop app (yes/no/unclear), and do you have a URL
for each surface that does exist. "Unclear" is fine to carry forward — Phases
2 and 3 exist partly to resolve it.
