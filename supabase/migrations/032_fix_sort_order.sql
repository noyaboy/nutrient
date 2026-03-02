------------------------------------------------------------
-- 032: 修正 sort_order 確保首頁按時間順序顯示
-- 下午 group: NSDR(15:00) → 鈣(14:00-15:00) → 銅(15:00-16:00) → 豌豆蛋白(15:30) → 社交(17:00)
-- 晚間 group: 晚餐(19:00) → 散步(19:30) → 睡前補充品(21:30) → 藍光管理(22:00) → 熱水澡(22:00-23:00)
------------------------------------------------------------

-- === 下午 group ===
-- 14:00-15:00 鈣攝取確認 — 全天項目不在下午 group，不需改

-- 15:00 NSDR 排第一
UPDATE plan_items SET sort_order = 9
WHERE title LIKE '15:00 NSDR%';

-- 15:00-16:00 銅排第二
UPDATE plan_items SET sort_order = 10
WHERE title LIKE '15:00-16:00 銅%';

-- 15:30 下午點心排第三
UPDATE plan_items SET sort_order = 11
WHERE title LIKE '15:30 下午點心%';

-- 17:00 社交排第四
UPDATE plan_items SET sort_order = 12
WHERE title LIKE '17:00 高質量社交%';

-- === 晚間 group ===
-- 19:00 晚餐
UPDATE plan_items SET sort_order = 13
WHERE title LIKE '19:00 晚餐%';

-- 19:30 餐後散步
UPDATE plan_items SET sort_order = 14
WHERE title LIKE '19:30 餐後散步%';

-- 21:30-22:00 睡前補充品
UPDATE plan_items SET sort_order = 15
WHERE title LIKE '21:30-22:00 睡前%';

-- 22:00 藍光管理
UPDATE plan_items SET sort_order = 16
WHERE title LIKE '22:00 藍光管理%';

-- 22:00-23:00 熱水澡
UPDATE plan_items SET sort_order = 17
WHERE title LIKE '22:00-23:00 熱水澡%';

-- 23:30 Cyclic Sighing
UPDATE plan_items SET sort_order = 18
WHERE title LIKE '23:30 Cyclic%';

-- 23:50 口腔衛生
UPDATE plan_items SET sort_order = 19
WHERE title LIKE '23:50 口腔衛生%';

-- 00:00 準時入睡
UPDATE plan_items SET sort_order = 20
WHERE title LIKE '00:00 準時入睡%';

-- === 全天 group（往後推）===
UPDATE plan_items SET sort_order = 21
WHERE title LIKE '全天 蛋白質 146g%';

UPDATE plan_items SET sort_order = 22
WHERE title LIKE '全天 膳食纖維%';

UPDATE plan_items SET sort_order = 23
WHERE title LIKE '全天 每 45 分鐘%';

UPDATE plan_items SET sort_order = 24
WHERE title LIKE '全天 碳水循環%';

UPDATE plan_items SET sort_order = 25
WHERE title LIKE '全天 鈣攝取確認%';

UPDATE plan_items SET sort_order = 26
WHERE title LIKE '全天 飲水%';
