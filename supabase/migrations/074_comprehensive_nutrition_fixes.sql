-- Migration 074: Comprehensive Nutrition Fixes (2026-03-01)
-- Covers: D3 2000IU (2 capsules), Iodine 3-4 nori, Calcium mandatory 300g yogurt + regular tablet,
--         Magnesium 200mg glycinate, Omega-3 salmon day reduction, Vitamin C backup reactivation

------------------------------------------------------------
-- 1. D3: Update to 2 capsules (2000 IU) — aligns with 070 intent but uses existing 1000IU product
------------------------------------------------------------
UPDATE plan_items
SET description = '蛋白質 35-40g（正餐食物，單餐建議 ≤45g）+ 肌酸 5g + 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆（鮭魚日減為 2 顆）、D3 2000IU（2 顆）、K2、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 200mg、B群 1 顆（活化型態，隨正餐油脂+蛋白質完整食物基質服用，吸收率最佳）'
WHERE title = '12:00 午餐 + 訓練後補充品'
AND frequency = 'daily'
AND category = '飲食';

-- Update D3 product to 2 capsules/day
UPDATE products
SET description = '每日服用 2 顆（2000 IU）。Endocrine Society 建議 1500-2000 IU/日，目標血清 25(OH)D 40-60 ng/mL。血檢達標+每日晨光曝曬→可進一步減量。✅ 1000IU 軟凝膠，每日 2 顆',
    usage = '每日 2 顆（2000 IU）隨訓練後餐（需搭配油脂吸收）',
    purchase_note = 'iHerb 直送。✅ 每日 2 顆（2000IU），無需切割。180 顆可用 3 個月。'
WHERE name LIKE '維他命 D3 1000IU%'
AND category = 'iherb_supplement';

------------------------------------------------------------
-- 2. Iodine: Nori/seaweed 1-2 → 3-4 sheets daily
------------------------------------------------------------
UPDATE products
SET usage = '每日隨餐食用 3-4 片（配飯或入湯），確保碘攝取達 RDA 150mcg',
    purchase_note = '每日隨餐攝取 3-4 片（乾貨耐儲存，每次 2-4g 乾重）。紫菜/海苔每片含 ~12-43mcg 碘，3-4 片 ≈ 36-172mcg。搭配晨間 1g 碘鹽（20-33mcg），總碘攝入可穩定達 RDA 150mcg。⚠️ 不購買昆布：碘含量極高且變異大（1-2g = 300-6000mcg），與精確碘鹽控制策略衝突。常溫密封保存，開封後放密封袋/罐。'
WHERE name = '紫菜 / 海苔';

-- Update iodine salt plan item
UPDATE plan_items
SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 全日鈉預算（WHO <2400mg/日）：晨間 1g（~400mg 鈉）+ 午晚餐烹調碘鹽合計 1-1.5g（~400-600mg 鈉）+ 泡菜 30g（~200mg 鈉）+ 茶葉蛋 1 顆（~250mg 鈉）+ 食物天然鈉 ~500mg ≈ 總計 1750-1950mg。⚠️ 午晚餐烹調碘鹽嚴格控制在合計 1-1.5g 內。⚠️ 全日碘鹽僅提供 ~20-33mcg 碘（台灣食鹽法規標準），必須搭配每日紫菜/海苔 3-4 片（另含約 36-172mcg）確保穩定達 RDA 150mcg'
WHERE title = '09:05 碘鹽 1g'
AND frequency = 'daily';

------------------------------------------------------------
-- 3. Calcium: Yogurt 300g mandatory + tablet on non-tofu days
------------------------------------------------------------
UPDATE products
SET usage = '每日 300g（必須）',
    purchase_note = '賣場限定，無法線上訂。每日 300g（必須），907g×2 約 6 天，每週補貨。兩罐圓筒無法改形狀，緊靠冷藏室最上層深處放置（最低溫區），前方空間留給泡菜疊放。'
WHERE name = '希臘優格（Kirkland 零脂 907g×2）';

UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 300g（必須，~280mg 鈣）+ 深綠蔬菜 + 板豆腐（100g ~150mg 鈣）。非板豆腐日鈣片 1 錠隨午餐服用（+500mg）。午餐板豆腐的植酸在 7hr 後已進入大腸，不影響 19:00 鋅吸收。⚠️ 優格 300g + 板豆腐日 ≈ 430-580mg，仍需搭配深綠蔬菜（~150-200mg）。非板豆腐日：優格 300mg + 鈣片 500mg + 蔬菜 150mg ≈ 930mg'
WHERE title = '全天 鈣攝取確認（目標 1000mg）'
AND frequency = 'daily'
AND category = '飲食';

UPDATE products
SET description = '碳酸鈣 + 檸檬酸鈣雙鈣源。非板豆腐日常規使用（非僅備用）。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加後總計 2150IU 仍在安全範圍。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）',
    usage = '非板豆腐日隨午餐服用 1 錠（+500mg 鈣）。日常 K2 已改用獨立 K2 MK-7 產品'
WHERE name = '鈣片備用（Nature Made Ca+D3+K2 250 錠）';

------------------------------------------------------------
-- 4. Magnesium: Glycinate 100mg → 200mg (2 tablets)
------------------------------------------------------------
UPDATE plan_items
SET description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 200mg（2 錠）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。洗完熱水澡後立即服用效果最佳 — 熱水澡與甘胺酸皆促進周邊血管擴張降低核心體溫，兩者協同加速入睡'
WHERE title = '22:30 睡前補充品'
AND frequency = 'daily'
AND category = '補充品';

UPDATE products
SET usage = '睡前 2 錠（200mg）',
    purchase_note = 'iHerb 直送。180 錠可用 3 個月。產品標示 serving size 為 2 錠 200mg，本計畫每日 2 錠（200mg 元素鎂）。'
WHERE name = '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）';

------------------------------------------------------------
-- 5. Omega-3: Reduce to 2 capsules on salmon days
------------------------------------------------------------
UPDATE products
SET usage = '每日隨餐 3 顆（EPA+DHA 共 2100mg）。⚠️ 鮭魚日減為 2 顆（1400mg + 鮭魚 ~1200mg ≈ 2600mg，避免超過 3000mg）'
WHERE name = '緩釋魚油（Kirkland 新型緩釋 Omega-3）';

------------------------------------------------------------
-- 6. Vitamin C: Reactivate as lunch-only backup
------------------------------------------------------------
UPDATE products
SET description = '午餐備用 Vit C。僅在未服用膠原蛋白肽的日子隨午餐服用 1 錠（500mg）。⚠️ 嚴禁晚餐服用（夜間高劑量 Vit C 代謝為草酸有腎結石風險）。膠原蛋白肽日已提供 ~160mg Vit C，無需額外補充',
    usage = '備用：未服用膠原蛋白肽日隨午餐 1 錠（500mg）'
WHERE name = '維他命 C（NOW Foods 500mg × 100 錠）';
