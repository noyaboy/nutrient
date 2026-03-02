-- 1. Move VO2 Max from Saturday to Wednesday, Zone 2 from 3x to 2x (Sat/Sun only)
UPDATE plan_items
SET description = '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘。每次 60-90 分鐘'
WHERE title = '08:00 運動';

UPDATE plan_items
SET title = 'Zone 2 有氧 2 次',
    description = '週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機',
    target_count = 2
WHERE title LIKE 'Zone 2 有氧%';

UPDATE plan_items
SET description = 'Peter Attia 4×4 法 — 4 分鐘全力（90-95% HRmax）+ 4 分鐘恢復 × 4 組。週三進行'
WHERE title LIKE 'VO2 Max%';

-- 2. Dinner: switch from cruciferous to low-FODMAP veggies by default
UPDATE plan_items
SET title = '18:00 晚餐 + 低 FODMAP 蔬菜',
    description = '蛋白質 30-40g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。隨餐服用鋅 25mg（與銅間隔 4hr+）。固體食物睡前 3-4hr 結束'
WHERE title LIKE '18:00 晚餐%';

-- 3. Casein halved (64g→32g) and moved to 20:30 to reduce nighttime digestive load
UPDATE plan_items
SET title = '20:30 睡前：熱水澡 + 酪蛋白 + 補充品',
    description = '熱水澡 40-42°C 10-15 分鐘（睡前 60-90 分鐘）。酪蛋白 ~32g 粉（≈25g 蛋白）+ 甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 + Ashwagandha 600mg（8 週用 / 4 週停，停用期改服紅景天 500mg。第 6-8 週留意情緒冷漠或早晨無力）'
WHERE title LIKE '%睡前%酪蛋白%';

-- 4. Lunch protein 40-50g → 30-40g (aligned with 2.0g/kg target)
UPDATE plan_items
SET description = REPLACE(description, '蛋白質 40-50g', '蛋白質 30-40g')
WHERE title LIKE '13:00 午餐%';

-- 5. Update water schedule reference (21:00 → 20:30)
UPDATE plan_items
SET description = REPLACE(description, '21:00 酪蛋白沖泡', '20:30 酪蛋白沖泡')
WHERE title LIKE '%飲水%' AND description LIKE '%酪蛋白沖泡%';
