------------------------------------------------------------
-- 調整補充品時間 + 碳水纖維建議 + 新增牛肉
------------------------------------------------------------

-- 1. 睡前補充品：22:30 → 21:30-22:00（拆分為補充品 + 熱水澡兩個項目）
UPDATE plan_items SET
  title = '21:30-22:00 睡前補充品',
  description = '豌豆蛋白 ~20g 粉（≈16g 蛋白）+ 甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 600mg（8 週用 / 4 週停）。提前至 21:30-22:00 服用，為腎臟保留排尿緩衝時間，避免半夜起床中斷睡眠',
  sort_order = 14
WHERE title LIKE '22:30 睡前%';

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('22:00-23:00 熱水澡', '40-42°C 10-15 分鐘（睡前 60-90 分鐘）。提高核心體溫後快速降溫觸發睡眠驅動', 'daily', '睡眠', 15, 1, true);

-- 2. 午餐：新增銅，移除維他命 C
UPDATE plan_items SET
  description = '蛋白質 45-50g（正餐食物）+ 肌酸 5g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日）。脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g。魚油 3 顆、D3 2000IU（5+2）、K2（僅取 K2 引導鈣至骨骼）、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 100-200mg（脂溶性，與魚油同服提升吸收）、B群 1 顆（水溶性，白天能量代謝）、銅 2mg（隨午餐正餐服用，利用食物體積緩衝腸胃刺激）。每日脂肪目標 80-90g（22-25% 總熱量）。不再額外沖乳清蛋白（正餐蛋白質已足夠）'
WHERE title LIKE '12:00 午餐%';

-- 3. 晚餐：新增維他命 C
UPDATE plan_items SET
  description = '蛋白質 45-50g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 1 大匙（14g）入菜或涼拌 + 堅果一把 30g（~15g 脂肪）≈ 20-25g。隨餐服用鋅 25mg（與午餐銅間隔 4hr+ 避免競爭吸收）+ 維他命 C 500-1000mg（改至晚餐服用，遠離早晨訓練視窗，減少腸胃刺激）。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- 4. 15:00 NSDR：移除銅
UPDATE plan_items SET
  title = '15:00 NSDR',
  description = '使用引導式 Yoga Nidra 音檔（非單純休息）。11 分鐘有 RCT 支持，促進深度放鬆與多巴胺恢復'
WHERE title LIKE '15:00 NSDR%';

-- 5. 碳水循環：新增低纖維建議
UPDATE plan_items SET
  description = '重訓日 5-6g/kg (360-430g)、有氧日 3-4g/kg (215-290g)、休息日 2-3g/kg (145-215g，僅 Deload 週或臨時休息)。支持 mTOR 肌肉修復與合成。高碳水日建議將 30-40% 替換為低纖維來源（白米飯、義大利麵、去皮馬鈴薯）以控制總纖維量並減輕腸胃負擔。卡路里目標：重訓日 3,100-3,400 kcal'
WHERE title LIKE '%碳水循環%';

-- 6. 新增產品：冷凍草飼牛肉片
INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '冷凍草飼牛肉片（澳洲）',
  '紅肉提供血基質鐵（吸收率 15-35%）、維他命 B12、天然肌酸。草飼牛肉 Omega-3 較高',
  '每週 1-2 次（200-300g/次）替代雞胸肉',
  'NT$600-800 / 1kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/c/90701',
  'Costco', 'costco_food', NULL, '澳洲',
  '{"cut":"薄片火鍋肉片或牛排","fat":"選擇瘦部位（如菲力、後腿）","storage":"冷凍 -18°C"}'::jsonb,
  '{"protein_per_100g":"20-25g","iron":"2-3mg（血基質鐵）","b12":"豐富","creatine":"天然含有"}'::jsonb,
  '每週 1-2 次作為紅肉來源。補充血基質鐵（植物鐵吸收率僅 2-20%）與 B12。草飼優於穀飼。瘦部位脂肪 <10g/100g。',
  22
);
