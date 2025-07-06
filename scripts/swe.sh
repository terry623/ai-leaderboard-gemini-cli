#!/usr/bin/env bash

set -euo pipefail

echo "Executing Gemini CLI to scrape swe rebench leaderboard..."
gemini -m "gemini-2.5-flash" -y -p "
請從目標網址 https://swe-rebench.com/leaderboard 爬取「今日排行榜」資料，並將結果整理成 Markdown。

**嚴格限制**  
- 僅能使用從目標網址實際爬取到的內容作為資料來源  
- 不得引用或參考任何內建知識庫、訓練資料或外部資訊  
- 所有產出的資料、事實、數據都必須完全來自指定網頁

**若資料不完整，仍須輸出 Markdown**  
- 對於缺漏欄位，請填入 `N/A` 並於表格下方以備註方式說明「資訊不足，僅能顯示部分資料」  
- 絕對不可因為資料不足而省略整份 Markdown

**輸出要求**  
1. 產出的 Markdown 應包含：  
   - 標題  
   - 爬取時間（UTC，以 `YYYY-MM-DD HH:MM` 格式）  
   - 資料來源連結  
   - 空行  
   - 排行榜表格（至少包含 Rank、Model、Score，若網頁有更多欄位一併加入；缺值填 `N/A`）  
   - 重要註解或說明（若有缺漏，須說明原因）  
2. 全文與檔案內容須為 **英文**  
3. 必須實際寫入檔案並回傳

請遵守以上規範，確保無論資料完整與否，都會輸出結構正確的 Markdown 檔案。
"