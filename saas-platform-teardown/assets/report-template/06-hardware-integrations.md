# 06 — Hardware Integrations

> Researched: <date>

## Finding

Either, explicitly:

**No hardware integration found.** Checked: marketing nav/footer/copy,
pricing-page SKUs, docs nav, jobs page (embedded/firmware roles), mobile
store permissions (no Bluetooth/NFC/USB).

— the checked locations are listed because an explicit "none" is a finding.

Or, per device family:

## <Device family — e.g. "Card reader">

| Aspect | Finding | Tag |
|---|---|---|
| Connection protocol | BLE / BT Classic / USB / NFC / Wi-Fi direct / proprietary dongle | |
| Setup / pairing flow | <initiating screen, QR vs button-hold vs serial entry, account binding> | |
| Pairs from web | Yes / No / No evidence found | |
| Pairs from desktop | Yes / No / No evidence found | |
| Pairs from iOS | Yes / No / No evidence found | |
| Pairs from Android | Yes / No / No evidence found | |
| SDK / firmware update mechanism | <OTA via which app? versioned? release-noted?> | |
| Certified / partner hardware list | <URL + entry count> or none found | |
| Actual manufacturer | <FCC grantee name, other filings, teardown coverage> | |

**Why this hardware exists (business logic):** unlocks a
software-impossible workflow / lock-in / hardware revenue line / data
quality — vendor-stated (cite) or Inferred (reasoning shown). Links into
07's business-objective map.

**Platform pairing gaps flagged:** e.g. "mobile-only pairing while web is
the admin surface — deliberate field-workforce scoping — Inferred"

*(repeat the block above per device family)*
