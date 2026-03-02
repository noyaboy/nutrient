------------------------------------------------------------
-- 新增膠原蛋白肽、CoQ10、B群 + 脂肪攝取提醒
------------------------------------------------------------

-- 更新午餐 description：新增膠原蛋白肽、CoQ10、B群、橄欖油提醒
UPDATE plan_items
SET description = '蛋白質 30-40g（正餐食物）+ 肌酸 5g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日）。魚油 3 顆、D3 2000IU（5+2）、D3+K2（不額外補鈣片，鈣從食物攝取）、維他命 C、葉黃素 20mg、膠原蛋白肽 10-15g（與 Vit C 協同促進膠原蛋白合成）、CoQ10 100-200mg（脂溶性，與魚油同服提升吸收）、B群 1 顆（水溶性，白天能量代謝）。適量橄欖油確保脂肪攝取（每日脂肪目標 20-30% 總熱量）。不再額外沖乳清蛋白（正餐蛋白質已足夠）'
WHERE title = '12:00 午餐 + 訓練後補充品';

-- 更新晚餐 description：新增橄欖油提醒
UPDATE plan_items
SET description = '蛋白質 30-40g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。隨餐服用鋅 25mg（與銅間隔 4hr+）。適量橄欖油確保脂肪攝取（每日脂肪目標 20-30% 總熱量）。固體食物睡前 3-4hr 結束'
WHERE title = '19:00 晚餐 + 低 FODMAP 蔬菜';

-- 新增 3 個 iHerb products
INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '膠原蛋白肽 CollagenUP（CGN 206g）',
  '水解海洋膠原蛋白肽 + 玻尿酸 + 維他命 C。與 Vit C 協同促進膠原蛋白合成，支持皮膚、關節與結締組織健康',
  '每日 10-15g 隨午餐（搭配維他命 C）',
  'NT$489 / 206g',
  'https://tw.iherb.com/pr/california-gold-nutrition-collagenup-marine-hydrolyzed-collagen-hyaluronic-acid-vitamin-c-unflavored-7-26-oz-206-g/64903',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  NULL, NULL, NULL, 'CGN-01033',
  '{"ingredients":"水解海洋膠原蛋白肽、玻尿酸、維他命C","form":"無調味粉末","weight":"206g"}'::jsonb,
  '{"serving_size":"6.5g","collagen_peptides":"5.1g","hyaluronic_acid":"18mg","vitamin_c":"80mg"}'::jsonb,
  'iHerb 直送。每日 10-15g，206g 約可用 2-3 週。與維他命 C 同服效果最佳。搭配其他 iHerb 品項湊免運。',
  29
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'CoQ10 Ubiquinol 200mg（NOW Foods 60 顆）',
  '還原型輔酶 Q10（Ubiquinol），生物利用率高於 Ubiquinone。支持細胞能量產生與心血管健康。脂溶性，與魚油同服提升吸收',
  '每日 1 顆隨午餐（搭配魚油）',
  'NT$1,095 / 60 顆',
  'https://tw.iherb.com/pr/now-foods-ubiquinol-200-mg-60-softgels/45079',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL, NULL, NULL, 'NOW-03153',
  '{"form":"軟膠囊","count":"60顆"}'::jsonb,
  '{"serving_size":"1顆","ubiquinol":"200mg"}'::jsonb,
  'iHerb 直送。每日 1 顆，60 顆可用 2 個月。脂溶性，務必隨含油脂餐食服用。',
  30
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'B群 B-50（NOW Foods 100 顆）',
  '完整 B 群複方（B1/B2/B3/B5/B6/B7/B9/B12）。水溶性，支持白天能量代謝、神經系統與紅血球生成',
  '每日 1 顆隨午餐',
  'NT$364 / 100 顆',
  'https://tw.iherb.com/pr/now-foods-b-50-100-veg-capsules/604',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL, NULL, NULL, 'NOW-00426',
  '{"form":"素食膠囊","count":"100顆"}'::jsonb,
  '{"serving_size":"1顆","b_complex":"B-50 完整複方"}'::jsonb,
  'iHerb 直送。每日 1 顆，100 顆可用 3 個多月，每季補一次。尿液變黃為正常現象（B2 代謝）。',
  31
);

-- 調整設備 sort_order 避免衝突
UPDATE products SET sort_order = 32 WHERE name = '防藍光眼鏡（琥珀色鏡片）';
UPDATE products SET sort_order = 33 WHERE name = '食品電子秤';
UPDATE products SET sort_order = 34 WHERE name = '全遮光窗簾';
