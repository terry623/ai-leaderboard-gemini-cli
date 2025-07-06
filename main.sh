#!/usr/bin/env bash

set -euo pipefail   # 嚴格模式：任何指令失敗就終止，避免推送半成品

# ===== 1. 要執行的腳本清單 =====
SCRIPTS=(
  "./scripts/llm.sh"
)

# ===== 2. 建立以今天日期命名的資料夾 =====
TODAY=$(date +%Y-%m-%d)          # 2025-07-06 這種格式
OUTPUT_DIR="data/${TODAY}"     # 也可改成純 ${TODAY}
mkdir -p "$OUTPUT_DIR"

# ===== 3. 依序執行腳本，收集 .md =====
for SCRIPT in "${SCRIPTS[@]}"; do
  NAME=$(basename "$SCRIPT" .sh)           # e.g. build_docs
  echo "➤ Running $SCRIPT …"

  "$SCRIPT"
  mv "./${NAME}.md" "${OUTPUT_DIR}/"

done

# ===== 4. Git commit & push =====
git add "$OUTPUT_DIR"
git commit -m "docs: update markdown for ${TODAY}"
git push        # 預設會推到目前 branch 的 upstream；請先設定好 remote

echo "✅ 所有 Markdown 已推送到 ${OUTPUT_DIR}/"
