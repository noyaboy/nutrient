-- Migration 071: Clarify Calcium Protocol & Target 1000mg Daily
-- Implements CORR-CA-001 from Comprehensive Nutrition Evaluation 2026-03-01
--
-- RATIONALE:
-- Current calcium intake ~700 mg (70% of RDA 1000 mg) despite migration 067 making it daily.
-- Issue: Greek yogurt intake maxed at ~250g (limited by fridge space), only provides ~250 mg Ca.
-- Solution: Use backup Nature Made Ca+D3+K2 tablet 2-3×/week on low-yogurt days.
-- This approach:
--   - Maintains food-first strategy (yogurt provides probiotics + protein synergy)
--   - Uses backup tablet efficiently (2-3×/week → adds ~500mg Ca → total 700-1000 mg on tablet days)
--   - Gives flexibility without forcing excessive daily yogurt
--
-- TARGET:
-- Daily non-tablet days: 600-700 mg (yogurt 300g + tofu + vegetables + seaweed)
-- Tablet days (Tue/Thu/Sat): 1000-1100 mg (above + tablet 500 mg)
-- Weekly average: ~850-900 mg (acceptable, trending toward RDA 1000 mg)
--
-- IMPLEMENTATION:
-- 1. Update lunch plan description with clear Greek yogurt portion (300-400g)
-- 2. Add new plan item: "鈣片備用日" protocol (specific days + timing)
-- 3. Update "全天 鈣攝取確認" plan item with new targets

-- Update main calcium tracking plan item with clarified protocol
UPDATE plan_items
SET description = '每日確認鈣攝取是否達標。主要來源：
💡 非補錠日（一三五六日）：希臘優格 300-400g（無植酸，每 100g 補 ~83mg 鈣 → 250-330mg）+ 板豆腐（100-150g, 100-150mg 鈣）+ 深綠蔬菜（100-150mg）+ 海苔 1-2 片（~30mg） = 約 600-700mg。
💊 補錠日（週二四六）：上述食物來源（600-700mg） + Nature Made Ca+D3+K2 1 錠（500mg 鈣） = 1000-1100mg（達到 RDA）。
每週加權平均：(600-700) × 4 天 + (1000-1100) × 3 天 ÷ 7 = ~850-900mg/日（趨近 RDA 1000mg）。'
WHERE title = '全天 鈣攝取確認（目標 1000mg）'
AND frequency = 'daily'
AND category = '飲食';

-- Add new plan item: Calcium tablet backup protocol with specific days
INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  '鈣片補錠日（週二、週四、週六）',
  '週二、週四、週六隨午餐（與 D3、K2、魚油同服，脂溶性需油脂）服用 Nature Made Ca+D3+K2 1 錠（500mg 鈣 + 150IU D3 + 10mcg K2）。目的：週末低食物鈣日防護。
📋 補錠日操作：
   1. 確認當天早晨/午間是否已攝取 ≥300g 優格。
   2. 若有（正常），午餐隨餐吃 1 錠 → 當日鈣 ~1000mg（達 RDA）。
   3. 若無（外出/冷鏈故障），提前準備替代鈣源（豆製品、葉菜）；補錠確保下限。
⚠️ 無須每日服用（會造成過量 D3：補錠 150 IU × 7 天 = 1050 IU 額外 D3，與獨立 2000 IU 補充疊加）。3 天/週最佳平衡。',
  'weekly',
  '補充品',
  29,
  3,
  true
);

-- Update calcium backup tablet product description to reflect new protocol
UPDATE products
SET purchase_note = '線上可訂（常溫配送）。250 錠用法：每週 2-3 次隨午餐服用（週二、週四、週六），每次 1 錠。250 錠可用 1-2 年。碳酸鈣+檸檬酸鈣錠劑常溫陰涼處穩定保存。⚠️ 補錠日注意 D3 疊加：備錠含 150IU D3，3×/週 = 450IU 額外，加上獨立 2000IU 補充 = 總 2450IU（仍在 4000IU UL 內，安全）。'
WHERE name = '鈣片備用（Nature Made Ca+D3+K2 250 錠）'
AND category = 'costco_supplement';

-- Add clarification on Greek yogurt ideal portion
INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  '希臘優格 300-400g 每日（鈣質 + 益生菌）',
  '無脂希臘優格 Kirkland 牌（Costco 賣場限定）。目標每日 300-400g（約 250-330mg 鈣 + 29-39g 蛋白質 + 5 種活菌）。
🧊 小冰箱容納方案：每次 Costco 購物 2 × 907g 包（共 1814g = 約 5-6 日份）。開回家立即分裝：
   • 玻璃罐 300ml × 2 個（日常用，轉進冷藏抽屜）
   • 原包 1 罐保留（展示/確認日期），冷藏最深處
⚠️ 務必每 2-3 天補貨（小冰箱 65L 能力有限）。',
  'daily',
  '飲食',
  30,
  300,
  true
);
