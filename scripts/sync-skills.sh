#!/bin/sh
# Copy each kit's SKILL.md, LICENSE and NOTICE into skills/<skill-name>/.
# The kit repositories are the source of truth. Run from anywhere; kits must be
# checked out next to this repository (../<kit-repo>/). No network access.
set -e
cd "$(dirname "$0")/.."
sync() { # sync <kit-repo> <skill-name>
  src="../$1"; dst="skills/$2"
  [ -f "$src/SKILL.md" ] || { echo "missing $src/SKILL.md" >&2; exit 1; }
  mkdir -p "$dst"
  cp "$src/SKILL.md" "$src/LICENSE" "$dst/"
  for n in NOTICE NOTICE.md; do [ -f "$src/$n" ] && cp "$src/$n" "$dst/"; done
  echo "synced $2 from $1"
}
sync agent-name-assurance-explained agent-name-assurance
sync rahp-toolkit-explained         rahp-harm-check
sync dpi-ai-governance-explained    dpi-ai-risk-tiers
sync oaaf-explained                 oaaf-authority
sync agent-receipts-explained       agent-receipts-audit
sync agent-governance-spec-explained agent-behavior-rules
sync aegis-sovereign-ai-explained   sovereignty-check
sync ai-incident-response-explained ai-incident-response
