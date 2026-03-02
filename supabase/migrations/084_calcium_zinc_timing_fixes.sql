-- Migration 084: Fix 5 nutrition issues
-- 1. Move calcium from 16:00 → 17:30 (calcium-zinc timing conflict)
-- 2. Prefer casein powder at bedtime (calcium-magnesium competition)
-- 3. Standardize psyllium dose (5g, not 8-10g)
-- 4. Increase pumpkin seeds 30g → 35g (zinc adequacy)
-- 5. Increase lecithin to 1.5 tbsp on beef days (choline adequacy)

-- === Fix 1: Move calcium from 16:00 to 17:30 ===

-- Update 15:30 afternoon snack: remove calcium 16:00 reference, add 17:30
UPDATE plan_items SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）+ 🥜 綜合堅果 45g + 南瓜籽 35g + 核桃 15g + 葵花籽 15g（共 110g）。💊 17:30 服用鈣片 1 錠（500mg）——距堅果鋅 2hr（DMT1 轉運完畢），距晚餐鐵 1.5hr（鈣已離開腸道）。⚠️ 堅果/種子全部集中於此時段：避免午餐/晚餐鋅（堅果 ~5.5mg）與鐵競爭 DMT1 轉運蛋白（同餐鋅抑制非血基質鐵吸收 30-50%）。⚠️ 訓練日改用此組合。休息日可改為燕麥 80g + 藍莓 50g + 堅果種子 110g。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g'
WHERE title = '15:30 下午點心';

-- Update calcium tracking
UPDATE plan_items SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 300g（必須，~280mg 鈣）+ 深綠蔬菜（~150-200mg）。🔴 每日 17:30 服用鈣片 1 錠（+500mg）——距 15:30 堅果鋅 2hr（鋅吸收完畢），距 19:00 晚餐鐵 1.5hr（鈣片已離開腸道），距睡前鎂 5hr（無競爭）。板豆腐日：優格 280mg + 板豆腐 150-225mg + 鈣片 500mg + 蔬菜 150mg ≈ 1080-1155mg ✅。非板豆腐日：優格 280mg + 鈣片 500mg + 蔬菜 150mg ≈ 930mg'
WHERE title = '全天 鈣攝取確認（目標 1000mg）';

-- Update dinner reference: 16:00 → 17:30
UPDATE plan_items SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。隨餐服用：CoQ10 200mg + K2 100mcg（28g 橄欖油提供充足脂質）+ 維他命C 半錠 250mg（促進晚餐鐵吸收 + 覆蓋晚間需求）。⚠️ 鋅補劑已停用。晚餐避開全穀類植酸。💊 鈣片已移至 17:30（距晚餐 1.5hr，避免鈣抑制鐵吸收）。🔴 牛肉日：牛肉上限 150g，雞蛋分散至午餐+下午點心。⚠️ 膽鹼：每日至少 4 顆雞蛋或牛肉日卵磷脂 1.5 大匙確保達 AI 550mg'
WHERE title = '19:00 晚餐 + 低 FODMAP 蔬菜';

-- Update bedtime supplements reference: 16:00 → 17:30
UPDATE plan_items SET description = '甘胺酸 3g + 甘胺酸鎂 150mg（1.5 錠）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停）。洗完熱水澡後立即服用。💊 鈣片已移至 17:30（距睡前鎂 5hr，無鈣鎂競爭）。⚠️ Magtein 144mg 在 09:15 服用（認知效益最佳化）。補充品鎂合計 ~294mg（甘胺酸鎂 150mg + 蘇糖酸鎂 144mg AM），安全低於 UL 350mg'
WHERE title = '22:30 睡前補充品';

-- Update iron optimization reference: 16:00 → 17:30
UPDATE plan_items SET description = '每日確認鐵吸收最佳化（男性 RDA 8mg）。🔴 鐵吸收促進因子：(1) 維他命C 午餐 500mg + 晚餐 250mg 隨餐（促進非血基質鐵吸收 2-6 倍）✅。(2) 動物蛋白「肉類因子」（MFP）促進鐵吸收。(3) 鈣片已移至 17:30——午餐/晚餐鐵均不再被鈣抑制 ✅。(4) 堅果/種子移至 15:30——午餐/晚餐無鋅競爭 ✅。🔴 鐵吸收抑制因子：(1) 咖啡 09:15（午餐前 2.75hr+），影響 15-20%（搭配 VitC 500mg 淨正效益）✅。(2) 綠茶 15:00（午餐後 3hr+），影響有限 ✅。(3) 植酸：午餐使用白米。(4) 草酸（菠菜）：僅影響自身鐵。主要鐵來源：牛肉、雞蛋、菠菜、雞肝 2×/週 50g。⚠️ 每半年驗血清鐵蛋白 Ferritin 目標 50-150 ng/mL'
WHERE title = '全天 鐵吸收最佳化確認（目標 RDA 8mg）';

-- Update calcium product
UPDATE products SET
  description = '碳酸鈣 + 檸檬酸鈣雙鈣源。每日 17:30 服用（距 15:30 堅果鋅 2hr，距 19:00 晚餐鐵 1.5hr）。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加後總計 2150IU 仍在安全範圍。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）',
  usage = '每日 17:30 服用 1 錠（+500mg 鈣）。距 15:30 堅果鋅 2hr（鋅腸道吸收完畢），距 19:00 晚餐鐵 1.5hr（鈣片已離開腸道），距睡前鎂 5hr（無競爭）'
WHERE name LIKE '鈣片備用%';

-- === Fix 2: Prefer casein powder at bedtime ===

UPDATE plan_items SET description = '💪 晚餐 19:00 至入睡 00:00 長達 5 小時無蛋白質攝入，錯失夜間肌肉蛋白合成窗口。睡前 1-2 小時服用酪蛋白（casein）20g，緩釋氨基酸維持整夜 MPS。📋 首選酪蛋白粉 20g 沖泡（鈣含量僅 ~60-100mg，不干擾 22:30 鎂吸收）。次選希臘優格 200g（~180mg 鈣，建議提前至 21:30 服用，拉開與鎂的間隔至 60 分鐘）。⚠️ 與睡前補充品（甘胺酸+鎂）間隔 30-60 分鐘。蛋白質總量更新：訓練前 27g + 午餐 41-44g + 下午 16g + 晚餐 38-45g + 睡前 20g ≈ 142-152g（1.9-2.1g/kg）'
WHERE title = '22:00 睡前酪蛋白 20g';

-- === Fix 3: Standardize psyllium dose ===

-- Fix 09:15 training nutrition: 8-10g → 5g psyllium
UPDATE plan_items SET description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ 肌酸 5g（溶於乳清一起沖泡）+ 奇亞籽 15g（~5g 纖維 + 2.5g ALA omega-3）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉+奇亞籽（先泡水 10 分鐘形成凝膠再加入乳清）。🔴 訓練日纖維補強：奇亞籽 15g（5g 纖維）+ 洋車前子殼 5g（4g 纖維）= 額外 9g 纖維，搭配午餐前洋車前子殼 5g（4g）+ 蔬菜 5-8g 達標 35g+。地瓜需 60-90 分鐘消化，若要吃請提前至 08:00。⚠️ 堅果/種子請留至 15:30 下午點心（避免訓練前高脂延緩胃排空 + 保護午晚餐鐵吸收）'
WHERE title = '09:15 訓練前營養';

-- Fix fiber tracking: 8-10g → 5g+5g
UPDATE plan_items SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜（抗性澱粉）。搭配發酵食物（優格、泡菜 ≤30g/日）增強腸道多樣性。⚠️ 訓練日注意：低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）可能使纖維降至 20-25g。訓練日補充：奇亞籽 15g（5g 纖維）+ 洋車前子殼 5g 早上 + 5g 午餐前（共 8g 纖維）= 額外 13g，搭配蔬菜 5-8g 達標 35g+。🔴 葉酸保險：B群休息日（隔日無 B-complex），15:30 點心加入浸泡扁豆/鷹嘴豆 100g（~180mcg 葉酸 + 6-8g 纖維）——浸泡 8hr+ 可減少植酸 50-70%，確保每日葉酸 ≥400mcg DFE'
WHERE title = '全天 膳食纖維 35-45g';

-- Fix psyllium plan item
UPDATE plan_items SET description = '重訓日低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）會使膳食纖維降至 20-25g，距目標 35g+ 缺口 10-15g。09:15 訓練前洋車前子殼 5g（4g 纖維）+ 午餐前洋車前子殼 5g（4g 纖維）= 共 8g 額外纖維。⚠️ 每次必須搭配充足水分（250ml+），否則可能引起腸阻塞。⚠️ 僅訓練日使用——休息日正常飲食纖維已達標 35g+，無需額外補充'
WHERE title = '訓練日 洋車前子殼 5g（纖維補充）';

-- Fix psyllium product usage
UPDATE products SET usage = '訓練日 09:15 5g + 午餐前 5g，各沖 250ml 水'
WHERE name LIKE '洋車前子殼粉%';

-- === Fix 4: Increase pumpkin seeds 30g → 35g ===

-- Update nuts product description and usage
UPDATE products SET
  description = '（每日必須）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅、維他命E、硒來源。🔴 份量：堅果 45g + 南瓜籽 35g + 核桃 15g + 葵花籽 15g = 共 ~110g/日。🟢 鋅補強：南瓜籽 35g 提供 ~2.9mg 鋅，確保非牛肉日鋅攝取 ≥11mg RDA。維他命E 修正：堅果 45g ~5.4mg + 葵花籽 15g ~5.3mg + 核桃 15g ~0.3mg + 橄欖油 42g ~5.9mg + 酪梨 ~0.7mg = ~17.6mg（搭配南瓜籽 35g ~0.7mg = ~18.3mg，達 RDA 15mg）。🔴 Omega-6 改善：葵花籽從 25-30g 減至 15g（減少 ~6.5g omega-6），核桃 15g 提供 ~1.3g ALA omega-3。🔴 鮭魚日嚴格禁止巴西堅果。⚠️ 巴西堅果嚴格 1 顆/日上限',
  usage = '每日必須（堅果 45g + 南瓜籽 35g + 核桃 15g + 葵花籽 15g = ~110g）',
  purchase_note = '每日必須 ~110g。全部集中於 15:30 下午點心食用（避免午晚餐鋅鐵競爭）。線上可訂（常溫配送）。1.13kg 堅果約 3.5 週。另購：南瓜籽 500g + 核桃 500g + 葵花籽 500g（全聯/Costco）。🔴 鮭魚日跳過巴西堅果'
WHERE name LIKE '綜合堅果%';

-- === Fix 5: Fix choline shortfall on beef days ===

UPDATE plan_items SET description = '每日確認膽鹼攝取達 AI 550mg。主力來源：雞蛋 3-4 顆（~420-560mg，蛋黃為核心）。⚠️ 牛肉日雞蛋僅 2-3 顆（~280-420mg），需額外補充：卵磷脂 1.5 大匙（~180mg）確保達 AI 550mg。膽鹼對肝臟脂肪代謝、神經傳導、甲基化代謝至關重要。缺乏膽鹼可導致脂肪肝與肌肉損傷'
WHERE title = '全天 膽鹼攝取確認（目標 AI 550mg）';

-- Update lecithin product
UPDATE products SET
  description = '向日葵卵磷脂（非大豆），富含磷脂醯膽鹼（Phosphatidylcholine）。牛肉日膽鹼補充主力，每大匙（~10g）含 ~120mg 膽鹼。牛肉日用 1.5 大匙（~180mg 膽鹼）確保達 AI 550mg。非基改、無大豆過敏風險',
  usage = '牛肉日 1.5 大匙（~15g, ~180mg 膽鹼）隨餐，或每日加入燕麥/優格'
WHERE name LIKE '卵磷脂顆粒%';
