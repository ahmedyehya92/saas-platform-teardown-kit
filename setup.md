# Setup

The kit works with zero installs beyond Claude Code itself. Each tier adds
capability; nothing is required to start, and every tier degrades
gracefully when missing.

## Tier 0 — zero-install (the default)

Copy the skill into your skills directory and restart Claude Code:

```bash
# global (any project)
cp -r saas-platform-teardown ~/.claude/skills/saas-platform-teardown
# or project-local
cp -r saas-platform-teardown <project>/.claude/skills/saas-platform-teardown
```

Done. Research runs on the built-in web search/fetch tools (Engine A in
`references/06-research-sweeps.md`); the web audit is limited to static
fetches of public pages — no live app exploration — so UI-behavior claims
stay `Reported` instead of `Confirmed`.

## Tier 1 — live browser (recommended)

Playwright MCP gives the web-platform audit live DOM access: real in-app
journeys, authenticated-state screens, `Confirmed` UI claims.

```bash
claude mcp add playwright -s user -- npx @playwright/mcp@latest
claude mcp list | grep playwright   # must show: ✔ Connected
```

Or merge `mcp-config.example.json` (standard `mcpServers` object) into a
project `.mcp.json`. Scope notes that have bitten people:

- Register at **user scope** (`-s user`) to have the server available in
  every project. Dropping a server into `~/.claude/.mcp.json` does NOT
  register it — that file is only read when the session's working
  directory IS `~/.claude`.
- MCP servers load at session **start** — a server added mid-session won't
  appear until the next one.

Optional, same tier: `gh` (useful when the product has public repos —
desktop shells, SDKs, changelogs), `curl` (HEAD requests against download
links and update manifests), `jq` (parsing any JSON API responses). All
three are convenience, not requirement — the built-in tools cover their
cases more slowly.

Browser fallback: the `agent-browser` CLI (`npm install -g agent-browser`)
is used automatically when the MCP server isn't present. If
`command -v agent-browser` fails while `npm ls -g` shows it installed, the
nvm-bin symlink dangles — fix with
`ln -sf ../lib/node_modules/agent-browser/bin/agent-browser.js "$(npm prefix -g)/bin/agent-browser"`.

## Tier 2 — parallel research power (optional)

`agy` (Antigravity CLI) runs the research sweeps as parallel headless shell
jobs instead of sequentially through the built-in tools. Install:

```bash
curl -fsSL https://antigravity.google/cli/install.sh | bash
```

`agy` needs `jq` for output parsing, and headless mode auto-denies tool
permissions unless allow-listed. Add to
`~/.gemini/antigravity-cli/settings.json`:

```json
"permissions": { "allow": ["search_web", "read_url(*)", "read_url_content(*)", "read_resource(*)"] }
```

GOTCHA: the permission name is `read_url` — the tool is named
`read_url_content`; the error message quotes the name to allow. Blanket
fallback on any machine: append `--dangerously-skip-permissions` to the
agy invocation (auto-approves ALL its tools — see the playbook's caution).

Verify (last verified against agy 1.1.27, 2026-09 — the CLI self-updates,
so flag and model drift is possible):

```bash
agy --version
mkdir -p .agy-out && agy -p "Reply with the single word: pong" \
  --output-format stream-json --model gemini-3.8-flash --effort medium \
  > .agy-out/ping.jsonl
jq -r 'select(.event=="result") | .result.status' .agy-out/ping.jsonl  # SUCCESS
```

Note the pairing: no `--non-interactive` flag exists (`-p` is already
non-interactive), and `--model` requires a paired `--effort`. If the model
name 404s, run `agy models` and pick the current flash-family entry.

## Optional extras (never assumed)

- **Wappalyzer-class tech detector** (CLI or MCP) — faster stack
  fingerprinting of the marketing site and app subdomain. Exact package
  names churn; check the current OSS options at run time and confirm the
  tool is maintained before relying on it. The kit never assumes one is
  present.
- **App-store listing/review CLI** — structured store data without
  developer accounts. Same caveat: this space moves fast; verify before
  relying. Without it, the kit reads store listings via web fetch, which
  is the default path and is sufficient.

No other CLIs are needed: revenue-estimator, FCC-filing, Wayback, and
traffic-proxy lookups all run through the research sweeps (either engine),
and desktop installer sizes come from `curl -sI` HEAD requests. Mobile
release data deliberately stops at store-listing metadata — the kit never
extracts APK/IPA binaries, so no extraction tooling is wanted.

## What degrades how

No `agy` (Tier 2 missing): research sweeps run on the built-in web
search/fetch tools — slower and less parallel, but the pipeline still
works and the report is not thinner on sourced claims.

No Playwright MCP (Tier 1 missing): the web-platform audit degrades to
static `web_fetch` inspection of public pages only — no live app
exploration, no authenticated-state screens, and UI-behavior claims stay
`Reported`.
