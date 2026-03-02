------------------------------------------------------------
-- 081: Nutrition Review — 10 Fixes (2026-03-01)
--
-- 🔴 CRITICAL:
-- 1. Vitamin A excess: chicken liver 2×/wk 100g → 2×/wk 50g
-- 2. Ca-Fe competition: calcium dinner→16:00 between meals
-- 3. Vitamin C gap at dinner: add 250mg, move 500mg to lunch
--
-- 🟡 HIGH:
-- 4. Zinc marginal on non-beef days: add pumpkin seeds 30g
-- 5. Omega-6 excess: sunflower seeds 25-30g → 15g + walnuts 15g
-- 6. Training day fiber: add chia seeds 15g to morning shake
-- 7. Pre-sleep protein: add casein 20g at 22:00
--
-- 🟢 MODERATE:
-- 8. Fish oil: 3→2 caps baseline, salmon days 1 cap
-- 9. K2 move lunch→dinner (better fat vehicle)
-- 10. Vitamin C timing: 500mg breakfast→lunch
------------------------------------------------------------

-- ============================================================
-- #1: Reduce chicken liver to 50g per serving (vitamin A safety)
-- 22,000mcg RAE/wk at 2×100g exceeds UL. 2×50g = 11,000mcg/wk = ~1,571mcg/day avg (safe)
-- ============================================================
UPDATE products
SET description = '鐵質最強食物來源。每 100g 含血基質鐵 ~11mg（吸收率 25-35%）。另含維他命A（視黃醇形式）、B12、葉酸、銅。🔴 每週 2 次 50g（從 100g 減量——2×100g 週均維他命A ~3,140mcg RAE/日超 UL 3000mcg。2×50g = ~1,571mcg RAE/日，安全且仍覆蓋 BCMO1 poor converters 需求）。⚠️ 每週上限 100g 總量',
    usage = '每週 2 次午餐入菜（每次 50g），替代當天其他動物蛋白。⚠️ 嚴格上限 2 次/週各 50g'
WHERE name LIKE '雞肝%';

-- Update vitamin A tracker
UPDATE plan_items
SET description = '每日確認維他命A攝取。主要來源：橘色地瓜 100g（~700mcg RAE β-胡蘿蔔素）+ 雞蛋 3-4 顆（~270-360mcg RAE）+ 雞肝 2×/週 50g（~5,500mcg RAE/次，攤平 ~1,571mcg/日）= 週均 ~2,271-2,631mcg RAE/日（安全低於 UL 3000mcg）。⚠️ 地瓜必須選橘色品種（台農 57 號）。搭配油脂烹調（β-胡蘿蔔素為脂溶性）。無地瓜日可用胡蘿蔔 50g（~400mcg RAE）替代'
WHERE title LIKE '%維他命A攝取%';

-- ============================================================
-- #2: Move calcium from dinner (19:00) to 16:00 between meals
-- Eliminates Ca-Fe competition at dinner (was inhibiting 50-60%)
-- 16:00 afternoon snack is low-iron (pea protein + egg = mostly)
-- ============================================================
UPDATE plan_items
SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。⚠️ 鋅補劑已停用（飲食鋅 10-15mg 已達 RDA 11mg）。晚餐避開全穀類（糙米、燕麥）的植酸。🔴 牛肉日：牛肉上限 150g，雞蛋 1-2 顆移至午餐、1 顆移至 15:30 下午點心。⚠️ 膽鹼（Choline）注意：每日至少 4 顆雞蛋或每日卵磷脂 1 大匙確保達 AI 550mg。⚠️ 晚餐隨餐 CoQ10 200mg（28g 橄欖油提供充足脂質微膠粒）。💊 鈣片已移至 16:00 下午點心時段——(1) 避免晚餐鈣抑制鐵吸收 50-60%，(2) 16:00 距午餐鐵吸收已過 4hr 無競爭，(3) 距睡前鎂 6.5hr 無競爭'
WHERE title LIKE '%晚餐 + 低 FODMAP%';

-- Update calcium all-day tracker
UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 300g（必須，~280mg 鈣）+ 深綠蔬菜（~150-200mg）。🔴 每日 16:00 服用鈣片 1 錠（+500mg）——從晚餐移至 16:00 下午點心時段，避免晚餐鐵吸收被鈣抑制 50-60%。16:00 距午餐鐵已過 4hr（十二指腸吸收完畢），距睡前鎂 6.5hr（無競爭）。板豆腐日：優格 280mg + 板豆腐 150-225mg + 鈣片 500mg + 蔬菜 150mg ≈ 1080-1155mg ✅。非板豆腐日：優格 280mg + 鈣片 500mg + 蔬菜 150mg ≈ 930mg'
WHERE title LIKE '%鈣攝取確認%';

-- Update calcium product
UPDATE products
SET usage = '每日 16:00 下午點心時段服用 1 錠（+500mg 鈣）。從晚餐 19:00 移至 16:00——避免晚餐鈣抑制鐵吸收 50-60%，且距睡前鎂 6.5hr 無競爭',
    description = '碳酸鈣 + 檸檬酸鈣雙鈣源。每日 16:00 下午點心時段服用（從晚餐移出——鈣 500mg 抑制同餐非血基質鐵吸收 50-60%）。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加後總計 2150IU 仍在安全範圍。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）'
WHERE name LIKE '鈣片備用%';

-- Update afternoon snack to note calcium timing
UPDATE plan_items
SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）。💊 16:00 服用鈣片 1 錠（500mg）——低鐵點心時段，不干擾任何礦物質吸收。⚠️ 訓練日改用此組合。休息日可改為燕麥 80g + 藍莓 50g。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g'
WHERE title LIKE '%下午點心%' AND is_active = true;

-- ============================================================
-- #3 & #10: Vitamin C timing optimization
-- Move 500mg tablet from breakfast to lunch (iron-rich meal)
-- Add 250mg at dinner for iron absorption + evening coverage
-- ============================================================
UPDATE products
SET description = '每日 Vit C 補充。🔴 分時服用最大化吸收：午餐 1 錠（500mg，搭配鐵質食物促進吸收 2-6 倍）+ 晚餐半錠（250mg，覆蓋晚餐鐵吸收需求）。膠原蛋白日午餐已含 VitC 120-160mg，仍建議服用 1 錠以確保鐵吸收最佳化。⚠️ 切半錠備晚餐用——500mg 錠劑用切藥器對半切開，半錠隨晚餐服用。Vit C 半衰期 ~2hr，分次服用維持血中濃度',
    usage = '午餐 1 錠（500mg）+ 晚餐半錠（250mg）。每日共 750mg，分 2 次服用'
WHERE name LIKE '維他命 C%NOW%';

-- Update lunch to include Vit C tablet
UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，不含膠原蛋白）+ 蔬菜（建議使用白米或冷卻再加熱白米飯以減少植酸干擾鐵吸收）。隨餐服用：魚油 2 顆（鮭魚日 1 顆）、D3 2000IU（2 顆）、葉黃素 20mg、膠原蛋白肽 10-15g（額外，含 VitC ~120-160mg）、維他命C 500mg 1 錠（搭配鐵質食物最大化吸收）、B群 1 顆（⚠️ 隔日服用——P5P 50mg/日長期有周邊神經病變風險）。🔴 CoQ10 與 K2 已移至晚餐（28g 橄欖油提供更充足脂質微膠粒）。⚠️ 午餐搭配維他命C食物（彩椒、花椰菜）促進鐵吸收'
WHERE title LIKE '%午餐 + 訓練後%';

-- Update dinner to include Vit C 250mg + K2
UPDATE plan_items
SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。隨餐服用：CoQ10 200mg + K2 100mcg（28g 橄欖油提供充足脂質）+ 維他命C 半錠 250mg（促進晚餐鐵吸收 + 覆蓋晚間需求）。⚠️ 鋅補劑已停用。晚餐避開全穀類植酸。💊 鈣片已移至 16:00（避免晚餐鈣抑制鐵吸收）。🔴 牛肉日：牛肉上限 150g，雞蛋分散至午餐+下午點心。⚠️ 膽鹼：每日至少 4 顆雞蛋或每日卵磷脂 1 大匙確保達 AI 550mg'
WHERE title LIKE '%晚餐 + 低 FODMAP%';

-- ============================================================
-- #4: Fix marginal zinc — add pumpkin seeds 30g
-- Non-beef days zinc ~8-9mg vs RDA 11mg. Pumpkin seeds 30g = +2.5mg zinc
-- ============================================================
UPDATE products
SET description = '（每日必須）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅、維他命E、硒來源。🔴 份量：堅果 45g + 南瓜籽 30g + 核桃 15g + 葵花籽 15g = 共 ~105g/日。🟢 鋅補強：南瓜籽 30g 提供 ~2.5mg 鋅，確保非牛肉日鋅攝取 ≥11mg RDA。維他命E 修正：堅果 45g ~5.4mg + 葵花籽 15g ~5.3mg + 核桃 15g ~0.3mg + 橄欖油 42g ~5.9mg + 酪梨 ~0.7mg = ~17.6mg（搭配南瓜籽 30g ~0.6mg = ~18.2mg，偏低但達 RDA 15mg）。🔴 Omega-6 改善：葵花籽從 25-30g 減至 15g（減少 ~6.5g omega-6），核桃 15g 提供 ~1.3g ALA omega-3。🔴 鮭魚日嚴格禁止巴西堅果。⚠️ 巴西堅果嚴格 1 顆/日上限',
    usage = '每日必須（堅果 45g + 南瓜籽 30g + 核桃 15g + 葵花籽 15g = ~105g）',
    purchase_note = '每日必須 ~105g。線上可訂（常溫配送）。1.13kg 堅果約 3.5 週。另購：南瓜籽 500g + 核桃 500g + 葵花籽 500g（全聯/Costco）。🔴 鮭魚日跳過巴西堅果'
WHERE name LIKE '綜合堅果%';

-- ============================================================
-- #5: Omega-6 fix (handled in #4 above — sunflower seeds reduced,
-- walnuts added for ALA omega-3)
-- ============================================================

-- ============================================================
-- #6: Close training day fiber gap — add chia seeds 15g
-- ============================================================
UPDATE plan_items
SET description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ 肌酸 5g（溶於乳清一起沖泡）+ 奇亞籽 15g（~5g 纖維 + 2.5g ALA omega-3）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉+奇亞籽（先泡水 10 分鐘形成凝膠再加入乳清）。🔴 訓練日纖維補強：奇亞籽 15g（5g 纖維）+ 洋車前子殼 8-10g（6.4-8g）= 額外 11-13g 纖維，搭配蔬菜 5-8g 達標 35g+。地瓜需 60-90 分鐘消化，若要吃請提前至 08:00'
WHERE title LIKE '%訓練前營養%';

-- ============================================================
-- #7: Add pre-sleep casein protein at 22:00
-- 5hr gap between dinner and sleep = missed overnight MPS opportunity
-- ============================================================
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('22:00 睡前酪蛋白 20g', '💪 晚餐 19:00 至入睡 00:00 長達 5 小時無蛋白質攝入，錯失夜間肌肉蛋白合成窗口。睡前 1-2 小時服用酪蛋白（casein）20g，緩釋氨基酸維持整夜 MPS。📋 選項：(1) 酪蛋白粉 20g 沖泡，(2) 希臘優格 200g（若當日優格總量未達 300g），(3) cottage cheese 200g。⚠️ 與睡前補充品（甘胺酸+鎂）間隔 30 分鐘，避免大量液體影響入睡。蛋白質總量更新：訓練前 27g + 午餐 41-44g + 下午 16g + 晚餐 38-45g + 睡前 20g ≈ 142-152g（1.9-2.1g/kg）', 'daily', '飲食', 16, 1, true);

-- Update protein tracker
UPDATE plan_items
SET title = '全天 蛋白質 142-152g+（1.9-2.1g/kg）',
    description = '訓練前乳清 27g + 午餐 41-44g + 下午豌豆 16g + 晚餐 38-45g + 睡前酪蛋白 20g ≈ 142-152g。每餐 ≤45g，每日 5 餐均勻分配，總計約 1.9-2.1g/kg。🔴 睡前酪蛋白（22:00）填補 19:00-08:00 長達 13hr 的蛋白質斷層，多項 RCT 證實睡前酪蛋白顯著提升夜間肌肉蛋白合成率'
WHERE title LIKE '%蛋白質 122-132g%';

-- ============================================================
-- #8: Reduce fish oil to 2 caps baseline
-- Benefits plateau at ~1500-2000mg EPA+DHA
-- ============================================================
UPDATE products
SET usage = '每日隨餐 2 顆（EPA+DHA 共 1400mg）。⚠️ 鮭魚日減為 1 顆（700mg + 鮭魚 ~1200mg ≈ 1900mg）。從 3 顆降至 2 顆——EPA+DHA 效益在 1500-2000mg 趨於平穩，>2000mg 增加 LDL 氧化與出血風險',
    description = '每 1200mg 魚油含 Omega-3 約 700mg（EPA 419mg + DHA 281mg）。沙丁魚、鯷魚、鯖魚來源，緩釋不打嗝。產地加拿大。🔴 從 3 顆降至 2 顆/日——EPA+DHA 1400mg 已覆蓋心血管保護與抗發炎效益（VITAL 試驗支持 840mg+），>2000mg/日額外效益有限但出血風險增加',
    purchase_note = '線上可訂（常溫配送）。每日 2 顆，180 顆可用 3 個月。⚠️ 開瓶後必須冷藏（2-8°C），每次取用後迅速旋緊瓶蓋。📋 在瓶身標註開瓶日期，開瓶後 60 天內用完。⚠️ 有腥味或苦味表示已氧化變質，立即丟棄。'
WHERE name LIKE '緩釋魚油%';

-- Update lunch fish oil reference
-- (Already handled in lunch update above — "魚油 2 顆（鮭魚日 1 顆）")

-- ============================================================
-- #9: Move K2 from lunch to dinner (28g olive oil = better absorption)
-- ============================================================
UPDATE products
SET usage = '每日 1 顆隨晚餐（19:00）服用——從午餐移至晚餐，28g 橄欖油提供更充足脂質載體提升脂溶性 K2 吸收。MK-7 半衰期 ~72hr，每日 1 次即可',
    description = '獨立 K2 MK-7（納豆來源），引導鈣質沉積至骨骼而非血管壁。與 D3 協同作用，防止動脈鈣化。🔴 已移至晚餐（19:00，搭配 28g 橄欖油）——午餐僅 14g 橄欖油，晚餐 28g 提供更充足脂質微膠粒，脂溶性維生素吸收提升 30-50%'
WHERE name LIKE '維他命 K2%';

-- ============================================================
-- #10: Vitamin C timing (handled in #3 above)
-- ============================================================

-- ============================================================
-- Update iron absorption tracker to reflect new changes
-- ============================================================
UPDATE plan_items
SET description = '每日確認鐵吸收最佳化（男性 RDA 8mg）。🔴 鐵吸收促進因子：(1) 維他命C 午餐 500mg + 晚餐 250mg 隨餐（促進非血基質鐵吸收 2-6 倍）✅。(2) 動物蛋白「肉類因子」（MFP）促進鐵吸收。(3) 鈣片已移至 16:00 下午點心——午餐/晚餐鐵均不再被鈣抑制 ✅。🔴 鐵吸收抑制因子：(1) 咖啡 15:00（午餐後 3hr），影響 5-10% ✅。(2) 綠茶 15:30（3.5hr 後），影響有限 ✅。(3) 植酸：午餐使用白米。(4) 草酸（菠菜）：僅影響自身鐵。主要鐵來源：牛肉、雞蛋、菠菜、雞肝 2×/週 50g。⚠️ 每半年驗血清鐵蛋白 Ferritin 目標 50-150 ng/mL'
WHERE title LIKE '%鐵吸收最佳化%';

-- ============================================================
-- Update bedtime supplements (calcium already removed in 080, confirm)
-- ============================================================

-- ============================================================
-- Update Magtein timing note (pre-workout, already correct from 080)
-- Confirm bedtime is clean: glycine + Mg glycinate + ashwagandha only
-- ============================================================
UPDATE plan_items
SET description = '甘胺酸 3g + 甘胺酸鎂 150mg（1.5 錠）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停）。洗完熱水澡後立即服用。💊 鈣片已移至 16:00 下午點心時段（避免鈣鎂競爭+晚餐鐵干擾）。⚠️ Magtein 144mg 在 09:15 服用（認知效益最佳化）。補充品鎂合計 ~294mg（甘胺酸鎂 150mg + 蘇糖酸鎂 144mg AM），安全低於 UL 350mg'
WHERE title LIKE '%睡前補充品%';

-- ============================================================
-- Seed file note: 002_seed_data.sql should be updated separately
-- to reflect these changes for fresh deploys.
-- ============================================================
