------------------------------------------------------------
-- 1. 訓練後：update description to D3+K2 only (food-first calcium)
--    Migration 004 failed because WHERE title didn't match live DB
------------------------------------------------------------
UPDATE plan_items
SET description = '乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 2000IU（5+2）、D3+K2（不額外補鈣片，鈣從食物攝取）、維他命 C、葉黃素 20mg',
    updated_at = now()
WHERE title = '09:00 訓練後營養 + 補充品';

------------------------------------------------------------
-- 2. Fix afternoon sort_order (currently non-chronological)
--    散步(18:30)=10, 社交(17:00)=11, 晚餐(18:00)=12
--    → 社交=10, 晚餐=11, 散步=12
------------------------------------------------------------
UPDATE plan_items
SET sort_order = 10, updated_at = now()
WHERE title = '17:00 高質量社交對話';

UPDATE plan_items
SET sort_order = 11, updated_at = now()
WHERE title = '18:00 晚餐 + 十字花科蔬菜';

UPDATE plan_items
SET sort_order = 12, updated_at = now()
WHERE title = '18:30 餐後散步 15 分鐘';
