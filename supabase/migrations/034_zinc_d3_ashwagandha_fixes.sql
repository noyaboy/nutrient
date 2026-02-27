------------------------------------------------------------
-- 034: 鋅降為每兩天 + D3 改 1000IU + Ashwagandha 肝監測
--      + 甘胺酸鎂用量修正 + 睡前補充品延至 22:00
--      + 維他命C規格 + B群時機 + L-Theanine補貨 + 鈣片存放
------------------------------------------------------------

-- === 1. 鋅改為每兩天一次 ===

-- 停用「每日」鋅項目
UPDATE plan_items SET is_active = false
WHERE title = '鋅 25mg 每日補充';

-- 新增「每兩天」鋅項目
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('鋅 25mg 每兩天補充',
   '每兩天隨晚餐服用鋅 25mg（Zinc Picolinate 半顆）。平均每日鋅攝入 12.5mg + 銅 2mg/日 = 鋅銅比約 6.25:1（加上飲食鋅可達 10:1 以上）。與 15:00 銅間隔 4hr+',
   'daily', '補充品', 27, 1, true);

-- 更新晚餐描述（鋅改為每兩天）
UPDATE plan_items SET
  description = '蛋白質 40-45g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 2 大匙（28g）入菜或涼拌。隨餐服用：維他命 C 500mg（半錠）+ 鋅 25mg（半顆，每兩天一次，與 15:00 銅間隔 4hr+）。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- 更新銅描述（鋅改為每兩天）
UPDATE plan_items SET
  description = '銅 2mg（Solaray Bisglycinate）嚴格單獨空腹服用，不與任何礦物質補劑同服。空腹可最大化吸收率，避免與鋅、鈣、鐵等礦物質競爭。與晚餐鋅間隔 4hr+（鋅每兩天服用）。若空腹不適可搭配少量水果（非含鈣/鐵食物）'
WHERE title LIKE '15:00-16:00 銅%';

-- 更新鋅產品
UPDATE products SET
  description = '免疫與睪固酮合成必需。每兩天 25mg（半顆），搭配每日銅 2mg。飲食鋅 + 補充品平均可維持鋅銅比 10:1 以上。Picolinate 形式吸收率優於其他形式',
  usage = '每兩天隨晚餐服用半顆（25mg），與銅 2mg 維持平衡',
  purchase_note = 'iHerb 直送。每兩天半顆 25mg，120 顆可用約 16 個月。與 15:00 銅間隔 4hr+（晚餐 19:00 服用）。與銅保持 10-15:1 比例（含飲食鋅）。'
WHERE name LIKE '鋅 Zinc Picolinate%';

-- === 2. D3 改為 1000IU 每日 ===

-- 更新午餐描述
UPDATE plan_items SET
  description = REPLACE(description, 'D3 2000IU（5+2）', 'D3 1000IU（每日）')
WHERE title LIKE '12:00 午餐%';

-- 更新 D3 產品
UPDATE products SET
  name = '維他命 D3 2000IU（Doctor''s Best 360 顆）',
  description = '每日服用半顆（1000 IU）。目標血清 25(OH)D 40-60 ng/mL。血檢達標+每日晨光曝曬→可進一步減量。原產品為 2000IU/顆，半顆即 1000IU',
  usage = '每日半顆（1000 IU）隨訓練後餐（需搭配油脂吸收）',
  purchase_note = 'iHerb 直送。每日半顆（1000IU），360 顆可用約 2 年。大包裝每顆僅 ~$1.27。'
WHERE name LIKE '維他命 D3%Doctor%';

-- 更新鈣片備用描述中的 D3 2000IU 引用
UPDATE products SET
  description = '碳酸鈣 + 檸檬酸鈣雙鈣源。純粹作為鈣質備用品。注意：本品含 D3 150IU/錠，與獨立 D3 1000IU 疊加風險低但需留意。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）。鈣質食物優先策略：優先從希臘優格等原型食物攝取鈣'
WHERE name LIKE '鈣片備用%';

-- === 3. 刪除堅果腹瀉殘留提示 ===

UPDATE products SET
  description = '（可選品項）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅來源',
  purchase_note = '（可選）線上可訂（常溫配送）。每日 30g，1.13kg 約 5-6 週。⚠️ 含花生油，過敏者注意'
WHERE name LIKE '綜合堅果%';

-- === 4. Ashwagandha 明確掛鉤健康檢測 ALT/AST ===

UPDATE plan_items SET
  description = '每半年一次全面健康檢查。必檢指標：BUN（尿素氮）、Creatinine（肌酐）、eGFR（腎絲球過濾率）監測腎功能；ALT/AST 監測肝功能。⚠️ 若 ALT/AST 異常：首位停用 Ashwagandha（偶有肝損傷案例報告），其次停用 CoQ10、葉黃素。其他：血液、荷爾蒙、代謝指標、維他命D、鋅銅比'
WHERE title LIKE '【每半年】健康檢測%';

-- === 5. 甘胺酸鎂產品統一為 1 錠 100mg ===

UPDATE products SET
  purchase_note = 'iHerb 直送。每日睡前 1 錠（100mg），180 錠可用 6 個月。⚠️ 產品標示 serving size 為 2 錠 200mg，但本計畫僅用 1 錠（減半策略，避免總鎂過高致腹瀉）。'
WHERE name LIKE '甘胺酸鎂%NOW%';

-- === 6. 睡前補充品延後至 22:00 ===

UPDATE plan_items SET
  title = '22:00 睡前補充品',
  description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 600mg（嚴格 8 週用 / 4 週停）。⚠️ 第 6 週起密切觀察情緒變化：若出現情緒冷漠（Anhedonia）或早晨無力起床 → 立即進入停用期。22:00 服用確保與 19:00 晚餐蛋白質間隔 3hr+（甘胺酸與蛋白質競爭吸收），同時為腎臟保留排尿緩衝時間'
WHERE title LIKE '21:30-22:00 睡前補充品%';

-- 更新熱水澡時間（配合睡前補充品延後）
UPDATE plan_items SET
  description = '40-42°C 10-15 分鐘（睡前 60-90 分鐘）。提高核心體溫後快速降溫觸發睡眠驅動。建議 22:30-23:00 洗澡 → 00:00 入睡'
WHERE title LIKE '22:00-23:00 熱水澡%';

-- === 7. 維生素 C 規格修正（specs count 500→100） ===

UPDATE products SET
  specs = $${"ingredients":"抗壞血酸(維生素C),微結晶狀a-纖維素,羥丙基甲基纖維素(膜衣成分),交聯羧甲基纖維素鈉,硬脂酸,羥丙基纖維素(膜衣成分),硬脂酸鎂,羥丙基甲基纖維素(膜衣成分),二氧化矽,棕櫚蠟(膜衣成分)","form":"錠劑","count":"100錠","storage":"請存放於乾燥陰涼處，開封後請旋緊瓶蓋，並避免陽光直射。"}$$::jsonb,
  nutrition = $${"vitamin_c":"1000mg/錠（掰半服用 500mg）"}$$::jsonb
WHERE name LIKE '維他命 C%NOW Foods%';

-- === 8. B群服用時機統一（產品 usage 已正確為早餐） ===
-- 產品 usage 已標「每日 1 顆隨早餐（訓練前營養餐）」✓ 無需修改

-- === 9. L-Theanine 補貨週期提醒 ===

UPDATE products SET
  purchase_note = 'iHerb 直送。標準用量每日 1 顆（200mg），120 顆可用 4 個月。⚠️ 若偏好 1:2 比例（每日 2 顆 400mg 搭配咖啡因 200mg），120 顆僅可用 2 個月，需提前補貨。'
WHERE name LIKE 'L-Theanine%NOW%';

-- === 10. 鈣片存放邏輯修正 ===

UPDATE products SET
  purchase_note = '線上可訂（常溫配送）。純鈣備用品（鈣從食物攝取為主），250 錠可用非常久。K2 已獨立購買（NOW Foods MK-7），本品 K2 含量不足日常需求。⚠️ 碳酸鈣+檸檬酸鈣錠劑常溫陰涼處即可穩定保存，無需冰箱（原包裝建議冰箱保存為保守建議）。適合放辦公桌或隨身攜帶，確保 14:00-15:00 補鈣時段可取用。'
WHERE name LIKE '鈣片備用%';
