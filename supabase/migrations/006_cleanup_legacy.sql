-- 清除與 Health 頁面不一致的 legacy plan_items（原始 Huberman 協議殘留）

-- 穩定性訓練：不在目前的 Upper/Lower 肌力訓練計劃中
UPDATE plan_items SET is_active = false
WHERE title LIKE '穩定性訓練%';

-- 每週回顧與調整：meta-task，不屬於健康協議
UPDATE plan_items SET is_active = false
WHERE title = '每週回顧與調整';
