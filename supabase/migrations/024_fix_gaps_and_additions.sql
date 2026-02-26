------------------------------------------------------------
-- Fix: B群→morning, standalone K2, blueberries, 泡菜 reminder, 電子鍋
------------------------------------------------------------

-- 1. B群 moved from lunch to morning (plan_items)
UPDATE plan_items
SET description = '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（水溶性，早晨隨餐提供全天能量代謝）'
WHERE title = '09:15 訓練前營養';

UPDATE plan_items
SET description = '蛋白質 45-50g（正餐食物）+ 肌酸 5g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日）。脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g。魚油 3 顆、D3 2000IU（5+2）、K2 MK-7 100mcg（引導鈣至骨骼，使用獨立K2而非鈣片複方）、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 100-200mg（脂溶性，與魚油同服提升吸收）、銅 2mg（隨午餐正餐服用，利用食物體積緩衝腸胃刺激）。每日脂肪目標 80-90g（22-25% 總熱量）。不再額外沖乳清蛋白（正餐蛋白質已足夠）'
WHERE title = '12:00 午餐 + 訓練後補充品';

-- 2. 膳食纖維 plan_item: explicit daily泡菜/優格 reminder
UPDATE plan_items
SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜。供腸道菌產生丁酸，維護腸腦軸。每日至少 1 份發酵食物：希臘優格 200-300g（午餐/點心）+ 泡菜 50-100g（晚餐隨餐）。雙菌源增強腸道多樣性'
WHERE title = '全天 膳食纖維 35-45g';

-- 3. Update Ca+D3+K2 product: clarify as calcium-only backup
UPDATE products
SET name = '鈣片備用（Nature Made Ca+D3+K2 250 錠）',
    description = '碳酸鈣 + 檸檬酸鈣雙鈣源。純粹作為鈣質備用品。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加風險低但需留意。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）。鈣質食物優先策略：優先從希臘優格等原型食物攝取鈣',
    usage = '備用品：僅在當日飲食鈣攝取確認嚴重不足時才服用 1 錠。日常 K2 已改用獨立 K2 MK-7 產品',
    purchase_note = '線上可訂（常溫配送）。純鈣備用品（鈣從食物攝取為主），250 錠可用非常久。K2 已獨立購買（NOW Foods MK-7），本品 K2 含量不足日常需求。開封後建議冰箱保存。'
WHERE name = '鈣 + D3 + K2（Nature Made 250 錠）';

-- 4. Update B群 product usage to morning
UPDATE products
SET usage = '每日 1 顆隨早餐（訓練前營養餐）'
WHERE name LIKE 'B群 B-50%';

-- 5. Shift iherb_supplement sort_orders >= 28 to make space for K2 MK-7
UPDATE products SET sort_order = sort_order + 1
WHERE category = 'iherb_supplement' AND sort_order >= 28;

-- 6. Insert standalone K2 MK-7
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '維他命 K2 MK-7（NOW Foods 100mcg × 120 顆）',
  '獨立 K2 MK-7（納豆來源），引導鈣質沉積至骨骼而非血管壁。與 D3 協同作用，防止動脈鈣化。取代鈣片複方中不足量的 K2',
  '每日 1 顆隨午餐（與 D3、魚油同服，脂溶性需油脂）',
  'NT$450 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-mk-7-vitamin-k-2-100-mcg-120-veg-capsules/40283',
  'iHerb', 'iherb_supplement', 'NOW Foods', NULL,
  '{"form":"素食膠囊","count":"120顆","source":"MK-7（納豆來源）"}'::jsonb,
  '{"serving_size":"1顆","vitamin_k2":"100mcg（MK-7型）"}'::jsonb,
  'iHerb 直送。每日 1 顆，120 顆可用 4 個月。MK-7 型半衰期長（~72hr），每日 1 顆即可維持穩定血中濃度。取代 Nature Made 鈣片複方中僅 10mcg 的不足 K2。',
  28
);

-- 7. Insert 藍莓 (sort_order 24 is a gap in costco_food)
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '藍莓 / 冷凍莓果',
  '抗氧化花青素含量最高的水果之一。搭配燕麥碗、希臘優格食用。改善認知功能與心血管健康',
  '每日 50-100g（燕麥碗或優格搭配）',
  '新鮮 ~NT$399/510g 或 冷凍 ~NT$329/600g',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, '美國/加拿大/智利',
  '{"storage":"新鮮冷藏3-5天，冷凍版-18°C長期保存"}'::jsonb,
  '{"anthocyanins":"花青素豐富","fiber":"約2.4g/100g","vitamin_c":"約10mg/100g"}'::jsonb,
  '新鮮藍莓在 Costco 蔬果區（季節性）。小冰箱建議買新鮮版每週 1 盒（510g），放保鮮抽屜 3-5 天用完。若買冷凍版（Nature''s Touch 600g），僅佔冷凍約 0.5L 可接受。每日取 50-100g 加入燕麥碗或優格。',
  24
);

-- 8. Insert 電子鍋 to equipment
INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '電子鍋 / 多功能電鍋',
  '煮飯、蒸地瓜/馬鈴薯、燉雞胸肉、煮燕麥粥。一鍋多用是小廚房核心設備。選 3-6 人份（1.0-1.8L 內鍋）適合一人備餐',
  '每日使用（煮飯、蒸菜、燉肉）',
  'NT$1,500-4,000',
  'https://www.costco.com.tw/TVs-Electronics/Home-Appliances/Rice-Cookers/c/90118',
  'Costco/momo/蝦皮', 'equipment',
  '一次性購買。推薦：大同電鍋 6 人份（~$1,800，經典耐用）或象印微電腦電子鍋 3 人份（~$2,500-4,000，煮飯品質佳）。選有預約定時功能可前晚設定早上煮好。Costco 線上有多款可比較。',
  40
);
