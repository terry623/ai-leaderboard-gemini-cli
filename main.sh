#!/usr/bin/env bash
set -euo pipefail   # 嚴格模式：任何指令失敗就終止

# ===== 1. 要執行的腳本清單 =====
SCRIPTS=(
  "./scripts/llm.sh",
  "./scripts/lmarena.sh",
  "./scripts/swe.sh",
  "./scripts/vellum.sh",
  "./scripts/scale.sh"
)

# ===== 2. 產生日期與時間資料夾 =====
DATE=$(date +%Y-%m-%d)   # 例如 2025-07-06
TIME=$(date +%H-%M)      # 例如 17-21；同分鐘重跑才會衝突
OUTPUT_DIR="data/${DATE}/${TIME}"
mkdir -p "$OUTPUT_DIR"

# ===== 3. 執行腳本並搬移 .md =====
for SCRIPT in "${SCRIPTS[@]}"; do
  echo "➤ Running $SCRIPT …"
  "$SCRIPT"
  mv ./*.md "$OUTPUT_DIR"/ 2>/dev/null || true
done

# ===== 4. Git commit & push =====
git add "$OUTPUT_DIR"
git commit -m "docs: update markdown for ${DATE} ${TIME}"
git push

echo "✅ 所有 Markdown 已推送到 ${OUTPUT_DIR}/"
