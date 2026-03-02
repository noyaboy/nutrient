------------------------------------------------------------
-- 083: Morning coffee + nutrition interaction fixes
-- F1: Move coffee to 09:15 (morning, with pre-workout)
-- F2: Move L-Theanine to 09:15 (with coffee)
-- F3: Afternoon → green tea only (remove coffee reference)
-- F4: Nuts/seeds → 15:30 snack only (avoid zinc-iron competition)
-- F5: Clarify collagen excluded from protein target
-- F6: Add soaked lentils on B-off days for folate insurance
------------------------------------------------------------

-- F1+F2: Update coffee plan_item → morning 09:15
UPDATE plan_items
SET title = '09:15 咖啡 + L-Theanine（訓練前）',
    description = '☕ 起床後 15 分鐘，搭配訓練前營養一起攝取。咖啡因 150-200mg + L-Theanine 200mg（1:1 A 級 nootropic 組合）。咖啡因 ~45-60 分鐘達峰，10:00 訓練時正好最佳狀態。✅ 距午餐 12:00 達 2.75hr+，咖啡多酚對午餐鐵吸收影響降至 15-20%（搭配 VitC 500mg 仍淨正效益）。✅ 距入睡 00:00 達 14.75hr（>5 個半衰期），咖啡因殘留 <5mg，對睡眠影響趨近零。⚠️ CAR（皮質醇覺醒反應）通常 30 分鐘內達峰——起床後 15 分鐘略早，但搭配 L-Theanine 可緩衝焦慮感。若感覺過度亢奮可延至 09:30',
    sort_order = 3
WHERE title LIKE '%咖啡 + L-Theanine%' AND is_active = true;

-- F3: Update green tea → sole afternoon caffeine, no coffee
UPDATE plan_items
SET description = '午餐後 3hr+ 再飲用（~15:00），高脂高蛋白午餐胃排空需 3-4hr，3hr 內 EGCG 仍會螯合鐵鋅。改用低咖啡因綠茶（白毫銀針或老白毫），天然 L-Theanine（40-90mg）+ EGCG 為下午專注紅利。15:30 前喝完（咖啡因 cutoff 統一 15:30）。🔴 下午僅喝綠茶，咖啡已移至 09:15 訓練前（避免下午咖啡干擾午餐鐵吸收）'
WHERE title LIKE '%綠茶 EGCG%' AND is_active = true;

-- F4: Update afternoon snack → explicitly include all nuts/seeds
UPDATE plan_items
SET description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）+ 🥜 綜合堅果 45g + 南瓜籽 30g + 核桃 15g + 葵花籽 15g（共 105g）。💊 16:00 服用鈣片 1 錠（500mg）——低鐵點心時段，不干擾任何礦物質吸收。⚠️ 堅果/種子全部集中於此時段：避免午餐/晚餐鋅（堅果 ~5mg）與鐵競爭 DMT1 轉運蛋白（同餐鋅抑制非血基質鐵吸收 30-50%）。⚠️ 訓練日改用此組合。休息日可改為燕麥 80g + 藍莓 50g + 堅果種子 105g。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g'
WHERE title LIKE '%15:30 下午點心%' AND is_active = true;

-- F4b: Update pre-workout → remove any nut reference, keep low-fat
UPDATE plan_items
SET description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ 肌酸 5g（溶於乳清一起沖泡）+ 奇亞籽 15g（~5g 纖維 + 2.5g ALA omega-3）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉+奇亞籽（先泡水 10 分鐘形成凝膠再加入乳清）。🔴 訓練日纖維補強：奇亞籽 15g（5g 纖維）+ 洋車前子殼 8-10g（6.4-8g）= 額外 11-13g 纖維，搭配蔬菜 5-8g 達標 35g+。地瓜需 60-90 分鐘消化，若要吃請提前至 08:00。⚠️ 堅果/種子請留至 15:30 下午點心（避免訓練前高脂延緩胃排空 + 保護午晚餐鐵吸收）'
WHERE title LIKE '%09:15 訓練前營養%' AND is_active = true;

-- F5: Update lunch → clarify collagen excluded from protein target
UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，⚠️ 不含膠原蛋白——膠原蛋白缺乏色胺酸與 BCAAs，非合成代謝等效蛋白質，僅作為結締組織修復補充）+ 蔬菜（建議使用白米或冷卻再加熱白米飯以減少植酸干擾鐵吸收）。隨餐服用：魚油 2 顆（鮭魚日 1 顆）、D3 2000IU（2 顆）、葉黃素 20mg、膠原蛋白肽 10-15g（額外，含 VitC ~120-160mg）、維他命C 500mg 1 錠（搭配鐵質食物最大化吸收）、B群 1 顆（⚠️ 隔日服用——P5P 50mg/日長期有周邊神經病變風險）。🔴 CoQ10 與 K2 已移至晚餐（28g 橄欖油提供更充足脂質微膠粒）。⚠️ 午餐搭配維他命C食物（彩椒、花椰菜）促進鐵吸收。⚠️ 堅果/種子請留至 15:30（避免鋅鐵 DMT1 競爭）'
WHERE title LIKE '%12:00 午餐%' AND is_active = true;

-- F5b: Update protein tracker → clarify collagen exclusion
UPDATE plan_items
SET description = '訓練前乳清 27g + 午餐 35-40g（不含膠原蛋白）+ 下午豌豆 16g + 晚餐 38-45g + 睡前酪蛋白 20g ≈ 136-148g（1.9-2.0g/kg）。每餐 ≤45g，每日 5 餐均勻分配。⚠️ 膠原蛋白 10-15g 為額外結締組織修復用途，不計入合成代謝蛋白質目標。🔴 睡前酪蛋白（22:00）填補 19:00-08:00 長達 13hr 的蛋白質斷層，多項 RCT 證實睡前酪蛋白顯著提升夜間肌肉蛋白合成率'
WHERE title LIKE '%蛋白質 142-152g%' AND is_active = true;

-- F6: Update fiber tracker → add soaked lentils on B-off days for folate
UPDATE plan_items
SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜（抗性澱粉）。搭配發酵食物（優格、泡菜 ≤30g/日）增強腸道多樣性。⚠️ 訓練日注意：低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）可能使纖維降至 20-25g。訓練日補充：奇亞籽 15g（5g 纖維）+ 洋車前子殼 8-10g（6.4-8g 纖維）= 額外 11-13g，搭配蔬菜 5-8g 達標 35g+。🔴 葉酸保險：B群休息日（隔日無 B-complex），15:30 點心加入浸泡扁豆/鷹嘴豆 100g（~180mcg 葉酸 + 6-8g 纖維）——浸泡 8hr+ 可減少植酸 50-70%，確保每日葉酸 ≥400mcg DFE'
WHERE title LIKE '%膳食纖維 35-45g%' AND is_active = true;

-- F6b: Update iron tracker → reflect morning coffee
UPDATE plan_items
SET description = '每日確認鐵吸收最佳化（男性 RDA 8mg）。🔴 鐵吸收促進因子：(1) 維他命C 午餐 500mg + 晚餐 250mg 隨餐（促進非血基質鐵吸收 2-6 倍）✅。(2) 動物蛋白「肉類因子」（MFP）促進鐵吸收。(3) 鈣片已移至 16:00 下午點心——午餐/晚餐鐵均不再被鈣抑制 ✅。(4) 堅果/種子移至 15:30——午餐/晚餐無鋅競爭 ✅。🔴 鐵吸收抑制因子：(1) 咖啡 09:15（午餐前 2.75hr+），影響 15-20%（搭配 VitC 500mg 淨正效益）✅。(2) 綠茶 15:00（午餐後 3hr+），影響有限 ✅。(3) 植酸：午餐使用白米。(4) 草酸（菠菜）：僅影響自身鐵。主要鐵來源：牛肉、雞蛋、菠菜、雞肝 2×/週 50g。⚠️ 每半年驗血清鐵蛋白 Ferritin 目標 50-150 ng/mL'
WHERE title LIKE '%鐵吸收最佳化%' AND is_active = true;

-- Update products: coffee usage timing
UPDATE products
SET usage = '每日 1-2 杯，09:15 訓練前（搭配 L-Theanine 200mg）',
    description = '訓練前飲用，咖啡因 150-200mg + L-Theanine 200mg（A 級 nootropic 組合）。多酚抗氧化、增強專注力。距午餐 2.75hr+，鐵吸收影響極低'
WHERE name LIKE '%咖啡豆%';

-- Update products: L-Theanine usage timing
UPDATE products
SET usage = '每日 1 顆（200mg）09:15 隨咖啡服用。下午綠茶另含天然 L-Theanine 40-90mg 為額外紅利'
WHERE name LIKE '%L-Theanine%';

-- Update products: green tea usage timing
UPDATE products
SET usage = '每日下午 15:00-15:30 綠茶 2-3 杯（咖啡已移至早晨）'
WHERE name LIKE '%綠茶%';

-- Update products: CoQ10 usage → already at dinner (just fix stale "午餐" reference)
UPDATE products
SET usage = '每日 1 顆隨 19:00 晚餐（搭配 28g 橄欖油增強脂溶性吸收）'
WHERE name LIKE '%CoQ10%';

-- Update products: nuts purchase note → add timing guidance
UPDATE products
SET purchase_note = '每日必須 ~105g。全部集中於 15:30 下午點心食用（避免午晚餐鋅鐵競爭）。線上可訂（常溫配送）。1.13kg 堅果約 3.5 週。另購：南瓜籽 500g + 核桃 500g + 葵花籽 500g（全聯/Costco）。🔴 鮭魚日跳過巴西堅果'
WHERE name LIKE '%綜合堅果%';
