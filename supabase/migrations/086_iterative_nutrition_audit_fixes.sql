------------------------------------------------------------
-- 086: Iterative Nutrition Audit Fixes (2026-03-02)
-- F1. Move Magtein 15:00 → 14:00 (EGCG chelates Mg²⁺ at 15:00)
-- F2. Correct chicken liver Vitamin A value (5500 → ~1650 RAE/50g cooked)
-- F3. B6 neuropathy mitigation (switch to ≤25mg B6 B-complex or every-3rd-day)
-- F4. Deactivate copper supplement plan item (dietary Cu sufficient)
-- F5. Greek yogurt timing → 15:30 (away from meal iron)
-- F6. Move creatine 09:15 → 12:00 lunch (separate from caffeine)
-- F7. Psyllium: drop 09:15 dose, use pre-lunch 5g + 15:30 snack 5g (protect dinner CoQ10/K2)
-- F8. Coconut water mandatory daily (potassium gap fix)
------------------------------------------------------------

-- === F1: Move Magtein from 15:00 to 14:00 (separate from EGCG) ===

UPDATE plan_items
SET description = '午餐後 3hr+ 再飲用（~15:00），高脂高蛋白午餐胃排空需 3-4hr，3hr 內 EGCG 仍會螯合鐵鋅。改用低咖啡因綠茶（白毫銀針或老白毫），天然 L-Theanine（40-90mg）+ EGCG 為下午專注紅利。15:30 前喝完（咖啡因 cutoff 統一 15:30）。🔴 下午僅喝綠茶，咖啡已移至 09:15 訓練前（避免下午咖啡干擾午餐鐵吸收）。⚠️ Magtein 已移至 14:00（見下方說明），本時段僅喝綠茶，不服用任何礦物質補充品——EGCG 為強效二價陽離子螯合劑（Mg²⁺、Zn²⁺、Fe²⁺），與 Magtein 同服會顯著降低鎂吸收率'
WHERE title = '15:00 綠茶 EGCG 2-3 杯';

UPDATE plan_items
SET description = '甘胺酸 3g + 甘胺酸鎂 150mg（1.5 錠）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停）。洗完熱水澡後立即服用。💊 鈣片已移至 17:00（距睡前鎂 5.5hr，無鈣鎂競爭）。💊 Magtein 144mg 已移至 14:00（午餐後 2hr 空腹，避開 15:00 綠茶 EGCG 螯合）。補充品鎂合計 ~294mg（甘胺酸鎂 150mg + 蘇糖酸鎂 144mg PM），安全低於 UL 350mg'
WHERE title = '22:30 睡前補充品';

UPDATE products
SET usage = '每日 3 顆（元素鎂 ~144mg），14:00 空腹服用（午餐後 2hr）。⚠️ 不可與 15:00 綠茶同服——EGCG 螯合 Mg²⁺ 降低吸收率。距 17:00 鈣片 3hr，無競爭'
WHERE name LIKE '蘇糖酸鎂%';

-- === F2: Correct chicken liver Vitamin A value ===

UPDATE plan_items
SET description = '每日確認維他命A攝取。主要來源：橘色地瓜 100g（~700mcg RAE β-胡蘿蔔素）+ 雞蛋 3-4 顆（~270-360mcg RAE）+ 雞肝 2×/週 50g 熟重（~1,650mcg RAE/次，USDA 熟雞肝 ~3,300 RAE/100g）。⚠️ 必須使用熟重計量——生雞肝 ~11,000 RAE/100g，若誤用生重 50g = 5,500mcg 將超過 UL 3,000mcg。熟重 50g = 1,650mcg + 蛋 360mcg = 2,010mcg 預成型視黃醇，安全低於 UL。攤平週均 ~1,441-1,531mcg RAE/日。⚠️ 地瓜必須選橘色品種（台農 57 號）。搭配油脂烹調（β-胡蘿蔔素為脂溶性）。無地瓜日可用胡蘿蔔 50g（~400mcg RAE）替代'
WHERE title LIKE '全天 維他命A攝取確認%';

-- === F3: B6 neuropathy — add mitigation to B-complex product and lunch item ===

UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，⚠️ 不含膠原蛋白——膠原蛋白缺乏色胺酸與 BCAAs，非合成代謝等效蛋白質，僅作為結締組織修復補充）+ 蔬菜（建議使用白米或冷卻再加熱白米飯以減少植酸干擾鐵吸收）。隨餐服用：魚油 2 顆（鮭魚日 1 顆）、D3 2000IU（2 顆）、葉黃素 20mg、膠原蛋白肽 10-15g（額外，含 VitC ~120-160mg）、維他命C 500mg 1 錠（搭配鐵質食物最大化吸收）、B群 1 顆（⚠️ 隔日服用）。🔴 B6 劑量管控：目前 NOW B-50 含 P5P 50mg/顆，隔日服均 25mg/日——位於周邊神經病變風險閾值。建議換用 ≤25mg B6 的 B-complex（如 Thorne Basic B Complex），或改為每 3 天服用 1 顆（均 ~17mg/日）。⚠️ 每月自檢手腳有無持續麻木/刺痛/灼熱感，有症狀立即停用。🔴 肌酸 5g 已移至午餐隨餐服用（碳水+胰島素促進肌酸攝取，且避免與 09:15 咖啡因同服）。✅ 午餐總脂肪約 20-25g（橄欖油 14g + 蛋/魚/肉脂肪），足以支持脂溶性 D3 與葉黃素吸收。⚠️ 堅果/種子請留至 15:30（避免鋅鐵 DMT1 競爭）'
WHERE title LIKE '12:00 午餐%';

UPDATE products
SET description = '活化型態 B 群：甲基鈷胺素（B12）、5-MTHF（葉酸）、P5P（B6 50mg）。⚠️ P5P 50mg/日長期有周邊神經病變風險（>25mg/日）。🔴 建議方案：(A) 換用 ≤25mg B6 的 B-complex（如 Thorne Basic B Complex 25mg P5P），隔日服均 12.5mg/日（安全）。(B) 若繼續使用本品，改為每 3 天 1 顆（均 ~17mg/日）。每月自檢手腳麻木/刺痛。每半年健檢包含 B6 水平',
    usage = '⚠️ 目前隔日 1 顆隨午餐服用（P5P 50mg 均 25mg/日——風險閾值）。建議改為每 3 天 1 顆（均 ~17mg/日），或換用 ≤25mg B6 產品後恢復隔日服用'
WHERE name LIKE 'B-Complex%';

-- === F4: Deactivate copper supplement plan item (product already stopped) ===

-- The '14:00-15:00 銅 2mg 補充' item is already inactive (is_active=false in seed)
-- But '14:00-15:00 午餐補銅 2mg' may still be active — deactivate it
UPDATE plan_items
SET is_active = false,
    description = '⛔ 已停用（2026-03-02 營養審查）。飲食銅已達 1.3-1.7mg/日（黑巧克力 0.5mg + 堅果 0.3-0.5mg + 可可粉 0.2mg + 其他 ~0.3mg），超過 RDA 0.9mg。鋅補劑已停用，無需額外補銅維持鋅銅比。保留全天銅攝取確認追蹤項'
WHERE title LIKE '14:00-15:00 午餐補銅%' AND is_active = true;

-- === F5: Greek yogurt timing specified at 15:30 + F8: Coconut water mandatory ===

UPDATE plan_items
SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）+ 🥜 綜合堅果 45g + 南瓜籽 35g + 核桃 15g + 葵花籽 15g（共 110g）+ 🥛 希臘優格 300g（~280mg 鈣，此時段距午餐鐵 3.5hr、距晚餐鐵 3.5hr，鈣對正餐鐵吸收無影響）+ 🥥 椰子水 330ml（~600mg 鉀，每日必喝，鉀缺口核心補充）。💊 17:00 服用鈣片 1 錠（500mg）——距堅果鋅 1.5hr（DMT1 轉運完畢），距晚餐鐵 2hr（鈣已離開腸道）。⚠️ 堅果/種子全部集中於此時段：避免午餐/晚餐鋅（堅果 ~5.5mg）與鐵競爭 DMT1 轉運蛋白。⚠️ 訓練日本時段加 洋車前子殼 5g（見 F7），無脂溶性補充品不受影響。休息日可改為燕麥 80g + 藍莓 50g + 堅果種子 110g + 優格 + 椰子水。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g'
WHERE title LIKE '15:30 下午點心%';

-- === F6: Move creatine from 09:15 to 12:00 lunch ===

UPDATE plan_items
SET description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ 奇亞籽 15g（~5g 纖維 + 2.5g ALA omega-3）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉+奇亞籽（先泡水 10 分鐘形成凝膠再加入乳清）。🔴 肌酸 5g 已移至午餐 12:00 隨餐（碳水+胰島素促進肌酸攝取 + 避免與咖啡因同服——部分研究顯示咖啡因可能減弱肌酸肌肉效益）。地瓜需 60-90 分鐘消化，若要吃請提前至 08:00。⚠️ 堅果/種子請留至 15:30 下午點心（避免訓練前高脂延緩胃排空 + 保護午晚餐鐵吸收）'
WHERE title = '09:15 訓練前營養';

-- Update creatine product usage
UPDATE products
SET usage = '每日 5g 溶於午餐湯/飲品（12:00 隨餐），碳水+胰島素促進肌酸攝取。已從 09:15 訓練前移出（避免與咖啡因同服）。454g ÷ 5g = 90 天'
WHERE name LIKE '肌酸%';

-- === F7: Psyllium — drop 09:15 dose, use pre-lunch 5g + 15:30 snack 5g ===

UPDATE plan_items
SET description = '重訓日低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）會使膳食纖維降至 20-25g，距目標 35g+ 缺口 10-15g。🔴 新分配：午餐前 11:45 洋車前子殼 5g（4g 纖維）+ 下午點心 15:30 洋車前子殼 5g（4g 纖維）= 共 8g 額外纖維。⚠️ 已從 09:15 訓練前移除——訓練前 45 分鐘攝取 8.5g 纖維（原洋車前子殼 5g + 奇亞籽 5g）導致 GI 不適風險高（腹脹、痙攣）。現 09:15 僅剩奇亞籽 ~5g 纖維，可接受。⚠️ 不安排於晚餐前——洋車前子殼結合膽汁酸會降低 28g 橄欖油的脂肪吸收，影響 CoQ10（泛醇）和 K2（MK-7）等脂溶性補充品。15:30 點心無脂溶性補充品，安全。⚠️ 每次必須搭配充足水分（250ml+），否則可能引起腸阻塞。⚠️ 僅訓練日使用——休息日正常飲食纖維已達標 35g+'
WHERE title LIKE '訓練日 洋車前子殼%';

-- Also update fiber tracking item to reflect new psyllium distribution
UPDATE plan_items
SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜（抗性澱粉）。搭配發酵食物（優格、泡菜 ≤30g/日）增強腸道多樣性。⚠️ 訓練日注意：低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）可能使纖維降至 20-25g。訓練日補充：奇亞籽 15g（5g 纖維 09:15）+ 洋車前子殼 5g 午餐前 11:45 + 5g 下午點心 15:30（共 8g 纖維）= 額外 13g，搭配蔬菜 5-8g 達標 35g+。🔴 洋車前子殼已從 09:15 移除（避免訓練前 GI 不適），改為午餐前 + 下午點心。晚餐前不用（保護 CoQ10/K2 脂溶性吸收）。🔴 葉酸保險：B群休息日（隔日無 B-complex），15:30 點心加入浸泡扁豆/鷹嘴豆 100g（~180mcg 葉酸 + 6-8g 纖維）——浸泡 8hr+ 可減少植酸 50-70%，確保每日葉酸 ≥400mcg DFE'
WHERE title LIKE '全天 膳食纖維%';

-- === F8: Coconut water mandatory + potassium tracking update ===

UPDATE plan_items
SET description = '每日確認鉀攝取達 3800-4000mg。主力來源：酪梨半顆（~350mg）+ 馬鈴薯 1 顆（~800mg）+ 香蕉 1 根（~400mg）+ 希臘優格 300g（~300mg）+ 菠菜/蔬菜（~400mg）+ 鮭魚/肉類（~400mg）+ 地瓜 100g（~300mg）+ 🥥 椰子水 330ml（~600mg，每日必喝）+ 其他（~300mg）≈ 3,850-4,150mg ✅。🔴 椰子水、酪梨、馬鈴薯為核心三件，缺一不可——無椰子水日鉀攝取僅 ~3,250mg，長期不足增加高血壓風險。椰子水建議於 15:30 下午點心時飲用'
WHERE title LIKE '全天 鉀攝取確認%';

-- === Also update calcium tracking to mention yogurt at 15:30 ===

UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：🥛 希臘優格 300g（~280mg 鈣，15:30 下午點心時段食用——距午餐鐵 3.5hr、距晚餐鐵 3.5hr，不影響鐵吸收）+ 深綠蔬菜（~150-200mg）。🔴 每日 17:00 服用鈣片 1 錠（+500mg）——距 15:30 堅果鋅 1.5hr（鋅吸收完畢），距 19:00 晚餐鐵 2hr（鈣片已離開腸道），距睡前鎂 5.5hr（無競爭）。板豆腐日：優格 280mg + 板豆腐 150-225mg + 鈣片 500mg + 蔬菜 150mg ≈ 1080-1155mg ✅。非板豆腐日：優格 280mg + 鈣片 500mg + 蔬菜 150mg + 酪蛋白 60-100mg ≈ 990-1080mg ✅'
WHERE title LIKE '全天 鈣攝取確認%';
