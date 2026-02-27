------------------------------------------------------------
-- Migration 039: 草酸鈣警示、D3 回滾停用、甘胺酸 3.5hr、
--                B群活化型態、Ashwagandha 感冒停用
------------------------------------------------------------

-- ===== 1. 鈣攝取：草酸警示 + 確認碘鹽間隔 =====

UPDATE plan_items SET
  description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（~200-300mg）+ 深綠蔬菜 + 豆腐。⚠️ 若當日飲食鈣攝取確認不足 → 午餐後 1hr（13:00）補 1 錠鈣片 500mg（Nature Made Ca+D3+K2），與午餐脂溶性維生素（魚油/D3/K2/葉黃素）間隔 1hr+ 避免競爭吸收。⚠️ 補鈣當日：停用午餐獨立 D3（鈣片已含 D3 150IU，25(OH)D 為長期蓄積指標，單日少攝取不影響血清濃度）。🚫 草酸警示：補鈣日午餐避免大量菠菜等高草酸食物（草酸與鈣結合 → 草酸鈣結石 + 降低鈣吸收），菠菜移至晚餐或非補鈣日食用。禁止睡前服用（鈣與鎂競爭 DMT1 載體）。09:05 碘鹽 → 13:00 鈣（間隔 4hr）→ 16:00 銅 → 19:00 鋅，各間隔 3hr+'
WHERE title LIKE '全天 鈣攝取確認%';

-- ===== 2. D3 補鈣日：回滾為完全停用（錠劑 1/4 切分不實際） =====

UPDATE plan_items SET
  description = '蛋白質 35-40g（正餐食物，單餐 ≤40g 避免 BUN 飆升與腸道產氣）+ 肌酸 5g（CGN Creatine Monohydrate）+ 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日，建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g（確保脂溶性維生素充分吸收）。隨餐服用：魚油 3 顆、D3 1000IU（每日半顆）、K2 MK-7 100mcg、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 200mg。⚠️ 若當日需補鈣：鈣片午餐後 1hr（13:00）服用，當日停用午餐獨立 D3（鈣片已含 150IU，25(OH)D 為長期蓄積指標不受單日影響）。🚫 補鈣日午餐避免大量菠菜（草酸結合鈣降低吸收）'
WHERE title LIKE '12:00 午餐%';

UPDATE products SET
  purchase_note = '線上可訂（常溫配送）。純鈣備用品（鈣從食物攝取為主），250 錠可用非常久。⚠️ 補鈣當日注意：本品每錠含 D3 150IU，午餐獨立 D3 1000IU 當日停用（錠劑無法精確切分，25(OH)D 為長期蓄積指標不受單日影響）。碳酸鈣+檸檬酸鈣錠劑常溫陰涼處即可穩定保存。適合放辦公桌或隨身攜帶，確保 13:00 補鈣時段可取用。'
WHERE name LIKE '鈣片備用%';

-- ===== 3. 甘胺酸：嚴格 22:30+ 距晚餐 3.5hr =====

UPDATE plan_items SET
  description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 600mg（嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。🚫 血清素藥物禁忌：若正在服用抗憂鬱劑（SSRIs/SNRIs）或任何影響血清素的藥物 → 必須立即停用 Ashwagandha，可能誘發血清素綜合徵（Serotonin Syndrome）。⚠️ 第 6 週起密切觀察情緒變化：若出現情緒冷漠（Anhedonia）或早晨無力起床 → 立即進入停用期。停用期替代：甘胺酸鎂 + Cyclic Sighing 維持睡眠品質。⏰ 嚴格 22:30 後服用（非 22:00），確保與 19:00 晚餐蛋白質間隔 3.5hr+（甘胺酸與蛋白質共用氨基酸載體，間隔不足會降低甘胺酸降溫效果），同時為腎臟保留排尿緩衝時間'
WHERE title LIKE '22:00 睡前補充品%';

-- ===== 4. B群：改為活化型態 =====

UPDATE products SET
  name = 'B群 活化型態（NOW Foods B-50 Coenzyme 60 顆）',
  description = '✓ iHerb 必買。活化型態 B 群複方：甲鈷胺（Methylcobalamin B12）、5-MTHF 葉酸（非合成 Folic Acid）、P5P（活化 B6）。應對 MTHFR 基因變異風險，確保 B 群被有效利用。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成',
  usage = '每日 1 顆隨早餐（訓練前營養餐）',
  price = 'NT$450-550 / 60 顆',
  url = 'https://tw.iherb.com/pr/now-foods-coenzyme-b-complex-60-veg-capsules/14804',
  sku = 'NOW-00427',
  specs = $${"form":"素食膠囊","count":"60顆","type":"Coenzyme（活化型態）"}$$::jsonb,
  nutrition = $${"serving_size":"1顆","b12":"甲鈷胺 Methylcobalamin","folate":"5-MTHF（非 Folic Acid）","b6":"P5P（活化型態）"}$$::jsonb,
  purchase_note = 'iHerb 必買品項。✅ 活化型態（Coenzyme）優於普通合成 B-50：甲鈷胺 B12（非氰鈷胺）、5-MTHF 葉酸（非 Folic Acid，應對 MTHFR 基因變異）、P5P B6。每日 1 顆隨 09:15 早餐，60 顆可用 2 個月。水溶性，尿液變黃為正常現象（B2 代謝）'
WHERE name LIKE 'B群 B-50%';

UPDATE plan_items SET
  description = '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（活化型態 Coenzyme B-Complex：甲鈷胺 B12 + 5-MTHF 葉酸 + P5P B6，應對 MTHFR 基因變異，水溶性隨餐）。⚠️ 地瓜建議前晚用電子鍋蒸好冷藏（產生抗性澱粉 RS3），隔日微波 30 秒加溫即可食用，抗性澱粉仍保留大部分'
WHERE title LIKE '09:15 訓練前營養%';

-- ===== 5. Ashwagandha：停用期標籤 + 感冒/免疫停用 =====

UPDATE plan_items SET
  description = '在瓶身標記「開始日」與「第 56 天停用日」，建議設定手機鬧鐘提醒停用日期。📋 週期檢查：第 1-5 週正常服用 / 第 6 週起每日自評情緒冷漠（Anhedonia）、早晨無力起床 → 任一症狀立即停用 / 第 8 週（56 天）準時進入停用期 / 停用 4 週（28 天）替代方案：甘胺酸鎂 + Cyclic Sighing。🚫 禁忌：服用 SSRIs/SNRIs 或血清素藥物者禁用。⚠️ ALT/AST 異常 → 首位停用本品。🚫 感冒/免疫啟動時立即停用：Ashwagandha 具有免疫調節作用（上調 Th1/Th2 平衡），感冒、發燒或任何急性感染徵兆出現時 → 立即暫停服用，待完全康復後再恢復，避免干擾身體對急性感染的自然免疫反應。每半年健檢時確認肝功能指標'
WHERE title LIKE 'Ashwagandha 週期管理%';

UPDATE products SET
  purchase_note = 'iHerb 直送。⚠️ 8 週用期（56 天）每日 1 顆，每瓶 90 顆可完成 1 個完整週期（56 顆用 + 剩 34 顆留下一輪）。建議在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。停用期 4 週（28 天）替代方案：甘胺酸鎂 + Cyclic Sighing 呼吸法維持睡眠品質。⚠️ 第 6 週起留意情緒冷漠 → 立即停用。若 ALT/AST 異常 → 首位停用本品。🚫 血清素藥物禁忌：若正在服用抗憂鬱劑（SSRIs/SNRIs）或任何影響血清素的藥物 → 禁用本品（血清素綜合徵風險）。🚫 感冒/免疫啟動時立即暫停：Ashwagandha 具免疫調節作用，急性感染期間服用可能干擾自然免疫反應，待完全康復後再恢復'
WHERE name LIKE 'Ashwagandha%';
