------------------------------------------------------------
-- 小冰箱後勤優化（冷凍 7L / 冷藏 65L）
-- 核心策略：冷凍庫只放鮭魚，其餘全轉冷藏
------------------------------------------------------------

-- 鮭魚：冷凍庫絕對優先權（2.5L）
UPDATE products SET
  purchase_note = '冷凍庫主力，每 2 週線上訂 1 包（冷凍配送）。買回立即分裝 5-6 份 zip bag（佔冷凍約 2.5L），每 2-3 天取 1 份移至冷藏解凍。冷凍庫僅 7L，鮭魚是唯一需要長期冷凍的高價值食材。',
  updated_at = now()
WHERE name LIKE '%鮭魚%';

-- 綠花椰菜：取消冷凍版，改買新鮮
UPDATE products SET
  purchase_note = '小冰箱請勿買冷凍版（佔冷凍 3L 直接爆倉）。改在傳統市場或超市買新鮮綠花椰菜，每次 2-3 顆，切成小朵後靜置 40 分鐘（最大化蘿蔔硫素），裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。每週補貨 1-2 次。',
  updated_at = now()
WHERE name LIKE '%綠花椰菜%';

-- 雞胸肉：煮熟冷藏為主，極少量冷凍
UPDATE products SET
  purchase_note = '線上可訂（冷凍配送）。買回當天全部煮熟，分裝長方形保鮮盒：冷藏 4-5 天份（放最上層靠冷凍處）+ 極少量壓扁冷凍（最多 1-1.5L）。或改每週 2 次在全聯/超市買冷藏鮮雞胸，隨買隨煮，完全不佔冷凍庫。',
  updated_at = now()
WHERE name LIKE '%雞胸肉%';

-- 雞蛋：抽屜式蛋盒取代紙托
UPDATE products SET
  purchase_note = '賣場限定，無法線上訂。每日 3-4 顆，30 入約 7-10 天。絕對不要把 30 入紙托直接塞冰箱——買一個雙層抽屜式雞蛋盒（寬約 15cm），貼齊冷藏最底層側邊，上方平面還能繼續疊放保鮮盒。',
  updated_at = now()
WHERE name LIKE '%雞蛋%';

-- 堅果：方形密封盒取代圓罐
UPDATE products SET
  purchase_note = '線上可訂（常溫配送）。每日 30g，1.13kg 約 5-6 週。原廠大圓罐浪費空間——開封後分裝 1-2 週份量到方形密封盒或夾鏈袋塞冷藏，剩餘留原罐常溫陰涼處。含花生油，過敏者注意。',
  updated_at = now()
WHERE name LIKE '%堅果%';

-- 希臘優格：靠深處放置
UPDATE products SET
  purchase_note = '賣場限定，無法線上訂。每日 200-300g，907g×2 約 6-9 天，每週補貨。兩罐圓筒無法改形狀，緊靠冷藏室最上層深處放置（最低溫區），前方空間留給泡菜疊放。',
  updated_at = now()
WHERE name LIKE '%希臘優格%';

-- 泡菜：見縫插針疊放
UPDATE products SET
  purchase_note = '賣場限定，無法線上訂。每日 50-100g，120g×6 約 7-14 天，每 1-2 週補貨。小圓罐適合見縫插針：兩兩疊放在優格罐前方，或利用層板間的零碎高度。',
  updated_at = now()
WHERE name LIKE '%泡菜%';

-- 菠菜：紙巾吸濕保鮮法
UPDATE products SET
  purchase_note = '絕對不買冷凍版（500g×6 佔冷凍室 70%）。每週在傳統市場或 Costco 蔬果區買 300-400g 新鮮菠菜，放入大保鮮袋、裡面墊一張廚房紙巾吸濕，平放於保鮮抽屜底部，3-5 天內用完。',
  updated_at = now()
WHERE name LIKE '%菠菜%';

-- 檸檬：矽膠套保鮮
UPDATE products SET
  purchase_note = '賣場蔬果區散裝。選外皮鮮黃有光澤。整顆放保鮮抽屜，切半後用矽膠套包住切面冷藏。每日半顆，約可用 3-4 週。',
  updated_at = now()
WHERE name LIKE '%檸檬%';
