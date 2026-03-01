------------------------------------------------------------
-- 075: Nutrition gaps & interactions review fixes
-- Addresses: Vitamin A, Potassium, Vitamin E, lunch pill burden,
-- zinc-copper monitoring, Mg tolerance, selenium, folate verification
------------------------------------------------------------

-- ============================================================
-- TASK 1 (HIGH): Vitamin A gap — add tracking plan_item
-- Current ~400-600mcg vs RDA 900mcg. Orange sweet potato is
-- already in the plan but not tracked as a Vitamin A source.
-- ============================================================

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('全天 維他命A攝取確認（目標 900mcg RAE）',
   '每日確認維他命A攝取。主要來源：橘色地瓜 100g（~700mcg RAE β-胡蘿蔔素）+ 雞蛋 3-4 顆（~270-360mcg RAE）= 總計 ~970-1060mcg RAE。⚠️ 地瓜必須選橘色品種（台農 57 號），白肉/紫肉地瓜β-胡蘿蔔素極低。搭配油脂烹調或隨餐食用（β-胡蘿蔔素為脂溶性）。無地瓜日可用胡蘿蔔 50g（~400mcg RAE）或南瓜 100g（~200mcg RAE）替代',
   'daily', '飲食', 27, 1, true);

-- Update sweet potato product to emphasize orange variety for Vitamin A
UPDATE products SET
  description = '原型碳水來源 + 維他命A主力（橘色品種）。訓練前能量補充（前晚蒸好冷藏 → RS3）。冷卻後產生抗性澱粉（益生元）。⚠️ 必選台農 57 號等橘色品種：每 100g 含 ~700mcg RAE β-胡蘿蔔素，是全計畫唯一高效維他命A來源。白肉/紫肉地瓜β-胡蘿蔔素極低，不可替代。非重訓日晚餐可食用（色氨酸→血清素→褪黑激素，助眠）。⚠️ 重訓日晚餐禁用冷卻地瓜（RS 發酵 + 睡前甘胺酸鎂 → 夜間腹脹）'
WHERE name = '地瓜';

-- ============================================================
-- TASK 2 (HIGH): Potassium gap — make avocado + potato daily
-- Current ~2500-3000mg vs AI 3400mg
-- ============================================================

-- Update avocado product: from optional to daily mandatory
UPDATE products SET
  description = '修復鉀缺口（每顆 ~700mg 鉀）+ 健康單元不飽和脂肪 + 膳食纖維 7g。⚠️ 每日必須食用半顆至一顆，不可省略——鉀是全計畫最大缺口（AI 3400mg vs 現行 ~2500-3000mg）',
  usage = '每日半顆至一顆（必須）'
WHERE name = '酪梨';

-- Update potato product: emphasize daily potassium role
UPDATE products SET
  description = '去皮後低纖維碳水 + 鉀質主力（每顆 ~800mg 鉀）。與酪梨共同修復鉀缺口。訓練日 30-40% 替代地瓜。冷卻後產生抗性澱粉。選擇黃皮或紅皮較甜',
  usage = '每日 1 顆（去皮烹調），訓練日作為低纖維碳水選項'
WHERE name = '馬鈴薯（美國/加拿大）';

-- Add potassium tracking plan_item
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('全天 鉀攝取確認（目標 3400mg）',
   '每日確認鉀攝取達 AI 3400mg。主力來源：酪梨半顆（~350mg）+ 馬鈴薯 1 顆（~800mg）+ 香蕉 1 根（~400mg）+ 希臘優格 300g（~300mg）+ 菠菜/蔬菜（~400mg）+ 鮭魚/肉類（~400mg）+ 其他（~300mg）≈ 2950-3450mg。⚠️ 酪梨與馬鈴薯為核心，缺一不可。電解質粉（有氧日）另提供 150mg',
   'daily', '飲食', 28, 1, true);

-- ============================================================
-- TASK 3 (MEDIUM): Vitamin E — make mixed nuts non-optional
-- RDA 15mg. Nuts provide ~7mg/30g + olive oil ~6mg + avocado ~2mg
-- ============================================================

UPDATE products SET
  description = '（每日必須）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅、維他命E（~7mg/30g，占 RDA 47%）、硒（巴西堅果 1-2 顆 = 68-91mcg）來源。⚠️ 不可省略：搭配橄欖油（~6mg）+ 酪梨（~2mg）= 每日維他命E ~15mg 恰好達 RDA',
  usage = '每日一把（30g，必須）'
WHERE name = '綜合堅果（Kirkland 1.13kg）';

-- ============================================================
-- TASK 4 (MEDIUM): Reduce lunch pill burden — move creatine to pre-workout
-- ============================================================

-- Update lunch plan_item: remove creatine from lunch description
UPDATE plan_items SET
  description = '蛋白質 35-40g（正餐食物，單餐建議 ≤45g）+ 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆（鮭魚日減為 2 顆）、D3 2000IU（2 顆）、K2、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 200mg、B群 1 顆（活化型態，隨正餐油脂+蛋白質完整食物基質服用，吸收率最佳）'
WHERE title LIKE '12:00 午餐%';

-- Update pre-workout plan_item: add creatine
UPDATE plan_items SET
  description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ 肌酸 5g（溶於乳清一起沖泡）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉。地瓜需 60-90 分鐘消化（含抗性澱粉），若要吃地瓜請提前至 08:00 進食'
WHERE title LIKE '09:15 訓練前營養%';

-- Update creatine product usage
UPDATE products SET
  usage = '每日 5g，溶於 09:15 訓練前乳清蛋白一起沖泡（從午餐移至訓練前，減輕午餐補充品負擔）'
WHERE name LIKE '肌酸%';

-- ============================================================
-- TASK 5 (MEDIUM): Zinc-copper monitoring — add to blood test
-- ============================================================

UPDATE plan_items SET
  description = '每半年一次全面健康檢查。🔴 絕對前提：抽血前 7 天停用肌酸 + 48-72 小時暫停高強度重訓。必檢：腎功能（BUN/Creatinine/eGFR/Cystatin C）、肝功能（ALT/AST）、甲狀腺（TSH/Free T4）、銅代謝（血清銅 + 銅藍蛋白 Ceruloplasmin，監控長期鋅補充是否導致銅耗竭）、鐵代謝（血清鐵蛋白 Ferritin，目標 50-150 ng/mL，>200 則減少紅肉頻率）、維他命D（25(OH)D，目標 40-60 ng/mL）'
WHERE title LIKE '%每半年%健康檢測%';

-- ============================================================
-- TASK 6 (LOW): Mg tolerance monitoring note
-- Supplemental Mg ~344mg vs UL 350mg
-- ============================================================

UPDATE plan_items SET
  description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 200mg（2 錠）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。洗完熱水澡後立即服用效果最佳 — 熱水澡與甘胺酸皆促進周邊血管擴張降低核心體溫，兩者協同加速入睡。⚠️ 鎂 UL 監控：補充品鎂合計 ~344mg（甘胺酸鎂 200mg + 蘇糖酸鎂 144mg），接近 IOM 補充品 UL 350mg。若出現腹瀉或腸胃不適，優先將甘胺酸鎂減為 1 錠（100mg），總計降至 244mg'
WHERE title = '22:30 睡前補充品';

-- ============================================================
-- TASK 7 (LOW): Selenium tracking — ensure daily Brazil nuts
-- Already handled in Task 3 (nuts product update includes selenium note)
-- Add explicit note to purchase_note
-- ============================================================

UPDATE products SET
  purchase_note = '每日必須 30g（非可選）。線上可訂（常溫配送）。1.13kg 約 5-6 週。⚠️ 含花生油，過敏者注意。🥜 硒（Selenium）：每日確保吃到 1-2 顆巴西堅果（每顆 ~68-91mcg 硒，RDA 55mcg）。勿超過 3 顆/日（UL 400mcg）'
WHERE name = '綜合堅果（Kirkland 1.13kg）';

-- ============================================================
-- TASK 8 (LOW): Folate verification note on B-complex
-- ============================================================

UPDATE products SET
  description = '✓ iHerb 必買。活化型態 B 群複方：甲鈷胺（Methylcobalamin B12）、5-MTHF 葉酸（非合成 Folic Acid）、P5P（活化 B6）。應對 MTHFR 基因變異風險，確保 B 群被有效利用。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成。⚠️ 收到後驗證標籤：確認 5-MTHF 葉酸含量 ≥400mcg DFE（成人 RDA）。若 <400mcg 則需從深綠蔬菜額外補充（菠菜 100g ≈ 194mcg DFE）'
WHERE name LIKE 'B群%';
