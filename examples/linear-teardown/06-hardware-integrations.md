# 06 — Hardware Integrations

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Finding

**No hardware integration found.** Linear ships no physical devices and pairs with none.

Checked (because an explicit "none" is a finding, not a missing section):

- **Marketing site (2026-09-07):** homepage, /pricing, /mobile, /download, /agents, /coding-sessions, /asks, /customers, /method — zero mentions of any device family (no reader, terminal, scanner, printer, wearable, sensor, kiosk, dongle, or beacon vocabulary anywhere in nav, footer, or copy)
- **Pricing-page SKUs:** four software tiers + a Salesforce integration add-on + AI credits — no hardware add-on, no device bundle
- **Docs nav:** 17 sections (Getting started → Importers) — no hardware/pairing section; `linear.app/docs/desktop` is a 404 and no `docs/hardware`-class page surfaced
- **Jobs page:** "30 open roles" cited on the company growth post are engineering/design/GTM roles — no embedded/firmware/hardware roles surfaced
- **Mobile store permission summaries (pass 2 of the two-pass check):** neither the iOS listing nor the Google Play listing surfaces Bluetooth, NFC, or USB-accessory permissions — the standard tell for hardware pairing is absent on both stores
- **FCC filings:** not searched — no plausible hardware product exists to search for (per playbook, sweep 13 is conditional on Phase 0 finding hardware)

## Per-platform pairing matrix

| Platform | Hardware pairing | Basis |
|---|---|---|
| Web | Not applicable — no hardware product exists | Checked 2026-09-07 (see above) — Confirmed (absence) |
| macOS desktop | Not applicable | Same — Confirmed (absence) |
| Windows desktop | Not applicable | Same — Confirmed (absence) |
| iOS | Not applicable (no BLE/NFC/USB permissions surfaced) | Store listing review — Confirmed (absence) |
| Android | Not applicable (same) | Store listing review — Confirmed (absence) |

## Closest physical-world touchpoints (not hardware)

For completeness — the only "physical" interactions in the product are OS-level, not proprietary-device integrations:

- Screenshot/photo capture from the phone's share sheet into issue/bug-report creation (vendor copy on [linear.app/mobile](https://linear.app/mobile)) — Reported (vendor wording)
- File attachments up to tier-dependent size caps (10 MB on Free per pricing page) — Reported (pricing copy)

**Why no hardware (business logic):** Linear's strategy is agent-leverage over physical leverage — the 2026 roadmap (coding sessions, Loops, agent platform, MCP for AI clients) extends the product into machines that already exist (the customer's dev environment) rather than into devices the vendor would manufacture. Company-stated framing: agents installed across "95% of paid Linear workspaces" ([growth post](https://linear.app/now/sharing-growth-with-the-people-building-linear)) — Confirmed (company-stated). No hardware revenue line, no lock-in via devices, no pairing matrix to maintain.
