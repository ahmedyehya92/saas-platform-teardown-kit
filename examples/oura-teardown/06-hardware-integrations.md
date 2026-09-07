# 06 — Hardware Integrations

> Researched: 2026-09-07. Sources current as of this date; SaaS products
> change frequently — verify anything decision-critical before acting on it.

## Finding

**Hardware IS the product.** Oura is a hardware-first SaaS: two device
families (ring + charger), a mobile-only pairing path, a public FCC
filing trail from 2015 to 2026, and third-party teardown coverage for
every generation. This file is the kit's hardware-path showcase.

## Device family 1 — Oura Ring (smart ring; Gen2 / Gen3 / Ring 4 / Ring 5)

| Aspect | Finding | Tag |
|---|---|---|
| Connection protocol | Bluetooth Low Energy; "Bluetooth 5.0" required device-side. FCC filing descriptions explicitly name BLE for the 2015 and 2018 rings ("OURA Wellness ring with Bluetooth Low Energy") | Confirmed (help docs + FCC filing text) |
| Setup / pairing flow | App-only, mobile-only: download app → unbox ring + charger → plug charger into USB power → ring on charger, LED blinks blue when ready → phone Bluetooth on → in-app account setup pairs the ring. Binds to exactly ONE Oura account; factory reset required to rebind (gift/resale requires reset; warranty-replaced rings may arrive disabled). No QR, no serial-entry, no desktop pairing path in any vendor doc | Confirmed (help articles, fetched) |
| Pairs from web | No — no pairing capability in "Oura on the Web"; web blog claims analysis only | Inferred (absence across all vendor material + app-mandatory setup docs; reasoning shown in 02) |
| Pairs from desktop | No — no desktop client exists (04) | Confirmed (absence verified via searches/careers/status) |
| Pairs from iOS | Yes — iOS 16+, Bluetooth 5.0 | Confirmed (help docs) |
| Pairs from Android | Yes — Android 11 + Google Play services, Bluetooth 5.0. Gen2 ring support ended: last app 4.0.0 (2021-11-15) | Confirmed (help docs + vendor changelog) |
| SDK / firmware update mechanism | OTA firmware updates delivered through the mobile app; no public firmware changelog found this run (flagged). Ring firmware update referenced in replacement-ring help flow. Review reports of update hangs corroborate in-app OTA | Reported (vendor docs + reviews; no firmware release notes found) |
| Certified / partner hardware list | None found — first-party device; no certified-accessory program surfaced | Confirmed (absence in fetched surfaces) |
| Actual manufacturer | FCC grantee: **Oura Health Oy**, Oulu, Finland (grantee code 2AD7V; registered 2015-02-05) — the grantee is the brand itself, not a disclosed OEM. Radio details in filings; third-party teardowns show the internal stack: Grepow 3.7V 16 mAh Li battery + TI BQ25120A battery-management IC (Gen 2); 2x green LEDs + 2x photodiodes + red/IR multi-chip LED sensor arrays; destructive cut-open required even for Gen 3 (resin-encased). Ring 5 adds red+IR LEDs (SpO2), green+IR LEDs (HR/HRV/respiration), a digital temperature sensor, accelerometer; titanium, IP68, 100 m | Confirmed (FCC grantee page, fetched); Reported (teardowns: Becky Stern Gen2/Gen3; TechInsights Ring 4; iFixit Ring 5 via community report) |
| Ring pricing | Ring 5: $399 (Silver, Black) / $499 (Gold, Deep Rose, Stealth, Brushed Silver). Ring 4: page live; per-finish prices not captured this run (fetch truncated — flagged) | Confirmed (store page fetch) |
| Form specs (Ring 4 page) | weight 3.3–5.2 g depending on size | Confirmed (store page fetch) |
| Battery / charging | Ring 5: multi-day battery — store copy shows a "6–9" range and "~80" charge figure; the store page fetch was truncated, so the units (days / minutes) are interpretation, not a verbatim capture | Reported (vendor numbers, truncated fetch — flagged) |

### FCC filing trail (all "Original Equipment" applications)

| FCC ID | Grant date | Description |
|---|---|---|
| 2AD7V-OURARING15001 | 2015-12-16 | OURA ring — Wellness ring with BLE |
| 2AD7V-OURA1801 | 2018-05-18 | OURA Wellness ring with BLE |
| 2AD7V-OURA2101 | 2022-04-19 | Wellness ring (Gen 3 era) |
| 2AD7V-OURA2402 | 2024-07-25 | Charger for Wellness Ring |
| 2AD7V-OURA2401 | 2025-09-18 | Wellness ring |
| 2AD7V-OURA2501 | 2025-11-19 | Charger for Wellness Ring |
| 2AD7V-OURA2601 | 2026-03-19 | "Wellness ring and app designed to help user gets more restful sleep and performs better" |
| 2AD7V-OURA2602 | 2026-04-08 | Charger — "Inductive charging using WTP" |
| 2AD7V-OURA2603 | 2026-05-12 | Charger for Wellness Ring |

Read: an unbroken annual filing cadence from 2015 through 2026, with a
dense 2025–2026 cluster (two rings + three chargers) consistent with the
Ring 5 generation launch the store currently sells. Claim-hygiene note:
an initial FCC grantee-code guess (2ABM7) was wrong and corrected to
2AD7V by the fetched record.

## Device family 2 — Ring charger

| Aspect | Finding | Tag |
|---|---|---|
| Connection protocol | Inductive wireless charging ("WTP" — wireless power transfer per 2026 FCC description); charger side is USB power (laptop/power brick per help docs). No documented data path over USB | Confirmed (FCC text + help docs) |
| Setup / pairing flow | None — dumb power device; the ring must sit on it for charging AND for pairing readiness (LED blink) | Confirmed (help docs) |
| Pairs from web/desktop/iOS/Android | n/a — no pairing; only the ring pairs | — |
| Firmware update mechanism | None documented | — |
| Certified / partner list | None found; chargers are first-party, per-generation (three charger filings 2024–2026) | Confirmed (absence + FCC trail) |
| Actual manufacturer | Same grantee (Oura Health Oy filings) | Confirmed (FCC) |
| Purchase | Sold with ring / as accessory on the store | Confirmed (store nav) |

**Why this hardware exists (business logic):**
1. **Sensing impossible in pure software** — the finger's arteries give a vendor-claimed "50-100x stronger pulse signal" than the wrist; the ring is the measurement instrument (vendor-stated, organizations page).
2. **Lock-in + switching costs** — a $399–499 titanium ring encased so teardown reviewers call it effectively unrepairable with a non-replaceable battery (iFixit Ring 5 teardown via community report — Reported), bound to one account, with features gated behind Gen3+.
3. **Recurring revenue line** — hardware is the meter for a $5.99/mo membership that most insights sit behind (08).
4. **Data-quality/retention flywheel** — 24/7 wear produces the longitudinal baselines (weeks to 30–60 days) that make leaving costly (vendor-documented feature gates).

**Platform pairing gaps flagged:** pairing is mobile-only while web is the
analysis/admin surface — a deliberate scope decision (BLE from browsers is
unreliable and the phone is the always-carried gateway), consistent with
the vendor's stated data-quality positioning — Inferred (reasoning: every
documented setup path is app-only; web claims no sync capability).

**Repairability note:** iFixit maintains an Oura Ring 2 teardown and a
Ring 3 charger repair guide; a Ring 5 teardown is reported (community)
as cut-apart-only with a sealed battery. The Ring 4 teardown of record is
TechInsights' professional teardown with cost analysis. No iFixit Ring 4
teardown was found.
