------------------------------------------------------------
-- D3 降至保守安全劑量：5000 IU → 2000 IU
-- 總量：2000 + 150 (Ca+D3+K2) = 2,150 IU/天（53% of UL）
------------------------------------------------------------

-- Update D3 product: name, description, nutrition
UPDATE products SET
  name = '維他命 D3 2000IU（Doctor''s Best 360 顆）',
  description = '每日補充 2000 IU + 鈣+D3+K2 錠 150 IU = 總計約 2,150 IU/天，低於 IOM UL（4000 IU），屬保守安全劑量。目標血清 25(OH)D 40-60 ng/mL。360 顆大包裝更划算',
  nutrition = '{"serving_size":"1顆","vitamin_d3":"50微克（2000IU）"}'::jsonb,
  purchase_note = 'iHerb 直送。每日 1 顆，360 顆可用整年。大包裝每顆僅 ~$1.27。',
  updated_at = now()
WHERE name LIKE '%D3 5000IU%Doctor%';

-- Update plan_items 09:00: D3 5000IU → 2000IU
UPDATE plan_items SET
  description = '乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 2000IU、鈣+D3+K2 1 錠、維他命 C、葉黃素 20mg',
  updated_at = now()
WHERE title LIKE '09:00%';
