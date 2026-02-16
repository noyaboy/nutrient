-- 新增 target_count 欄位（每週目標次數）
ALTER TABLE plan_items ADD COLUMN IF NOT EXISTS target_count INTEGER DEFAULT 1;

-- 更新現有 weekly 項目的 target_count
UPDATE plan_items SET target_count = 3 WHERE frequency = 'weekly' AND title LIKE '%Zone 2%';
UPDATE plan_items SET target_count = 4 WHERE frequency = 'weekly' AND title LIKE '%肌力訓練%';
UPDATE plan_items SET target_count = 1 WHERE frequency = 'weekly' AND title LIKE '%VO2 Max%';
UPDATE plan_items SET target_count = 3 WHERE frequency = 'weekly' AND title LIKE '%學習新技能%';
UPDATE plan_items SET target_count = 1 WHERE frequency = 'weekly' AND title LIKE '%每週回顧%';
UPDATE plan_items SET target_count = 1 WHERE frequency = 'weekly' AND title LIKE '%健康檢測%';

-- 穩定性訓練和碳水循環本質上是每日習慣（target=7），改為 daily frequency
UPDATE plan_items SET frequency = 'daily', sort_order = 22 WHERE title LIKE '%穩定性訓練%' AND frequency = 'weekly';
UPDATE plan_items SET frequency = 'daily', sort_order = 23 WHERE title LIKE '%碳水循環%' AND frequency = 'weekly';

-- 健康檢測是半年一次，設 target_count=0 表示不追蹤每週完成率
UPDATE plan_items SET target_count = 0, description = '每半年一次全面健康檢查（血液、荷爾蒙、代謝指標）。此為半年提醒，非每週目標' WHERE title LIKE '%健康檢測%';

-- VO2 Max 修正描述：避免與 Zone 2 同日，強度為 90-95% HRmax
UPDATE plan_items SET description = '4 分鐘高強度（90-95% HRmax）+ 4 分鐘低強度恢復，重複 4 組。建議安排在週三（避免與 Zone 2 同日）' WHERE title LIKE '%VO2 Max%';

-- Zone 2 修正描述：明確安排在非重訓日
UPDATE plan_items SET description = '非重訓日（週六、週日）進行 Zone 2 有氧 60 分鐘+。週三安排 VO2 Max 間歇' WHERE title LIKE '%Zone 2%';
