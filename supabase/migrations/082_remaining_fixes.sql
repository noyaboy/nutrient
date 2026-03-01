------------------------------------------------------------
-- 082: Remaining Fixes from Comprehensive Review (2026-03-01)
--
-- Fixes issues missed or broken by 080/081:
--
-- 1. Insert chicken liver product (080/081 UPDATE failed — no product existed)
-- 2. Fix Mg glycinate product (150mg/1.5 tabs, not 200mg/2 tabs per 079)
-- 3. Fix fiber tracker psyllium 5g → 8-10g (080 only updated plan_item title)
-- 4. Standardize caffeine cutoff to 15:30 (080 set green tea to 16:00)
-- 5. Add coconut water product for potassium gap
-- 6. Update potassium tracker with coconut water
------------------------------------------------------------

-- ============================================================
-- #1: Insert chicken liver product (was never in products table)
-- 080 and 081 both tried UPDATE products WHERE name LIKE '雞肝%'
-- which matched 0 rows. This INSERT creates the missing product.
-- ============================================================
INSERT INTO products (name, description, usage, price, url, store, category, nutrition, purchase_note, sort_order) VALUES (
  '雞肝（傳統市場/超市）',
  '鐵質+預成形維他命A最強食物來源。每 50g 含：血基質鐵 ~5.5mg（吸收率 25-35%）、維他命A ~5,500mcg RAE（視黃醇形式）、B12 ~8.5mcg、葉酸 ~290mcg、銅 ~0.25mg。🔴 嚴格 50g/次、2次/週——100g/次會使週均 preformed retinol 達 3,143mcg/日超 UL 3,000mcg。2×50g = ~1,571mcg/日（安全）。⚠️ BCMO1 基因變異者（45% 人口）β-胡蘿蔔素→視黃醇轉化率極低，雞肝提供直接視黃醇繞過此瓶頸',
  '每週 2 次午餐入菜（每次嚴格 50g，電子秤量測）。⚠️ 不可超過 50g/次',
  'NT$40-60 / 300g',
  'https://www.pxmart.com.tw',
  '傳統市場 / 全聯', 'convenience_daily',
  '{"per_50g":"鐵 5.5mg, 維他命A 5500mcg RAE, B12 8.5mcg, 葉酸 290mcg, 銅 0.25mg"}'::jsonb,
  '每週買 100g（2 次 × 50g）。新鮮雞肝冷藏 1-2 天，買當天料理最佳。可分 2 份 50g 用保鮮膜包好冷藏。',
  58
);

-- ============================================================
-- #2: Fix Mg glycinate product (079 reduced to 150mg but product not updated)
-- ============================================================
UPDATE products
SET nutrition = '{"serving_size":"1.5錠","magnesium":"150mg（提取自1500mg甘氨酸鎂）"}'::jsonb,
    purchase_note = 'iHerb 直送。每日 1.5 錠（150mg），180 錠可用 4 個月。與蘇糖酸鎂（每月補貨）合併 iHerb 訂購節省運費。'
WHERE name LIKE '甘胺酸鎂%';

-- ============================================================
-- #3: Fix fiber tracker — psyllium 5g → 8-10g
-- 080 updated the psyllium plan_item title/description but missed the fiber tracker
-- ============================================================
UPDATE plan_items
SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜（抗性澱粉）。搭配發酵食物（優格、泡菜 ≤30g/日）增強腸道多樣性。⚠️ 訓練日注意：低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）可能使纖維降至 20-25g。訓練日補充：奇亞籽 15g（5g 纖維）+ 洋車前子殼 8-10g（6.4-8g 纖維）= 額外 11-13g，搭配蔬菜 5-8g 達標 35g+'
WHERE title LIKE '%膳食纖維%';

-- ============================================================
-- #4: Standardize caffeine cutoff to 15:30
-- 080 extended green tea to 16:00 but coffee item says 15:30 cutoff
-- ============================================================
UPDATE plan_items
SET title = '15:00 綠茶 EGCG 2-3 杯',
    description = '午餐後 3hr+ 再飲用（~15:00），高脂高蛋白午餐胃排空需 3-4hr，3hr 內 EGCG 仍會螯合鐵鋅。改用低咖啡因綠茶（白毫銀針或老白毫），配合 L-theanine 天然組合促進專注。15:30 前喝完（咖啡因 cutoff 統一 15:30）。綠茶天然 L-Theanine（40-90mg）為額外放鬆紅利'
WHERE title LIKE '%綠茶 EGCG%';

-- ============================================================
-- #5: Add coconut water product for systematic potassium fix
-- Baseline 3250-3550mg vs target 3800-4000mg — gap 250-750mg
-- Coconut water 330ml = +600mg K closes the gap
-- ============================================================
INSERT INTO products (name, description, usage, price, url, store, category, nutrition, purchase_note, sort_order) VALUES (
  '椰子水（Vita Coco / Kirkland 330ml）',
  '天然鉀補充來源，每 330ml 含鉀 ~600mg。系統性彌補每日鉀攝取缺口 250-750mg（食物基線 3,250-3,550mg vs 目標 3,800-4,000mg）。另含鎂 ~60mg、少量鈉。低熱量天然飲品',
  '每日 1 瓶（330ml），15:30 下午點心時段或訓練後飲用',
  'NT$35-55 / 330ml',
  'https://www.costco.com.tw/Food-Dining/Drinks/c/90810',
  'Costco / 全聯 / 便利超商', 'convenience_daily',
  '{"per_330ml":"鉀 ~600mg, 鎂 ~60mg, 熱量 ~50kcal, 糖 ~12g"}'::jsonb,
  '每日 1 瓶。Costco 12 瓶裝最划算（~NT$420/12 瓶）。常溫保存。每月約 30 瓶。',
  59
);

-- ============================================================
-- #6: Update potassium tracker with coconut water
-- ============================================================
UPDATE plan_items
SET title = '全天 鉀攝取確認（目標 3800-4000mg）',
    description = '每日確認鉀攝取達 3800-4000mg。主力來源：酪梨半顆（~350mg）+ 馬鈴薯 1 顆（~800mg）+ 香蕉 1 根（~400mg）+ 希臘優格 300g（~300mg）+ 菠菜/蔬菜（~400mg）+ 鮭魚/肉類（~400mg）+ 地瓜 100g（~300mg）+ 椰子水 330ml（~600mg）+ 其他（~300mg）≈ 3,850-4,150mg ✅。⚠️ 酪梨、馬鈴薯、椰子水為核心三件，缺一不可'
WHERE title LIKE '%鉀攝取確認%';
