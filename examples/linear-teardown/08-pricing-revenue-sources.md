# 08 — Pricing, Revenue & Sources

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Pricing tiers

From the official pricing page (fetched 2026-09-07). All prices are per user, billed yearly; monthly-billing prices are not shown on the page — Confirmed (page structure).

| Tier | Price | Billing | Headline features | Platform restrictions, if any |
|---|---|---|---|---|
| Free | $0 | — | Unlimited members, 2 teams, 250 issues, 10 MB uploads, Agent platform + Linear Agent included | none — all platforms available on Free |
| Basic | $10/user/mo | yearly | 5 teams, unlimited issues and uploads, admin roles | none |
| Business | $16/user/mo | yearly | Unlimited teams, private teams + guests, Triage Intelligence, Loops, Code Intelligence, Linear Insights, Linear Asks, Zendesk/Intercom integrations, dashboards, data-warehouse sync, Slack/email intake | none per tier; feature availability same across web/desktop/mobile |
| Enterprise | custom | annual only | All Business + SAML/SCIM, invoice/PO billing, granular admin controls, advanced org modeling, migration/onboarding support, priority support, HIPAA compliance, IP restrictions, audit log, uptime SLA | none |

**Add-ons (billed outside seats):**
- **Salesforce integration** — add-on, price not listed (contact sales) — Reported (pricing page shows no figure)
- **AI credits** — prepaid wallet via Stripe: workspace-level USD balance, $10 minimum top-up, credits expire 12 months after purchase; **Coding Sessions** bill $0.25 per 20-minute sandbox session plus model tokens at provider rates; **Loops** bill $0.07–$0.20 per run by model; opt-in (no funding → no access/charges); spend limits configurable — Confirmed ([docs/ai-credits](https://linear.app/docs/ai-credits), fetched 2026-09-07)

## Notes on pricing

- **Unlimited members on Free** is the acquisition wedge (contrast: per-seat competitors charge for viewers); the caps bite on teams (2), issues (250), and upload size (10 MB) instead — Reported (pricing copy)
- **Two-bill architecture:** seats (predictable) + AI credits (usage) — the agent product line is monetized per-run, not per-seat. The Aug 20, 2026 changelog entry advertises "lower, more transparent pricing" for AI credits — Reported
- **Enterprise is annual-only with SAML/SCIM** — the standard SSO paywall; SAML SSO button exists at signup but authenticating via it requires an Enterprise workspace
- No per-platform pricing differences: the same seat covers web/desktop/mobile (mobile is free to install on every tier)
- Hidden-tier check: nothing gated by platform (e.g., no "desktop is Pro-only"); gating is by feature, not by client

## Revenue & business-scale estimates

Rules enforced here: every figure shows its method and source; estimates are labeled estimates; sources are never merged into one number. Linear files with no regulator — **nothing below is a filed figure**.

### Source-by-source estimates

| Source | Figure / range | What it actually measures | Inherent reliability | Tag |
|---|---|---|---|---|
| Company growth post (primary, 2026) | "passed $100 million in annual recurring revenue" earlier in 2026 | company-stated ARR | medium-high (company-stated, unaudited) | Confirmed (company-stated) — [linear.app/now/sharing-growth-with-the-people-building-linear](https://linear.app/now/sharing-growth-with-the-people-building-linear) |
| Company growth post | "More than 40,000 companies now pay for Linear" | paying-customer count (companies, not seats) | medium (company-stated) | Confirmed (company-stated) |
| Company growth post | 177% net revenue retention | expansion-net retention | medium (company-stated) | Confirmed (company-stated) |
| Company growth post | $99M tender at $2.5B valuation (2026); prior $1.25B Series C "last year" | market-clearing price for secondary equity; funding-stage signal | high for the round facts, medium for what they imply about revenue | Confirmed (company-stated) |
| Forbes (Sep 14, 2023) | $35M Series B led by Accel at ~$400M valuation; profitable; <50 employees | round facts + profitability claim | high for round facts | Reported — [forbes.com](https://www.forbes.com/sites/alexkonrad/2023/09/14/linear-developer-tools-raises-35-million-series-b/) |
| TechCrunch (2025, via coverage) | $82M Series C led by Accel at $1.25B valuation | round facts | high for round facts | Reported |
| TechCrunch (2020) | $13M Series A led by Sequoia | round fact | high | Reported |
| Getlatka (third-party estimator) | "$100M ARR (2026), up from $8.4M (2023)"; "$2.5B valuation"; "total funding $234.2M across 5 rounds" | algorithmic estimate + scraped valuation | **low** — its $234.2M total-funding figure conflicts with the round-by-round press sum (≈$135M); kept separate and flagged | Reported (algorithmic, conflicting) — [getlatka.com/companies/linear.app](https://getlatka.com/companies/linear.app) |
| Similarweb (July 2026, fetched 2026-09-07) | 9.4M visits / 3 months; +9.35% MoM; 7:26 avg duration; 6.47 pages/visit; 31.98% bounce; 79.1% direct; global rank #5,797; US #3,442; top countries US 35.49%, India 8.82%, UK 5.15% | web traffic — **a scale indicator, NOT revenue** | medium for traffic | Reported — [similarweb.com/website/linear.app](https://www.similarweb.com/website/linear.app/) |
| Google Play listing | 100K+ installs (Android) | store-stated install floor | high for the floor it states | Confirmed (store-stated) |
| iOS App Store | 4.8★, 2.1K ratings | rating volume — weak scale proxy | medium | Confirmed (store-stated) |
| Sensor Tower / data.ai / Appfigures | not found — no public app-revenue estimates surfaced for Linear's apps in this run | — | — | not found (searched 2026-09-07) |
| Regulator filing | none — Linear Orbit, Inc. is private; no 10-K/20-F/990 exists | — | — | Confirmed (absence, searched 2026-09-07) |

### Bottom-up estimate (math shown, assumptions stated)

- **Inputs (labeled):** company-stated 40,000+ paying companies; pricing tiers $10 (Basic) and $16 (Business) per user/month billed yearly; Enterprise custom.
- **Assumption A (seat count unknown — this is the weak link):** paying teams are engineering teams; assume 5–20 seats per company, median ~10.
- **Range math:**
  - Floor: if most customers sit on Basic: 40,000 × 10 seats × $10 × 12 = **$48M ARR**
  - Mid: mix of Basic/Business at ~12 seats avg: 40,000 × 12 × $13 × 12 ≈ **$75M ARR**
  - Ceiling: heavy Business mix at 20 seats: 40,000 × 20 × $16 × 12 = **$154M ARR**
- **Cross-check:** the company's own "$100M ARR" claim sits inside this $48M–$154M band, which is consistent rather than contradictory. The company-stated figure is the better number to quote; this range exists only to show the claim is arithmetically plausible given the stated customer count and pricing.
- Plus AI-credits usage revenue (unquantifiable from public data — wallet-based, opt-in).
- **Label: estimate.** Math with stated assumptions — not asserted as fact. The company-stated $100M ARR (Confirmed, company-stated) remains the headline number.

**Funding-as-stage read (per integrity rule, revenue-multiple framing only):** $2.5B latest valuation ÷ $100M company-stated ARR ≈ 25× — a stage signal, not a figure; the multiple assumes the company-stated ARR is accurate and comparable.

## Sources

Flat, deduplicated list of every URL cited anywhere in this report:

- https://linear.app/
- https://linear.app/pricing
- https://linear.app/signup
- https://linear.app/login
- https://linear.app/changelog
- https://linear.app/integrations
- https://linear.app/developers
- https://linear.app/docs
- https://linear.app/docs/ai-credits
- https://linear.app/docs/how-to-use-linear-small-teams
- https://linear.app/mobile
- https://linear.app/download
- https://linear.app/agents
- https://linear.app/asks
- https://linear.app/coding-sessions
- https://linear.app/customers
- https://linear.app/method
- https://linear.app/careers
- https://linear.app/careers/cd5ae036-0223-427a-b038-ba16ef9dcb32
- https://linear.app/now
- https://linear.app/now/sharing-growth-with-the-people-building-linear
- https://linearstatus.com
- https://releases.linear.app/mac
- https://releases.linear.app/windows
- https://apps.apple.com/us/app/linear-mobile/id1645587184
- https://play.google.com/store/apps/details?id=app.linear
- https://github.com/linear
- https://github.com/linear/linear/tree/master/packages/sdk
- https://zapier.com/apps/linear/integrations
- https://www.similarweb.com/website/linear.app/
- https://www.forbes.com/sites/alexkonrad/2023/09/14/linear-developer-tools-raises-35-million-series-b/
- https://techcrunch.com (Series A 2020 and Series C 2025 coverage; exact article URLs surfaced via search/social references)
- https://www.linkedin.com/in/karrisaarinen
- https://getlatka.com/companies/linear.app
- http://web.archive.org/cdx/search/cdx?url=linear.app (earliest capture 2019-04-18)
- https://linear.app/developers/webhooks
- https://linear.app/developers/oauth-2-0-authentication
- https://linear.app/developers/rate-limiting
- https://linear.app/join-slack (community; linked from in-app onboarding)
