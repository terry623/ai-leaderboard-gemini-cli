#!/usr/bin/env bash

set -euo pipefail

echo "Executing Gemini CLI to scrape vellum leaderboard..."
gemini -m "gemini-2.5-pro" -y -p "
請從目標網址 https://www.vellum.ai/llm-leaderboard 爬取「今日排行榜」資料，並將結果整理成 Markdown。

**嚴格限制：僅能使用指定網頁內容作為資料來源**
- 不得引用或參考任何內建知識庫、訓練資料或外部資訊
- 所有產出的資料、事實、數據和內容都必須完全來自於指定的網頁材料
- 如果提供的網頁內容不足以生成完整內容，請明確告知資訊不足，而非使用其他來源補充

要求：
1. 爬取完整的排行榜資料，包含所有模型的排名、分數等資訊
2. 將資料格式化為清晰易讀的 markdown 表格格式
3. 在 markdown 開頭加上爬取時間和資料來源
4. 將結果儲存為檔案，檔名名稱為 vellum-leaderboard.md
5. 爬取時間和資料來源連結，中間需要空行，只能用純文字
6. 使用 WriteFileTool 寫入檔案時，請使用英文內容

請確保 markdown 檔案包含：
- 標題
- 爬取時間
- 資料來源連結
- 完整的排行榜表格（包含排名、模型名稱、分數等欄位）
- 任何重要的註解或說明
"