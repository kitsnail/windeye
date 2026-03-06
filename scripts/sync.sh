#!/bin/bash

# sync.sh - 同步 Skills 到 OpenClaw

set -e

OPENCLAW_SKILLS="$HOME/.agents/skills"
WINDEYE_SKILLS="$(dirname "$0")/../skills"

echo "🔄 Syncing Windeye Skills..."

# Wind Radar
echo "  → Wind Radar"
cp -r "$WINDEYE_SKILLS/wind-radar" "$OPENCLAW_SKILLS/"

# Daily Signal
echo "  → Daily Signal"
cp -r "$WINDEYE_SKILLS/daily-signal" "$OPENCLAW_SKILLS/"

echo "✅ Sync complete!"
