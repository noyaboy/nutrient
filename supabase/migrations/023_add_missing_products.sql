------------------------------------------------------------
-- Add missing products: 櫛瓜 + low-fiber carbs + skincare
------------------------------------------------------------

-- Step 1: Shift costco_food sort_orders to make space for櫛瓜
UPDATE products SET sort_order = sort_order + 1
WHERE category = 'costco_food' AND sort_order >= 16;

-- Step 2: Insert櫛瓜 at sort_order 16
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '櫛瓜（美國/加拿大）',
  '低FODMAP蔬菜，腸胃溫和。富含鉀、維他命C、膳食纖維。替代綠花椰菜避免脹氣',
  '每日 100-150g 入菜（晚餐優先）',
  '~NT$100-150 / 300-500g',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, '美國/加拿大',
  '{}'::jsonb,
  '{}'::jsonb,
  '賣場蔬果區散裝。選外表光滑無軟爛。每週在 Costco 或傳統市場買 300-500g，裝入大保鮮袋平放保鮮抽屜，5-7 天內用完。低FODMAP首選，腸胃敏感者必備。',
  16
);

-- Step 3: Insert low-fiber carbs (白米/義大利麵/馬鈴薯)
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('有機白米（銀川一等白米 3kg）',
   '花蓮產有機白米。低纖維碳水，訓練日30-40%替代糙米以減輕腸胃負擔。易消化，GI較高適合訓練後補充',
   '訓練日適量（目標總碳水30-40%來自低纖維）',
   'NT$320-380 / 3kg',
   'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/c/hero_rice',
   'Costco', 'costco_food', '銀川', '台灣（花蓮）',
   '{"ingredients":"有機白米","weight":"3公斤"}'::jsonb,
   '{"fiber":"低纖維（<1g/100g）","gi":"中高GI（約73）"}'::jsonb,
   '線上可訂（常溫配送）。與糙米混合購買：糙米為基礎，白米作為訓練日高碳日補充。3kg約3-6週（取決於訓練頻率）。開封後密封避免蟲害，夏天建議冷藏。',
   25),

  ('義大利麵（Garofalo 500g×6）',
   '義大利進口杜蘭小麥義大利麵。低纖維碳水，訓練日30-40%替代全麥麵食。煮熟後冷卻可產生抗性澱粉',
   '訓練日適量（作為低纖維碳水選項）',
   'NT$459 / 500g×6',
   'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Garofalo-Penne-Rigate-Pasta-500-g-X-6-Pack/p/117346',
   'Costco', 'costco_food', 'Garofalo', '義大利',
   '{"ingredients":"杜蘭小麥粉","weight":"3公斤","count":"500g × 6包","storage":"常溫陰涼乾燥處"}'::jsonb,
   '{"fiber":"低纖維（約2-3g/100g乾麵）","protein":"約12g/100g","gi":"中GI（約55-65，視煮熟度）"}'::jsonb,
   '線上可訂（常溫配送）。500g×6共3kg，每週訓練日1-2餐使用，可用1-2個月。開封後每包密封防潮。常溫存放不佔冰箱空間。Costco另有其他品牌（Barilla, De Cecco）可替換。',
   26),

  ('馬鈴薯（美國/加拿大）',
   '去皮後低纖維碳水，訓練日30-40%替代地瓜。富含鉀（每顆~800mg），冷卻後產生抗性澱粉。選擇黃皮或紅皮較甜',
   '訓練日適量（去皮烹調）',
   '~NT$199 / 3kg',
   'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
   'Costco', 'costco_food', NULL, '美國/加拿大',
   '{"storage":"陰涼通風處，勿冷藏（會轉甜並影響質地）","notes":"發芽或變綠的馬鈴薯含有毒素（龍葵鹼），務必丟棄"}'::jsonb,
   '{"potassium":"約800mg/顆","fiber":"去皮後低纖維（約1g/100g）","gi":"中高GI（約85-90，視烹調法）"}'::jsonb,
   '賣場蔬果區散裝，約NT$199/3kg（6-8顆）。選外皮光滑無發芽。常溫通風處可放2-3週，勿冷藏。去皮後煮、蒸或烤，冷卻後作為訓練日碳水。每週補1次約可用7-10天。',
   27);

-- Step 4: Insert personal_care products (新 category)
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('防曬乳（Neutrogena/La Roche-Posay SPF 50+）',
   '廣譜 UVA/UVB 防護，SPF 50+ PA++++。物理+化學防曬，質地清爽不油膩。防曬是#1抗皮膚老化措施',
   '每日早上外出前，全臉頸部（約1/4茶匙）',
   'NT$350-600 / 50-100ml',
   'https://www.watsons.com.tw/sunscreen',
   '屈臣氏/康是美/iHerb', 'personal_care', 'Neutrogena / La Roche-Posay / Biore', '美國/法國/日本',
   '{"spf":"SPF 50+ PA++++","volume":"50-100ml","features":"廣譜防曬,防水配方"}'::jsonb,
   '{}'::jsonb,
   '屈臣氏/康是美實體購買可試質地。Neutrogena Ultra Sheer約$400/88ml（CP值高），La Roche-Posay Anthelios約$600/50ml（敏感肌），Biore Aqua Rich約$350/50ml（清爽款）。每日使用，50ml約1個月。',
   40),

  ('洗面乳（CeraVe Hydrating Cleanser 236ml）',
   '胺基酸溫和潔面，含神經醯胺+玻尿酸，不破壞皮膚屏障。pH平衡配方適合每日早晚使用',
   '早晚各一次，溫水洗臉',
   'NT$420 / 236ml',
   'https://tw.iherb.com/pr/cerave-hydrating-facial-cleanser-8-fl-oz-236-ml/69325',
   'iHerb/屈臣氏/康是美', 'personal_care', 'CeraVe', '美國',
   '{"volume":"236ml","ph":"pH 5.5-6 (接近皮膚自然pH)","features":"無香料,無皂鹼,低敏配方"}'::jsonb,
   '{}'::jsonb,
   'iHerb 直送 NT$420/236ml（最划算）。屈臣氏/康是美也有販售但容量較小。每日2次，236ml約3個月。CeraVe 是皮膚科醫師推薦品牌，含神經醯胺修復皮膚屏障。替代品：Cetaphil 溫和潔膚乳（約$400/200ml）。',
   41),

  ('保濕乳液（CeraVe Moisturizing Cream 340g）',
   '含玻尿酸+神經醯胺+甘油，MVE 緩釋技術24小時保濕。無香料低敏配方，洗臉後立即使用鎖水',
   '早晚洗臉後立即使用（臉頸部）',
   'NT$566 / 340g',
   'https://tw.iherb.com/pr/cerave-moisturizing-cream-12-oz-340-g/69326',
   'iHerb/屈臣氏/康是美', 'personal_care', 'CeraVe', '美國',
   '{"volume":"340g","features":"MVE緩釋技術,24小時保濕,無香料,無油配方"}'::jsonb,
   '{}'::jsonb,
   'iHerb 直送 NT$566/340g（大包裝划算）。每日2次，340g約3-4個月。同品牌與洗面乳搭配使用效果佳。替代品：Cetaphil 長效潤膚乳（約$550/350ml）或平價選項如Neutrogena水活保濕凝露（約$300/100g）。',
   42),

  ('A醇精華 0.5% + Vit C 精華（The Ordinary）',
   'A醇（晚）：0.5%濃度適合進階使用，促進細胞更新與膠原蛋白生成。Vit C（早）：抗氧化+促進膠原蛋白，防曬前使用增強防護',
   'A醇每週2-3次晚上（保濕後），Vit C每日早上（洗臉後）',
   'A醇 NT$440/30ml + Vit C NT$550/30ml',
   'https://tw.iherb.com/pr/the-ordinary-retinol-0-5-in-squalane-1-fl-oz-30-ml/90058',
   'iHerb/屈臣氏', 'personal_care', 'The Ordinary / Timeless', '加拿大',
   '{"a醇":"0.5% in Squalane基底,30ml","vit_c":"20% L-Ascorbic Acid + Vit E + Ferulic Acid,30ml","storage":"避光陰涼處,Vit C開封後冷藏"}'::jsonb,
   '{}'::jsonb,
   'iHerb 購買最划算。A醇：從0.2%開始適應→0.5%→1%漸進提升。初期每週1次，無刺激後增至2-3次。若出現脫皮紅癢→暫停數日。Vit C：選L-Ascorbic Acid形式（效果最佳但需冷藏）。開封後3個月內用完避免氧化。兩者不可同時使用（A醇晚，Vit C早）。',
   43);
