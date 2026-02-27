------------------------------------------------------------
-- 028: 調整補劑時程 + 採購清單優化
-- 1. 鋅從每日→每週 2-3 次
-- 2. 銅移至下午 15:00-16:00 單獨服用
-- 3. 豌豆蛋白改至晚餐後點心 20:00-20:30
-- 4. B-50 標記 iHerb 必買
-- 5. 綠花椰菜/菠菜改為新鮮版
-- 6. 10:00 運動加入冷水浴警示
------------------------------------------------------------

-- === 1. 鋅：每日 → 每週 2-3 次 ===

-- 1a. 晚餐移除鋅
UPDATE plan_items SET
  title = '19:00 晚餐 + 低 FODMAP 蔬菜',
  description = '蛋白質 45-50g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 1 大匙（14g）入菜或涼拌 + 堅果一把 30g（~15g 脂肪）≈ 20-25g。隨餐服用維他命 C 500-1000mg。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- 1b. 新增每週鋅補充項目
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('鋅 25mg 補充',
   '每週 2-3 次服用鋅 25mg（Zinc Picolinate 半顆），隨晚餐服用。與銅間隔 4hr+。降低每日高劑量補充的長期風險，維持鋅銅比 10-15:1',
   'weekly', '補充品', 12, 3, true);

-- 1c. 更新鋅產品描述
UPDATE products SET
  usage = '每週 2-3 次，每次半顆（25mg）隨晚餐（避開鈣，與銅間隔 4hr+）',
  purchase_note = 'iHerb 直送。每週 2-3 次（週二、四、六），每次半顆 25mg，120 顆可用 8-10 個月。降低每日補充的長期風險。與銅保持 10-15:1 比例。'
WHERE name LIKE '鋅 Zinc Picolinate%';

-- === 2. 銅移至下午 15:00-16:00 單獨服用 ===

-- 2a. 午餐移除銅
UPDATE plan_items SET
  title = '12:00 午餐 + 訓練後補充品',
  description = '蛋白質 45-50g（正餐食物）+ 肌酸 5g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日）。脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g。魚油 3 顆、D3 2000IU（5+2）、K2 MK-7 100mcg、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 100-200mg。每日脂肪目標 80-90g（22-25% 總熱量）'
WHERE title LIKE '12:00 午餐%';

-- 2b. 停用舊的午餐補銅項目
UPDATE plan_items SET is_active = false
WHERE title LIKE '12:00-13:00 午餐補銅%';

-- 2c. 新增下午銅補充項目
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('15:00-16:00 銅 2mg 補充',
   '銅 2mg（Solaray Bisglycinate）單獨服用或與無礦物質補劑的輕食搭配。空腹或僅少量食物可最大化吸收率，避免與鋅、鈣、鐵等礦物質競爭。與晚餐鋅間隔 4hr+',
   'daily', '補充品', 9, 1, true);

-- 2d. 更新銅產品描述
UPDATE products SET
  usage = '每日 1 顆，下午 15:00-16:00 單獨服用（空腹或僅搭配輕食，與礦物質補劑間隔）',
  description = '長期補鋅必須搭配銅。甘胺酸銅吸收率優於檸檬酸銅。下午單獨服用可最大化吸收率，避免與鋅、鈣、鐵競爭。鋅銅比維持 10-15:1，防止銅缺乏導致貧血與神經損傷',
  purchase_note = 'iHerb 直送。每日 1 顆，100 顆可用 3 個多月。下午 15:00-16:00 空腹或搭配少量食物服用，避開午餐的魚油/D3/鈣鎂等礦物質競爭，最大化吸收率。與晚餐鋅間隔 4hr+'
WHERE name LIKE '銅 Copper%';

-- === 3. 豌豆蛋白改至晚餐後點心（20:00-20:30）===

-- 3a. 睡前補充品移除豌豆蛋白
UPDATE plan_items SET
  title = '21:30-22:00 睡前補充品',
  description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 600mg（8 週用 / 4 週停）。提前至 21:30-22:00 服用，為腎臟保留排尿緩衝時間，避免半夜起床中斷睡眠'
WHERE title LIKE '21:30-22:00 睡前%';

-- 3b. 新增晚餐後點心項目
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('20:00-20:30 晚餐後點心',
   '豌豆蛋白 ~20g 粉（≈16g 蛋白）。非乳製植物蛋白，中速消化。晚餐後 1-1.5 小時服用，補充當日蛋白質目標，避免睡前過飽影響睡眠',
   'daily', '飲食', 13, 1, true);

-- 3c. 更新豌豆蛋白產品描述
UPDATE products SET
  usage = '晚餐後點心 ~20g 粉（≈16g 蛋白），約 20:00-20:30',
  description = '非乳製植物蛋白，中速消化。晚餐後 1-1.5 小時服用補充當日蛋白質，避免睡前過飽。無大豆、無乳製品、無麩質。每份 ~24g 蛋白',
  purchase_note = 'iHerb 直送。每日 ~20g，907g 可用 45 天。無調味可搭配少量蜂蜜或可可粉。晚餐後 1-1.5 小時服用，避免睡前影響睡眠品質'
WHERE name LIKE '豌豆蛋白 Pea Protein%';

-- === 4. B-50 標記 iHerb 必買 ===

UPDATE products SET
  description = '✓ iHerb 必買。完整 B 群複方（B1/B2/B3/B5/B6/B7/B9/B12）。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成',
  purchase_note = 'iHerb 必買品項。每日 1 顆隨早餐（訓練前營養餐）服用，100 顆可用 3 個多月。水溶性維生素，隨餐服用提升吸收率。尿液變黃為正常現象（B2 代謝）'
WHERE name LIKE 'B群 B-50%';

-- === 5. 綠花椰菜/菠菜改為新鮮版 ===

-- 5a. 綠花椰菜
UPDATE products SET
  name = '新鮮綠花椰菜（傳統市場/超市）',
  description = '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）。切碎後靜置 40 分鐘可最大化黑芥子酶轉化',
  price = 'NT$20-30 / 顆',
  url = 'https://www.pxmart.com.tw',
  store = '傳統市場 / 全聯 / 頂好',
  purchase_note = '每週補貨 1-2 次，每次買 2-3 顆。切成小朵後靜置 40 分鐘（最大化蘿蔔硫素），裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。小冰箱用戶不建議買 Costco 冷凍版（454g×4 佔冷凍 3L 直接爆倉）',
  specs = '{"storage":"冷藏3-4天","preparation":"切碎靜置40分鐘最大化蘿蔔硫素","portion":"每次2-3顆"}'::jsonb
WHERE name LIKE '冷凍綠花椰菜%';

-- 5b. 菠菜
UPDATE products SET
  name = '新鮮菠菜（傳統市場/超市）',
  description = '低 FODMAP 蔬菜，鉀、鎂、鐵、葉酸來源。搭配維他命C增強鐵吸收',
  price = 'NT$30-50 / 300-400g',
  url = 'https://www.pxmart.com.tw',
  store = '傳統市場 / 全聯 / 頂好',
  purchase_note = '每週補貨 1-2 次，每次買 300-400g。放入大保鮮袋、裡面墊一張廚房紙巾吸濕，平放於保鮮抽屜底部，3-5 天內用完。小冰箱用戶不建議買 Costco 冷凍版（500g×6 佔冷凍室 70%）',
  specs = '{"storage":"冷藏3-5天","preparation":"墊廚房紙巾吸濕","portion":"每週300-400g"}'::jsonb
WHERE name LIKE '菠菜（冷凍%';

-- === 6. 10:00 運動加入冷水浴警示 ===

UPDATE plan_items SET
  description = '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘。每次 60-90 分鐘。⚠️ 重訓後 4-6 小時內禁止冷水浴（會抑制肌肥大信號 mTOR/IGF-1）— 冷水浴僅限休息日或訓練前'
WHERE title LIKE '10:00 運動%';
