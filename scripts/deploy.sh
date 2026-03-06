#!/bin/bash

# deploy.sh - 部署 Windeye 系统

set -e

SCRIPT_DIR="$(dirname "$0")"
WINDEYE_ROOT="$(dirname "$SCRIPT_DIR")"

echo "🚀 Deploying Windeye..."

# 1. 检查 Insight Hub
echo ""
echo "1️⃣ Checking Insight Hub..."
if curl -s http://localhost:8090/api/v1/items?limit=1 > /dev/null 2>&1; then
    echo "  ✅ Insight Hub is running"
else
    echo "  ⚠️ Insight Hub is not running"
    echo "  → Please start Insight Hub manually:"
    echo "    cd $WINDEYE_ROOT/insight-hub && docker-compose up -d"
fi

# 2. 同步 Skills
echo ""
echo "2️⃣ Syncing Skills..."
"$SCRIPT_DIR/sync.sh"

echo ""
echo "✅ Deploy complete!"
