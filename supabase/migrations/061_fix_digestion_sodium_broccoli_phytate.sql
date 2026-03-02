------------------------------------------------------------
-- 061: Fix 5 consistency issues
-- 1. Move B群 from 09:15 to 12:00 lunch (digestion + absorption)
-- 2. Limit kimchi to ≤30g/day (sodium control)
-- 3. Add broccoli pre-cut at 09:00 instruction
-- 4. Resolve tofu phytic acid vs zinc contradiction
-- 5. B群 product usage updated to lunch
------------------------------------------------------------

-- === Fix 1+5: Move B群 from 09:15 → 12:00 午餐 ===

UPDATE plan_items
SET description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉。地瓜需 60-90 分鐘消化（含抗性澱粉），若要吃地瓜請提前至 08:00 進食。B群已移至 12:00 午餐隨餐服用（正餐食物基質更完整，避免空腹活化型 B 群引發噁心）'
WHERE title = '09:15 訓練前營養';

UPDATE plan_items
SET description = '蛋白質 35-40g（正餐食物，單餐建議 ≤45g）+ 肌酸 5g + 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆、D3 1000IU、K2、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 200mg、B群 1 顆（活化型態，隨正餐油脂+蛋白質完整食物基質服用，吸收率最佳）'
WHERE title = '12:00 午餐 + 訓練後補充品';

UPDATE plan_items
SET description = '起床後 90-135 分鐘再喝（避免干擾皮質醇覺醒反應）。咖啡因 200-300mg + L-Theanine 200mg（1:1 A 級 nootropic 組合）。15:00 後禁止咖啡因。✅ 無論當天是否飲用綠茶，喝咖啡就必須同步服用 L-Theanine'
WHERE title = '11:15 咖啡 + L-Theanine';

UPDATE products
SET usage = '每日 1 顆隨 12:00 午餐服用（搭配魚油、橄欖油等完整正餐油脂+蛋白質，吸收率最佳。避免訓練前空腹服用引發噁心）',
    purchase_note = 'iHerb 必買品項。✅ 活化型態（Coenzyme）優於普通合成 B-50：甲鈷胺 B12（非氰鈷胺）、5-MTHF 葉酸（非 Folic Acid，應對 MTHFR 基因變異）、P5P B6。60 顆可用 2 個月。⚠️ 已改為 12:00 午餐隨餐服用（非訓練前）'
WHERE name LIKE 'B群%';

-- === Fix 2: Sodium control — kimchi ≤30g, cooking salt 1-1.5g ===

UPDATE products
SET usage = '每日 ≤30g 隨餐（控鈉：100g 泡菜含鈉 ~600-900mg，30g 約 180-270mg）',
    purchase_note = '賣場限定，無法線上訂。每日 ≤30g（控鈉），120g×6 約 24 天，每月補貨 1 次即可。小圓罐適合見縫插針：兩兩疊放在優格罐前方，或利用層板間的零碎高度。⚠️ 泡菜為高鈉食物，嚴格限量 30g/日以配合 WHO <2400mg/日鈉攝取目標'
WHERE name LIKE '泡菜%';

UPDATE plan_items
SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 全日鈉預算（WHO <2400mg/日）：晨間 1g（~400mg 鈉）+ 午晚餐烹調碘鹽合計 1-1.5g（~400-600mg 鈉）+ 泡菜 30g（~200mg 鈉）+ 茶葉蛋 1 顆（~250mg 鈉）+ 食物天然鈉 ~500mg ≈ 總計 1750-1950mg。⚠️ 午晚餐烹調碘鹽嚴格控制在合計 1-1.5g 內'
WHERE title = '09:05 碘鹽 1g';

UPDATE plan_items
SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜（抗性澱粉）。搭配發酵食物（優格、泡菜 ≤30g/日）增強腸道多樣性'
WHERE title = '全天 膳食纖維 35-45g';

-- === Fix 3: Broccoli pre-cut at 09:00 ===

UPDATE products
SET description = '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）。切碎後靜置 40 分鐘可最大化黑芥子酶轉化。⚠️ 備餐時間軸：09:00 起床時立刻切碎放入保鮮盒冷藏（訓練期間完成 40 分鐘靜置），午餐直接取出烹調。或改用於 19:00 晚餐（時間彈性較大，運動後有充足備餐時間）',
    purchase_note = '每週補貨 2 次，每次買 3-4 顆（每顆約 300-400g）。裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。小冰箱用戶不建議買 Costco 冷凍版（454g×4 佔冷凍 3L 直接爆倉）。📋 每日 09:00 起床時先切碎放保鮮盒冷藏，訓練結束後可直接烹調（已完成 40 分鐘蘿蔔硫素轉化）'
WHERE name LIKE '新鮮綠花椰菜%';

-- === Fix 4: Tofu phytic acid vs zinc contradiction ===

UPDATE products
SET description = '優質植物蛋白 + 鈣質來源。100g 板豆腐含鈣 ~150mg + 蛋白質 ~8g。⚠️ 大豆製品含高濃度植酸，午餐食用板豆腐後，腸道殘留植酸會持續螯合微量元素，干擾晚間鋅吸收。補鈣日建議完全依賴零脂希臘優格（乳製品無植酸）作為天然鈣源；若當日午餐食用板豆腐，晚間應放棄鋅補充',
    usage = '每週 2-3 次午餐入菜（100-150g），⚠️ 食用板豆腐當天晚間不補鋅'
WHERE name LIKE '板豆腐%';

UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（無植酸，補鈣日首選）+ 深綠蔬菜。⚠️ 板豆腐含高植酸，食用當天晚間不補鋅（比照吃鈣片邏輯）。食物鈣優先，不足時鈣片隨午餐服用'
WHERE title = '全天 鈣攝取確認（目標 1000mg）';

UPDATE plan_items
SET description = '每日隨晚餐服用鋅 15mg（Picolinate 錠劑 1 錠）。補充品 15mg + 飲食鋅 ~10-15mg = 每日總計 25-30mg（安全低於 UL 40mg/日）。15mg 屬安全生理劑量，不會觸發金屬硫蛋白阻斷銅吸收，銅由堅果/可可粉/全穀類天然提供。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 150g 已含鋅 6-9mg。🚫 補鈣日豁免：當日服用鈣片 500mg 者，晚餐不補鋅（鈣殘餘競爭 DMT1）。🚫 板豆腐日豁免：午餐食用板豆腐者，晚餐不補鋅（大豆植酸殘留螯合鋅，降低吸收率）。單日不補鋅不影響整體鋅營養狀態'
WHERE title = '鋅 15mg 每日補充';
