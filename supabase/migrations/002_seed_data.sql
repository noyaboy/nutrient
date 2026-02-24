------------------------------------------------------------
-- 每日計畫項目 (25 active + 6 inactive = 31 items)
-- Matches live DB state as of 2026-02-24
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  -- === Morning (< 11:00) ===
  ('07:00 起床 & 晨光曝曬', '起床後 30 分鐘內到戶外曬太陽 10-20 分鐘（陰天久一點）。不戴太陽眼鏡。校正晝夜節律、降低皮質醇、促進維他命D合成', 'daily', '睡眠', 1, 1, true),
  ('07:05 補水 & 電解質', '起床後盡快補水。500ml 室溫水 + 少許碘鹽 + 檸檬汁。可搭配晨光曝曬同時進行。碘鹽取代海鹽以確保碘攝取', 'daily', '飲食', 2, 1, true),
  ('07:15 NMN + TMG（空腹）', '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）', 'daily', '補充品', 2, 1, false),
  ('07:15 訓練前營養', '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）', 'daily', '飲食', 3, 1, true),
  ('07:45 穩定性訓練暖身', 'RAMP 暖身含穩定性訓練共 15 分鐘（升溫→激活→活動度→增強）：反伸展、反旋轉、單腳 RDL、肩胛穩定、抗側屈（行李箱負重走）', 'daily', '運動', 4, 1, true),
  ('08:00 運動', '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇（含 Zone 2 暖身收操）。六/日 Zone 2 有氧 90 分鐘。每次 60-90 分鐘', 'daily', '運動', 5, 1, true),
  ('08:30 咖啡 + L-Theanine', '起床後 60-90 分鐘再喝。咖啡因 200-300mg（約 1-2 杯黑咖啡）+ L-Theanine 200mg（A 級 nootropic 組合，消除焦慮、增強專注）。13:00 後禁止咖啡因（半衰期 5-6 小時影響睡眠）', 'daily', '飲食', 6, 1, true),
  ('09:00 訓練後營養 + 補充品', '乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 2000IU（5+2）、D3+K2（不額外補鈣片，鈣從食物攝取）、維他命 C、葉黃素 20mg', 'daily', '飲食', 7, 1, true),

  -- === Midday (11:00-15:00) ===
  ('11:00 綠茶 EGCG 2-3 杯', '訓練後餐 2hr+ 再飲用（~11:00），避免螯合鈣、鐵、鋅。EGCG + L-theanine 天然組合促進專注。13:00 前喝完（咖啡因 cutoff）', 'daily', '飲食', 8, 1, true),
  ('12:00-13:00 午餐補銅 2mg', '銅 2mg（Solgar）隨午餐服用。與鋅間隔 4+ 小時（鋅在晚餐）。鋅銅比維持 10-15:1，防止長期鋅補充導致銅缺乏', 'daily', '補充品', 8, 1, false),
  ('13:00 午餐 + 蘿蔔硫素 BroccoMax', '蛋白質 40-50g + 十字花科蔬菜 + BroccoMax 1-2 顆（最強 Nrf2 激活劑）', 'daily', '飲食', 9, 1, true),
  ('14:00 NSDR + 銅 2mg', '使用引導式 Yoga Nidra 音檔（非單純休息）。11 分鐘有 RCT 支持，促進深度放鬆與多巴胺恢復。銅 2mg 搭配少量堅果或水果服用（與 EGCG 間隔 3hr+）', 'daily', '心理', 10, 1, true),

  -- === Afternoon (15:00-19:00) ===
  ('17:00 高質量社交對話', '至少與一位親友進行非公事的深度對話。每週安排 1 次面對面社交活動。戶外自然接觸 120+ 分鐘/週（可結合有氧）。哈佛研究：人際關係品質對壽命影響高於飲食與運動', 'daily', '心理', 10, 1, true),
  ('18:00 晚餐 + 十字花科蔬菜', '蛋白質 40-50g + 花椰菜、西蘭花。順序：纖維→蛋白→碳水。隨餐服用鋅 25mg（與銅間隔 4hr+）。固體食物睡前 3-4hr 結束（21:00 酪蛋白液態補充例外）', 'daily', '飲食', 11, 1, true),
  ('18:30 餐後散步 15 分鐘', '控制餐後血糖最有效的方法，降低胰島素峰值。輕快步行即可，不需高強度。午餐後也建議散步 10-15 分鐘。可結合戶外自然接觸（每週目標 120+ 分鐘）', 'daily', '運動', 12, 1, true),

  -- === Evening (19:00+) ===
  ('20:00 藍光管理', '調暗燈光或佩戴防藍光眼鏡（琥珀色鏡片）', 'daily', '睡眠', 11, 1, true),
  ('21:00 睡前：熱水澡 + 酪蛋白 + 補充品', '熱水澡 40-42°C 10-15 分鐘（睡前 60-90 分鐘）。酪蛋白 ~64g 粉（≈50g 蛋白）+ 甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 + Ashwagandha 600mg（8 週用 / 4 週停，停用期改服紅景天 500mg）', 'daily', '補充品', 15, 1, true),
  ('21:30 Cyclic Sighing + 專注冥想', 'Cyclic Sighing 5 分鐘（雙吸鼻、長呼口，Stanford RCT 證實最佳呼吸法）+ 專注冥想 10 分鐘（單點注意力：鼻尖呼吸）。寫下三件感恩的事', 'daily', '心理', 16, 1, true),
  ('22:00 感恩練習', '睡前或早晨寫下三件感恩的事，調節自律神經系統', 'daily', '心理', 17, 1, false),
  ('21:50 口腔衛生：刷牙 + 牙線', '早晚各一次。牙周病菌（P. gingivalis）與心血管疾病、阿茲海默症強相關。每日至少刷牙 2 次 + 牙線 1 次', 'daily', '一般', 17, 1, true),
  ('22:00 準時入睡', '目標 8-8.5 小時睡眠。全黑、低溫 18-19°C。深層睡眠啟動腦部排毒系統。週末偏差不超過 30 分鐘。不使用褪黑激素（24歲不需要）', 'daily', '睡眠', 18, 1, true),

  -- === All-day items ===
  ('全天 蛋白質 170g+ 目標', '每餐 30-50g 蛋白（蛋、魚、雞胸、乳清、酪蛋白）。每日 4-5 餐均勻分配，總計 170g+（2.4g/kg）。每餐達到亮氨酸門檻 2.5-3g', 'daily', '飲食', 19, 1, true),
  ('全天 膳食纖維 35-45g', '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜。供腸道菌產生丁酸，維護腸腦軸。搭配發酵食物（優格、泡菜）增強腸道多樣性', 'daily', '飲食', 20, 1, true),
  ('全天 每 45 分鐘站立/坐姿切換', '維持脂蛋白脂肪酶 LPL 活性，避免久坐代謝下降', 'daily', '運動', 21, 1, true),
  ('全天 碳水循環：訓練日 vs 休息日', '重訓日 5-6g/kg (360-430g)、有氧日 3-4g/kg (215-290g)、休息日 2-3g/kg (145-215g，僅 Deload 週或臨時休息)。支持 mTOR 肌肉修復與合成。卡路里目標：重訓日 3,100-3,400 kcal', 'daily', '飲食', 22, 1, true),
  ('全天 週末睡眠一致性（±30 分鐘）', '週末起床/睡覺時間與平日偏差不超過 30 分鐘。社交時差（Social Jetlag）影響認知、情緒與代謝，A 級證據', 'daily', '睡眠', 23, 1, true),
  ('全天 數位衛生', '娛樂螢幕 <2hr、社群媒體 <30min。21:00 後無螢幕、專注時段手機勿擾模式', 'daily', '心理', 24, 1, true),
  ('全天 飲水 3-3.5L', '07:05 起床 500ml（碘鹽+檸檬）→ 08:00 訓練中 500ml → 10:00 訓練後補水 250ml → 11:00 綠茶 500ml → 13:00 隨餐 250ml → 15:00 下午補水 250ml → 18:00 隨餐 250ml → 21:00 酪蛋白沖泡 250ml。有氧日訓練中改用電解質粉。尿液淡黃色為適當水合指標', 'daily', '飲食', 25, 1, true);

------------------------------------------------------------
-- 每週計畫項目 (3 active + 3 semi-active/inactive)
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('Zone 2 有氧 3 次', '週三、週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機', 'weekly', '運動', 1, 3, true),
  ('肌力訓練 4 次（Upper/Lower）', '一上半身A/二下半身A/四上半身B/五下半身B。每肌群每週 12-20 組，分 2 次訓練。3 週漸進超負荷 + 第 4 週 Deload（量減 40-50%，強度維持 85%）。記錄每組重量/次數', 'weekly', '運動', 2, 4, true),
  ('VO2 Max 訓練 1 次', 'Peter Attia 4×4 法 — 4 分鐘全力（90-95% HRmax）+ 4 分鐘恢復 × 4 組。週六進行', 'weekly', '運動', 3, 1, true),
  ('學習新技能', '樂器或語言學習最佳（結構性神經可塑性證據最強）。20-30 分鐘練習後安排運動，有助記憶鞏固。NSDR 也可在學習後使用', 'weekly', '心理', 4, 3, true),
  ('Quercetin + Fisetin 抗氧化抗發炎', '每週集中 2-3 天服用，抗氧化與抗發炎，輔助清除衰老細胞', 'weekly', '補充品', 5, 1, false),
  ('每週回顧與調整', '記錄：1.早晨精神狀態 2.下午能量水平 3.運動後恢復速度 4.體重 7 日均值（目標每月 +0.5-1kg）5.主要複合動作進步。異常時優先調整睡眠與熱量', 'weekly', '一般', 5, 1, false),
  ('【每半年】健康檢測', '每半年一次全面健康檢查（血液、荷爾蒙、代謝指標）。此為半年提醒，非每週目標', 'weekly', '一般', 6, 0, true),
  ('【每季】FMD 斷食模擬飲食（5 天）', '每 3-4 月執行 5 天低蛋白/低糖/高脂飲食。清除衰老細胞、重啟免疫系統。FMD 期間停用：肌酸、魚油、NMN、白藜蘆醇', 'weekly', '飲食', 9, 1, false);

------------------------------------------------------------
-- Costco 保健品 (4 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '緩釋魚油（Kirkland 新型緩釋 Omega-3）',
  '每 1200mg 魚油含 Omega-3 約 700mg（EPA 419mg + DHA 281mg）。沙丁魚、鯷魚、鯖魚來源，緩釋不打嗝。產地加拿大',
  '每日隨餐 3 顆（EPA+DHA 共 2100mg）',
  'NT$579 / 180 顆',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Enteric-Omega-3-Fish-Oil-180-Softgel/p/240669',
  'Costco', 'costco_supplement', 'Kirkland Signature 科克蘭', '加拿大',
  $${"ingredients":"魚油(沙丁魚、鯷魚、鯖魚)、明膠(豬來源)、甘油、水、柑橘果膠、D-山梨醇(甜味劑)","form":"軟膠囊","count":"180粒","storage":"請置於陰涼乾燥處，開瓶後請旋緊瓶蓋，並避免陽光直射。","allergens":"本產品含魚可能導致過敏症狀。不添加乳糖、人工色素及麩質。"}$$::jsonb,
  $${"per_serving":"每1200毫克濃縮魚油","omega3_total":"約700毫克","epa":"419毫克","dha":"281毫克"}$$::jsonb,
  '線上可訂（常溫配送）。每日 3 顆，180 顆可用 2 個月。開瓶後旋緊避免氧化，有腥味表示已變質。',
  1
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '鈣 + D3 + K2（Nature Made 250 錠）',
  '碳酸鈣 + 檸檬酸鈣雙鈣源，K2 為 MK-7 型（納豆來源）。防骨鬆 + 防動脈鈣化。產地美國。鈣質食物優先策略：優先從希臘優格等原型食物攝取鈣',
  '備用品：僅在當日飲食鈣攝取確認嚴重不足時才服用 1 錠。日常以 D3+K2 為主，不額外補鈣片',
  'NT$759 / 250 錠',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453',
  'Costco', 'costco_supplement', 'NATURE MADE 萊萃美', '美國',
  $${"ingredients":"碳酸鈣(碳酸鈣、麥芽糊精(玉米)、阿拉伯膠)、檸檬酸鈣、微結晶纖維素、維生素K2(麥芽糊精(玉米)、納豆脂質、維生素K2(Menaquinone-7))、羥丙基甲基纖維素、二氧化鈦(著色劑)、聚糊精、硬脂酸鎂、二氧化矽、交聯羧甲基纖維素鈉、滑石粉、麥芽糊精、維生素D3(辛烯基丁二酸鈉澱粉、糖、L-抗壞血酸鈉(抗氧化劑)、二氧化矽、中鏈三酸甘油酯、生育醇(抗氧化劑)、膽鈣化醇)、脂肪酸甘油酯(乳化劑)","form":"錠劑","count":"250錠","storage":"請置於陰涼乾燥處，開封後請置於冰箱儲存。","allergens":"不添加麩質、防腐劑、化學色素及人工香料。"}$$::jsonb,
  $${"calcium":"500mg/錠","vitamin_d3":"3.75mcg (150IU)/錠","vitamin_k2":"10mcg (MK-7型)/錠"}$$::jsonb,
  '線上可訂（常溫配送）。現為備用品（鈣從食物攝取為主），250 錠可用非常久。開封後建議冰箱保存。',
  2
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '維他命 C（Kirkland 500mg × 500 錠）',
  '抗氧化、膠原蛋白合成、增強鐵吸收。產地加拿大',
  '每日 1-2 錠（500-1000mg）',
  'NT$399 / 500 錠',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Multi-Letter-Vitamins/Kirkland-Signature-Vitamin-C-500-mg-500-Tablet/p/684654',
  'Costco', 'costco_supplement', 'Kirkland Signature 科克蘭', '加拿大',
  $${"ingredients":"抗壞血酸(維生素C),微結晶狀a-纖維素,羥丙基甲基纖維素(膜衣成分),交聯羧甲基纖維素鈉,硬脂酸,羥丙基纖維素(膜衣成分),硬脂酸鎂,羥丙基甲基纖維素(膜衣成分),二氧化矽,棕櫚蠟(膜衣成分)","form":"錠劑","count":"500錠","storage":"請存放於乾燥陰涼處，開封後請旋緊瓶蓋，並避免陽光直射。"}$$::jsonb,
  $${"vitamin_c":"500mg/錠"}$$::jsonb,
  '線上可訂（常溫配送）。每日 1-2 錠，500 錠可用 8-16 個月，每錠不到 $1。',
  3
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  'Tryall 無調味分離乳清蛋白 2kg',
  '台灣品牌，無調味無添加。分離乳清蛋白（WPI），約 90% 蛋白質含量，每 30g 粉含 ~27g 蛋白、~120kcal。美國乳源，過濾大部分乳糖與脂肪，乳糖不耐者也適合',
  '訓練前 1 份（~30g 粉 ≈ 27g 蛋白），訓練後 ~1.3 份（~40g 粉 ≈ 36g 蛋白）',
  '約 NT$1,899~2,199 / 2kg',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Sports-Performance/Tryall-Whey-Protein-Isolate-Unflavored-2-kg/p/155648',
  'Costco', 'costco_supplement', 'Tryall',
  NULL, NULL, NULL, '155648', '台灣（品牌）/ 美國（乳源）',
  '{"ingredients":"分離乳清蛋白（美國乳源）","form":"無調味粉末","weight":"2kg","features":"無添加糖、甜味劑、人工色素、香料"}'::jsonb,
  '{"serving_size":"30g","calories":"~120kcal","protein":"~27g","fat":"~2g","carbs":"~3g","bcaa":"~5.3g","protein_pct":"約90%"}'::jsonb,
  'Costco 線上可訂。每日 ~70g，2kg 約 28 天，每月補貨。無調味可搭配咖啡、黑芝麻粉等調味。',
  4
);

------------------------------------------------------------
-- Costco 食材 (17 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '平飼雞蛋（全佑牧場 LL 規格）',
  '高蛋白第一餐，富含亮氨酸 Leucine。冷藏平飼蛋，非籠飼。賣場限定商品',
  '每日 3-4 顆',
  '~NT$274 / 30 入',
  'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/QUAN-YOU-FARM-Cage-Free-Eggs-LL-30-Count/p/128970',
  'Costco', 'costco_food', '全佑牧場', '台灣',
  $${"count":"30入","storage":"冷藏 7°C 以下，離開冷藏時間請勿超過30分鐘，開封後請盡速使用","warehouse_only":true}$$::jsonb,
  '{}'::jsonb,
  '賣場限定，無法線上訂。每日 3-4 顆，30 入約 7-10 天。絕對不要把 30 入紙托直接塞冰箱——買一個雙層抽屜式雞蛋盒（寬約 15cm），貼齊冷藏最底層側邊，上方平面還能繼續疊放保鮮盒。',
  4
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '冷凍鮭魚排（Kirkland 1.36kg）',
  '挪威養殖大西洋鮭魚，優質蛋白 + Omega-3 來源。成分：鮭魚、水、食鹽',
  '每週 3-4 份',
  'NT$1,229 / 1.36kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/Kirkland-Signature-Frozen-Atlantic-Salmon-136-kg/p/1286092',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '挪威',
  $${"ingredients":"養殖鮭魚、水、食鹽","weight":"1.36公斤","storage":"請冷凍-18℃保存。","allergens":"本產品含有鮭魚，食物過敏者，請注意。","cooking":"烤：將烤箱預熱至200℃，將解凍後的鮭魚調味後放在烤盤上烤約10-12分，或直到中心溫度達63℃。"}$$::jsonb,
  '{}'::jsonb,
  '冷凍庫主力，每 2 週線上訂 1 包（冷凍配送）。買回立即分裝 5-6 份 zip bag（佔冷凍約 2.5L），每 2-3 天取 1 份移至冷藏解凍。冷凍庫僅 7L，鮭魚是唯一需要長期冷凍的高價值食材。',
  5
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '冷凍綠花椰菜（Nature''s Touch 454g×4）',
  '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）。切碎後靜置 40 分鐘可最大化黑芥子酶轉化。產地厄瓜多',
  '每日一份',
  'NT$329 / 454g×4',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Fruits-Vegetables/Natures-Touch-Frozen-Broccoli-454-g-X-4-Pack/p/122199',
  'Costco', 'costco_food', 'Nature''s Touch', '厄瓜多',
  $${"ingredients":"綠花椰菜","weight":"1816公克","count":"454公克 X 4包","storage":"請冷凍-18℃保存","cooking":"取出建議份量一小袋(454公克)放入微波爐加熱5-6分鐘，或連同250毫升水倒入鍋中加熱5-6分鐘，即可食用。"}$$::jsonb,
  '{}'::jsonb,
  '小冰箱請勿買冷凍版（佔冷凍 3L 直接爆倉）。改在傳統市場或超市買新鮮綠花椰菜，每次 2-3 顆，切成小朵後靜置 40 分鐘（最大化蘿蔔硫素），裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。每週補貨 1-2 次。',
  6
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '地瓜',
  '原型碳水來源。訓練前能量補充，晚餐助色氨酸→血清素→褪黑激素。冷卻後產生抗性澱粉（益生元）',
  '訓練前/晚餐適量',
  '~NT$135 / 2.8kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。挑外皮光滑無發芽。每週約 1 袋（2.8kg）。常溫陰涼處可放 1-2 週，勿冷藏。',
  7
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '洋蔥 / 大蒜',
  '膳食纖維與益生元（菊糖 Inulin）來源',
  '日常入菜',
  '~NT$149',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。常溫通風處可保存 2-4 週，耗量低，每月補一次即可。',
  8
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '碘鹽（統一生機 日曬海鹽加碘）',
  '西班牙日曬海鹽 + 碘化鉀。海鹽/玫瑰鹽碘含量極低，十字花科蔬菜攝取量高時需確保碘攝取',
  '日常用鹽，每日少許',
  'NT$179 / 2kg',
  'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/Uni-President-Iodized-Solar-Sea-Salt-2-kg/p/283283',
  'Costco', 'costco_food', '統一生機', '西班牙',
  $${"ingredients":"日曬海鹽、碘化鉀","weight":"2公斤","storage":"常溫","allergens":"本產品與其它含有芒果、大豆、奶類、含麩質之穀物、魚、堅果、芝麻、蕎麥及甲殼類的產品於同一工廠生產，食物過敏者請留意。","notes":"不添加抗結塊劑，若有輕微結塊，品質無虞請安心食用。"}$$::jsonb,
  '{}'::jsonb,
  '線上可訂（常溫配送）。2kg 約可用 6 個月以上。確認選「加碘」版本。',
  9
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '檸檬',
  '早晨補水，促進消化',
  '每日半顆',
  '~NT$329 / 2.2kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。選外皮鮮黃有光澤。整顆放保鮮抽屜，切半後用矽膠套包住切面冷藏。每日半顆，約可用 3-4 週。',
  10
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '綜合堅果（Kirkland 1.13kg）',
  '腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅來源。產地越南',
  '每日一把',
  'NT$585 / 1.13kg',
  'https://www.costco.com.tw/Food-Dining/Snacks/Nuts-Jerky/Kirkland-Signature-Mixed-Nuts-113-kg/p/1669722',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '越南',
  $${"ingredients":"腰果,杏仁,開心果,夏威夷果仁,巴西堅果,花生油,海鹽","weight":"1.13公斤","storage":"未開封時請存放於陰涼乾燥處,開封後請冷藏並請儘速食用完畢","allergens":"本產品含有花生及堅果類製品，食物過敏者請留意","notes":"可能含有堅果碎殼，食用時請小心"}$$::jsonb,
  '{}'::jsonb,
  '線上可訂（常溫配送）。每日 30g，1.13kg 約 5-6 週。原廠大圓罐浪費空間——開封後分裝 1-2 週份量到方形密封盒或夾鏈袋塞冷藏，剩餘留原罐常溫陰涼處。含花生油，過敏者注意。',
  11
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '希臘優格（Kirkland 零脂 907g×2）',
  '5 種活菌（保加利亞乳桿菌、嗜熱鏈球菌、嗜酸乳桿菌、雙歧桿菌、乾酪乳桿菌）。零脂，每 100g 含 9.4g 蛋白質。賣場限定商品',
  '每日 200-300g',
  'NT$479 / 907g×2',
  'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/Kirkland-Signature-Chilled-Nonfat-Greek-Yogurt-907-g-X-2-Count/p/599369',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '美國',
  $${"ingredients":"巴氏殺菌發酵脫脂牛奶(巴氏殺菌脫脂牛奶,乳酸菌), 乳酸菌(Lactobacillus bulgaricus, Streptococcus thermophilus, Lactobacillus acidophilus, Bifidobacterium lactis, Lactobacillus casei)","weight":"907公克 X 2入","storage":"冷藏 4°C 以下，開封後請盡速食用完畢","allergens":"本產品含牛奶，食物過敏者請留意","warehouse_only":true,"notes":"無防腐劑、無色素、無麩質、無人工香料、無添加糖"}$$::jsonb,
  $${"protein_per_100g":"9.4g"}$$::jsonb,
  '賣場限定，無法線上訂。每日 200-300g，907g×2 約 6-9 天，每週補貨。兩罐圓筒無法改形狀，緊靠冷藏室最上層深處放置（最低溫區），前方空間留給泡菜疊放。',
  12
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '泡菜（宗家府 冷藏切塊泡菜 120g×6）',
  '韓國產冷藏泡菜，活性乳酸菌來源。成分含白菜、蘿蔔、辣椒、大蒜、韭菜、蝦醬、鯷魚醬。賣場限定商品',
  '每日 50-100g 隨餐',
  '~NT$259 / 120g×6',
  'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/JONGGA-Sliced-Kimchi-120-g-X-6-Pack/p/137728',
  'Costco', 'costco_food', '宗家府', '韓國',
  $${"ingredients":"白菜,蘿蔔,米澱粉,辣椒,大蒜,韭菜,果糖,昆布萃取物,鹽,大蔥,鰹魚萃取物,梨,鯷魚醬(鯷魚,鹽),蝦醬(蝦,鹽,鯷魚,玉米糖膠),甜味劑(D-山梨醇,麥芽糖醇),L-麩酸鈉","weight":"720公克","count":"120公克 X 6入","storage":"0°C-7°C","allergens":"本產品含有魚,蝦類及其製品,不適合其過敏體質者食用.","warehouse_only":true}$$::jsonb,
  '{}'::jsonb,
  '賣場限定，無法線上訂。每日 50-100g，120g×6 約 7-14 天，每 1-2 週補貨。小圓罐適合見縫插針：兩兩疊放在優格罐前方，或利用層板間的零碎高度。',
  13
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '酪梨',
  '修復鉀缺口（每顆 ~700mg 鉀）+ 健康單元不飽和脂肪 + 膳食纖維 7g',
  '每日半顆至一顆',
  '~NT$329 / 1.3kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。輕捏微軟代表已熟。未熟室溫放 2-3 天催熟。1.3kg 約 4-5 顆，4-7 天用完。',
  14
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '菠菜（冷凍或新鮮）',
  '鉀、鎂、鐵、葉酸來源。搭配維他命C增強鐵吸收',
  '每日 100-150g 入菜',
  'NT$379 / 500g×6',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '絕對不買冷凍版（500g×6 佔冷凍室 70%）。每週在傳統市場或 Costco 蔬果區買 300-400g 新鮮菠菜，放入大保鮮袋、裡面墊一張廚房紙巾吸濕，平放於保鮮抽屜底部，3-5 天內用完。',
  15
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '有機燕麥（桂格有機大燕麥片 935g×2）',
  '澳洲有機燕麥，已完全煮熟。β-葡聚醣降膽固醇，優質碳水 + 膳食纖維 8g/份（GI~55，中升糖）',
  '每日 1 份（80g），訓練後或早餐',
  'NT$439 / 935g×2',
  'https://www.costco.com.tw/Food-Dining/Drinks/Powdered-Drink-Mix-Cereal-Oats/Quaker-Organic-Whole-Oats-935-g-X-2-Count/p/116958',
  'Costco', 'costco_food', 'QUAKER 桂格', '澳洲（原料）/ 台灣（製造）',
  $${"ingredients":"有機燕麥(澳洲)","weight":"935公克 X 2入","storage":"開封前請置於乾燥陰涼處，開封後請盡速食用完畢。","allergens":"本產品含有含穀蛋白之穀物(燕麥)。","cooking":"直接將本產品置於250c.c.熱開水中三分鐘，均勻攪拌即可。"}$$::jsonb,
  $${"fiber":"8g/份","gi":"約55（中升糖）"}$$::jsonb,
  '線上可訂（常溫配送）。每日 80g，935g×2 約 23 天，每月補一次。開封後密封避免受潮。',
  16
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '香蕉',
  '訓練前後快速碳水，富含鉀。青香蕉含抗性澱粉（益生元）',
  '每日 1-2 根（訓練前後）',
  '~NT$99 / 1.4kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。選微青帶黃放 2-3 天自然熟成。1.4kg 約 7-8 根，4-7 天用完。',
  17
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '雞胸肉（大成 冷凍雞清胸肉 2.5kg×2）',
  '台灣產清雞胸肉，高蛋白低脂，每 100g 約 31g 蛋白質。增肌期核心蛋白來源',
  '每週 1-2kg',
  'NT$1,179 / 2.5kg×2',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/DaChan-Taiwan-Frozen-Chicken-Breast-25-kg-X-2-Count/p/133602',
  'Costco', 'costco_food', '大成', '台灣',
  $${"ingredients":"清雞胸肉","weight":"5公斤","count":"2.5公斤 X 2入","storage":"冷凍-18度保存","notes":"請保持冷凍直至食用前，解凍後請勿重覆冷凍，以免失去新鮮。"}$$::jsonb,
  $${"protein_per_100g":"約31g"}$$::jsonb,
  '線上可訂（冷凍配送）。買回當天全部煮熟，分裝長方形保鮮盒：冷藏 4-5 天份（放最上層靠冷凍處）+ 極少量壓扁冷凍（最多 1-1.5L）。或改每週 2 次在全聯/超市買冷藏鮮雞胸，隨買隨煮，完全不佔冷凍庫。',
  18
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '有機糙米（銀川有機一等糙米 3kg）',
  '花蓮產有機糙米。基礎碳水來源，冷卻後產生抗性澱粉（益生元）。提供膳食纖維與鎂',
  '每日適量，訓練日增加碳水攝取',
  'NT$359 / 3kg',
  'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Greenme-Organic-Brown-Rice-3-kg/p/124095',
  'Costco', 'costco_food', '銀川', '台灣（花蓮）',
  $${"ingredients":"有機糙米","weight":"3公斤"}$$::jsonb,
  '{}'::jsonb,
  '線上可訂（常溫配送）。3kg 約 3-6 週。有機花蓮產。開封後密封避免蟲害，夏天建議冷藏。',
  19
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '咖啡豆 / 研磨咖啡',
  '起床 60-90 分鐘後飲用，咖啡因 200-300mg。多酚抗氧化、增強專注力',
  '每日 1-2 杯，08:30-13:00 之間',
  '~NT$399 / 1.13kg',
  'https://www.costco.com.tw/Coffee-Beans/c/hero_coffeebean',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場咖啡專區。Kirkland 深焙豆 1.13kg 約 $399 最經濟，可用 1-2 個月。開封後密封或冷凍保存。',
  20
);

------------------------------------------------------------
-- iHerb 專業補充品 (7 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '肌酸 Creatine Monohydrate（CGN 454g）',
  '養肌肉 + 養腦，改善認知與工作記憶',
  '每日 5g',
  'NT$420 / 454g',
  'https://tw.iherb.com/pr/california-gold-nutrition-sport-creatine-monohydrate-unflavored-1-lb-454-g/71026',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01059/g/144.jpg',
  4.8, 29306, 'CGN-01059',
  $${"ingredients":"一水肌酸","form":"無調味粉末","weight":"454g"}$$::jsonb,
  $${"serving_size":"5g","creatine_monohydrate":"5g"}$$::jsonb,
  'iHerb 直送。每日 5g，454g 可用 3 個月。CGN 自有品牌常有額外折扣。搭配其他 iHerb 品項湊免運。',
  22
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）',
  '甘胺酸是抑制性神經傳導物質，降低核心體溫助眠。高吸收率，每日補充鎂 200mg',
  '睡前 2 錠（200mg）',
  'NT$399 / 180 錠',
  'https://tw.iherb.com/pr/now-foods-magnesium-glycinate-180-tablets-100-mg-per-tablet/88819',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now01289/g/41.jpg',
  4.8, 30061, 'NOW-01289',
  $${"form":"錠劑","count":"180錠","chelate_type":"TRAACS™ 甘氨酸鎂"}$$::jsonb,
  $${"serving_size":"2錠","magnesium":"200mg（提取自2000mg甘氨酸鎂）"}$$::jsonb,
  'iHerb 直送。每日 2 錠，180 錠可用 3 個月，每季補一次。',
  23
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '葉黃素 + 玉米黃素（CGN 20mg × 120 顆）',
  '沉積於視網膜黃斑部，保護眼睛抵禦藍光與氧化傷害',
  '每日 1 顆隨餐（需搭配油脂吸收）',
  'NT$914 / 120 顆',
  'https://tw.iherb.com/pr/california-gold-nutrition-lutein-with-zeaxanthin-from-marigold-extract-120-veggie-softgels/94824',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01403/g/126.jpg',
  4.7, 45894, 'CGN-01403',
  $${"ingredients":"葉黃素（來自萬壽菊提取物）（花）、玉米黃質（來自萬壽菊提取物）（花）","form":"素食軟膠囊","count":"120顆","source":"mGold™ 萬壽菊花提取物"}$$::jsonb,
  $${"serving_size":"1顆","lutein":"20mg","zeaxanthin":"含玉米黃質"}$$::jsonb,
  'iHerb 直送。每日 1 顆，120 顆可用 4 個月。CGN 自有品牌 CP 值高。需隨含油脂餐食服用。',
  24
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '鋅 Zinc Picolinate（NOW Foods 50mg × 120 顆）',
  '免疫與睪固酮合成必需。每日 25mg（半顆），搭配銅 2mg 維持平衡',
  '每日半顆（25mg）隨晚餐（避開鈣，與銅間隔 4hr+）',
  'NT$710 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-zinc-picolinate-50-mg-120-veg-capsules/878',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now01552/g/57.jpg',
  4.8, 46833, 'NOW-01552',
  $${"form":"素食膠囊","count":"120顆","chelate_type":"吡啶甲酸鋅"}$$::jsonb,
  $${"serving_size":"1顆","zinc":"50mg（270mg吡啶甲酸鋅）"}$$::jsonb,
  'iHerb 直送。每日半顆，120 顆可用 8 個月。建議隔日 1 顆替代切半。務必搭配銅。',
  25
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）',
  '長期補鋅必須搭配銅。甘胺酸銅吸收率優於檸檬酸銅，鋅銅比維持 10-15:1，防止銅缺乏導致貧血與神經損傷。100 顆裝省 13%/顆',
  '每日 1 顆隨午餐或午後（與鋅間隔 4hr+）',
  'NT$529 / 100 顆',
  'https://tw.iherb.com/pr/solaray-copper-2-mg-100-vegcaps/70102',
  'iHerb', 'iherb_supplement', 'Solaray',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/sor/sor45931/g/37.jpg',
  4.7, 17219, 'SOR-45931',
  $${"form":"素食膠囊","count":"100顆","chelate_type":"銅氨基酸螯合物"}$$::jsonb,
  $${"serving_size":"1顆","copper":"2mg"}$$::jsonb,
  'iHerb 直送。每日 1 顆，100 顆可用 3 個多月，每季補一次。與鋅間隔至少 4 小時。',
  26
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '維他命 D3 2000IU（Doctor''s Best 360 顆）',
  '每日 2000 IU（5+2：週一至五服用，週末休息）。目標血清 25(OH)D 40-60 ng/mL。血檢達標+每日晨光曝曬→可減半或改兩天一次。360 顆大包裝更划算',
  '每日 1 顆隨訓練後餐（需搭配油脂吸收）。5+2 週末休息',
  'NT$457 / 360 顆',
  'https://tw.iherb.com/pr/doctor-s-best-vitamin-d3-125-mcg-5-000-iu-360-softgels/36580',
  'iHerb', 'iherb_supplement', 'Doctor''s Best',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/drb/drb00250/g/114.jpg',
  4.9, 75650, 'DRB-00250',
  $${"form":"軟凝膠","count":"360顆"}$$::jsonb,
  $${"serving_size":"1顆","vitamin_d3":"50微克（2000IU）"}$$::jsonb,
  'iHerb 直送。每日 1 顆，360 顆可用整年。大包裝每顆僅 ~$1.27。',
  27
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'L-Theanine（NOW Foods Double Strength 200mg × 120 顆）',
  '搭配咖啡的最強 nootropic 組合（A 級證據）。促進專注 + 放鬆，消除咖啡因焦慮感。120 顆大包裝更划算',
  '每日 1 顆（200mg）搭配早晨咖啡',
  'NT$399 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-double-strength-l-theanine-200-mg-120-veg-capsules/54096',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00148/g/32.jpg',
  4.7, 16952, 'NOW-00148',
  $${"form":"素食膠囊","count":"120顆"}$$::jsonb,
  $${"serving_size":"1顆","l_theanine":"200mg"}$$::jsonb,
  'iHerb 直送。每日 1 顆，120 顆可用 4 個月。Double Strength 200mg，每季訂一次。',
  28
);

------------------------------------------------------------
-- 設備 (3 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '防藍光眼鏡（琥珀色鏡片）',
  '阻擋 400-550nm 藍光，保護褪黑激素分泌',
  '20:00 後佩戴',
  'NT$500~1,500',
  'https://www.amazon.com/amber-blue-light-blocking-glasses/s?k=amber+blue+light+blocking+glasses',
  'Amazon', 'equipment',
  '一次性購買，Amazon 或蝦皮。選琥珀色鏡片才有效阻擋藍光。$500-1,500 即可。',
  29
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '食品電子秤',
  '精準測量蛋白粉、食材重量，確保每日蛋白質攝取達標',
  '每餐使用，精度 0.1-1g',
  'NT$300~800',
  'https://www.amazon.com/digital-kitchen-food-scale/s?k=digital+kitchen+food+scale',
  'Amazon', 'equipment',
  '一次性購買，Amazon 或蝦皮。精度 0.1-1g，最大秤量至少 5kg。$300-800 即可。',
  30
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '全遮光窗簾',
  '確保臥室全黑環境，維持褪黑激素正常分泌。配合 22:00 入睡方案',
  '安裝於臥室窗戶',
  'NT$1,000~3,000',
  'https://www.amazon.com/100-percent-blackout-curtains/s?k=100+percent+blackout+curtains',
  'Amazon', 'equipment',
  '一次性購買。量好窗戶尺寸，選「100% blackout」標示。邊緣可用魔鬼氈輔助密封。',
  31
);
