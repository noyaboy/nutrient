------------------------------------------------------------
-- 087: Nutrition Audit Round 2 (2026-03-02)
-- F1. Fix B-complex product update (086 targeted wrong name)
-- F2. Fix protein target to match actual intake (~180-192g)
-- F3. Rest day calorie alignment (reduce nuts/seeds on rest days)
-- F4. Calcium tablet: add small snack note for carbonate absorption
-- F5. Standardize eggs to 4/day minimum (choline consistency)
-- F6. Add avocado to lunch explicitly
-- F7. Folate: recommend B-complex 5 days/week instead of EOD
------------------------------------------------------------

-- === F1: Fix B-complex product (086 used wrong LIKE pattern) ===

UPDATE products
SET description = '活化型態 B 群：甲基鈷胺素（B12）、5-MTHF（葉酸）、P5P（B6 50mg）。⚠️ P5P 50mg/日長期有周邊神經病變風險（>25mg/日文獻個案）。🔴 建議方案：(A) 換用 ≤25mg B6 的 B-complex（如 Thorne Basic B Complex），每日服用（均 25mg/日，安全）。(B) 若繼續使用本品，改為每 3 天 1 顆（均 ~17mg/日）。每月自檢手腳麻木/刺痛。每半年健檢包含 B6 水平',
    usage = '⚠️ 目前隔日 1 顆隨午餐服用（P5P 50mg，均 25mg/日——風險閾值）。建議改為每 3 天 1 顆（均 ~17mg/日），或換用 ≤25mg B6 產品後恢復每日服用'
WHERE name LIKE 'B群%';

-- === F2: Fix protein target to match actual intake ===

UPDATE plan_items
SET title = '全天 蛋白質 180-192g+（2.5-2.6g/kg）',
    description = '訓練前乳清 27g + 午餐 35-40g（不含膠原蛋白）+ 下午豌豆 16g + 蛋 6g + 堅果種子 ~25g + 🥛 希臘優格 ~28g + 晚餐 38-45g + 睡前酪蛋白 ~16g ≈ 180-192g。每餐 ≤45g，每日 5-6 餐均勻分配。⚠️ 膠原蛋白 10-15g 為額外結締組織修復用途，不計入合成代謝蛋白質目標。🔴 睡前酪蛋白（22:00）填補 19:00-08:00 長達 13hr 的蛋白質斷層。✅ 2.5g/kg 蛋白質對重訓運動員安全且有益（ISSN 立場聲明建議 1.6-2.7g/kg），腎功能正常者無風險。⚠️ 確保每日飲水 3-3.5L 支持高蛋白代謝'
WHERE title LIKE '全天 蛋白質%';

-- === F3: Rest day calorie alignment ===

UPDATE plan_items
SET description = '重訓日 5-7g/kg (360-510g)、有氧日 3-4g/kg (215-290g)、休息日 3-3.5g/kg (220-255g)。重訓日熱量目標 3,100-3,400 kcal、休息日目標 2,400-2,600 kcal。🔴 休息日熱量控制：堅果種子從 110g 減至 75g（減少 ~200kcal 脂肪），或午餐橄欖油從 14g 減至 7g（減少 ~60kcal）。⚠️ 110g 堅果 + 42g 橄欖油 + 優格 + 正餐 = 休息日實際 ~2,800-3,000kcal，超出 200-400kcal。⚠️ 休息日碳水不可低於 3g/kg——低於此值造成每週熱量赤字（TDEE ~2,960 kcal/日），無法達成增肌目標 +0.5-1kg/月。⚠️ 高碳水日嚴格執行低纖維替換'
WHERE title LIKE '全天 碳水循環%';

-- === F4: Calcium tablet with small snack for carbonate absorption ===

UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：🥛 希臘優格 300g（~280mg 鈣，15:30 下午點心時段食用——距午餐鐵 3.5hr、距晚餐鐵 3.5hr，不影響鐵吸收）+ 深綠蔬菜（~150-200mg）。🔴 每日 17:00 服用鈣片 1 錠（+500mg）搭配小口柑橘類水果（碳酸鈣需胃酸溶解，空腹吸收率降低 30-40%，少量食物刺激胃酸分泌即可）——距 15:30 堅果鋅 1.5hr（鋅吸收完畢），距 19:00 晚餐鐵 2hr（鈣已離開腸道），距睡前鎂 5.5hr（無競爭）。板豆腐日：優格 280mg + 板豆腐 150-225mg + 鈣片 500mg + 蔬菜 150mg ≈ 1080-1155mg ✅。非板豆腐日：優格 280mg + 鈣片 500mg + 蔬菜 150mg + 酪蛋白 60-100mg ≈ 990-1080mg ✅'
WHERE title LIKE '全天 鈣攝取確認%';

-- === F5: Standardize eggs to 4/day, fix choline tracking ===

UPDATE plan_items
SET description = '每日確認膽鹼攝取達 AI 550mg。主力來源：雞蛋 4 顆/日（~560mg，蛋黃為核心）——⚠️ 嚴格 4 顆最低標準，3 顆僅 420mg 不達 AI。分配：非牛肉日 1 顆 15:30 + 3 顆晚餐；牛肉日 1-2 顆午餐 + 1 顆 15:30 + 晚餐補足。⚠️ 牛肉日雞蛋可能僅 2-3 顆（蛋白質額度被牛肉佔用），需額外補充：卵磷脂 1.5 大匙（~180mg）確保達 AI 550mg。⚠️ 豆腐日 / 低膽鹼蛋白日（非雞肉/鮭魚/牛肉）：即使 4 顆蛋（560mg）已達 AI，仍建議卵磷脂 1 大匙（~120mg）作為緩衝。膽鹼對肝臟脂肪代謝、神經傳導、甲基化代謝至關重要'
WHERE title LIKE '全天 膽鹼攝取確認%';

-- === F6: Add avocado to lunch explicitly ===

UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，⚠️ 不含膠原蛋白——膠原蛋白缺乏色胺酸與 BCAAs，非合成代謝等效蛋白質，僅作為結締組織修復補充）+ 蔬菜 + 🥑 酪梨半顆（必須，~350mg 鉀 + 7g 纖維 + 健康脂肪）（建議使用白米或冷卻再加熱白米飯以減少植酸干擾鐵吸收）。隨餐服用：魚油 2 顆（鮭魚日 1 顆）、D3 2000IU（2 顆）、葉黃素 20mg、膠原蛋白肽 10-15g（額外，含 VitC ~120-160mg）、維他命C 500mg 1 錠（搭配鐵質食物最大化吸收）、B群 1 顆（⚠️ 每 3 天服用 1 顆，或換 ≤25mg B6 產品後隔日服用）、肌酸 5g（溶於湯/飲品隨餐）。✅ 午餐總脂肪約 27-32g（橄欖油 14g + 酪梨 ~7g + 蛋/魚/肉脂肪），充足支持脂溶性 D3 與葉黃素吸收。⚠️ 堅果/種子請留至 15:30（避免鋅鐵 DMT1 競爭）'
WHERE title LIKE '12:00 午餐%';

-- === F7: B-complex frequency — every 3 days for P5P safety ===
-- (Already addressed in F1 product update and F6 lunch description)

-- === Update casein description to clarify protein content ===

UPDATE plan_items
SET description = '💪 晚餐 19:00 至入睡 00:00 長達 5 小時無蛋白質攝入，錯失夜間肌肉蛋白合成窗口。睡前 1-2 小時服用酪蛋白（casein）20g 粉（≈16g 蛋白質），緩釋氨基酸維持整夜 MPS。📋 首選酪蛋白粉 20g 沖泡（鈣含量僅 ~60-100mg，不干擾 22:30 鎂吸收）。次選希臘優格 200g（~180mg 鈣，建議提前至 21:30 服用，拉開與鎂的間隔至 60 分鐘）。⚠️ 與睡前補充品（甘胺酸+鎂）間隔 30-60 分鐘'
WHERE title LIKE '22:00 睡前酪蛋白%';

-- === Update egg product to reflect strict 4/day ===

UPDATE products
SET usage = '每日嚴格 4 顆（膽鹼 AI 550mg 最低保障）。非牛肉日：1 顆 15:30 + 3 顆晚餐。牛肉日：1-2 顆午餐 + 1 顆 15:30 + 補卵磷脂'
WHERE name LIKE '平飼雞蛋%';
