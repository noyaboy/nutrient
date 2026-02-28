------------------------------------------------------------
-- Migration 066: Fix 4 critical physiological conflicts
-- 1. Oats β-glucan conflict with pre-training gastric load & lunch calcium
-- 2. Whey protein 70g daily vs actual 30g usage → kidney load
-- 3. Caffeine 200-300mg + half-life residue → SWS sleep damage
-- 4. Iodine salt Taiwan standard 20-33mcg/g vs 50-82mcg assumption
------------------------------------------------------------

-- ===== ISSUE 1: Oats scheduling (train pre vs rest day) =====

-- Update plan_item: 15:30 afternoon snack to mention oats option
UPDATE plan_items
SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）。⚠️ 訓練日改用此組合。休息日可改為燕麥 80g + 藍莓 50g（避開訓練前高粘度膠狀纖維傷胃，避開午餐鈣吸收干擾）。非乳製植物蛋白，下午點心時段分散蛋白質攝取壓力。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g，消化負擔輕，不影響 19:00 晚餐食慾'
WHERE title = '15:30 下午點心';

-- Update product: Oats usage (separate rest day vs training day)
UPDATE products
SET usage = '休息日早/午餐每日 1 份（80g）；訓練日改置於 15:30 下午點心搭配豌豆蛋白 + 藍莓'
WHERE name = '有機燕麥（桂格有機大燕麥片 935g×2）';

-- ===== ISSUE 2: Whey protein 70g vs 30g actual usage =====

-- Update whey product purchase_note: correct daily consumption from 70g to 30g
UPDATE products
SET purchase_note = 'Costco 線上可訂。每日 ~30g（訓練前 1 份），2kg 約 2 個月。無調味可搭配咖啡、黑芝麻粉等調味。'
WHERE name = 'Tryall 無調味分離乳清蛋白 2kg';

-- ===== ISSUE 3: Caffeine timing & dose (reduce & move earlier) =====

-- Update plan_item: 11:15 Coffee timing (move from 90-135min → 60-90min) & dose (200-300mg → 150-200mg)
UPDATE plan_items
SET description = '起床後 60-90 分鐘再喝。咖啡因 150-200mg + L-Theanine 200mg（1:1 A 級 nootropic 組合，保護睡眠品質）。15:00 後禁止咖啡因。✅ 無論當天是否飲用綠茶，喝咖啡就必須同步服用 L-Theanine'
WHERE title = '11:15 咖啡 + L-Theanine';

-- Update plan_item: 14:00 green tea (change to low-caffeine version)
UPDATE plan_items
SET description = '午餐後 2hr+ 再飲用（~14:00），高脂高蛋白午餐胃排空需 2-4hr，1hr 仍會螯合鐵鋅鈣。改用低咖啡因綠茶（白毫銀針或老白毫），配合 L-theanine 天然組合促進專注，同時避免晚間睡眠干擾。15:00 前喝完（咖啡因 cutoff）。綠茶天然 L-Theanine（40-90mg）為額外放鬆紅利，不影響早晨 L-Theanine 補劑的服用'
WHERE title = '14:00 綠茶 EGCG 2-3 杯';

-- Update product: Coffee bean timing & dose
UPDATE products
SET description = '起床 60-90 分鐘後飲用，咖啡因 150-200mg（減量以保護睡眠）。多酚抗氧化、增強專注力',
    usage = '每日 1-2 杯，09:30-10:15 之間（起床後 60-90 分鐘）'
WHERE name = '咖啡豆 / 研磨咖啡';

-- Update product: Green tea (specify low-caffeine version)
UPDATE products
SET description = '低咖啡因白毫銀針或老白毫。EGCG + L-theanine 天然組合促進專注。多酚抗氧化。不含茶多酚氧化產物，溫和不傷腸胃',
    usage = '每日午餐後 1-2 杯低咖啡因版本（14:00-15:00）'
WHERE name = '綠茶（茶葉/茶包）';

-- ===== ISSUE 4: Iodine salt standard (Taiwan 20-33mcg/g) & seaweed frequency =====

-- Update plan_item: 09:05 Iodized salt (correct iodine amount from 50-82 → 20-33mcg)
UPDATE plan_items
SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 全日鈉預算（WHO <2400mg/日）：晨間 1g（~400mg 鈉）+ 午晚餐烹調碘鹽合計 1-1.5g（~400-600mg 鈉）+ 泡菜 30g（~200mg 鈉）+ 茶葉蛋 1 顆（~250mg 鈉）+ 食物天然鈉 ~500mg ≈ 總計 1750-1950mg。⚠️ 午晚餐烹調碘鹽嚴格控制在合計 1-1.5g 內。⚠️ 全日碘鹽僅提供 ~20-33mcg 碘（台灣食鹽法規標準），必須搭配每日紫菜/海苔 1-2 片（另含約 15-85mcg）確保達 RDA 150mcg'
WHERE title = '09:05 碘鹽 1g';

-- Update product: Nori/Seaweed frequency (from 2-3 times/week → daily)
UPDATE products
SET usage = '每日隨餐食用 1-2 片（配飯或入湯），補足碘攝取至 RDA 150mcg'
WHERE name = '紫菜 / 海苔';

-- Update product: Nori/Seaweed purchase_note (change frequency)
UPDATE products
SET purchase_note = '每日隨餐攝取 1-2 片（乾貨耐儲存，每次 1-2g 乾重即可）。紫菜/海苔每片含 ~12-43mcg 碘。搭配晨間 1g 碘鹽（20-33mcg）+ 日常海苔，總碘攝入可達 RDA 150mcg。⚠️ 不購買昆布：碘含量極高且變異大（1-2g = 300-6000mcg），與精確碘鹽控制策略衝突。常溫密封保存，開封後放密封袋/罐。'
WHERE name = '紫菜 / 海苔';

------------------------------------------------------------
-- Consolidated notes for all fixes:
-- 1. Oats: 訓練前高粘度β-葡聚醣形成膠狀延遲胃排空(同地瓜風險)，午餐植酸與鈣競爭吸收
--    → 移至休息日或訓練日下午點心
-- 2. Whey: 70g daily > 160g total protein > 1.7-1.8g/kg safe range → kidney BUN↑
--    → 購買筆記改為 30g/日實際用量
-- 3. Caffeine: 11:15(250mg) + 14:00(~80mg) → 23:00 still 70-90mg → SWS damage
--    → 改 60-90min, 150-200mg + 低咖啡因綠茶版本
-- 4. Iodine: 1g salt = 20-33mcg (Taiwan std), NOT 50-82mcg → daily seaweed补足
--    → 紫菜每週 2-3 次 → 每日 1-2 片, 晨鹽 50-82mcg claim → 20-33mcg實際
------------------------------------------------------------
