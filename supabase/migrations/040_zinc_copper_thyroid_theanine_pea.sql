------------------------------------------------------------
-- Migration 040: 鋅改 15mg 錠劑、銅隨點心服用、
--                甲狀腺警示+TSH/FT4、L-Theanine 統一 1:1、
--                豌豆蛋白改 Tryall
------------------------------------------------------------

-- ===== 1. 鋅：改為 15mg 錠劑，每日 1 錠 =====

-- 1a. 更新鋅產品
UPDATE products SET
  name = '鋅 Zinc Picolinate（NOW Foods 15mg × 120 錠）',
  description = '免疫與睪固酮合成必需。每日 15mg 錠劑，含飲食鋅（雞蛋 ~5mg + 肉類 ~5-12mg + 堅果 ~2-3mg）總計不超過 UL 40mg/日。Picolinate 形式吸收率優於其他形式。錠劑可精確控量（膠囊粉末無法掰半）',
  usage = '每日隨晚餐服用 1 錠（15mg），與銅 2mg 維持平衡',
  price = 'NT$250-350 / 120 錠',
  url = 'https://tw.iherb.com/pr/now-foods-zinc-picolinate-30-mg-100-veg-capsules/733',
  specs = $${"form":"錠劑","count":"120錠","chelate_type":"吡啶甲酸鋅"}$$::jsonb,
  nutrition = $${"serving_size":"1錠","zinc":"15mg"}$$::jsonb,
  purchase_note = 'iHerb 直送。✅ 15mg 錠劑（非 50mg 膠囊），可精確控量。每日 1 錠，120 錠可用 4 個月。含飲食鋅（蛋 ~5mg + 肉 ~5-12mg）每日總鋅攝取 25-32mg，安全低於 UL 40mg。⚠️ 牛肉日豁免：牛肉 200g 已含鋅 8-12mg，當晚不服鋅補劑。與 16:00 銅間隔 3hr+（晚餐 19:00 服用）'
WHERE name LIKE '鋅 Zinc Picolinate%';

-- 1b. 更新鋅 plan_items（每兩天 → 每日 15mg）
UPDATE plan_items SET
  title = '鋅 15mg 每日補充',
  description = '每日隨晚餐服用鋅 15mg（Picolinate 錠劑 1 錠）。補充品 15mg + 飲食鋅 ~10-15mg = 每日總計 25-30mg（安全低於 UL 40mg/日）。與 16:00 銅間隔 3hr+。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 200g 已含鋅 8-12mg，無需額外補充'
WHERE title LIKE '鋅 25mg 每兩天補充%';

-- 1c. 停用舊的每日 25mg 項目（若有）
UPDATE plan_items SET is_active = false
WHERE title LIKE '鋅 25mg 每日補充%';

-- 1d. 更新晚餐 plan_item（鋅 25mg → 15mg 每日）
UPDATE plan_items SET
  description = '蛋白質 35-40g（單餐 ≤40g）+ 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 2 大匙（28g）入菜或涼拌。隨餐服用：維他命 C 500mg（半錠）+ 鋅 15mg（每日 1 錠，與 16:00 銅間隔 3hr+）。⚠️ 牛肉日務必減蛋：草飼牛肉 200g ≈ 40-50g 蛋白，不加蛋，確保單餐 ≤40g 避免腎臟短時間代謝壓力。⚠️ 牛肉日取消鋅補劑：牛肉富含鋅 8-12mg/200g，當晚無需額外補鋅，避免超過 UL 40mg/日。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- ===== 2. 銅：改為隨小點心服用（非嚴格空腹） =====

UPDATE plan_items SET
  description = '銅 2mg（Solaray Bisglycinate）隨低鈣/低鐵小點心服用（如少量水果、幾片餅乾），避免空腹服用引發噁心嘔吐。不與鋅、鈣、鐵等礦物質補劑同服。⚠️ 時間安排：13:00 鈣 → 16:00 銅（間隔 3hr）→ 19:00 鋅（間隔 3hr）。遵從性優先：不再堅持「嚴格空腹」，以不引起嘔吐感為最高原則'
WHERE title LIKE '16:00-17:00 銅 2mg 補充%';

UPDATE products SET
  usage = '每日 1 顆，下午 16:00 隨低鈣/低鐵小點心服用（少量水果或餅乾，避免空腹噁心）',
  purchase_note = 'iHerb 直送。每日 1 顆，100 顆可用 3 個多月。⚠️ 16:00 隨小點心服用（非嚴格空腹）：銅離子空腹刺激性高，易引發噁心嘔吐，搭配少量低鈣/低鐵食物可大幅改善遵從性且仍保有良好吸收率。避開午餐的魚油/D3/鈣鎂等礦物質競爭，與晚餐鋅間隔 3hr+'
WHERE name LIKE '銅 Copper Bisglycinate%';

-- ===== 3. Ashwagandha：甲狀腺警示 + TSH/FT4 監測 =====

-- 3a. 更新 Ashwagandha 週期管理
UPDATE plan_items SET
  description = '在瓶身標記「開始日」與「第 56 天停用日」，建議設定手機鬧鐘提醒停用日期。📋 週期檢查：第 1-5 週正常服用 / 第 6 週起每日自評情緒冷漠（Anhedonia）、早晨無力起床 → 任一症狀立即停用 / 第 8 週（56 天）準時進入停用期 / 停用 4 週（28 天）替代方案：甘胺酸鎂 + Cyclic Sighing。🚫 禁忌：服用 SSRIs/SNRIs 或血清素藥物者禁用。🚫 甲狀腺警示：Ashwagandha 可能提升 T4 水平，甲亢或正服用甲狀腺藥物者禁用（甲狀腺風暴風險）。⚠️ ALT/AST 異常 → 首位停用本品。🚫 感冒/免疫啟動時立即停用：Ashwagandha 具有免疫調節作用，急性感染徵兆出現時 → 立即暫停，待完全康復後再恢復。每半年健檢時確認肝功能 + 甲狀腺指標（TSH、Free T4）'
WHERE title LIKE 'Ashwagandha 週期管理%';

-- 3b. 更新健康檢測（加入 TSH/FT4）
UPDATE plan_items SET
  description = '每半年一次全面健康檢查。必檢指標：BUN（尿素氮）、Creatinine（肌酐）、eGFR（腎絲球過濾率）監測腎功能；ALT/AST 監測肝功能；TSH + Free T4 監測甲狀腺功能（Ashwagandha 可能提升 T4）。⚠️ 若 ALT/AST 異常：首位停用 Ashwagandha（偶有肝損傷案例報告），其次停用 CoQ10、葉黃素。🚫 Ashwagandha 禁忌：若正在服用抗憂鬱劑或血清素藥物 → 禁用（血清素綜合徵風險）；甲亢或服用甲狀腺藥物者 → 禁用（甲狀腺風暴風險）。⚠️ 若 eGFR <90：立即將蛋白質攝取下修至 1.6g/kg/day（≈ 117g/day），每餐 ≤35g，密切監測 BUN/Creatinine 變化。其他：血液、荷爾蒙、代謝指標、維他命D、鋅銅比'
WHERE title LIKE '【每半年】健康檢測%';

-- 3c. 更新 Ashwagandha 產品（加入甲狀腺警示）
UPDATE products SET
  purchase_note = 'iHerb 直送。⚠️ 8 週用期（56 天）每日 1 顆，每瓶 90 顆可完成 1 個完整週期（56 顆用 + 剩 34 顆留下一輪）。建議在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。停用期 4 週替代：甘胺酸鎂 + Cyclic Sighing。⚠️ 第 6 週起留意情緒冷漠 → 立即停用。若 ALT/AST 異常 → 首位停用本品。🚫 血清素藥物禁忌（SSRIs/SNRIs）→ 禁用。🚫 甲狀腺警示：甲亢或正服用甲狀腺藥物者禁用（可能提升 T4，甲狀腺風暴風險）。🚫 感冒/免疫啟動時立即暫停，待康復後再恢復'
WHERE name LIKE 'Ashwagandha%';

-- ===== 4. L-Theanine：移除 1:2 建議，統一 1:1 =====

UPDATE plan_items SET
  description = '起床後 60-90 分鐘再喝。咖啡因 200-300mg（約 1-2 杯黑咖啡）+ L-Theanine 200mg（1:1 比例，A 級 nootropic 組合，消除焦慮、增強專注）。15:00 後禁止咖啡因（半衰期 5-6 小時影響睡眠）'
WHERE title LIKE '10:30 咖啡 + L-Theanine%';

UPDATE products SET
  purchase_note = 'iHerb 直送。每日 1 顆（200mg），120 顆可用 4 個月，與其他 iHerb 品項同步補貨。1:1 比例（咖啡因 200mg + L-Theanine 200mg）為標準用量'
WHERE name LIKE 'L-Theanine%';

-- ===== 5. 豌豆蛋白：改為 Tryall 品牌 =====

UPDATE products SET
  name = '豌豆蛋白 Pea Protein（Tryall 1kg）',
  description = '台灣品牌 Tryall，非乳製植物蛋白，中速消化。下午點心時段服用，分散每日蛋白質攝取至 4-5 餐。無大豆、無乳製品、無麩質。與 Tryall 乳清同品牌，品質一致',
  price = '約 NT$800-1,000 / 1kg',
  url = 'https://www.tryall.com.tw',
  store = 'Costco',
  brand = 'TRYALL',
  image_url = NULL,
  rating = NULL,
  review_count = NULL,
  sku = NULL,
  specs = $${"ingredients":"豌豆蛋白分離物","form":"無調味粉末","weight":"1kg","brand":"Tryall"}$$::jsonb,
  nutrition = $${"serving_size":"33g","protein":"~24g","fat":"~2g","carbs":"~1g"}$$::jsonb,
  purchase_note = 'Tryall 官網或 Costco 線上可訂。每日 ~20g，1kg 可用約 50 天。無調味可搭配少量蜂蜜或可可粉。下午 15:30 服用，分散蛋白質攝取。與 Tryall 乳清同品牌，統一採購更方便'
WHERE name LIKE '豌豆蛋白 Pea Protein%';

UPDATE plan_items SET
  description = 'Tryall 豌豆蛋白 ~20g 粉（≈16g 蛋白）。非乳製植物蛋白，中速消化。下午點心時段服用，分散蛋白質攝取壓力。與 Tryall 乳清同品牌，品質一致'
WHERE title LIKE '15:30 下午點心%';
