# 07 — Integration Architecture

> Researched: <date>

## Cross-platform summary

| Platform | Auth model | Data source / API domain | Sync behavior | Notification path |
|---|---|---|---|---|
| Web | | | | |
| Mobile | | | | |
| Desktop | | | | |

Each cell tagged Confirmed / Reported / Inferred.

## Integration business-objective map

Every integration point paired with the PM-level "why" — the column a
decision-maker actually reads. Confirmed = vendor states it (cite the
source); Inferred = deduced, with the reasoning shown.

| Integration point | Technical evidence | Business objective it serves | Tag & reasoning |
|---|---|---|---|
| e.g. Mobile push notifications | FCM permission; "abandoned cart" email schedule in docs | Recover flows started on web | Inferred (push timing matches cart-abandonment windows) |
| e.g. Desktop menu-bar app | tray + global hotkey present; no offline mode | Cut time-to-capture on the core loop → retention | Inferred (…) |
| e.g. Shared auth | same session cookie domain web+desktop | One account, no re-login friction across platforms | Confirmed (docs: <url>) |

## Narrative

2–4 paragraphs: how the platforms actually relate. Is there one primary
platform and companions, or genuine multi-platform parity? Same backend or
separate services? Real-time sync or periodic? Where does the evidence come
from (network domains, status-page incident history, app permissions, docs)?

## Public API & integration ecosystem

- Public API: yes/no, docs URL, auth method
- Webhooks: yes/no
- Official integrations marketplace: count, notable examples
- Zapier / Make / n8n listings: yes/no, links

## Notable mismatches between marketing claims and observed reality

Bullet list, each with the marketing claim and the counter-evidence.
