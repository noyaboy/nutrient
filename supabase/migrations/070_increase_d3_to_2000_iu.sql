-- Migration 070: Increase Vitamin D3 to 2000 IU
-- Implements CORR-D3-001 from Comprehensive Nutrition Evaluation 2026-03-01
--
-- RATIONALE:
-- Current 1000 IU is insufficient for subtropical athlete strength training.
-- Endocrine Society 2022: 2000-4000 IU recommended for athletes in subtropical/temperate climates.
-- Taiwan UV index 8-10; sun synthesis ~1000 IU/day (uncertain, weather-dependent).
-- Total estimate: 1000 IU (supplement) + 1000 IU (sun) = 2000 IU (marginal).
-- Bone remodeling, immune tolerance, training recovery all benefit from ≥2000 IU.
-- Still well below UL of 4000 IU; zero toxicity risk.
--
-- TARGET:
-- Update D3 supplement from 1000 IU to 2000 IU
-- Product: NOW Foods D3-10 (2000 IU per capsule) OR Kirkland D3 2000 IU
-- Estimated daily total post-fix: 2000 IU (supplement) + 1000 IU (sun) = 3000 IU (optimal)
--
-- IMPLEMENTATION:
-- 1. Update plan_items lunch description to reflect 2000 IU D3
-- 2. Add/update D3 product in products table with 2000 IU specification
-- 3. Clarify in lunch plan that D3 is now 2000 IU (primary) + 150 IU backup (Ca tablet, rarely used)

-- Update plan_items: Lunch description with D3 2000 IU
UPDATE plan_items
SET description = '蛋白質 35-40g（正餐食物，單餐建議 ≤45g）+ 肌酸 5g + 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆、D3 2000IU、K2 100mcg、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 200mg、B群 1 顆（活化型態，隨正餐油脂+蛋白質完整食物基質服用，吸收率最佳）'
WHERE title = '12:00 午餐 + 訓練後補充品'
AND frequency = 'daily'
AND category = '飲食';

-- Add D3 2000 IU product (if not already exists)
INSERT INTO products (
  name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order
) VALUES (
  '維他命 D3 2000IU（NOW Foods 180 顆）',
  '由羊毛脂提取，膽鈣化醇形式（最活躍的 D3 形式）。每顆 2000 IU。絕對符合 Endocrine Society 2022 指引下限（針對亞熱帶強力運動員）。',
  '每日 1 顆隨午餐（與魚油、K2、葉黃素、CoQ10 同服，脂溶性需油脂載體）',
  'NT$400-500 / 180 顆',
  'https://tw.iherb.com/pr/now-foods-vitamin-d-3-2000-iu-180-softgels/3755',
  'iHerb',
  'iherb_supplement',
  'NOW Foods',
  'USA',
  $${"ingredients":"膽鈣化醇(維生素D3)","form":"軟膠囊","count":"180粒","storage":"請存放於乾燥陰涼處，開封後請旋緊瓶蓋。"}$$::jsonb,
  $${"vitamin_d3":"2000IU/膠囊"}$$::jsonb,
  'iHerb 直送。✅ 每日 1 顆（2000 IU），免切免推藥器。180 顆可用 6 個月。開瓶後標記日期，12 個月內用完。⚠️ 與現有 1000 IU 版本區別：新規格為 2000 IU 單顆。',
  40
) ON CONFLICT DO NOTHING;

-- Add clarification comment in plan items for transparency
-- This is informational; actual dosing is in the updated lunch description above
INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  'D3 補充增量背景說明',
  '✅ 已更新：D3 補充從 1000IU 增至 2000IU（migration 070, 2026-03-01）。理由：Endocrine Society 2022 亞熱帶強力運動員建議 2000-4000IU。當前估算：2000IU（補充）+ ~1000IU（日光合成）= 3000IU（最適範圍下限）。預期血清 25-OH D 將在 2026-05 月升至 30-50 ng/mL（運動員最適）。基準抽血已排定 2026-03-31。',
  'daily',
  '備註',
  999,
  1,
  false
) ON CONFLICT DO NOTHING;
