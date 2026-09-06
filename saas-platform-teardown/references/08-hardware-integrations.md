# Conditional — Hardware Integrations

Load this playbook ONLY when Phase 0's hardware check (or a later phase —
e.g. Phase 2 finding Bluetooth/NFC/USB permissions in a store listing)
found a physical-device touchpoint. If the check found none, this file
stays unread and the report carries the explicit finding instead: "No
hardware integration found (checked: marketing nav/footer/copy, pricing
SKUs, docs nav, jobs page; store permissions showed no Bluetooth/NFC/
USB)." Zero cost for hardware-less products is the design goal.

Goal: document every way the product touches physical hardware —
connection protocols, pairing flows, which platforms can pair (a common
blind spot: pairing is mobile-only), firmware/SDK update paths,
certified-hardware programs, and who actually manufactures the hardware —
plus the business rationale for hardware existing at all.

## Steps

1. **Enumerate the touchpoints.** Sources: marketing product pages for
   devices, hardware SKUs or bundles on the pricing page, docs-nav
   hardware/setup sections, store-listing permissions (BLE, Bluetooth
   Classic, NFC, USB accessory), the integrations marketplace's hardware
   category if one exists, and jobs-page embedded/firmware roles. Name
   each touchpoint as a device family ("card reader", "barcode scanner",
   "temperature sensor", "receipt printer") — the report is organized per
   family.

2. **Per device family, document each of these — every one is a template
   row, so a gap in the row is itself a finding:**
   - **Connection protocol** — BLE, Bluetooth Classic, USB, NFC, Wi-Fi
     direct, Ethernet, proprietary dongle. Help-center setup articles
     almost always state this explicitly; store permissions corroborate
     (Android `BLUETOOTH_SCAN`/`BLUETOOTH_CONNECT`, iOS
     `NSBluetoothAlwaysUsageDescription`, NFC reader session entitlements).
   - **Setup / pairing flow** — which screen initiates pairing, QR-code vs
     button-hold vs serial-number entry, whether the device binds to an
     account or a workspace. Reconstruct from help-center articles and
     demo videos per the ladder (`references/02-web-platform-audit.md`) —
     same rungs, same evidence grades.
   - **Platform pairing matrix — the common gap.** Which of web / desktop
     / iOS / Android can pair with AND use the device. Pairing is
     frequently mobile-only: BLE from desktop is uncommon, and Web
     Bluetooth is Chromium-only and often absent — check before assuming.
     Record the matrix and flag every empty cell; "mobile-only pairing
     while web is the admin surface" is a deliberate scope decision, i.e.
     business logic for Phase 4's objective map.
   - **SDK / firmware update mechanism** — OTA via which app? Desktop-side
     updater? Are firmware versions release-noted anywhere? Changelog
     entries mentioning firmware updates, and their cadence, signal how
     alive the hardware line actually is.
   - **Official partner / certified-hardware list** — URL and entry count.
     A certified list implies a partner program (ecosystem moat, maybe a
     revenue line); its absence means either first-party hardware or
     generic "works with any X" support — distinguish which.

3. **Identify the actual manufacturer.** Branded hardware is usually
   contract-manufactured, and the public filing trail says by whom:
   - **FCC ID lookup (public record).** The FCC ID sits on the device
     label — product photos usually show it — and fccid.io / the FCC's
     equipment-authorization database expose the *grantee*, whose name is
     often the real OEM rather than the brand on the box. Radio-module
     approvals in the same filing reveal the chipset family.
   - **Other certification trails:** CE / UL listings, Bluetooth SIG
     QDID/PID listings (they name the stack vendor), Wi-Fi Alliance
     certification.
   - **Teardown coverage** — iFixit and similar, where it exists.
   - **Import records (optional signal)** — public US customs manifest
     databases (e.g. ImportYeti) name the shipping manufacturer.
   Tag each identification `Reported` (the filing/grantee is named) or
   `Inferred` ("grantee matches a known POS OEM — likely contract
   manufacture"), never stronger than the evidence.

4. **Business rationale per device family** — feeds Phase 4's
   business-objective map. Does the hardware exist to (a) unlock a
   workflow impossible in pure software (payments, physical capture,
   sensing), (b) create lock-in / switching costs, (c) add a hardware
   revenue line (check the pricing page's SKUs and their pricing), or
   (d) raise data quality or capture latency? Cite the vendor's stated
   rationale where one exists; otherwise infer with the reasoning shown,
   under the same rules as Phase 4's "why" layer.

## Constraints

Filing databases and certified-hardware lists are public record — use them
freely. Do not purchase hardware, dump or reverse-engineer firmware, or
attempt any DRM/protection bypass. This playbook never requires an account
or a device in hand; it runs entirely on public documentation, filings,
and imagery.

## Exit criteria

Every device family has: protocol, pairing flow, platform pairing matrix
(with gaps flagged), firmware/update path, certified-list status,
manufacturer evidence, and a business-rationale line — OR the report
carries the explicit no-hardware finding listing every location checked.
