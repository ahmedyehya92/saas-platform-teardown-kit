# Phase 0 — Intake & Recon

Goal: turn one URL into a dossier of every platform surface the product has,
plus the two triage calls every later phase depends on — how each surface
will be accessed (live trial vs. the no-credential ladder) and whether the
product touches physical hardware — so later phases know exactly what to
audit instead of guessing.

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

3. **Build the complete link inventory — this is the web platform's release
   artifact, not busywork.** A web app "ships" URLs, so the durable record
   of it is an organized inventory with exact URLs, never descriptions of
   where something lives: marketing site, web app/login, signup, pricing,
   docs, API reference, status page, blog, changelog/release-notes page
   (web apps usually have one even without installers), community/forum,
   and public GitHub org/repos. Verify each URL by fetching it — a footer
   link that 404s is itself a finding. Record the inventory in the recon
   dossier; template `01-overview-and-recon.md` mirrors it in the report.

4. **Triage access for every surface (the gating check).** For each surface,
   decide how its audit will get in, and write the per-surface access plan
   into the dossier:
   - **Self-serve free trial / freemium / sandbox → plan to USE IT** with a
     disposable identity. A product with a self-serve tier is not "gated" —
     this is in scope, preferred, and beats every secondhand source. Note
     what signup demands: email-only is fine; card-upfront or ID
     verification is a wall you do not cross (see SKILL.md operating rules).
   - **Demo-on-request / contact-sales-only → flag the surface for the
     no-credential ladder** (canonical version in
     `references/02-web-platform-audit.md`). While you're here, note which
     ladder rungs look promising for THIS vendor: do they run a public help
     center? A YouTube channel? A public changelog? Conference talks?
   - **Public API docs with an open sandbox or spec → usable for
     feature-scope mapping** even without app access.

   Never misrepresent yourself to sales to obtain an enterprise demo — the
   ladder exists precisely so you don't need to.

5. **Hardware touchpoint quick-check — binary outcome, recorded either
   way.** Scan for physical-device touchpoints: device words in marketing
   nav/footer/page copy (terminal, reader, scanner, printer, wearable,
   sensor, kiosk, dongle, beacon, camera, "works with <device>"), hardware
   SKUs or bundles on the pricing page, hardware/setup sections in the docs
   nav, and embedded/firmware roles on the jobs page. Then:
   - **Any hit** → list the touchpoints in the dossier and load
     `references/08-hardware-integrations.md` alongside the platform audits
     (mobile usually owns pairing, but check web and desktop too).
   - **No hit** → record the explicit finding "No hardware integration
     found (checked: marketing nav/footer/copy, pricing SKUs, docs nav,
     jobs page)". Phase 2's store-listing permissions (Bluetooth/NFC/USB)
     act as the second check. Absence is a reportable finding, never a
     skipped check.

6. **Run a tech-stack fingerprint** on both the marketing domain and the app
   subdomain if one exists (they're often different stacks — e.g. a
   marketing site on Webflow/Next.js in front of an app on a completely
   different framework). Use whatever current Wappalyzer-class tool is
   available (CLI, MCP, or a manual look at response headers / script tags
   via `web_fetch` if no tool is installed). Note the two stacks separately.

7. **Establish company-level facts** via `agy` or `web_search`: founding
   year, ownership, funding rounds with amounts/dates/lead investors (press
   coverage, not just a database page), headcount signal (LinkedIn), and
   category peers — this grounds the "who is this for" framing later and
   costs almost nothing to gather now. **Also dispatch the revenue /
   business-scale sweeps from the search playbook right now** (revenue
   estimators, app-traction estimates, traffic proxy, public-filings check,
   customer-count claims) so the numbers — each with source and method —
   are back by report time instead of being improvised at the end.

8. **Create the workspace** `./<product-slug>-teardown/` and **write the
   recon dossier** — a short scratch file (not part of the final report) at
   `./<product-slug>-teardown/recon-dossier.md` listing every URL and fact
   found above, each tagged with where it came from, PLUS the per-surface
   access plan (step 4) and the hardware-check outcome (step 5). Every later
   phase reads from this instead of re-deriving it.

## Exit criteria

Move to Phase 1 once you can answer: does this product have a web app
(virtually always yes), does it have native mobile apps (yes/no/unclear),
does it have a native desktop app (yes/no/unclear), do you have a URL for
each surface that does exist, how will each surface be accessed (trial /
ladder / hard wall), and does it touch hardware (yes + touchpoints, or
no (+ where you checked). "Unclear" is fine to carry forward — Phases 2 and 3
exist partly to resolve it.
