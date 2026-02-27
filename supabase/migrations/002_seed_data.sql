------------------------------------------------------------
-- 每日計畫項目 (23 active + 8 inactive = 31 items)
-- Matches live DB state as of 2026-02-25
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  -- === Morning (< 12:00) ===
  ('09:00 起床 & 晨光曝曬', '起床後 30 分鐘內到戶外曬太陽 10-20 分鐘（陰天久一點）。不戴太陽眼鏡。校正晝夜節律、降低皮質醇、促進維他命D合成', 'daily', '睡眠', 1, 1, true),
  ('09:05 補水 & 電解質', '起床後盡快補水。500ml 室溫水 + 少許碘鹽 + 檸檬汁。可搭配晨光曝曬同時進行。碘鹽取代海鹽以確保碘攝取', 'daily', '飲食', 2, 1, true),
  ('09:15 NMN + TMG（空腹）', '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）', 'daily', '補充品', 2, 1, false),
  ('09:15 訓練前營養', '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（水溶性，早晨隨餐提供全天能量代謝）', 'daily', '飲食', 3, 1, true),
  ('09:45 穩定性訓練暖身', 'RAMP 暖身含穩定性訓練共 15 分鐘（升溫→激活→活動度→增強）：反伸展、反旋轉、單腳 RDL、肩胛穩定、抗側屈（行李箱負重走）', 'daily', '運動', 4, 1, true),
  ('10:00 運動', '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘。每次 60-90 分鐘。⚠️ 重訓後 4-6 小時內禁止冷水浴（會抑制肌肥大信號 mTOR/IGF-1）— 冷水浴僅限休息日或訓練前', 'daily', '運動', 5, 1, true),
  ('10:30 咖啡 + L-Theanine', '起床後 60-90 分鐘再喝。咖啡因 200-300mg（約 1-2 杯黑咖啡）+ L-Theanine 200mg（A 級 nootropic 組合，消除焦慮、增強專注）。15:00 後禁止咖啡因（半衰期 5-6 小時影響睡眠）', 'daily', '飲食', 6, 1, true),

  -- === Midday (12:00-15:00) ===
  ('12:00 午餐 + 訓練後補充品', '蛋白質 45-50g（正餐食物）+ 肌酸 5g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日）。脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g。魚油 3 顆、D3 2000IU（5+2）、K2 MK-7 100mcg、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 100-200mg。每日脂肪目標 80-90g（22-25% 總熱量）', 'daily', '飲食', 7, 1, true),
  ('12:00-13:00 午餐補銅 2mg', '銅 2mg（Solgar）隨午餐服用。與鋅間隔 4+ 小時（鋅在晚餐）。鋅銅比維持 10-15:1，防止長期鋅補充導致銅缺乏', 'daily', '補充品', 8, 1, false),
  ('15:00-16:00 銅 2mg 補充', '銅 2mg（Solaray Bisglycinate）單獨服用或與無礦物質補劑的輕食搭配。空腹或僅少量食物可最大化吸收率，避免與鋅、鈣、鐵等礦物質競爭。與晚餐鋅間隔 4hr+', 'daily', '補充品', 9, 1, true),
  ('13:00 綠茶 EGCG 2-3 杯', '午餐後 1hr+ 再飲用（~13:00），避免螯合鈣、鐵、鋅。EGCG + L-theanine 天然組合促進專注。15:00 前喝完（咖啡因 cutoff）', 'daily', '飲食', 8, 1, true),
  ('15:00 NSDR', '使用引導式 Yoga Nidra 音檔（非單純休息）。11 分鐘有 RCT 支持，促進深度放鬆與多巴胺恢復', 'daily', '心理', 10, 1, true),

  -- === Afternoon (17:00-20:00) ===
  ('17:00 高質量社交對話', '至少與一位親友進行非公事的深度對話。每週安排 1 次面對面社交活動。戶外自然接觸 120+ 分鐘/週（可結合有氧）。哈佛研究：人際關係品質對壽命影響高於飲食與運動', 'daily', '心理', 10, 1, true),
  ('19:00 晚餐 + 低 FODMAP 蔬菜', '蛋白質 45-50g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 1 大匙（14g）入菜或涼拌 + 堅果一把 30g（~15g 脂肪）≈ 20-25g。隨餐服用維他命 C 500-1000mg。固體食物睡前 3-4hr 結束', 'daily', '飲食', 11, 1, true),
  ('19:30 餐後散步 15 分鐘', '控制餐後血糖最有效的方法，降低胰島素峰值。輕快步行即可，不需高強度。午餐後也建議散步 10-15 分鐘。可結合戶外自然接觸（每週目標 120+ 分鐘）', 'daily', '運動', 12, 1, true),

  -- === Evening (22:00+) ===
  ('22:00 藍光管理', '調暗燈光或佩戴防藍光眼鏡（琥珀色鏡片）。白天：娛樂螢幕 <2hr、社群媒體 <30min、專注時段手機勿擾模式', 'daily', '睡眠', 11, 1, true),
  ('20:00-20:30 晚餐後點心', '豌豆蛋白 ~20g 粉（≈16g 蛋白）。非乳製植物蛋白，中速消化。晚餐後 1-1.5 小時服用，補充當日蛋白質目標，避免睡前過飽影響睡眠', 'daily', '飲食', 13, 1, true),
  ('21:30-22:00 睡前補充品', '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 600mg（8 週用 / 4 週停）。提前至 21:30-22:00 服用，為腎臟保留排尿緩衝時間，避免半夜起床中斷睡眠', 'daily', '補充品', 14, 1, true),
  ('22:00-23:00 熱水澡', '40-42°C 10-15 分鐘（睡前 60-90 分鐘）。提高核心體溫後快速降溫觸發睡眠驅動', 'daily', '睡眠', 15, 1, true),
  ('23:30 Cyclic Sighing + 專注冥想', 'Cyclic Sighing 5 分鐘（雙吸鼻、長呼口，Stanford RCT 證實最佳呼吸法）+ 專注冥想 10 分鐘（單點注意力：鼻尖呼吸）。寫下三件感恩的事', 'daily', '心理', 16, 1, true),
  ('00:00 感恩練習', '睡前或早晨寫下三件感恩的事，調節自律神經系統', 'daily', '心理', 17, 1, false),
  ('23:50 口腔衛生：刷牙 + 牙線', '早晚各一次。牙周病菌（P. gingivalis）與心血管疾病、阿茲海默症強相關。每日至少刷牙 2 次 + 牙線 1 次', 'daily', '一般', 17, 1, true),
  ('00:00 準時入睡', '目標 8-8.5 小時睡眠。全黑、低溫 18-19°C。深層睡眠啟動腦部排毒系統。週末偏差不超過 30 分鐘。不使用褪黑激素（24歲不需要）', 'daily', '睡眠', 18, 1, true),

  -- === All-day items ===
  ('全天 蛋白質 146g+ 目標', '訓練前乳清 27g + 午晚餐各 45-50g + 睡前豌豆 16g ≈ 143g。每餐達亮氨酸門檻 2.5-3g。每日 4-5 餐均勻分配，總計 146g+（2.0g/kg）', 'daily', '飲食', 19, 1, true),
  ('全天 膳食纖維 35-45g', '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜。供腸道菌產生丁酸，維護腸腦軸。每日至少 1 份發酵食物：希臘優格 200-300g（午餐/點心）+ 泡菜 50-100g（晚餐隨餐）。雙菌源增強腸道多樣性', 'daily', '飲食', 20, 1, true),
  ('全天 每 45 分鐘站立/坐姿切換', '維持脂蛋白脂肪酶 LPL 活性，避免久坐代謝下降', 'daily', '運動', 21, 1, true),
  ('全天 碳水循環：訓練日 vs 休息日', '重訓日 5-6g/kg (360-430g)、有氧日 3-4g/kg (215-290g)、休息日 2-3g/kg (145-215g，僅 Deload 週或臨時休息)。支持 mTOR 肌肉修復與合成。高碳水日建議將 30-40% 替換為低纖維來源（白米飯、義大利麵、去皮馬鈴薯）以控制總纖維量並減輕腸胃負擔。卡路里目標：重訓日 3,100-3,400 kcal', 'daily', '飲食', 22, 1, true),
  ('全天 週末睡眠一致性（±30 分鐘）', '週末起床/睡覺時間與平日偏差不超過 30 分鐘。社交時差（Social Jetlag）影響認知、情緒與代謝，A 級證據', 'daily', '睡眠', 23, 1, false),
  ('全天 數位衛生', '娛樂螢幕 <2hr、社群媒體 <30min。23:00 後無螢幕、專注時段手機勿擾模式', 'daily', '心理', 24, 1, false),
  ('全天 飲水 3-3.5L', '尿液淡黃色為適當水合指標。有氧日訓練中改用電解質粉', 'daily', '飲食', 25, 1, true);

------------------------------------------------------------
-- 每週計畫項目 (3 active + 3 semi-active/inactive)
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('Zone 2 有氧 2 次', '週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機', 'weekly', '運動', 1, 2, true),
  ('肌力訓練 4 次（Upper/Lower）', '一上半身A/二下半身A/四上半身B/五下半身B。每肌群每週 12-20 組，分 2 次訓練。3 週漸進超負荷 + 第 4 週 Deload（量減 40-50%，強度維持 85%）。記錄每組重量/次數', 'weekly', '運動', 2, 4, true),
  ('VO2 Max 訓練 1 次', 'Peter Attia 4×4 法 — 4 分鐘全力（90-95% HRmax）+ 4 分鐘恢復 × 4 組。週三進行', 'weekly', '運動', 3, 1, true),
  ('學習新技能', '樂器或語言學習最佳（結構性神經可塑性證據最強）。20-30 分鐘練習後安排運動，有助記憶鞏固。NSDR 也可在學習後使用', 'weekly', '心理', 4, 3, true),
  ('鋅 25mg 補充', '每週 2-3 次服用鋅 25mg（Zinc Picolinate 半顆），隨晚餐服用。與銅間隔 4hr+。降低每日高劑量補充的長期風險，維持鋅銅比 10-15:1', 'weekly', '補充品', 12, 3, true),
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
  '鈣片備用（Nature Made Ca+D3+K2 250 錠）',
  '碳酸鈣 + 檸檬酸鈣雙鈣源。純粹作為鈣質備用品。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加風險低但需留意。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）。鈣質食物優先策略：優先從希臘優格等原型食物攝取鈣',
  '備用品：僅在當日飲食鈣攝取確認嚴重不足時才服用 1 錠。日常 K2 已改用獨立 K2 MK-7 產品',
  'NT$759 / 250 錠',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453',
  'Costco', 'costco_supplement', 'NATURE MADE 萊萃美', '美國',
  $${"ingredients":"碳酸鈣(碳酸鈣、麥芽糊精(玉米)、阿拉伯膠)、檸檬酸鈣、微結晶纖維素、維生素K2(麥芽糊精(玉米)、納豆脂質、維生素K2(Menaquinone-7))、羥丙基甲基纖維素、二氧化鈦(著色劑)、聚糊精、硬脂酸鎂、二氧化矽、交聯羧甲基纖維素鈉、滑石粉、麥芽糊精、維生素D3(辛烯基丁二酸鈉澱粉、糖、L-抗壞血酸鈉(抗氧化劑)、二氧化矽、中鏈三酸甘油酯、生育醇(抗氧化劑)、膽鈣化醇)、脂肪酸甘油酯(乳化劑)","form":"錠劑","count":"250錠","storage":"請置於陰涼乾燥處，開封後請置於冰箱儲存。","allergens":"不添加麩質、防腐劑、化學色素及人工香料。"}$$::jsonb,
  $${"calcium":"500mg/錠","vitamin_d3":"3.75mcg (150IU)/錠","vitamin_k2":"10mcg (MK-7型)/錠"}$$::jsonb,
  '線上可訂（常溫配送）。純鈣備用品（鈣從食物攝取為主），250 錠可用非常久。K2 已獨立購買（NOW Foods MK-7），本品 K2 含量不足日常需求。開封後建議冰箱保存。',
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
  '訓練前 1 份（~30g 粉 ≈ 27g 蛋白）。午餐改為正餐蛋白質，不再額外沖乳清',
  '約 NT$1,899~2,199 / 2kg',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Sports-Performance/Tryall-Whey-Protein-Isolate-Unflavored-2-kg/p/155648',
  'Costco', 'costco_supplement', 'TRYALL',
  NULL, NULL, NULL, '155648', '台灣（品牌）/ 美國（乳源）',
  '{"ingredients":"分離乳清蛋白（美國乳源）","form":"無調味粉末","weight":"2kg","features":"無添加糖、甜味劑、人工色素、香料"}'::jsonb,
  '{"serving_size":"30g","calories":"~120kcal","protein":"~27g","fat":"~2g","carbs":"~3g","bcaa":"~5.3g","protein_pct":"約90%"}'::jsonb,
  'Costco 線上可訂。每日 ~70g，2kg 約 28 天，每月補貨。無調味可搭配咖啡、黑芝麻粉等調味。',
  4
);

------------------------------------------------------------
-- Costco 食材 (19 items)
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
  '新鮮綠花椰菜（傳統市場/超市）',
  '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）。切碎後靜置 40 分鐘可最大化黑芥子酶轉化',
  '每日一份',
  'NT$20-30 / 顆',
  'https://www.pxmart.com.tw',
  '傳統市場 / 全聯 / 頂好', 'costco_food', NULL, '台灣',
  '{"storage":"冷藏3-4天","preparation":"切碎靜置40分鐘最大化蘿蔔硫素","portion":"每次2-3顆"}'::jsonb,
  '{}'::jsonb,
  '每週補貨 1-2 次，每次買 2-3 顆。切成小朵後靜置 40 分鐘（最大化蘿蔔硫素），裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。小冰箱用戶不建議買 Costco 冷凍版（454g×4 佔冷凍 3L 直接爆倉）',
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
  'NT$599 / 1.13kg',
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
  '新鮮菠菜（傳統市場/超市）',
  '低 FODMAP 蔬菜，鉀、鎂、鐵、葉酸來源。搭配維他命C增強鐵吸收',
  '每日 100-150g 入菜',
  'NT$30-50 / 300-400g',
  'https://www.pxmart.com.tw',
  '傳統市場 / 全聯 / 頂好', 'costco_food', NULL, '台灣',
  '{"storage":"冷藏3-5天","preparation":"墊廚房紙巾吸濕","portion":"每週300-400g"}'::jsonb,
  '{}'::jsonb,
  '每週補貨 1-2 次，每次買 300-400g。放入大保鮮袋、裡面墊一張廚房紙巾吸濕，平放於保鮮抽屜底部，3-5 天內用完。小冰箱用戶不建議買 Costco 冷凍版（500g×6 佔冷凍室 70%）',
  15
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '櫛瓜（美國/加拿大）',
  '低FODMAP蔬菜，腸胃溫和。富含鉀、維他命C、膳食纖維。替代綠花椰菜避免脹氣',
  '每日 100-150g 入菜（晚餐優先）',
  '~NT$100-150 / 300-500g',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, '美國/加拿大',
  '{}'::jsonb,
  '{}'::jsonb,
  '賣場蔬果區散裝。選外表光滑無軟爛。每週在 Costco 或傳統市場買 300-500g，裝入大保鮮袋平放保鮮抽屜，5-7 天內用完。低FODMAP首選，腸胃敏感者必備。',
  16
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '有機燕麥（桂格有機大燕麥片 935g×2）',
  '澳洲有機燕麥，已完全煮熟。β-葡聚醣降膽固醇，優質碳水 + 膳食纖維 8g/份（GI~55，中升糖）',
  '每日 1 份（80g），訓練後或早餐',
  'NT$439 / 935g×2',
  'https://www.costco.com.tw/Food-Dining/Drinks/Powdered-Drink-Mix-Cereal-Oats/Quaker-Organic-Whole-Oats-935-g-X-2-Count/p/116958',
  'Costco', 'costco_food', 'QUAKER 桂格', '澳洲（原料）/ 台灣（製造）',
  $${"ingredients":"有機燕麥(澳洲)。","weight":"935公克 X 2入","storage":"開封前請置於乾燥陰涼處，開封後請盡速食用完畢。","allergens":"本產品含有含穀蛋白之穀物(燕麥)。","cooking":"直接將本產品置於250c.c.熱開水中三分鐘，均勻攪拌即可。"}$$::jsonb,
  $${"fiber":"8g/份","gi":"約55（中升糖）"}$$::jsonb,
  '線上可訂（常溫配送）。每日 80g，935g×2 約 23 天，每月補一次。開封後密封避免受潮。',
  17
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
  18
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
  19
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
  20
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '咖啡豆 / 研磨咖啡',
  '起床 60-90 分鐘後飲用，咖啡因 200-300mg。多酚抗氧化、增強專注力',
  '每日 1-2 杯，10:30-15:00 之間',
  '~NT$399 / 1.13kg',
  'https://www.costco.com.tw/Coffee-Beans/c/hero_coffeebean',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場咖啡專區。Kirkland 深焙豆 1.13kg 約 $399 最經濟，可用 1-2 個月。開封後密封或冷凍保存。',
  21
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '特級初榨橄欖油（Kirkland 2L）',
  '單元不飽和脂肪酸（MUFA）來源，支持脂溶性維他命吸收。抗發炎多酚。產地西班牙',
  '午餐 + 晚餐各 1 大匙（14g），每日共 ~28g',
  'NT$459 / 2L',
  'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/c/90903',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '西班牙',
  $${"ingredients":"100% 特級初榨橄欖油","volume":"2公升","storage":"陰涼避光處，開封後 3-6 個月內用完"}$$::jsonb,
  $${"fat_per_15ml":"14g","mufa":"約10g","calories":"約126kcal"}$$::jsonb,
  '線上可訂（常溫配送）。每日 ~28g（2 大匙），2L 約 2.5 個月。避免高溫油炸（發煙點 ~190°C），涼拌或中低溫烹調最佳。',
  22
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '冷凍草飼牛肉片（澳洲）',
  '紅肉提供血基質鐵（吸收率 15-35%）、維他命 B12、天然肌酸。草飼牛肉 Omega-3 較高',
  '每週 1-2 次（200-300g/次）替代雞胸肉',
  'NT$600-800 / 1kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/c/90701',
  'Costco', 'costco_food', NULL, '澳洲',
  '{"cut":"薄片火鍋肉片或牛排","fat":"選擇瘦部位（如菲力、後腿）","storage":"冷凍 -18°C"}'::jsonb,
  '{"protein_per_100g":"20-25g","iron":"2-3mg（血基質鐵）","b12":"豐富","creatine":"天然含有"}'::jsonb,
  '每週 1-2 次作為紅肉來源。補充血基質鐵（植物鐵吸收率僅 2-20%）與 B12。草飼優於穀飼。瘦部位脂肪 <10g/100g。',
  23
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '綠茶（茶葉/茶包）',
  'EGCG + L-theanine 天然組合，促進專注。多酚抗氧化',
  '每日午餐後 2-3 杯（13:00-15:00）',
  '~NT$200-400',
  'https://www.costco.com.tw/Food-Dining/Drinks/Tea/c/90811',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  'Costco 茶飲區或超市購買。散裝綠茶葉 CP 值最高。午餐後 1hr+ 再飲用避免螯合鈣鐵鋅，15:00 前喝完（咖啡因 cutoff）。',
  23
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '藍莓 / 冷凍莓果',
  '抗氧化花青素含量最高的水果之一。搭配燕麥碗、希臘優格食用。改善認知功能與心血管健康',
  '每日 50-100g（燕麥碗或優格搭配）',
  '新鮮 ~NT$399/510g 或 冷凍 ~NT$329/600g',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, '美國/加拿大/智利',
  '{"storage":"新鮮冷藏3-5天，冷凍版-18°C長期保存"}'::jsonb,
  '{"anthocyanins":"花青素豐富","fiber":"約2.4g/100g","vitamin_c":"約10mg/100g"}'::jsonb,
  '新鮮藍莓在 Costco 蔬果區（季節性）。小冰箱建議買新鮮版每週 1 盒（510g），放保鮮抽屜 3-5 天用完。若買冷凍版（Nature''s Touch 600g），僅佔冷凍約 0.5L 可接受。每日取 50-100g 加入燕麥碗或優格。',
  24
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('有機白米（銀川一等白米 3kg）',
   '花蓮產有機白米。低纖維碳水，訓練日30-40%替代糙米以減輕腸胃負擔。易消化，GI較高適合訓練後補充',
   '訓練日適量（目標總碳水30-40%來自低纖維）',
   'NT$320-380 / 3kg',
   'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/c/hero_rice',
   'Costco', 'costco_food', '銀川', '台灣（花蓮）',
   '{"ingredients":"有機白米","weight":"3公斤"}'::jsonb,
   '{"fiber":"低纖維（<1g/100g）","gi":"中高GI（約73）"}'::jsonb,
   '線上可訂（常溫配送）。與糙米混合購買：糙米為基礎，白米作為訓練日高碳日補充。3kg約3-6週（取決於訓練頻率）。開封後密封避免蟲害，夏天建議冷藏。',
   25),

  ('義大利麵（Garofalo 500g×6）',
   '義大利進口杜蘭小麥義大利麵。低纖維碳水，訓練日30-40%替代全麥麵食。煮熟後冷卻可產生抗性澱粉',
   '訓練日適量（作為低纖維碳水選項）',
   'NT$459 / 500g×6',
   'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Garofalo-Penne-Rigate-Pasta-500-g-X-6-Pack/p/117346',
   'Costco', 'costco_food', 'Garofalo', '義大利',
   '{"ingredients":"杜蘭小麥粉","weight":"3公斤","count":"500g × 6包","storage":"常溫陰涼乾燥處"}'::jsonb,
   '{"fiber":"低纖維（約2-3g/100g乾麵）","protein":"約12g/100g","gi":"中GI（約55-65，視煮熟度）"}'::jsonb,
   '線上可訂（常溫配送）。500g×6共3kg，每週訓練日1-2餐使用，可用1-2個月。開封後每包密封防潮。常溫存放不佔冰箱空間。Costco另有其他品牌（Barilla, De Cecco）可替換。',
   26),

  ('馬鈴薯（美國/加拿大）',
   '去皮後低纖維碳水，訓練日30-40%替代地瓜。富含鉀（每顆~800mg），冷卻後產生抗性澱粉。選擇黃皮或紅皮較甜',
   '訓練日適量（去皮烹調）',
   '~NT$199 / 3kg',
   'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
   'Costco', 'costco_food', NULL, '美國/加拿大',
   '{"storage":"陰涼通風處，勿冷藏（會轉甜並影響質地）","notes":"發芽或變綠的馬鈴薯含有毒素（龍葵鹼），務必丟棄"}'::jsonb,
   '{"potassium":"約800mg/顆","fiber":"去皮後低纖維（約1g/100g）","gi":"中高GI（約85-90，視烹調法）"}'::jsonb,
   '賣場蔬果區散裝，約NT$199/3kg（6-8顆）。選外皮光滑無發芽。常溫通風處可放2-3週，勿冷藏。去皮後煮、蒸或烤，冷卻後作為訓練日碳水。每週補1次約可用7-10天。',
   27);

------------------------------------------------------------
-- iHerb 專業補充品 (15 items)
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
  '甘胺酸是抑制性神經傳導物質，降低核心體溫助眠。高吸收率',
  '睡前 1 錠（100mg）',
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
  '免疫與睪固酮合成必需。每週 2-3 次 25mg（半顆），搭配銅 2mg 維持平衡',
  '每週 2-3 次，每次半顆（25mg）隨晚餐（避開鈣，與銅間隔 4hr+）',
  'NT$710 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-zinc-picolinate-50-mg-120-veg-capsules/878',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now01552/g/57.jpg',
  4.8, 46833, 'NOW-01552',
  $${"form":"素食膠囊","count":"120顆","chelate_type":"吡啶甲酸鋅"}$$::jsonb,
  $${"serving_size":"1顆","zinc":"50mg（270mg吡啶甲酸鋅）"}$$::jsonb,
  'iHerb 直送。每週 2-3 次（週二、四、六），每次半顆 25mg，120 顆可用 8-10 個月。降低每日補充的長期風險。與銅保持 10-15:1 比例。',
  25
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）',
  '長期補鋅必須搭配銅。甘胺酸銅吸收率優於檸檬酸銅。下午單獨服用可最大化吸收率，避免與鋅、鈣、鐵競爭。鋅銅比維持 10-15:1，防止銅缺乏導致貧血與神經損傷',
  '每日 1 顆，下午 15:00-16:00 單獨服用（空腹或僅搭配輕食，與礦物質補劑間隔）',
  'NT$217 / 100 顆',
  'https://tw.iherb.com/pr/solaray-copper-2-mg-100-vegcaps/70102',
  'iHerb', 'iherb_supplement', 'Solaray',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/sor/sor45931/g/37.jpg',
  4.7, 17219, 'SOR-45931',
  $${"form":"素食膠囊","count":"100顆","chelate_type":"銅氨基酸螯合物"}$$::jsonb,
  $${"serving_size":"1顆","copper":"2mg"}$$::jsonb,
  'iHerb 直送。每日 1 顆，100 顆可用 3 個多月。下午 15:00-16:00 空腹或搭配少量食物服用，避開午餐的魚油/D3/鈣鎂等礦物質競爭，最大化吸收率。與晚餐鋅間隔 4hr+',
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
  '維他命 K2 MK-7（NOW Foods 100mcg × 120 顆）',
  '獨立 K2 MK-7（納豆來源），引導鈣質沉積至骨骼而非血管壁。與 D3 協同作用，防止動脈鈣化。取代鈣片複方中不足量的 K2',
  '每日 1 顆隨午餐（與 D3、魚油同服，脂溶性需油脂）',
  'NT$887 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-mk-7-vitamin-k-2-100-mcg-120-veg-capsules/78992',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00993/g/86.jpg', 4.8, NULL, 'NOW-00993',
  $${"form":"素食膠囊","count":"120顆","source":"MK-7（納豆來源）"}$$::jsonb,
  $${"serving_size":"1顆","vitamin_k2":"100mcg（MK-7型）"}$$::jsonb,
  'iHerb 直送。每日 1 顆，120 顆可用 4 個月。MK-7 型半衰期長（~72hr），每日 1 顆即可維持穩定血中濃度。取代 Nature Made 鈣片複方中僅 10mcg 的不足 K2。',
  28
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
  29
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '膠原蛋白肽 CollagenUP（CGN 206g）',
  '水解海洋膠原蛋白肽 + 玻尿酸 + 維他命 C。與 Vit C 協同促進膠原蛋白合成，支持皮膚、關節與結締組織健康',
  '每日 10-15g 隨午餐（搭配維他命 C）',
  'NT$1,279 / 206g',
  'https://tw.iherb.com/pr/california-gold-nutrition-collagenup-marine-hydrolyzed-collagen-hyaluronic-acid-vitamin-c-unflavored-7-26-oz-206-g/64903',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01033/g/255.jpg', 4.7, NULL, 'CGN-01033',
  $${"ingredients":"水解海洋膠原蛋白肽、玻尿酸、維他命C","form":"無調味粉末","weight":"206g"}$$::jsonb,
  $${"serving_size":"6.5g","collagen_peptides":"5.1g","hyaluronic_acid":"18mg","vitamin_c":"80mg"}$$::jsonb,
  'iHerb 直送。每日 10-15g，206g 約可用 2-3 週。與維他命 C 同服效果最佳。搭配其他 iHerb 品項湊免運。',
  30
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'CoQ10 Ubiquinol 200mg（NOW Foods 60 顆）',
  '還原型輔酶 Q10（Ubiquinol），生物利用率高於 Ubiquinone。支持細胞能量產生與心血管健康。脂溶性，與魚油同服提升吸收',
  '每日 1 顆隨午餐（搭配魚油）',
  'NT$1,109 / 60 顆',
  'https://tw.iherb.com/pr/now-foods-ubiquinol-200-mg-60-softgels/23657',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now03144/g/38.jpg', 4.8, NULL, 'NOW-03144',
  $${"form":"軟膠囊","count":"60顆"}$$::jsonb,
  $${"serving_size":"1顆","ubiquinol":"200mg"}$$::jsonb,
  'iHerb 直送。每日 1 顆，60 顆可用 2 個月。脂溶性，務必隨含油脂餐食服用。',
  31
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'B群 B-50（NOW Foods 100 顆）',
  '✓ iHerb 必買。完整 B 群複方（B1/B2/B3/B5/B6/B7/B9/B12）。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成',
  '每日 1 顆隨早餐（訓練前營養餐）',
  'NT$332 / 100 顆',
  'https://tw.iherb.com/pr/now-foods-b-50-100-veg-capsules/39670',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00420/g/74.jpg', 4.7, NULL, 'NOW-00420',
  $${"form":"素食膠囊","count":"100顆"}$$::jsonb,
  $${"serving_size":"1顆","b_complex":"B-50 完整複方"}$$::jsonb,
  'iHerb 必買品項。每日 1 顆隨早餐（訓練前營養餐）服用，100 顆可用 3 個多月。水溶性維生素，隨餐服用提升吸收率。尿液變黃為正常現象（B2 代謝）',
  32
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '豌豆蛋白 Pea Protein（NOW Foods 907g）',
  '非乳製植物蛋白，中速消化。晚餐後 1-1.5 小時服用補充當日蛋白質，避免睡前過飽。無大豆、無乳製品、無麩質。每份 ~24g 蛋白',
  '晚餐後點心 ~20g 粉（≈16g 蛋白），約 20:00-20:30',
  'NT$600 / 907g',
  'https://tw.iherb.com/pr/now-foods-sports-pea-protein-pure-unflavored-2-lbs-907-g/9858',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now02135/g/41.jpg', 4.4, NULL, 'NOW-02135',
  $${"ingredients":"豌豆蛋白分離物（黃豌豆）","form":"無調味粉末","weight":"907g"}$$::jsonb,
  $${"serving_size":"33g","protein":"24g","fat":"2g","carbs":"1g"}$$::jsonb,
  'iHerb 直送。每日 ~20g，907g 可用 45 天。無調味可搭配少量蜂蜜或可可粉。晚餐後 1-1.5 小時服用，避免睡前影響睡眠品質',
  33
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '甘胺酸 Glycine Pure Powder（NOW Foods 454g）',
  '抑制性神經傳導物質，降低核心體溫促進深層睡眠。參與膠原蛋白合成與肌酸生成',
  '睡前 3g（約半茶匙）',
  'NT$710 / 454g',
  'https://tw.iherb.com/pr/now-foods-glycine-pure-powder-1-lb-454-g/615',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00225/g/32.jpg', 4.8, NULL, 'NOW-00225',
  $${"ingredients":"甘胺酸","form":"純粉末","weight":"454g"}$$::jsonb,
  $${"serving_size":"3g","glycine":"3g"}$$::jsonb,
  'iHerb 直送。每日 3g，454g 可用 5 個月。微甜味，可直接加入豌豆蛋白一起沖泡。',
  34
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '蘇糖酸鎂 Magtein（NOW Foods 90 顆）',
  '唯一可穿越血腦屏障的鎂型態（鎂 L-蘇糖酸鹽）。改善認知功能與睡眠品質',
  '睡前 3 顆（元素鎂 ~144mg）',
  'NT$874 / 90 顆',
  'https://tw.iherb.com/pr/now-foods-magtein-magnesium-l-threonate-90-veg-capsules/57577',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now02390/g/50.jpg', 4.8, NULL, 'NOW-02390',
  $${"form":"素食膠囊","count":"90顆"}$$::jsonb,
  $${"serving_size":"3顆","magnesium_l_threonate":"2000mg","elemental_magnesium":"144mg"}$$::jsonb,
  'iHerb 直送。每日 3 顆，90 顆可用 1 個月。與甘胺酸鎂搭配使用，注意總鎂量。',
  35
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'Ashwagandha KSM-66（NOW Foods 90 顆）',
  'KSM-66 全譜根部萃取，降低皮質醇、改善壓力與睡眠品質。RCT 支持的適應原草藥',
  '睡前 1 顆（600mg）。8 週用 / 4 週停',
  'NT$288 / 90 顆',
  'https://tw.iherb.com/pr/now-foods-ashwagandha-standardized-extract-450-mg-90-veg-capsules/310',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now04603/g/83.jpg', 4.7, NULL, 'NOW-04603',
  $${"form":"素食膠囊","count":"90顆","extract":"KSM-66 全譜根部萃取"}$$::jsonb,
  $${"serving_size":"1顆","ashwagandha_extract":"450mg"}$$::jsonb,
  'iHerb 直送。8 週用期每日 1 顆（2 顆達 ~600mg 視劑量調整），90 顆約 1.5-3 個月。停用期留白讓受體重置。第 6-8 週留意情緒變化。',
  36
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '電解質粉 Sport Hydration（CGN 20 包）',
  '鈉、鉀、鎂、鈣電解質補充。有氧訓練日維持水合與電解質平衡',
  '有氧日訓練中 1 包沖 500ml 水',
  'NT$600 / 20 包',
  'https://tw.iherb.com/pr/california-gold-nutrition-hydrationup-electrolyte-drink-mix-variety-pack-20-packets-0-14-oz-0-17-oz-4-g-4-8-g-each/94823',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01402/g/75.jpg', 4.5, NULL, 'CGN-01402',
  $${"form":"沖泡粉末","count":"20包"}$$::jsonb,
  $${"serving_size":"1包","sodium":"250mg","potassium":"150mg"}$$::jsonb,
  'iHerb 直送。有氧日每次 1 包，每週 2-3 次，20 包約 7-10 週。CGN 自有品牌有折扣。',
  37
);

------------------------------------------------------------
-- 設備 (3 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '防藍光眼鏡（琥珀色鏡片）',
  '阻擋 400-550nm 藍光，保護褪黑激素分泌',
  '22:00 後佩戴',
  'NT$500~1,500',
  'https://www.amazon.com/amber-blue-light-blocking-glasses/s?k=amber+blue+light+blocking+glasses',
  'Amazon', 'equipment',
  '一次性購買，Amazon 或蝦皮。選琥珀色鏡片才有效阻擋藍光。$500-1,500 即可。',
  37
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '食品電子秤',
  '精準測量蛋白粉、食材重量，確保每日蛋白質攝取達標',
  '每餐使用，精度 0.1-1g',
  'NT$300~800',
  'https://www.amazon.com/digital-kitchen-food-scale/s?k=digital+kitchen+food+scale',
  'Amazon', 'equipment',
  '一次性購買，Amazon 或蝦皮。精度 0.1-1g，最大秤量至少 5kg。$300-800 即可。',
  38
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '全遮光窗簾',
  '確保臥室全黑環境，維持褪黑激素正常分泌。配合 00:00 入睡方案',
  '安裝於臥室窗戶',
  'NT$1,000~3,000',
  'https://www.amazon.com/100-percent-blackout-curtains/s?k=100+percent+blackout+curtains',
  'Amazon', 'equipment',
  '一次性購買。量好窗戶尺寸，選「100% blackout」標示。邊緣可用魔鬼氈輔助密封。',
  39
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '電子鍋（多功能）',
  '煮飯、蒸地瓜/馬鈴薯、燉雞胸肉、煮燕麥粥。一鍋多用是小廚房核心設備。選 3-6 人份（1.0-1.8L 內鍋）適合一人備餐',
  '每日使用（煮飯、蒸菜、燉肉）',
  'NT$1,500-4,000',
  'https://www.costco.com.tw/TVs-Electronics/Home-Appliances/Rice-Cookers/c/90118',
  'Costco/momo/蝦皮', 'equipment',
  '一次性購買。推薦：象印微電腦電子鍋 3 人份（~$2,500-4,000，煮飯品質佳，有預約定時功能可前晚設定早上煮好）或大同電子鍋 6 人份（~$1,800，經典耐用）。Costco 線上有多款可比較。',
  40
);

------------------------------------------------------------
-- 個人保養 Personal Care (4 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('防曬乳（Neutrogena/La Roche-Posay SPF 50+）',
   '廣譜 UVA/UVB 防護，SPF 50+ PA++++。物理+化學防曬，質地清爽不油膩。防曬是#1抗皮膚老化措施',
   '每日早上外出前，全臉頸部（約1/4茶匙）',
   'NT$350-600 / 50-100ml',
   'https://www.watsons.com.tw/sunscreen',
   '屈臣氏/康是美/iHerb', 'personal_care', 'Neutrogena / La Roche-Posay / Biore', '美國/法國/日本',
   '{"spf":"SPF 50+ PA++++","volume":"50-100ml","features":"廣譜防曬,防水配方"}'::jsonb,
   '{}'::jsonb,
   '屈臣氏/康是美實體購買可試質地。Neutrogena Ultra Sheer約$400/88ml（CP值高），La Roche-Posay Anthelios約$600/50ml（敏感肌），Biore Aqua Rich約$350/50ml（清爽款）。每日使用，50ml約1個月。',
   40),

  ('洗面乳（CeraVe Hydrating Cleanser 236ml）',
   '胺基酸溫和潔面，含神經醯胺+玻尿酸，不破壞皮膚屏障。pH平衡配方適合每日早晚使用',
   '早晚各一次，溫水洗臉',
   'NT$420 / 236ml',
   'https://tw.iherb.com/pr/cerave-hydrating-facial-cleanser-8-fl-oz-236-ml/69325',
   'iHerb/屈臣氏/康是美', 'personal_care', 'CeraVe', '美國',
   '{"volume":"236ml","ph":"pH 5.5-6 (接近皮膚自然pH)","features":"無香料,無皂鹼,低敏配方"}'::jsonb,
   '{}'::jsonb,
   'iHerb 直送 NT$420/236ml（最划算）。屈臣氏/康是美也有販售但容量較小。每日2次，236ml約3個月。CeraVe 是皮膚科醫師推薦品牌，含神經醯胺修復皮膚屏障。替代品：Cetaphil 溫和潔膚乳（約$400/200ml）。',
   41),

  ('保濕乳液（CeraVe Moisturizing Cream 340g）',
   '含玻尿酸+神經醯胺+甘油，MVE 緩釋技術24小時保濕。無香料低敏配方，洗臉後立即使用鎖水',
   '早晚洗臉後立即使用（臉頸部）',
   'NT$566 / 340g',
   'https://tw.iherb.com/pr/cerave-moisturizing-cream-12-oz-340-g/69326',
   'iHerb/屈臣氏/康是美', 'personal_care', 'CeraVe', '美國',
   '{"volume":"340g","features":"MVE緩釋技術,24小時保濕,無香料,無油配方"}'::jsonb,
   '{}'::jsonb,
   'iHerb 直送 NT$566/340g（大包裝划算）。每日2次，340g約3-4個月。同品牌與洗面乳搭配使用效果佳。替代品：Cetaphil 長效潤膚乳（約$550/350ml）或平價選項如Neutrogena水活保濕凝露（約$300/100g）。',
   42),

  ('A醇精華 0.5% + Vit C 精華（The Ordinary）',
   'A醇（晚）：0.5%濃度適合進階使用，促進細胞更新與膠原蛋白生成。Vit C（早）：抗氧化+促進膠原蛋白，防曬前使用增強防護',
   'A醇每週2-3次晚上（保濕後），Vit C每日早上（洗臉後）',
   'A醇 NT$440/30ml + Vit C NT$550/30ml',
   'https://tw.iherb.com/pr/the-ordinary-retinol-0-5-in-squalane-1-fl-oz-30-ml/90058',
   'iHerb/屈臣氏', 'personal_care', 'The Ordinary / Timeless', '加拿大',
   '{"a醇":"0.5% in Squalane基底,30ml","vit_c":"20% L-Ascorbic Acid + Vit E + Ferulic Acid,30ml","storage":"避光陰涼處,Vit C開封後冷藏"}'::jsonb,
   '{}'::jsonb,
   'iHerb 購買最划算。A醇：從0.2%開始適應→0.5%→1%漸進提升。初期每週1次，無刺激後增至2-3次。若出現脫皮紅癢→暫停數日。Vit C：選L-Ascorbic Acid形式（效果最佳但需冷藏）。開封後3個月內用完避免氧化。兩者不可同時使用（A醇晚，Vit C早）。',
   43);

------------------------------------------------------------
-- 便利超商日購 Convenience Store Daily (7 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('香蕉（單顆，已熟）',
   '便利超商每日新鮮香蕉，已達最佳熟度。訓練前快速碳水，富含鉀（每根 ~400mg）',
   '訓練前 1-2 根，或每日點心',
   'NT$10-12 / 根',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店', 'convenience_daily', NULL, '台灣 / 菲律賓',
   '{"ripeness":"已熟即食","storage":"常溫1-2天或冷藏3-4天"}'::jsonb,
   '{"potassium":"約400mg/根","carbs":"約27g/根","calories":"約105kcal/根"}'::jsonb,
   '每 2-3 天買 1-2 根。優點：零熟度追蹤、即買即食。比 Costco 散裝 1.4kg 每根貴 NT$2-4，但省冰箱空間 + 保證熟度。訓練日建議每日採購。',
   50),

  ('茶葉蛋',
   '便利超商現煮茶葉蛋，架穩定蛋白質來源。每顆 ~6.3g 蛋白，適合緊急補充或午餐搭配',
   '每日 1-2 顆作為蛋白質補充',
   'NT$8-12 / 顆',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店 / OK便利店', 'convenience_daily', NULL, '台灣',
   '{"shelf_life":"冷藏櫃24-48小時","protein":"約6.3g/顆"}'::jsonb,
   '{"protein":"6.3g/顆","fat":"5g/顆","sodium":"約200-300mg（鹹味）"}'::jsonb,
   '每 2-3 天買 1-2 顆。優點：熟食即食、不佔冷藏（架穩定）、補充 Costco 生蛋不足。注意鹽分較高，每日 1-2 顆為限。每月約 20 顆（NT$160-240）+ Costco 生蛋 20 顆/月，總成本約 Costco 30 顆價格，但省蛋盒空間。',
   51),

  ('新鮮雞胸肉（冷藏小包）',
   '超市/全聯冷藏鮮雞胸，300-500g 小包裝。當天購買當天烹調，零冷凍空間佔用',
   '每週 2-3 次購買，每次 300-500g',
   'NT$120-150 / 300g',
   'https://www.pxmart.com.tw',
   '全聯 / 頂好 / 家樂福', 'convenience_daily', NULL, '台灣',
   '{"packaging":"冷藏真空包","shelf_life":"冷藏3-5天","cooking":"當天購買建議當天烹調"}'::jsonb,
   '{"protein":"約31g/100g","fat":"約3g/100g","calories":"約165kcal/100g"}'::jsonb,
   '每週 2-3 次購買 300-500g（每次約 NT$360-450）。優點：釋放 Costco 5kg 冷凍佔用的 2-3L 冷凍空間、保證新鮮度、不需「當天全煮 5kg→分裝」流程。每月成本約 +NT$200-300，但冷凍庫從爆滿→餘裕 50%。',
   52),

  ('酪梨（單顆，已熟）',
   '便利超商/全聯單顆酪梨，已達最佳熟度（輕捏微軟）。健康脂肪 + 鉀（~700mg/顆）',
   '每 2-3 天 1 顆，午餐或晚餐',
   'NT$25-30 / 顆',
   'https://www.7-11.com.tw',
   '7-Eleven / 全聯', 'convenience_daily', NULL, '台灣 / 紐西蘭',
   '{"ripeness":"已熟即食","storage":"冷藏1-2天"}'::jsonb,
   '{"fat":"約15g/半顆","potassium":"約700mg/顆","fiber":"約7g/顆"}'::jsonb,
   '每 2-3 天買 1 顆（每週 3-4 顆）。優點：零氧化浪費（不需矽膠套保鮮）、熟度保證。比 Costco 1.3kg（4-5 顆）週購貴約 NT$20-40/顆，但省冷藏空間 + 切半保鮮負擔。每月約 12-16 顆（NT$300-480）。',
   53),

  ('新鮮藍莓（小盒）',
   '便利超商小盒藍莓 150-200g，花青素豐富。搭配燕麥碗、希臘優格',
   '每週 2-3 次，每次 50-100g',
   'NT$99-129 / 150-200g',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店', 'convenience_daily', NULL, '美國 / 智利',
   '{"packaging":"透明盒裝","shelf_life":"冷藏3-5天"}'::jsonb,
   '{"anthocyanins":"花青素豐富","fiber":"約2.4g/100g","vitamin_c":"約10mg/100g"}'::jsonb,
   '每週 2-3 次買 1 小盒（每週 300-450g）。優點：不需週購 Costco 510g 大盒（3-5 天吃完壓力）、小量新鮮。成本約 Costco ±0，但省冷藏抽屜空間。',
   54),

  ('新鮮菠菜（沙拉包）',
   '便利超商預洗菠菜沙拉包 100-150g。低 FODMAP 蔬菜，鉀、鎂、鐵來源',
   '每週 2-3 次，每次 100-150g',
   'NT$30-50 / 100-150g',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店', 'convenience_daily', NULL, '台灣',
   '{"packaging":"預洗沙拉包","shelf_life":"冷藏2-3天"}'::jsonb,
   '{"iron":"約2.7mg/100g","magnesium":"約79mg/100g","potassium":"約558mg/100g"}'::jsonb,
   '每週 2-3 次買 1 包（每週 300-400g）。優點：預洗即食、省傳統市場週購。比市場散裝貴 50-100%，但便利性高。可與傳統市場混搭：50% 便利超商 + 50% 市場散裝。',
   55),

  ('鮪魚罐頭（水煮）',
   '架穩定蛋白質備用來源。每罐 ~25g 蛋白，適合緊急午餐或晚餐補充',
   '備用（每月 2-4 罐）',
   'NT$50-80 / 罐（約 180g）',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店 / 全聯', 'convenience_daily', NULL, '泰國 / 台灣',
   '{"type":"水煮鮪魚（低鈉）","shelf_life":"未開封2-3年","storage":"常溫"}'::jsonb,
   '{"protein":"約25g/罐","fat":"約1g/罐","sodium":"約200-400mg（視品牌）"}'::jsonb,
   '備用品。當無法採購新鮮蛋白質時（雞胸、鮭魚、蛋缺貨），2 罐鮪魚 = 50g 蛋白可替代一餐。建議常備 2-4 罐（常溫不佔冰箱）。',
   56);
