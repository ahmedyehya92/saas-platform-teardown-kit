# 08 — Pricing, Revenue & Sources

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Pricing tiers

| Tier | Price | Billing | Headline features | Platform restrictions, if any |
|---|---|---|---|---|
| Oura Ring 5 (hardware) | $399 (Silver, Black); $499 (Gold, Deep Rose, Stealth, Brushed Silver) | one-time | red+IR LEDs (SpO2), green+IR LEDs (HR/HRV/respiration), digital temperature sensor, accelerometer; titanium; IP68 / 100 m; ~80 min charge | membership applies Gen3+ only; ring binds to one account |
| Oura Ring 4 (hardware) | per-finish prices not captured this run (page fetch truncated — flagged) | one-time | predecessor line; still sold | same membership rules |
| Membership | $5.99/mo or $69.99/yr (US). Localized: €5.99, £5.99, CA$7.99, A$9.99, ¥999, CHF 5.99; RoW $6.99/$79.00 | monthly / annual; first month free for new members | 50+ metrics; Oura Advisor (AI companion); Daily Scores; 24/7 vitals; cardiovascular age; resilience; women's health; glucose (with Stelo) | Gen3+ rings only; Gen2 users keep legacy app 4.0.0 with no membership needed |
| Free (cancel/no membership) | $0 | — | exactly three daily scores (Readiness, Sleep, Activity), ring battery, basic profile; CSV export of retained data via Membership Hub | all advanced insights locked |
| Enterprise (Oura for Organizations) | not published — "Contact us" | custom | rings + app + Enterprise Platform dashboard; Enterprise API; raw CSV/JSON export; role-based permissions | sales-gated only |

All prices Confirmed (vendor pages fetched 2026-09-07), except Ring 4
per-finish prices (fetch truncated — flagged) and Enterprise (gated).

## Notes on pricing

- **The hardware is the meter for the subscription.** The store sells
  memberships on the same pages as rings ("Become a member for $5.99…"
  appears on the Ring 4 product page), and the free tier is a 3-score
  ghost of the product — the retention-critical features (stress, heart
  health, cycle, Advisor) are all membership-side.
- **No pause option** — vendor-stated: "There is no option to 'pause' an
  Oura Membership."
- **Payment rails:** PayPal, Visa, Mastercard, Amex, Discover, HSA/FSA
  cards; UPI AutoPay in India. No real payment info was provided during
  this run.
- **Prepaid membership codes bind to the first account created** and
  cannot transfer — an anti-gifting constraint.
- **Regional price localization** (eight currency bands observed) with
  geo detection at the CDN edge (`countryCode`/`currencyCode` cookies).
- **HSA/FSA eligibility** is marketed on both consumer and B2B pages — a
  US-specific pricing channel (pre-tax dollars) that effectively
  discounts the ring+subscription bundle.
- **Enterprise has no public floor price** — the only plan with no
  self-serve tier.

## Revenue & business-scale estimates

Rules this section enforces: every figure shows its method and source;
estimates are labeled estimates; a lone unsourced number is worse than no
number. Oura is private — there is no regulator-filed revenue figure, so
every number below is an estimate or a company statement to press, and
the tags say which.

### Source-by-source estimates

| Source | Figure / range | What it actually measures | Inherent reliability | Tag |
|---|---|---|---|---|
| Company statements to press (TechCrunch, 2025-09-22, fetched) | ~$500M revenue 2024; >$1B expected 2025; >$1.5B forecast 2026 | company-claimed revenue trajectory | medium (company claim, not audited filing) | Reported (company-claimed) |
| Company statements to press (same) | 5.5M rings sold cumulative (2025-09); 2.5M (2024-06) | cumulative hardware units | medium-high (corroborated across press dates) | Reported |
| TechCrunch/Bloomberg | $875M+ Series E at ~$10.9–11B valuation (2025-09-22); ~$5B Series D (2024-12) | funding = fact; valuation = investor mark | high for round size; valuation is a point-in-time mark | Reported |
| Similarweb (profile via search snippets) | global rank ~5,430→7,478 (3-month trend to July 2026); company revenue band $500M–$1B | monthly web visits — a scale indicator, NOT revenue; revenue band is algorithmic | medium for traffic; low for the revenue band | Reported (algorithmic) |
| Apple iTunes API (fetched) | 292,573 iOS ratings, 4.86★ | iOS review volume (a floor for install scale, not installs) | high for the metric itself | Confirmed (Apple-published) |
| Google Play via snippets | 4.7★, 38.9K reviews | Android review volume | medium (snippet-graded; page fetch failed) | Reported |
| Sensor Tower / data.ai / Appfigures | not found — no Oura-specific app-revenue/download estimate surfaced this run | n/a | n/a | not found |
| Regulator filing | none — private company; confidential IPO filing reported by press | n/a | — | Reported (filing exists confidentially; contents not public) |
| Vendor marketing | "5+ Million members worldwide"; "86% of Oura Members see their health improve" (2026 survey) | self-reported member/engagement claims | low (marketing; "members" undefined) | Confirmed as vendor claim |

### Bottom-up estimate (math shown, assumptions stated)

Observed pricing (from the table above): membership $69.99/yr; rings
$399–499 (Ring 5), older generations cheaper; first month free.

- **Subscription bottom-up:** cumulative rings 5.5M. Assume 40–70% are
  active paying members (cumulative units include churned, inactive, and
  Gen2 rings that need no membership; free tier exists):
  5.5M × 40% × $70 = **$154M/yr** … 5.5M × 70% × $70 = **$269M/yr**.
  Even at an implausible 100% attach: $385M/yr.
- **Hardware bottom-up:** unit velocity — 2.5M → 5.5M rings between
  June 2024 and September 2025 ≈ 2.4M rings/yr run-rate. At a blended
  ASP of $350–450 (generations, finishes, discounts): 2.4M × $350 =
  **$840M/yr** … 2.4M × $450 = **$1.08B/yr** hardware alone.
- **Combined:** ~$1.0–1.35B/yr for 2025 — consistent with the company's
  ">$1B expected" claim to press, and showing the mix is **hardware-
  dominated** (subscription math tops out near $270M, a fraction of the
  total). The membership revenue is the margin layer; the ring is the
  revenue engine.
- **Label: estimate.** Shown as math with assumptions — not asserted as
  fact. The press figures are company claims; nothing here is
  regulator-filed.

## Sources

Flat, deduplicated list of every URL cited anywhere in this report:

Vendor (fetched this run unless noted):
- https://ouraring.com
- https://ouraring.com/membership
- https://ouraring.com/why-oura
- https://ouraring.com/integrations
- https://ouraring.com/careers
- https://ouraring.com/how-it-works
- https://ouraring.com/store/rings/oura-ring-5
- https://ouraring.com/store/rings/oura-ring-4
- https://ouraring.com/blog/oura-on-the-web/
- https://ouraring.com/blog/history-of-oura/
- https://organizations.ouraring.com/
- https://cloud.ouraring.com
- https://cloud.ouraring.com/docs
- https://cloud.ouraring.com/v2/docs
- https://status.ouraring.com
- https://support.ouraring.com
- https://support.ouraring.com/hc/en-us/categories/9709083519891
- https://support.ouraring.com/hc/en-us/categories/27782541623059
- https://support.ouraring.com/hc/en-us/articles/360058634153-Set-Up-the-Oura-App
- https://support.ouraring.com/hc/en-us/articles/4411128662291-Set-Up-an-Oura-Ring
- https://support.ouraring.com/hc/articles/4409086524819-Oura-Membership
- https://support.ouraring.com/hc/en-us/articles/10470796678035-Software-Updates-for-Android
- https://support.ouraring.com/hc/en-us/articles/360025586673-How-Oura-Protects-Your-Data
- https://job-boards.greenhouse.io/oura

Platform registries and public data:
- https://itunes.apple.com/search?term=oura&entity=software&limit=5&country=us
- https://itunes.apple.com/lookup?id=1043837948&country=us
- https://itunes.apple.com/us/rss/customerreviews/id=1043837948/sortBy=mostRecent/json
- https://apps.apple.com/us/app/oura/id1043837948
- https://play.google.com/store/apps/details?id=com.ouraring.oura (fetch failed; snippet-graded)
- https://fccid.io/2AD7V
- https://archive.org/wayback/available?url=ouraring.com
- https://github.com/ourahealth (0 public repos)
- https://n8n.io/integrations/oura/

Press and third-party:
- https://techcrunch.com/2025/09/22/oura-ring-maker-raising-875m-series-e-bringing-valuation-to-11b-report-says/
- https://www.similarweb.com/website/ouraring.com/
- https://en.wikipedia.org/wiki/Oura_Health
- https://beckystern.com/2022/04/17/oura-ring-teardown-gen-3-and-gen-2/
- https://www.ifixit.com/Teardown/Oura+Ring+2+Teardown/135207
- https://www.ifixit.com/Guide/Oura+Ring+3+-+Charger+Repair/179295
- https://www.techinsights.com/blog/oura-ring-gen-4-teardown
- https://github.com/hedgertronic/oura-ring (community Python client)
- https://github.com/Pinta365/oura_api (community TypeScript client)
- https://github.com/YuzeHao2023/MCP-oura (community MCP server)
- https://github.com/sam-roberts/oura-data-visualiser (community Grafana visualiser)
