------------------------------------------------------------
-- Migration 077: Fix 7 remaining nutrition issues
-- 1. Green tea timing 14:30 → 15:00 (3hr post-lunch for mineral absorption)
-- 2. Zinc beef-day skip enforcement
-- 3. Choline tracking + soy lecithin product
-- 4. Collagen excluded from protein MPS target
-- 5. Psyllium husk training-day plan item
-- 6. Selenium over-intake warning
-- 7. B6 neuropathy monitoring
------------------------------------------------------------

-- 1. Green tea timing: 14:30 → 15:00
UPDATE plan_items
SET title = '15:00 綠茶 EGCG 2-3 杯',
    description = '午餐後 3hr+ 再飲用（~15:00），高脂高蛋白午餐胃排空需 3-4hr，3hr 內 EGCG 仍會螯合鐵鋅鈣（尤其午餐 500mg 鈣片仍在小腸吸收中）。改用低咖啡因綠茶（白毫銀針或老白毫），配合 L-theanine 天然組合促進專注，同時避免晚間睡眠干擾。15:30 前喝完（咖啡因 cutoff）。綠茶天然 L-Theanine（40-90mg）為額外放鬆紅利，不影響早晨 L-Theanine 補劑的服用'
WHERE title = '14:30 綠茶 EGCG 2-3 杯';

-- 2. Zinc beef-day skip: update active zinc 15mg item
UPDATE plan_items
SET description = '每日隨晚餐服用鋅 15mg（Picolinate 錠劑 1 錠）。補充品 15mg + 飲食鋅 ~10-15mg = 每日總計 25-30mg（安全低於 UL 40mg/日）。15mg 屬安全生理劑量，銅由堅果/可可粉/黑巧克力天然提供。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 150g 已含鋅 6-9mg + 飲食鋅 ~10mg = 總計 16-19mg，無需額外補充且避免逼近 UL 40mg。⚠️ 銅監控：每半年驗血清銅+銅藍蛋白。若銅藍蛋白 <20mg/dL，立即加回銅 1mg/日補充品。每日必吃黑巧克力 20g（~0.5mg 銅）+ 堅果 30g（~0.3-0.5mg 銅）+ 可可粉 5g（~0.2mg 銅）確保飲食銅 ≥0.9mg'
WHERE title = '鋅 15mg 每日補充' AND is_active = true;

-- Also add beef-day zinc skip reminder to dinner description
UPDATE plan_items
SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。鋅 15mg 在晚餐「最後一口」吞服（每日固定，含補鈣日 — 午餐鈣至 19:00 已間隔 7hr，不存在吸收競爭）。⚠️ 晚餐避開全穀類（糙米、燕麥）的植酸干擾鋅吸收；菠菜主要含草酸（非植酸），對鋅影響較弱，可適量食用。🔴 牛肉日取消鋅補劑：牛肉 150g 含鋅 6-9mg + 飲食鋅 ~10mg，補充品 15mg 會使總計逼近 UL 40mg。⚠️ 牛肉日：牛肉上限 150g，雞蛋 1-2 顆移至午餐、1 顆移至 15:30 下午點心。⚠️ 膽鹼（Choline）注意：牛肉日雞蛋減至 2-3 顆（~290-440mg 膽鹼），牛肉 150g 另補 ~80mg，建議額外食用 1 大匙卵磷脂（~120mg 膽鹼）或多加 1 顆蛋黃，確保達 AI 550mg'
WHERE title = '19:00 晚餐 + 低 FODMAP 蔬菜';

-- 3. Choline tracking: add plan item + soy lecithin product
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('全天 膽鹼攝取確認（目標 AI 550mg）',
   '每日確認膽鹼攝取達 AI 550mg。主力來源：雞蛋 3-4 顆（~420-560mg，蛋黃為核心）。⚠️ 牛肉日雞蛋僅 2-3 顆（~280-420mg），需額外補充：卵磷脂 1 大匙（~120mg）或多 1 顆蛋黃（+140mg）。膽鹼對肝臟脂肪代謝、神經傳導、甲基化代謝至關重要。缺乏膽鹼可導致脂肪肝與肌肉損傷',
   'daily', '飲食', 29, 1, true);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '卵磷脂顆粒（NOW Foods Sunflower Lecithin 454g）',
  '向日葵卵磷脂（非大豆），富含磷脂醯膽鹼（Phosphatidylcholine）。牛肉日膽鹼補充主力，每大匙（~10g）含 ~120mg 膽鹼。非基改、無大豆過敏風險',
  '牛肉日 1 大匙（~10g）隨餐，或每日加入燕麥/優格',
  'NT$400-500 / 454g',
  'https://tw.iherb.com/pr/now-foods-sunflower-lecithin-pure-powder-1-lb-454-g/72188',
  'iHerb', 'iherb_supplement', 'NOW Foods', NULL,
  $${"ingredients":"向日葵卵磷脂","form":"顆粒粉末","weight":"454g","features":"非基改、無大豆"}$$::jsonb,
  $${"serving_size":"10g (1大匙)","phosphatidylcholine":"~1200mg","choline":"~120mg"}$$::jsonb,
  'iHerb 直送。454g 約 45 份。牛肉日必用（每週 1-2 次），非牛肉日可選用。顆粒可直接拌入燕麥碗或優格，口感中性。常溫保存。',
  38
);

-- 4. Collagen excluded from protein MPS target
UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，不含膠原蛋白——膠原蛋白缺乏色氨酸且亮氨酸極低，無法有效刺激肌肉蛋白合成 MPS，單餐建議 ≤45g）+ 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆（鮭魚日減為 2 顆）、D3 2000IU（2 顆）、K2、葉黃素 20mg、膠原蛋白肽 10-15g（額外，不計入蛋白質目標）、CoQ10 200mg、B群 1 顆（活化型態，隨正餐油脂+蛋白質完整食物基質服用，吸收率最佳）'
WHERE title = '12:00 午餐 + 訓練後補充品';

-- 5. Psyllium husk training-day plan item
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('訓練日 洋車前子殼 5g（纖維補充）',
   '重訓日低纖維碳水替換（白米/義大利麵/去皮馬鈴薯）會使膳食纖維降至 20-25g，距目標 35g+ 缺口 10-15g。午餐前沖泡洋車前子殼（Psyllium Husk）5g 於 250ml 水中飲用，補回纖維缺口。⚠️ 必須搭配充足水分（250ml+），否則可能引起腸阻塞。⚠️ 僅訓練日使用——休息日正常飲食纖維已達標 35g+，無需額外補充',
   'daily', '飲食', 23, 1, true);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '洋車前子殼粉（NOW Foods Psyllium Husk Powder 340g）',
  '天然水溶性膳食纖維，吸水膨脹形成凝膠促進腸道蠕動。訓練日纖維補充主力，每 5g 含 ~4g 膳食纖維',
  '訓練日午餐前 5g 沖 250ml 水',
  'NT$250-350 / 340g',
  'https://tw.iherb.com/pr/now-foods-psyllium-husk-powder-12-oz-340-g/1041',
  'iHerb', 'iherb_supplement', 'NOW Foods', NULL,
  $${"ingredients":"洋車前子殼粉","form":"粉末","weight":"340g"}$$::jsonb,
  $${"serving_size":"5g","dietary_fiber":"~4g","soluble_fiber":"~3g"}$$::jsonb,
  'iHerb 直送。訓練日使用（每週 4-5 天），340g 約可用 2-3 個月。⚠️ 沖泡後立即飲用（放置會凝固成膠狀難以吞嚥）。搭配 250ml+ 水，避免腸阻塞。',
  39
);

-- 6. Selenium over-intake warning: update mixed nuts product
UPDATE products
SET description = '（每日必須）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅、維他命E（~7mg/30g，占 RDA 47%）、硒（巴西堅果嚴格限 1 顆/日 = 68-91mcg，已超過 RDA 55mcg）來源。⚠️ 不可省略：搭配橄欖油（~6mg）+ 酪梨（~2mg）= 每日維他命E ~15mg 恰好達 RDA。⚠️ 巴西堅果嚴格 1 顆/日上限——含硒量變異極大（6-91mcg/顆），2 顆高硒堅果可能逼近 UL 400mcg。⚠️ 硒總量注意：雞蛋 3-4 顆（~45-60mcg）+ 鮭魚（~40mcg/份）的飲食基線已達 RDA 55mcg。加上巴西堅果 1 顆後總計可達 150-190mcg/日（3x RDA）。鮭魚日建議跳過巴西堅果，避免慢性硒過量（SELECT 試驗：>200mcg/日與第二型糖尿病風險增加相關）',
    purchase_note = '每日必須 30g（非可選）。線上可訂（常溫配送）。1.13kg 約 5-6 週。⚠️ 含花生油，過敏者注意。🥜 硒（Selenium）：每日嚴格限 1 顆巴西堅果（每顆 ~68-91mcg 硒，RDA 55mcg）。⚠️ 鮭魚日跳過巴西堅果——飲食硒基線（雞蛋+鮭魚）已達 100-140mcg，加巴西堅果恐超 200mcg。非鮭魚日 1 顆即可'
WHERE name = '綜合堅果（Kirkland 1.13kg）';

-- 7. B6 neuropathy monitoring: update B-complex product + health check
UPDATE products
SET description = '✓ iHerb 必買。活化型態 B 群複方：甲鈷胺（Methylcobalamin B12）、5-MTHF 葉酸（非合成 Folic Acid）、P5P（活化 B6）。應對 MTHFR 基因變異風險，確保 B 群被有效利用。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成。⚠️ 收到後驗證標籤：確認 5-MTHF 葉酸含量 ≥400mcg DFE（成人 RDA）。若 <400mcg 則需從深綠蔬菜額外補充（菠菜 100g ≈ 194mcg DFE）。⚠️ B6（P5P）50mg/日長期安全性：UL 為 100mg/日，P5P 形式比吡哆醇（Pyridoxine）安全性更高，但仍建議每半年自我檢查有無手腳麻木/刺痛感（周邊神經病變早期徵兆）。若出現症狀立即停用並就醫'
WHERE name = 'B群 活化型態（NOW Foods B-50 Coenzyme 60 顆）';

-- Update health check to include B6 neuropathy screening
UPDATE plan_items
SET description = '每半年一次全面健康檢查。🔴 絕對前提：抽血前 7 天停用肌酸 + 48-72 小時暫停高強度重訓。必檢：腎功能（BUN/Creatinine/eGFR/Cystatin C）、肝功能（ALT/AST）、甲狀腺（TSH/Free T4/Free T3——Ashwagandha 週期中特別注意 Free T3 偏高=亞臨床甲亢）、尿碘（Urinary Iodine，目標 100-199mcg/L，監控碘攝取是否穩定達 RDA）、銅代謝（血清銅 + 銅藍蛋白 Ceruloplasmin，監控長期鋅補充是否導致銅耗竭——⚠️ 銅藍蛋白 <20mg/dL 或血清銅 <70mcg/dL 立即補充銅 1mg/日）、鐵代謝（血清鐵蛋白 Ferritin，目標 50-150 ng/mL，>200 則減少紅肉頻率）、維他命D（25(OH)D，目標 40-60 ng/mL）、硒（血清硒，目標 70-150 ng/mL，>200 則減少巴西堅果）。📋 自我檢查：B6 周邊神經病變篩查——手腳有無持續性麻木、刺痛、灼熱感（P5P 50mg/日長期服用需監控），若有症狀立即停用 B-complex 並就醫'
WHERE title = '【每半年】健康檢測';
