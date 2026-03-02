------------------------------------------------------------
-- 085: Nutrition Audit Fixes (2026-03-02)
-- 1. Move Magtein 09:15 → 15:00 (psyllium+chia+whey sabotage absorption)
-- 2. Extend lecithin to tofu days (choline shortfall on 3-egg non-beef days)
-- 3. Move calcium 17:30 → 17:00 (2hr gap from dinner iron)
-- 4. Fix Mg glycinate product usage (200mg → 150mg)
-- 5. Fix zinc product to reflect stopped status
-- 6. Add lunch fat adequacy note for D3/lutein
------------------------------------------------------------

-- === 1. Move Magtein from 09:15 to 15:00 ===

-- Update sleep supplement item: remove 09:15 Magtein reference
UPDATE plan_items
SET description = '甘胺酸 3g + 甘胺酸鎂 150mg（1.5 錠）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停）。洗完熱水澡後立即服用。💊 鈣片已移至 17:00（距睡前鎂 5.5hr，無鈣鎂競爭）。⚠️ Magtein 144mg 已移至 15:00 隨綠茶服用（空腹無競爭礦物質，認知效益最佳化）。補充品鎂合計 ~294mg（甘胺酸鎂 150mg + 蘇糖酸鎂 144mg PM），安全低於 UL 350mg'
WHERE title = '22:30 睡前補充品';

-- Update green tea item: add Magtein
UPDATE plan_items
SET description = '午餐後 3hr+ 再飲用（~15:00），高脂高蛋白午餐胃排空需 3-4hr，3hr 內 EGCG 仍會螯合鐵鋅。改用低咖啡因綠茶（白毫銀針或老白毫），天然 L-Theanine（40-90mg）+ EGCG 為下午專注紅利。15:30 前喝完（咖啡因 cutoff 統一 15:30）。🔴 下午僅喝綠茶，咖啡已移至 09:15 訓練前（避免下午咖啡干擾午餐鐵吸收）。💊 15:00 同時服用 Magtein 蘇糖酸鎂 3 顆（144mg 元素鎂）——空腹無纖維/植酸/鈣競爭，吸收率最佳。Magtein 認知效益下午服用同樣有效（半衰期 ~12hr）'
WHERE title = '15:00 綠茶 EGCG 2-3 杯';

-- Update Magtein product usage
UPDATE products
SET usage = '每日 3 顆（元素鎂 ~144mg），15:00 隨綠茶服用。空腹無纖維/植酸/鈣干擾，吸收率最佳'
WHERE name LIKE '蘇糖酸鎂%';

-- Update pre-workout item: remove Magtein reference if present in description
-- (Magtein was referenced in MEMORY.md as 09:15 but not explicitly in this item's description, so no change needed)

-- === 2. Extend lecithin usage to tofu days ===

-- Update choline tracking item
UPDATE plan_items
SET description = '每日確認膽鹼攝取達 AI 550mg。主力來源：雞蛋 3-4 顆（~420-560mg，蛋黃為核心）。⚠️ 牛肉日雞蛋僅 2-3 顆（~280-420mg），需額外補充：卵磷脂 1.5 大匙（~180mg）確保達 AI 550mg。⚠️ 豆腐日 / 低膽鹼蛋白日（雞蛋 <4 顆且非雞肉/鮭魚）：卵磷脂 1 大匙（~120mg）補足缺口。膽鹼對肝臟脂肪代謝、神經傳導、甲基化代謝至關重要。缺乏膽鹼可導致脂肪肝與肌肉損傷'
WHERE title LIKE '全天 膽鹼攝取確認%';

-- Update dinner item: extend lecithin rule
UPDATE plan_items
SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。隨餐服用：CoQ10 200mg + K2 100mcg（28g 橄欖油提供充足脂質）+ 維他命C 半錠 250mg（促進晚餐鐵吸收 + 覆蓋晚間需求）。⚠️ 鋅補劑已停用。晚餐避開全穀類植酸。💊 鈣片已移至 17:00（距晚餐 2hr，避免鈣抑制鐵吸收）。🔴 牛肉日：牛肉上限 150g，雞蛋分散至午餐+下午點心。⚠️ 膽鹼：每日至少 4 顆雞蛋，或牛肉日卵磷脂 1.5 大匙 / 豆腐日卵磷脂 1 大匙，確保達 AI 550mg'
WHERE title LIKE '19:00 晚餐%';

-- Update lecithin product usage
UPDATE products
SET usage = '牛肉日 1.5 大匙（~15g, ~180mg 膽鹼）隨餐。豆腐日或低膽鹼蛋白日（雞蛋 <4 顆且非雞肉/鮭魚）1 大匙（~10g, ~120mg 膽鹼）。或每日加入燕麥/優格'
WHERE name LIKE '卵磷脂%';

-- === 3. Move calcium 17:30 → 17:00 ===

-- Update afternoon snack item
UPDATE plan_items
SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）+ 🥜 綜合堅果 45g + 南瓜籽 35g + 核桃 15g + 葵花籽 15g（共 110g）。💊 17:00 服用鈣片 1 錠（500mg）——距堅果鋅 1.5hr（DMT1 轉運完畢），距晚餐鐵 2hr（鈣已離開腸道）。⚠️ 堅果/種子全部集中於此時段：避免午餐/晚餐鋅（堅果 ~5.5mg）與鐵競爭 DMT1 轉運蛋白（同餐鋅抑制非血基質鐵吸收 30-50%）。⚠️ 訓練日改用此組合。休息日可改為燕麥 80g + 藍莓 50g + 堅果種子 110g。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g'
WHERE title LIKE '15:30 下午點心%';

-- Update calcium tracking item
UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 300g（必須，~280mg 鈣）+ 深綠蔬菜（~150-200mg）。🔴 每日 17:00 服用鈣片 1 錠（+500mg）——距 15:30 堅果鋅 1.5hr（鋅吸收完畢），距 19:00 晚餐鐵 2hr（鈣片已離開腸道），距睡前鎂 5.5hr（無競爭）。板豆腐日：優格 280mg + 板豆腐 150-225mg + 鈣片 500mg + 蔬菜 150mg ≈ 1080-1155mg ✅。非板豆腐日：優格 280mg + 鈣片 500mg + 蔬菜 150mg ≈ 930mg'
WHERE title LIKE '全天 鈣攝取確認%';

-- Update calcium product description and usage
UPDATE products
SET description = '碳酸鈣 + 檸檬酸鈣雙鈣源。每日 17:00 服用（距 15:30 堅果鋅 1.5hr，距 19:00 晚餐鐵 2hr）。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加後總計 2150IU 仍在安全範圍。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）',
    usage = '每日 17:00 服用 1 錠（+500mg 鈣）。距 15:30 堅果鋅 1.5hr（鋅腸道吸收完畢），距 19:00 晚餐鐵 2hr（鈣片已離開腸道），距睡前鎂 5.5hr（無競爭）'
WHERE name LIKE '鈣片備用%';

-- === 4. Fix Mg glycinate product usage ===

UPDATE products
SET usage = '睡前 1.5 錠（150mg）。與蘇糖酸鎂 144mg（15:00 服用）合計補充品鎂 294mg，安全低於 UL 350mg'
WHERE name LIKE '甘胺酸鎂%';

-- === 5. Fix zinc product to reflect stopped status ===

UPDATE products
SET description = '⛔ 已停用（2026-03-01 營養審查）。飲食鋅已達 10-15mg/日（雞蛋 ~5mg + 肉類 ~5-12mg + 堅果 ~2-3mg），超過 RDA 11mg。額外補充 15mg 使總計達 25-30mg（接近 UL 40mg），鋅銅比過高。⚠️ 每半年驗血清鋅，若 <70mcg/dL 才考慮恢復補充。保留產品供參考',
    usage = '⛔ 已停用。飲食鋅已達 RDA 11mg，無需額外補充'
WHERE name LIKE '鋅 Zinc Picolinate%';

-- === 6. Add lunch fat adequacy note ===

UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，⚠️ 不含膠原蛋白——膠原蛋白缺乏色胺酸與 BCAAs，非合成代謝等效蛋白質，僅作為結締組織修復補充）+ 蔬菜（建議使用白米或冷卻再加熱白米飯以減少植酸干擾鐵吸收）。隨餐服用：魚油 2 顆（鮭魚日 1 顆）、D3 2000IU（2 顆）、葉黃素 20mg、膠原蛋白肽 10-15g（額外，含 VitC ~120-160mg）、維他命C 500mg 1 錠（搭配鐵質食物最大化吸收）、B群 1 顆（⚠️ 隔日服用——P5P 50mg/日長期有周邊神經病變風險）。🔴 CoQ10 與 K2 已移至晚餐（28g 橄欖油提供更充足脂質微膠粒）。✅ 午餐總脂肪約 20-25g（橄欖油 14g + 蛋/魚/肉脂肪），足以支持脂溶性 D3 與葉黃素吸收。⚠️ 午餐搭配維他命C食物（彩椒、花椰菜）促進鐵吸收。⚠️ 堅果/種子請留至 15:30（避免鋅鐵 DMT1 競爭）'
WHERE title LIKE '12:00 午餐%';

-- === Also update iron tracking item to reflect 17:00 calcium ===

UPDATE plan_items
SET description = '每日確認鐵吸收最佳化（男性 RDA 8mg）。🔴 鐵吸收促進因子：(1) 維他命C 午餐 500mg + 晚餐 250mg 隨餐（促進非血基質鐵吸收 2-6 倍）✅。(2) 動物蛋白「肉類因子」（MFP）促進鐵吸收。(3) 鈣片已移至 17:00——午餐/晚餐鐵均不再被鈣抑制（距晚餐 2hr）✅。(4) 堅果/種子移至 15:30——午餐/晚餐無鋅競爭 ✅。🔴 鐵吸收抑制因子：(1) 咖啡 09:15（午餐前 2.75hr+），影響 15-20%（搭配 VitC 500mg 淨正效益）✅。(2) 綠茶 15:00（午餐後 3hr+），影響有限 ✅。(3) 植酸：午餐使用白米。(4) 草酸（菠菜）：僅影響自身鐵。主要鐵來源：牛肉、雞蛋、菠菜、雞肝 2×/週 50g。⚠️ 每半年驗血清鐵蛋白 Ferritin 目標 50-150 ng/mL'
WHERE title LIKE '全天 鐵吸收最佳化%';
