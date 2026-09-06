# Setup

## MCP servers (user scope — the only scope that works everywhere)

Required:
- **Playwright MCP** — live browser control via accessibility snapshots (no
  vision model needed). Used for the web-platform audit.
  ```bash
  claude mcp add playwright -s user -- npx @playwright/mcp@latest
  claude mcp list | grep playwright   # must show: ✔ Connected
  ```
  GOTCHA (cost us a broken first run): dropping a server into
  `~/.claude/.mcp.json` does NOT register it — that file is only read when
  the session's working directory IS `~/.claude`. User scope lives inside
  `~/.claude.json` and is managed by `claude mcp add -s user`. Also note
  MCP servers load at session START — a server added mid-session won't
  appear until the next one.

Browser fallback (strongly recommended): **`agent-browser` CLI** —
`npm install -g agent-browser`. The skill falls back to it automatically
when the MCP server isn't present. If `command -v agent-browser` fails
while `npm ls -g` shows it installed, the nvm-bin symlink dangles — fix
with `ln -sf ../lib/node_modules/agent-browser/bin/agent-browser.js
"$(npm prefix -g)/bin/agent-browser"`.

Strongly recommended:
- **GitHub MCP** (or the `gh` CLI directly, see below) — for products whose
  desktop shell, SDKs, or changelogs live in a public repo.
- **Fetch MCP** — only needed if your Claude Code build doesn't already have
  `web_fetch`/`web_search` built in.

## agy permissions (headless research mode — REQUIRED, not optional)

Research prompts make `agy` call its own `search_web` / `read_url` tools,
and headless mode auto-DENIES any tool it can't prompt for — the run then
finishes with `status: SUCCESS` and an EMPTY response (sneaky failure).

Fix (surgical, already applied on this machine): add to
`~/.gemini/antigravity-cli/settings.json` →

```json
"permissions": { "allow": ["search_web", "read_url(*)", "read_url_content(*)", "read_resource(*)"] }
```

GOTCHA: the permission name is `read_url` — the tool is named
`read_url_content`; the error message quotes the name to allow. Blanket
fallback on any machine: append `--dangerously-skip-permissions` to the
agy invocation (auto-approves ALL its tools — see the playbook's caution).

## CLIs (must be on `$PATH`)

| CLI | Purpose | Install |
|---|---|---|
| `agy` (Antigravity CLI) | Gemini-grounded web research, run headless and in parallel from bash | `curl -fsSL https://antigravity.google/cli/install.sh \| bash` |
| `gh` (GitHub CLI) | Release notes, changelogs, open-source desktop shells, org repos | `https://cli.github.com` |
| `curl` | HEAD requests against download links, update manifests, API probing | usually preinstalled |
| `jq` | Parsing `agy --output-format stream-json` output and any JSON API responses | package manager |
| A Wappalyzer-class tech detector (CLI or MCP) | Tech-stack fingerprinting of the marketing site and app subdomain | any current OSS "Wappalyzer alternative" CLI/MCP — check `npx` registry or `pip` at run time, since exact package names churn; do not assume a specific one is still current |
| `appstore-review-cli` (or equivalent) | Structured App Store / Google Play listing + review data without needing developer accounts | check current OSS options — this space moves fast, confirm the tool is still maintained before relying on it |

No additional CLIs are needed for the decision-grade methodology: revenue
estimator / FCC-filing / Wayback / traffic-proxy lookups all run through
`agy` or the built-in web search/fetch tools, and desktop installer sizes
come from `curl -sI` HEAD requests (curl is already listed above). Mobile
release data deliberately stops at store-listing metadata — the kit never
extracts APK/IPA binaries, so no extraction tooling is wanted.

## Verify before running the skill

```bash
agy --version
gh --version
jq --version
# full end-to-end agy check (verified pattern on agy 1.1.23 — note:
# no --non-interactive flag; gemini-3.8-flash requires --effort):
mkdir -p .agy-out && agy -p "Reply with the single word: pong" \
  --output-format stream-json --model gemini-3.8-flash --effort medium \
  > .agy-out/ping.jsonl
jq -r 'select(.event=="result") | .result.status' .agy-out/ping.jsonl  # SUCCESS
```

If `agy` is unavailable, the skill falls back to the built-in `web_search`/
`web_fetch` tools — slower and less parallel, but the pipeline still works.
If Playwright MCP is unavailable, the web-platform audit degrades to
static `web_fetch` inspection of public pages only (no live app exploration,
no authenticated-state screens).
