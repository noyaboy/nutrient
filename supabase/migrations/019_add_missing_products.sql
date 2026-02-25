------------------------------------------------------------
-- 補齊計畫中有用到但採購清單缺少的 7 項產品
------------------------------------------------------------

-- Costco 食材：橄欖油、綠茶
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '特級初榨橄欖油（Kirkland 2L）',
  '單元不飽和脂肪酸（MUFA）來源，支持脂溶性維他命吸收。抗發炎多酚。產地西班牙',
  '午餐 + 晚餐各 1 大匙（14g），每日共 ~28g',
  'NT$459 / 2L',
  'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/c/90903',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '西班牙',
  '{"ingredients":"100% 特級初榨橄欖油","volume":"2公升","storage":"陰涼避光處，開封後 3-6 個月內用完"}'::jsonb,
  '{"fat_per_15ml":"14g","mufa":"約10g","calories":"約126kcal"}'::jsonb,
  '線上可訂（常溫配送）。每日 ~28g（2 大匙），2L 約 2.5 個月。避免高溫油炸（發煙點 ~190°C），涼拌或中低溫烹調最佳。',
  21
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '綠茶（茶葉/茶包）',
  'EGCG + L-theanine 天然組合，促進專注。多酚抗氧化',
  '每日午餐後 2-3 杯（13:00-15:00）',
  '~NT$200-400',
  'https://www.costco.com.tw/Food-Dining/Drinks/Tea/c/90811',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  'Costco 茶飲區或超市購買。散裝綠茶葉 CP 值最高。午餐後 1hr+ 再飲用避免螯合鈣鐵鋅，15:00 前喝完（咖啡因 cutoff）。',
  22
);

-- iHerb 補充品：豌豆蛋白、甘胺酸、蘇糖酸鎂、Ashwagandha、電解質粉
INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '豌豆蛋白 Pea Protein（NOW Foods 907g）',
  '非乳製植物蛋白，中速消化適合睡前。無大豆、無乳製品、無麩質。每份 ~24g 蛋白',
  '睡前 ~20g 粉（≈16g 蛋白）',
  'NT$850 / 907g',
  'https://tw.iherb.com/pr/now-foods-pea-protein-natural-unflavored-2-lbs-907-g/29056',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL, NULL, NULL, 'NOW-02136',
  '{"ingredients":"豌豆蛋白分離物（黃豌豆）","form":"無調味粉末","weight":"907g"}'::jsonb,
  '{"serving_size":"33g","protein":"24g","fat":"2g","carbs":"1g"}'::jsonb,
  'iHerb 直送。每日 ~20g，907g 可用 45 天。無調味可搭配少量蜂蜜或可可粉。',
  32
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '甘胺酸 Glycine Pure Powder（NOW Foods 454g）',
  '抑制性神經傳導物質，降低核心體溫促進深層睡眠。參與膠原蛋白合成與肌酸生成',
  '睡前 3g（約半茶匙）',
  'NT$350 / 454g',
  'https://tw.iherb.com/pr/now-foods-glycine-pure-powder-1-lb-454-g/1613',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL, NULL, NULL, 'NOW-00228',
  '{"ingredients":"甘胺酸","form":"純粉末","weight":"454g"}'::jsonb,
  '{"serving_size":"3g","glycine":"3g"}'::jsonb,
  'iHerb 直送。每日 3g，454g 可用 5 個月。微甜味，可直接加入豌豆蛋白一起沖泡。',
  33
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '蘇糖酸鎂 Magtein（NOW Foods 90 顆）',
  '唯一可穿越血腦屏障的鎂型態（鎂 L-蘇糖酸鹽）。改善認知功能與睡眠品質',
  '睡前 3 顆（元素鎂 ~144mg）',
  'NT$850 / 90 顆',
  'https://tw.iherb.com/pr/now-foods-magtein-magnesium-l-threonate-90-veg-capsules/56714',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL, NULL, NULL, 'NOW-01295',
  '{"form":"素食膠囊","count":"90顆"}'::jsonb,
  '{"serving_size":"3顆","magnesium_l_threonate":"2000mg","elemental_magnesium":"144mg"}'::jsonb,
  'iHerb 直送。每日 3 顆，90 顆可用 1 個月。與甘胺酸鎂搭配使用，注意總鎂量。',
  34
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'Ashwagandha KSM-66（NOW Foods 90 顆）',
  'KSM-66 全譜根部萃取，降低皮質醇、改善壓力與睡眠品質。RCT 支持的適應原草藥',
  '睡前 1 顆（600mg）。8 週用 / 4 週停',
  'NT$530 / 90 顆',
  'https://tw.iherb.com/pr/now-foods-ashwagandha-450-mg-90-veg-capsules/3294',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL, NULL, NULL, 'NOW-04603',
  '{"form":"素食膠囊","count":"90顆","extract":"KSM-66 全譜根部萃取"}'::jsonb,
  '{"serving_size":"1顆","ashwagandha_extract":"450mg"}'::jsonb,
  'iHerb 直送。8 週用期每日 1 顆（2 顆達 ~600mg 視劑量調整），90 顆約 1.5-3 個月。停用期留白讓受體重置。第 6-8 週留意情緒變化。',
  35
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '電解質粉 Sport Hydration（CGN 20 包）',
  '鈉、鉀、鎂、鈣電解質補充。有氧訓練日維持水合與電解質平衡',
  '有氧日訓練中 1 包沖 500ml 水',
  'NT$320 / 20 包',
  'https://tw.iherb.com/pr/california-gold-nutrition-sport-hydration-electrolyte-drink-mix-variety-pack-20-packets/105289',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  NULL, NULL, NULL, 'CGN-01964',
  '{"form":"沖泡粉末","count":"20包"}'::jsonb,
  '{"serving_size":"1包","sodium":"250mg","potassium":"150mg"}'::jsonb,
  'iHerb 直送。有氧日每次 1 包，每週 2-3 次，20 包約 7-10 週。CGN 自有品牌有折扣。',
  36
);

-- 更新甘胺酸鎂用量（已減半至 100mg）
UPDATE products
SET description = '甘胺酸是抑制性神經傳導物質，降低核心體溫助眠。高吸收率',
    usage = '睡前 1 錠（100mg）'
WHERE name LIKE '甘胺酸鎂 Mg Glycinate%';

-- 調整設備 sort_order 避免衝突
UPDATE products SET sort_order = 37 WHERE name = '防藍光眼鏡（琥珀色鏡片）';
UPDATE products SET sort_order = 38 WHERE name = '食品電子秤';
UPDATE products SET sort_order = 39 WHERE name = '全遮光窗簾';
