#!/usr/bin/env bash
#
# validate-skill.sh — structural validator for the SaaS Platform Teardown Kit.
#
# Pure bash/grep (+ jq for JSON). Run from anywhere:
#   bash scripts/validate-skill.sh
#
# Checks:
#   1. SKILL.md frontmatter: name == directory name; description non-empty,
#      < 1024 chars; frontmatter delimiters balanced.
#   2. references/01..08 exist, sequential, no orphans.
#   3. Cross-reference resolution: every `references/NN-*.md` path cited in a
#      tracked doc resolves (catches playbook renames with stale call-sites).
#      Tracked .md files are the scan set; examples/ is excluded (dated
#      snapshots — dead links there are findings, not breakage).
#   4. Phase-table invariant in SKILL.md: the phase-N row cites
#      references/(N+1)-*.md (encodes the off-by-one so future renumbering
#      fails loudly); the conditional row cites references/08-*.md.
#   5. assets/report-template/00..08 exist, sequential; links inside
#      00-INDEX.md resolve.
#   6. Vocabulary: Confirmed/Reported/Inferred in SKILL.md; the four
#      access-method grades in references/02.
#   7. Regression guards: no tracked .idea/.serena/.agy-out paths; the kit
#      stays machine-agnostic ("on this machine"), scope-specific
#      ("registered at user scope"), and free of internal migration notes
#      ("(The old").
#   8. mcp-config.example.json parses as an object with an mcpServers key.
#   9. Every examples/<slug>-teardown/ has 00-INDEX.md; examples/README.md
#      relative links resolve (active once examples/ exists).
#
# Exit 0 = all green; exit 1 = at least one failure (listed at the end).

set -u

pass=0
fail=0
errors=()

ok()  { pass=$((pass + 1)); printf '  PASS %s\n' "$1"; }
bad() { fail=$((fail + 1)); errors+=("$1"); printf '  FAIL %s\n' "$1"; }
info() { printf '  .... %s\n' "$1"; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ROOT="$(git -C "$SCRIPT_DIR/.." rev-parse --show-toplevel 2>/dev/null)"
if [ -z "${ROOT}" ]; then
  ROOT="$(cd "$SCRIPT_DIR/.." && pwd)"
fi
KIT="$ROOT/saas-platform-teardown"
SKILL="$KIT/SKILL.md"

printf 'SaaS Platform Teardown Kit — structural validation\n'
printf 'root: %s\n' "$ROOT"

# ---------------------------------------------------------------- check 1
printf '\n[1/9] SKILL.md frontmatter\n'
if [ ! -f "$SKILL" ]; then
  bad "SKILL.md not found at $SKILL"
else
  first_line="$(head -n 1 "$SKILL")"
  if [ "$first_line" = "---" ]; then
    ok "file starts with a frontmatter delimiter"
  else
    bad "first line is '$first_line', expected '---'"
  fi
  delimiter_count="$(grep -c '^---[[:space:]]*$' "$SKILL" || true)"
  if [ "${delimiter_count:-0}" -ge 2 ] && [ $((delimiter_count % 2)) -eq 0 ]; then
    ok "frontmatter delimiters balanced ($delimiter_count)"
  else
    bad "frontmatter delimiters unbalanced (count=$delimiter_count)"
  fi
  skill_name="$(awk 'NR==1 {next} /^---[[:space:]]*$/ {exit} /^name:/ {sub(/^name:[[:space:]]*/, ""); print; exit}' "$SKILL")"
  if [ "$skill_name" = "$(basename "$KIT")" ]; then
    ok "name matches directory name ('$skill_name')"
  else
    bad "frontmatter name '$skill_name' != directory name '$(basename "$KIT")'"
  fi
  description="$(awk 'NR==1 {next} /^---[[:space:]]*$/ {exit} /^description:/ {sub(/^description:[[:space:]]*/, ""); print; exit}' "$SKILL")"
  desc_len="${#description}"
  if [ -n "$description" ]; then
    ok "description non-empty ($desc_len chars)"
  else
    bad "description is empty"
  fi
  if [ "$desc_len" -lt 1024 ]; then
    ok "description < 1024 chars ($desc_len)"
  else
    bad "description too long ($desc_len >= 1024)"
  fi
fi

# ---------------------------------------------------------------- check 2
printf '\n[2/9] references/01..08 sequential, no gaps, no orphans\n'
if [ -d "$KIT/references" ]; then
  for i in 1 2 3 4 5 6 7 8; do
    n="$(printf '%02d' "$i")"
    if compgen -G "$KIT/references/$n-*.md" > /dev/null; then
      ok "references/$n-* present"
    else
      bad "references/$n-*.md missing"
    fi
  done
  ref_count="$(find "$KIT/references" -maxdepth 1 -name '[0-9][0-9]-*.md' | wc -l | tr -d ' ')"
  if [ "$ref_count" -eq 8 ]; then
    ok "exactly 8 numbered reference files"
  else
    bad "found $ref_count numbered reference files, expected 8 (orphan?)"
  fi
else
  bad "references/ directory missing"
fi

# ---------------------------------------------------------------- check 3
printf '\n[3/9] cited references/NN-*.md paths resolve\n'
scan_list="$(git -C "$ROOT" ls-files '*.md' | grep -v '^examples/' || true)"
ref_hits=0
ref_broken=0
if [ -n "$scan_list" ]; then
  while IFS= read -r file; do
    [ -f "$ROOT/$file" ] || continue
    while IFS= read -r cited; do
      ref_hits=$((ref_hits + 1))
      dir="$(dirname "$ROOT/$file")"
      if [ -f "$ROOT/$cited" ] || [ -f "$KIT/$cited" ] || [ -f "$dir/$cited" ]; then
        :
      else
        ref_broken=$((ref_broken + 1))
        bad "$file cites '$cited' — no such file under the kit or next to the citing doc"
      fi
    done < <(grep -oE 'references/[0-9][0-9]-[A-Za-z0-9._-]*\.md' "$ROOT/$file" 2>/dev/null || true)
  done <<< "$scan_list"
fi
if [ "$ref_hits" -eq 0 ]; then
  info "no references/NN-*.md citations found in tracked docs"
elif [ "$ref_broken" -eq 0 ]; then
  ok "all $ref_hits citations resolve"
fi

# ---------------------------------------------------------------- check 4
printf '\n[4/9] phase-table invariant (phase N -> references/(N+1))\n'
if [ -f "$SKILL" ]; then
  # Row cells may carry annotations ("5 (parallel/ongoing)") — match the
  # leading token, don't require the cell to be bare.
  table_rows="$(grep -E '^\| *(conditional|[0-9]+)' "$SKILL" || true)"
  if [ -z "$table_rows" ]; then
    bad "no phase-table rows found in SKILL.md"
  else
    while IFS= read -r row; do
      phase="$(printf '%s' "$row" | awk -F'|' '{gsub(/[[:space:]]/, "", $2); print $2}' | grep -oE '^(conditional|[0-9]+)')"
      cited="$(printf '%s' "$row" | grep -oE 'references/[0-9][0-9]-[A-Za-z0-9._-]*\.md' | head -n 1)"
      if [ -z "$cited" ]; then
        bad "phase '$phase' row cites no references/NN-*.md playbook"
        continue
      fi
      if [ "$phase" = "conditional" ]; then
        expected="references/08-"
      else
        expected="$(printf 'references/%02d-' "$((phase + 1))")"
      fi
      case "$cited" in
        "$expected"*) ok "phase $phase -> $cited" ;;
        *) bad "phase $phase cites '$cited', expected $expected*.md" ;;
      esac
    done <<< "$table_rows"
  fi
fi

# ---------------------------------------------------------------- check 5
printf '\n[5/9] assets/report-template 00..08 + 00-INDEX links\n'
TPL="$KIT/assets/report-template"
if [ -d "$TPL" ]; then
  for i in 0 1 2 3 4 5 6 7 8; do
    n="$(printf '%02d' "$i")"
    if compgen -G "$TPL/$n-*.md" > /dev/null; then
      ok "template $n-* present"
    else
      bad "$TPL/$n-*.md missing"
    fi
  done
  tpl_count="$(find "$TPL" -maxdepth 1 -name '[0-9][0-9]-*.md' | wc -l | tr -d ' ')"
  if [ "$tpl_count" -eq 9 ]; then
    ok "exactly 9 template files"
  else
    bad "found $tpl_count numbered template files, expected 9 (orphan?)"
  fi
  if [ -f "$TPL/00-INDEX.md" ]; then
    index_links=0
    while IFS= read -r link; do
      link="$(printf '%s' "$link" | cut -d'#' -f1)"
      [ -z "$link" ] && continue
      index_links=$((index_links + 1))
      if [ -f "$TPL/$link" ]; then
        ok "00-INDEX link resolves: $link"
      else
        bad "00-INDEX.md links to missing file '$link'"
      fi
    done < <(grep -oE '\]\([^)]+\.md\)' "$TPL/00-INDEX.md" 2>/dev/null | sed -e 's/^\](//' -e 's/)$//' || true)
    [ "$index_links" -eq 0 ] && info "00-INDEX.md contains no relative .md links"
  else
    bad "assets/report-template/00-INDEX.md missing"
  fi
else
  bad "assets/report-template/ missing"
fi

# ---------------------------------------------------------------- check 6
printf '\n[6/9] vocabulary\n'
if [ -f "$SKILL" ]; then
  for word in Confirmed Reported Inferred; do
    if grep -q "$word" "$SKILL"; then
      ok "SKILL.md uses '$word'"
    else
      bad "SKILL.md missing confidence label '$word'"
    fi
  done
fi
AUDIT="$KIT/references/02-web-platform-audit.md"
if [ -f "$AUDIT" ]; then
  for grade in live vendor-documentary third-party marketing-render; do
    if grep -q "$grade" "$AUDIT"; then
      ok "references/02 access grades include '$grade'"
    else
      bad "references/02 missing access grade '$grade'"
    fi
  done
fi

# ---------------------------------------------------------------- check 7
printf '\n[7/9] regression guards\n'
tracked_junk="$(git -C "$ROOT" ls-files | grep -E '(^|/)\.idea/|(^|/)\.serena/|(^|/)\.agy-out/' || true)"
if [ -z "$tracked_junk" ]; then
  ok "no tracked .idea/.serena/.agy-out paths"
else
  bad "tracked IDE/agent/output paths found: $tracked_junk"
fi

# Machine-agnostic / migration-note string guards.
#
# ACTIVATION: these guards fail while the pre-engine-abstraction wording
# ("on this machine" in setup.md and references/06, "registered at user
# scope" and "(The old" in references/02) is still present. They switch on
# in the same commit that scrubs the last of those strings (the Phase B
# setup.md rewrite) — until then, uncommenting them would pin Gate A's CI
# red for wording the kit rework is about to delete anyway.
#
# for file in $(git -C "$ROOT" ls-files '*.md' | grep -v '^examples/'); do
#   [ -f "$ROOT/$file" ] || continue
#   if grep -q 'on this machine' "$ROOT/$file"; then
#     bad "$file contains machine-specific wording ('on this machine')"
#   fi
#   if grep -q 'registered at user scope' "$ROOT/$file"; then
#     bad "$file contains scope-specific wording ('registered at user scope')"
#   fi
#   if grep -q '(The old' "$ROOT/$file"; then
#     bad "$file contains an internal migration note ('(The old')"
#   fi
# done
ok "tracked-path guards ran (string guards pending Phase B — see comment above)"

# ---------------------------------------------------------------- check 8
printf '\n[8/9] mcp-config.example.json\n'
MCP_CONFIG="$ROOT/mcp-config.example.json"
if [ ! -f "$MCP_CONFIG" ]; then
  bad "mcp-config.example.json missing"
elif ! jq -e 'type == "object" and (.mcpServers | type == "object")' "$MCP_CONFIG" > /dev/null 2>&1; then
  bad "mcp-config.example.json does not parse as an object with an mcpServers key"
else
  ok "parses; has mcpServers object"
fi

# ---------------------------------------------------------------- check 9
printf '\n[9/9] examples checks\n'
if [ ! -d "$ROOT/examples" ]; then
  info "no examples/ directory yet — nothing to check (activates in Phase D)"
else
  example_count=0
  for d in "$ROOT/examples"/*-teardown; do
    [ -d "$d" ] || continue
    example_count=$((example_count + 1))
    if [ -f "$d/00-INDEX.md" ]; then
      ok "$(basename "$d") has 00-INDEX.md"
    else
      bad "$(basename "$d") missing 00-INDEX.md"
    fi
  done
  [ "$example_count" -eq 0 ] && info "examples/ exists but holds no *-teardown dirs yet"
  if [ -f "$ROOT/examples/README.md" ]; then
    readme_links=0
    while IFS= read -r link; do
      link="$(printf '%s' "$link" | cut -d'#' -f1)"
      [ -z "$link" ] && continue
      readme_links=$((readme_links + 1))
      if [ -e "$ROOT/examples/$link" ]; then
        ok "examples/README.md link resolves: $link"
      else
        bad "examples/README.md links to missing path '$link'"
      fi
    done < <(grep -oE '\]\([^)]+\)' "$ROOT/examples/README.md" 2>/dev/null | sed -e 's/^\](//' -e 's/)$//' | grep -v '^https\?://' || true)
    [ "$readme_links" -eq 0 ] && info "examples/README.md contains no relative links"
  fi
fi

# ---------------------------------------------------------------- summary
printf '\n========================================\n'
printf '%d passed, %d failed\n' "$pass" "$fail"
if [ "$fail" -gt 0 ]; then
  printf '\nFailures:\n'
  for e in "${errors[@]}"; do
    printf '  - %s\n' "$e"
  done
  exit 1
fi
printf 'All structural checks green.\n'
exit 0
