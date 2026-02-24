------------------------------------------------------------
-- Move Zone 2 to Wed/Sat/Sun (non-lifting days)
------------------------------------------------------------
UPDATE plan_items
SET description = '週三、週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機',
    updated_at = now()
WHERE title = 'Zone 2 有氧 3 次';

------------------------------------------------------------
-- Add 5+2 supplement holiday to D3/supplements description
------------------------------------------------------------
UPDATE plan_items
SET description = '乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 2000IU（5+2 週末休息）、鈣+D3+K2 1 錠（5+2）、維他命 C、葉黃素 20mg',
    updated_at = now()
WHERE title = '09:00 訓練後早餐 + 補充品';

------------------------------------------------------------
-- Add 5+2 to copper description
------------------------------------------------------------
UPDATE plan_items
SET description = '與鋅間隔 4hr+（鋅在 18:00 晚餐服用）。5+2：週一至五服用，週末休息',
    updated_at = now()
WHERE title = '14:00 銅 2mg';

------------------------------------------------------------
-- Add 5+2 to zinc/dinner description
------------------------------------------------------------
UPDATE plan_items
SET description = '蛋白質 + 十字花科蔬菜 + 原型碳水。進食順序：纖維→蛋白→碳水。鋅 25mg 隨餐服用（5+2：週一至五，週末休息）',
    updated_at = now()
WHERE title = '18:00 晚餐 + 鋅 25mg';
