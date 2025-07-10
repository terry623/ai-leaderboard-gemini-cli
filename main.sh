#!/usr/bin/env bash
set -euo pipefail   # 嚴格模式：任何指令失敗就終止

echo "------------------------------------------------------------------------------------------------------------------------------------------------------------"
echo "⏰ Current time: $(date +'%Y-%m-%d %H:%M:%S') ⏰"

# ===== 1. 要執行的腳本清單 =====
SCRIPTS=(
  "./scripts/lmarena.sh"
  # "./scripts/swe.sh"
  "./scripts/vellum.sh"
  "./scripts/scale.sh"
)

# ===== 2. 產生日期與時間資料夾 =====
DATE=$(date +%Y-%m-%d)   # 例如 2025-07-06
TIME=$(date +%H-%M)      # 例如 17-21；同分鐘重跑才會衝突
OUTPUT_DIR="output/${DATE}/${TIME}"
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
git push -f

echo "✅ 所有 Markdown 已推送到 ${OUTPUT_DIR}/"

# ===== 5. 設定自動排程 =====
# 1. 用 pmset 設定每天 07:55 自動喚醒 (macOS 專用指令)
# sudo pmset repeat wakeorpoweron MTWRFSU 07:57:00  # MTWRFSU = 每天
# pmset -g sched  # 檢查現有排程

# 2. 用 crontab 設定定時執行此腳本 (通用 Unix 系統)
# crontab -e  # 編輯排程，加入以下規則：
# 0 8 * * * /path/to/main.sh