------------------------------------------------------------
-- 035: 鈣D3疊加 + Ashwagandha週期 + 鈣銅間隔 + 牛肉日蛋白
--      + CoQ10統一 + 電解質粉整合 + 櫛瓜採購
------------------------------------------------------------

-- === 1. 鈣片+D3 疊加風險：補鈣當日 D3 停用 ===

UPDATE plan_items SET
  description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（~200-300mg）+ 深綠蔬菜 + 豆腐。⚠️ 若當日飲食鈣攝取確認不足 → 午餐後 13:00 隨輕食補 1 錠鈣片 500mg（Nature Made Ca+D3+K2）。⚠️ 補鈣當日：鈣片已含 D3 150IU，午餐獨立 D3 應停用（避免疊加超量，嚴格遵守血檢達標後減量原則）。禁止睡前服用（鈣與鎂競爭 DMT1 載體）。與 15:00 銅間隔 2hr+'
WHERE title LIKE '全天 鈣攝取確認%';

-- 更新鈣片產品備註
UPDATE products SET
  purchase_note = '線上可訂（常溫配送）。純鈣備用品（鈣從食物攝取為主），250 錠可用非常久。⚠️ 補鈣當日注意：本品每錠含 D3 150IU，午餐獨立 D3 1000IU 應停用，避免長期疊加超量。碳酸鈣+檸檬酸鈣錠劑常溫陰涼處即可穩定保存。適合放辦公桌或隨身攜帶，確保 13:00 補鈣時段可取用。'
WHERE name LIKE '鈣片備用%';

-- === 2. Ashwagandha 週期+停用日記錄+替代方案 ===

UPDATE products SET
  purchase_note = 'iHerb 直送。⚠️ 8 週用期（56 天）每日 1 顆，每瓶 90 顆可完成 1 個完整週期（56 顆用 + 剩 34 顆留下一輪）。建議在瓶身標記「開始日」與「第 56 天停用日」。停用期 4 週（28 天）替代方案：甘胺酸鎂 + Cyclic Sighing 呼吸法維持睡眠品質。⚠️ 第 6 週起留意情緒冷漠 → 立即停用。若 ALT/AST 異常 → 首位停用本品。'
WHERE name LIKE 'Ashwagandha%';

-- 更新睡前補充品 plan_item（加入停用期替代方案）
UPDATE plan_items SET
  description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 600mg（嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。⚠️ 第 6 週起密切觀察情緒變化：若出現情緒冷漠（Anhedonia）或早晨無力起床 → 立即進入停用期。停用期替代：甘胺酸鎂 + Cyclic Sighing 維持睡眠品質。22:00 服用確保與 19:00 晚餐蛋白質間隔 3hr+（甘胺酸與蛋白質競爭吸收），同時為腎臟保留排尿緩衝時間'
WHERE title LIKE '22:00 睡前補充品%';

-- === 3. 鈣銅間隔：補鈣提前至 13:00（午餐後）===
-- 已在 #1 中更新 plan_item description（13:00 隨輕食補）
-- TimingTable 也需同步更新（在前端代碼修改）

-- === 4. 牛肉日晚餐蛋白質上限 ===

UPDATE plan_items SET
  description = '蛋白質 40-45g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 2 大匙（28g）入菜或涼拌。隨餐服用：維他命 C 500mg（半錠）+ 鋅 25mg（半顆，每兩天一次，與 15:00 銅間隔 4hr+）。⚠️ 牛肉日注意：草飼牛肉 200g ≈ 40-50g 蛋白，應減少其他蛋白來源（減蛋/減量），確保單餐 ≤50g 避免腎臟短時間代謝壓力。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- 更新蛋白質目標（加入牛肉日提醒）
UPDATE plan_items SET
  description = '訓練前乳清 27g + 午餐 40-45g（含每週 1-2 次草飼牛肉 200-300g 替代雞胸）+ 下午豌豆 16g + 晚餐 40-45g ≈ 130-140g。每餐達亮氨酸門檻 2.5-3g。每日 4-5 餐均勻分配，總計 146g+（2.0g/kg）。⚠️ 牛肉日：牛肉 200g ≈ 40-50g 蛋白，晚餐應減少其他蛋白來源（少加蛋），確保單餐 ≤50g。牛肉日額外提供血基質鐵、B12、天然肌酸'
WHERE title LIKE '全天 蛋白質 146g%';

-- === 5. CoQ10 統一為每日 200mg ===

UPDATE plan_items SET
  description = REPLACE(description, 'CoQ10 100-200mg', 'CoQ10 200mg')
WHERE title LIKE '12:00 午餐%';

-- === 6. 電解質粉整合至 Zone 2 日 ===

-- 更新 09:05 補水（加入有氧日替換提示）
UPDATE plan_items SET
  description = '起床後盡快補水。500ml 室溫水 + 少許碘鹽 + 檸檬汁。可搭配晨光曝曬同時進行。碘鹽取代海鹽以確保碘攝取。⚠️ 週六/日 Zone 2 有氧日：09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水'
WHERE title LIKE '09:05 補水%';

-- 更新 Zone 2 plan_item（加入電解質提示）
UPDATE plan_items SET
  description = '週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機。⚠️ Zone 2 日補水策略：09:05 補水改用電解質粉沖泡（CGN Sport Hydration），訓練中持續飲用電解質水維持水合'
WHERE title LIKE 'Zone 2 有氧%';

-- === 7. 櫛瓜已存在於產品表，更新規格與營養資訊 ===

UPDATE products SET
  specs = '{"storage":"冷藏 5-7 天，不要水洗後再冷藏","preparation":"切片或切丁入菜、涼拌皆可","portion":"每次 100-150g"}'::jsonb,
  nutrition = '{"per_100g":"17kcal, 蛋白質 1.2g, 碳水 3.1g, 纖維 1.0g, 鉀 261mg"}'::jsonb
WHERE name LIKE '櫛瓜%';
