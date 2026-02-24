------------------------------------------------------------
-- 1. Post-workout: change 鈣+D3+K2 to D3+K2 (food-first calcium)
------------------------------------------------------------
UPDATE plan_items
SET description = '乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 2000IU（5+2）、D3+K2（不額外補鈣片，鈣從食物攝取）、維他命 C、葉黃素 20mg',
    updated_at = now()
WHERE title = '09:00 訓練後早餐 + 補充品';

------------------------------------------------------------
-- 2. Lunch: add low FODMAP alternative
------------------------------------------------------------
UPDATE plan_items
SET description = '蛋白質 40-50g + 十字花科蔬菜（脹氣時換菠菜/櫛瓜等低FODMAP，蛋白質降至30g）',
    updated_at = now()
WHERE title = '13:00 午餐';

------------------------------------------------------------
-- 3. Dinner: add low FODMAP + social exemption
------------------------------------------------------------
UPDATE plan_items
SET description = '蛋白質 + 十字花科蔬菜（脹氣換低FODMAP）+ 原型碳水。進食順序：纖維→蛋白→碳水。鋅 25mg 隨餐（5+2）。社交聚餐可彈性延後',
    updated_at = now()
WHERE title = '18:00 晚餐 + 鋅 25mg';

------------------------------------------------------------
-- 4. Bedtime: add monitoring indicators
------------------------------------------------------------
UPDATE plan_items
SET description = '希臘優格 300g（≈28g 蛋白）+ 甘胺酸鎂 200mg。若隔日異常昏沉或夜間腸胃過快→暫停甘胺酸鎂或優格減半',
    updated_at = now()
WHERE title = '21:00 睡前 希臘優格 + 甘胺酸鎂';
