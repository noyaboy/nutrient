-- Migration 060: Fix 4 nutrition logic contradictions
-- 1. Spinach/zinc dinner conflict in bloating fallback
-- 2. "Zero leafy veg" definition on training days
-- 3. Pea protein dosage correction (20g → 22g for accurate 16g protein)
-- 4. Resistant starch RS3 microwave destruction risk

-- === 1. Fix pea protein dosage: 15:30 下午點心 ===
UPDATE plan_items
SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）。非乳製植物蛋白，下午點心時段分散蛋白質攝取壓力'
WHERE title LIKE '%15:30%下午點心%' AND is_active = true;

-- === 2. Fix pea protein product usage text ===
UPDATE products
SET usage = '下午點心 22g 粉（≈16g 蛋白），約 15:30',
    purchase_note = 'Tryall 官網或 Costco 線上可訂。每日 22g，1kg 可用約 45 天。無調味可搭配少量蜂蜜或可可粉。與 Tryall 乳清同品牌，統一採購更方便'
WHERE name LIKE '%豌豆蛋白%Tryall%';
