------------------------------------------------------------
-- Fix whey protein numbers (90% WPI: 30g→27g, 40g→36g)
-- Unify broccoli naming: 青花菜 → 綠花椰菜
------------------------------------------------------------

-- Fix Tryall whey protein description & nutrition
UPDATE products SET
  description = '台灣品牌，無調味無添加。分離乳清蛋白（WPI），約 90% 蛋白質含量，每 30g 粉含 ~27g 蛋白、~120kcal。美國乳源，過濾大部分乳糖與脂肪，乳糖不耐者也適合',
  usage = '訓練前 1 份（~30g 粉 ≈ 27g 蛋白），訓練後 ~1.3 份（~40g 粉 ≈ 36g 蛋白）',
  nutrition = '{"serving_size":"30g","calories":"~120kcal","protein":"~27g","fat":"~2g","carbs":"~3g","bcaa":"~5.3g","protein_pct":"約90%"}'::jsonb,
  updated_at = now()
WHERE name LIKE '%Tryall%乳清%';

-- Fix plan_items whey protein references
UPDATE plan_items SET
  description = '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）',
  updated_at = now()
WHERE title LIKE '07:15%';

UPDATE plan_items SET
  description = '乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 5000IU、鈣+D3+K2 1 錠、維他命 C、葉黃素 20mg',
  updated_at = now()
WHERE title LIKE '09:00%';

-- Unify broccoli naming: 青花菜 → 綠花椰菜
UPDATE products SET
  name = REPLACE(name, '青花菜', '綠花椰菜'),
  description = REPLACE(description, '青花菜', '綠花椰菜'),
  updated_at = now()
WHERE name LIKE '%青花菜%' OR description LIKE '%青花菜%';
