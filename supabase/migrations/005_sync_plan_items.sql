-- 同步 plan_items 與健康優化計劃頁面的時間表
-- 使用 UPDATE ... WHERE title = '...' 避免影響使用者自訂項目

------------------------------------------------------------
-- 每日項目：更新時間與內容以匹配健康頁面
------------------------------------------------------------

-- 07:00 起床（保持不變，只更新描述）
UPDATE plan_items SET
  description = '戶外光照 10-20 分鐘（不戴太陽眼鏡），觸發皮質醇覺醒反應',
  sort_order = 1
WHERE title = '07:00 起床 & 戶外光照';

-- 07:30 → 07:05 補水
UPDATE plan_items SET
  title = '07:05 補水 & 電解質',
  description = '500ml 室溫水 + 少許碘鹽 + 檸檬汁',
  sort_order = 2
WHERE title = '07:30 補水 & 電解質';

-- 08:00 空腹運動 → 07:15 訓練前營養
UPDATE plan_items SET
  title = '07:15 訓練前營養',
  description = '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈24g 蛋白）',
  category = '飲食',
  sort_order = 3
WHERE title = '08:00 空腹運動';

-- 10:00 高蛋白第一餐 → 09:00 訓練後早餐（加入「訓練後」關鍵字供食譜匹配）
UPDATE plan_items SET
  title = '09:00 訓練後早餐 + 補充品',
  description = '乳清蛋白 ~40g 粉（≈31g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 5000IU、鈣+D3+K2 2-3 錠、維他命 C、葉黃素 20mg',
  sort_order = 5
WHERE title = '10:00 高蛋白第一餐';

-- 肌酸已整合進 09:00 訓練後，停用獨立項目
UPDATE plan_items SET
  is_active = false
WHERE title = '肌酸 Creatine 5g' AND frequency = 'daily';

-- 14:00 NSDR → 14:00 銅
UPDATE plan_items SET
  title = '14:00 銅 2mg',
  description = '與鋅間隔 4hr+（鋅在 18:00 晚餐服用）',
  category = '補充品',
  sort_order = 8
WHERE title = '14:00 NSDR 非睡眠休息 20 分鐘';

-- 18:00 晚餐更新描述（保留「晚餐」關鍵字）
UPDATE plan_items SET
  title = '18:00 晚餐 + 鋅 25mg',
  description = '蛋白質 + 十字花科蔬菜 + 原型碳水。進食順序：纖維→蛋白→碳水。鋅 25mg 隨餐服用',
  sort_order = 9
WHERE title = '18:00 晚餐 + 原型碳水';

-- 18:30 餐後散步（只更新 sort_order）
UPDATE plan_items SET
  sort_order = 10
WHERE title = '18:30 餐後散步 15 分鐘';

-- 20:00 藍光管理（更新描述）
UPDATE plan_items SET
  description = '調暗燈光或佩戴防藍光眼鏡（琥珀色鏡片）',
  sort_order = 11
WHERE title = '20:00 藍光管理';

-- 21:00 熱水澡 → 21:00 睡前營養
UPDATE plan_items SET
  title = '21:00 睡前 希臘優格 + 甘胺酸鎂',
  description = '希臘優格 300g（≈28g 蛋白）+ 甘胺酸鎂 200mg',
  sort_order = 12
WHERE title = '21:00 熱水澡 + 補充鎂';

-- 22:30 → 22:00 入睡
UPDATE plan_items SET
  title = '22:00 準時入睡',
  description = '確保臥室全黑、低溫 18-19°C',
  sort_order = 13
WHERE title = '22:30 準時入睡';

------------------------------------------------------------
-- 新增缺少的每日項目
------------------------------------------------------------

-- 08:30 咖啡 + L-Theanine
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count)
SELECT '08:30 咖啡 + L-Theanine', '咖啡因 200-300mg + L-Theanine 200mg（起床 60-90 分鐘後，13:00 前）', 'daily', '飲食', 4, 1
WHERE NOT EXISTS (SELECT 1 FROM plan_items WHERE title LIKE '08:30 咖啡%' AND is_active = true);

-- 13:00 午餐（加入「午餐」關鍵字供食譜匹配）
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count)
SELECT '13:00 午餐', '蛋白質 40-50g + 十字花科蔬菜', 'daily', '飲食', 7, 1
WHERE NOT EXISTS (SELECT 1 FROM plan_items WHERE title LIKE '13:00 午餐%' AND is_active = true);

------------------------------------------------------------
-- 每週項目：同步訓練頻率
------------------------------------------------------------

-- 肌力訓練 3 次 → 4 次（匹配 health page: 週一/二/四/五）
UPDATE plan_items SET
  title = '肌力訓練 4 次',
  description = 'Upper A（週一）/ Lower A（週二）/ Upper B（週四）/ Lower B（週五）',
  target_count = 4
WHERE title = '肌力訓練 3 次' AND frequency = 'weekly';

-- Zone 2 更新描述與標題
UPDATE plan_items SET
  title = 'Zone 2 有氧 3 次',
  description = '週二晚、週三、週五晚各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機',
  target_count = 3
WHERE title LIKE 'Zone 2 有氧%' AND frequency = 'weekly';

-- VO2 Max 更新描述
UPDATE plan_items SET
  description = 'Peter Attia 4×4 法 — 4 分鐘全力（90-95% HRmax）+ 4 分鐘恢復 × 4 組。週六進行',
  target_count = 1
WHERE title LIKE 'VO2 Max%' AND frequency = 'weekly';
