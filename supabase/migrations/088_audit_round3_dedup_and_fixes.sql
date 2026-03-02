------------------------------------------------------------
-- 088: Audit Round 3 — Deduplication & Data Fixes (2026-03-02)
--
-- CRITICAL:
--   C1. Deactivate duplicate lunch item '12:00 午餐 補鈣 500mg' (conflicts with canonical lunch item + calcium at 17:00)
--   C2. Deactivate '鈣片補錠日（週二、週四、週六）' — conflicts with daily 17:00 calcium in '全天 鈣攝取確認'
--
-- HIGH:
--   H1. Deactivate duplicate chicken liver product (sort 16, weekly 1x note conflicts with plan's 2x/wk)
--   H2. Fix Vit A: cooked chicken liver is ~11,000 RAE/100g (not 3,300)
--   H3. Deactivate duplicate D3 1000IU products (2000IU single-cap is canonical)
--
-- MEDIUM:
--   M1. Deactivate zinc product (description says 已停用 but is_active=true)
--   M2. Deactivate copper product (same issue)
--   M3. Deactivate kelp/seaweed product (same issue)
--   M4. Align B-complex product to every-3-days schedule
--   M5. Fix protein math (191-203g, not 180-192g)
------------------------------------------------------------

-- === C1: Deactivate duplicate lunch item ===
UPDATE plan_items
SET is_active = false
WHERE id = '6c80fbd6-e731-43e7-945f-d18bf85ebbe9';

-- === C2: Deactivate 3x/week calcium (conflicts with daily 17:00) ===
UPDATE plan_items
SET is_active = false
WHERE id = '24b84fbe-4c13-43b2-a0f5-42b9fbc8fda6';

-- === H1: Deactivate duplicate chicken liver product (sort_order 16) ===
UPDATE products
SET is_active = false
WHERE id = 'f3829f9b-e08f-48b6-b6c7-9c92ba42e10b';

-- === H2: Fix Vit A cooked chicken liver value ===
-- USDA: Cooked chicken liver ~11,078 mcg RAE/100g (retinol is heat-stable, 5-15% loss max)
-- The claim "熟雞肝 ~3,300 RAE/100g" is wrong — that appears to be a misreading
-- Raw AND cooked liver are both ~11,000 mcg RAE/100g
-- 50g cooked = ~5,500 mcg RAE per serving (single-day spike above UL 3,000)
-- BUT weekly average: 2x5,500/7 + eggs 360 = 1,931 mcg/day (safe, under UL 3,000 chronic)
UPDATE plan_items
SET description = '每日確認維他命A攝取。主要來源：橘色地瓜 100g（~700mcg RAE β-胡蘿蔔素）+ 雞蛋 4 顆（~360mcg RAE）+ 雞肝 2×/週 50g（~5,500mcg RAE/次，USDA 雞肝 ~11,000 RAE/100g，視黃醇耐熱損失僅 5-15%）。⚠️ 雞肝日單日攝取：~5,500 + 360 + 700 = ~6,560mcg RAE，超過 UL 3,000mcg。但 UL 適用於長期每日攝取，非偶發單日。週均：(5,500×2 + 1,060×5) ÷ 7 = ~2,329mcg RAE/日，安全低於 UL。⚠️ 地瓜必須選橘色品種（台農 57 號）。搭配油脂烹調。無地瓜日可用胡蘿蔔 50g（~400mcg RAE）替代'
WHERE id = '94d4fcd5-19cb-4591-b1cf-aa536422a382';

-- === H3: Deactivate duplicate D3 1000IU products (keep 2000IU as canonical) ===
-- Two 1000IU products: 7619318d (original seed) and a70388aa (added later)
-- Plus one 2000IU product: eba8f020 (canonical, single cap)
UPDATE products SET is_active = false WHERE id = '7619318d-79c0-48c3-a066-4ac981309ceb';
UPDATE products SET is_active = false WHERE id = 'a70388aa-d731-40b0-bbfe-b84acbc0cde1';

-- === M1: Deactivate zinc product (已停用 but is_active=true) ===
UPDATE products SET is_active = false WHERE id = '3bbc5601-172c-4829-83e5-2dd7e084c92f';

-- === M2: Deactivate copper product (已停用 but is_active=true) ===
UPDATE products SET is_active = false WHERE id = 'cb1de277-f57f-41fc-9a8e-aa7e8884f834';

-- === M3: Deactivate kelp/seaweed product (已停用 but is_active=true) ===
UPDATE products SET is_active = false WHERE id = '7009d62e-5971-4b96-9a11-a74abe606248';

-- === M4: Align B-complex product frequency to every 3 days ===
UPDATE products
SET usage = '每 3 天 1 顆隨午餐服用（P5P 50mg，均 ~17mg/日——低於神經病變風險閾值 25mg）。或換用 ≤25mg B6 產品後恢復每日服用'
WHERE id = '1556d6df-a1c3-4c3c-bc62-7a4f884c604f';

-- === M5: Fix protein target math ===
UPDATE plan_items
SET title = '全天 蛋白質 191-203g（2.6-2.8g/kg）',
    description = '訓練前乳清 27g + 午餐 35-40g（不含膠原蛋白）+ 下午豌豆 16g + 蛋 6g + 堅果種子 ~25g + 🥛 希臘優格 ~28g + 晚餐 38-45g + 睡前酪蛋白 ~16g ≈ 191-203g。每餐 ≤45g，每日 5-6 餐均勻分配。⚠️ 膠原蛋白 10-15g 為額外結締組織修復用途，不計入合成代謝蛋白質目標。🔴 睡前酪蛋白（22:00）填補 19:00-08:00 長達 13hr 的蛋白質斷層。✅ 2.6-2.8g/kg 蛋白質對重訓運動員安全且有益（ISSN 立場聲明支持 1.6-2.7g/kg，高端適用於增肌期），腎功能正常者無風險。⚠️ 確保每日飲水 4-4.5L（訓練日）/ 3.5L（休息日）支持高蛋白代謝。🔴 休息日堅果種子減至 75g（~18g 蛋白），蛋白質降至 ~173-185g（2.4-2.5g/kg），配合休息日熱量目標 2,400-2,600kcal'
WHERE title LIKE '全天 蛋白質%';
