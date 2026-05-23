#!/usr/bin/env bash
# audit-tool-registry.sh — Practice 7: verify the tool layer has no holes.
# All three sections below should be EMPTY. Any output = a gap to fix.
# Requires: yq (https://github.com/mikefarah/yq). Run: bash scripts/audit-tool-registry.sh
set -euo pipefail

REG="tools/registry.yaml"
[ -f "$REG" ] || { echo "no $REG"; exit 1; }

echo "=== Tools used in code but NOT declared in registry ==="
# Adjust the grep to your runner's call shape, e.g. runTool("name") / call_tool('name')
ACTUAL=$(grep -rEoh "(runTool|call_tool)\(['\"][a-z_]+['\"]" src/ 2>/dev/null \
          | sed -E "s/.*['\"]([a-z_]+)['\"].*/\1/" | sort -u || true)
DECLARED=$(yq '.tools[].name' "$REG" | sort -u)
comm -23 <(printf '%s\n' "$ACTUAL") <(printf '%s\n' "$DECLARED") || true

echo "=== Declared tools missing a timeout ==="
yq '.tools[] | select(.timeout_ms == null) | .name' "$REG" | awk 'NF{print "  ❌ no timeout: "$0}'

echo "=== Destructive tools missing an approval gate ==="
yq '.tools[] | select(.type == "destructive" and .requires_approval != true and (.requires_approval_if == null)) | .name' "$REG" \
  | awk 'NF{print "  ❌ destructive w/o approval: "$0}'

echo "=== Audit complete (all sections empty above = clean) ==="
