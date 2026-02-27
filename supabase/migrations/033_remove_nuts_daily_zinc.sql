------------------------------------------------------------
-- 033: 堅果移除 + 鋅每日化 + 維他命C小包裝 + 冷水浴統一 + 牛奶起司移除
------------------------------------------------------------

-- 1. 更新晚餐描述（移除堅果，橄欖油加倍，加入每日鋅）
UPDATE plan_items SET
  description = '蛋白質 40-45g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 2 大匙（28g）入菜或涼拌。隨餐服用：維他命 C 500mg（1 錠）+ 鋅 25mg（半顆，與 15:00 銅間隔 4hr+）。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- 2. 停用舊的每週鋅項目
UPDATE plan_items SET is_active = false
WHERE title LIKE '鋅 25mg 補充%' AND frequency = 'weekly';

-- 3. 新增每日鋅補充項目
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('鋅 25mg 每日補充',
   '每日隨晚餐服用鋅 25mg（Zinc Picolinate 半顆）。與每日銅 2mg 維持 12.5:1 鋅銅比例，防止長期銅缺乏導致貧血與神經損傷。與 15:00 銅間隔 4hr+',
   'daily', '補充品', 27, 1, true);

-- 4. 更新鋅產品用法（改為每日）
UPDATE products SET
  description = '免疫與睪固酮合成必需。每日 25mg（半顆）搭配每日銅 2mg，維持鋅銅平衡比例 12.5:1。Picolinate 形式吸收率優於其他形式',
  usage = '每日隨晚餐服用半顆（25mg），與銅 2mg 維持 12.5:1 比例',
  purchase_note = 'iHerb 直送。每日半顆 25mg，120 顆可用 8 個月。與 15:00 銅間隔 4hr+（晚餐 19:00 服用）。與銅保持 10-15:1 比例。'
WHERE name LIKE '鋅 Zinc Picolinate%';

-- 5. 更新堅果產品為可選品項
UPDATE products SET
  description = '（可選品項）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅來源。⚠️ 堅果含鎂，若有腹瀉傾向可省略，改用橄欖油補足脂肪',
  purchase_note = '（可選）線上可訂（常溫配送）。每日 30g，1.13kg 約 5-6 週。⚠️ 含花生油，過敏者注意。若睡前鎂補充已導致腹瀉，建議省略堅果改用橄欖油'
WHERE name LIKE '綜合堅果%';

-- 6. 更新維他命 C 產品（改為小包裝）
UPDATE products SET
  name = '維他命 C（NOW Foods 1000mg × 100 錠）',
  description = '抗氧化、膠原蛋白合成、增強鐵吸收。⚠️ 改買小包裝避免長期氧化：100 錠約 3 個月耗用，開瓶後效力不會大幅下降',
  usage = '每日 1 錠（500mg），掰半服用。午餐膠原蛋白已含 ~160mg，每日總計 ~660mg',
  price = 'NT$300-400 / 100 錠',
  url = 'https://tw.iherb.com/pr/now-foods-c-1000-100-tablets/446',
  store = 'iHerb',
  category = 'iherb_supplement',
  brand = 'NOW Foods',
  purchase_note = 'iHerb 直送。每日半錠（500mg），100 錠可用 6 個月（每半年補貨）。⚠️ 小包裝策略：避免 500 錠大包裝開瓶 16 個月導致嚴重氧化。午餐膠原蛋白已含 ~160mg Vit C，晚餐半錠 500mg 即可。開瓶後標記日期，6 個月內用完。'
WHERE name LIKE '維他命 C%Kirkland%';

-- 7. 更新運動項目（冷水浴統一規定）
UPDATE plan_items SET
  description = '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘。每次 60-90 分鐘。🚫 冷水浴統一規定：僅限週六、日 Zone 2 日執行（早晨 07:00-08:00），與運動間隔 4hr 以上。重訓日（一二四五）及 VO2 Max 日（三）嚴格禁止冷水浴（抑制 mTOR/IGF-1 肌肥大 + 線粒體適應）'
WHERE title LIKE '10:00 運動%';

-- 8. 更新鈣攝取確認描述（移除牛奶與起司）
UPDATE plan_items SET
  description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（~200-300mg）+ 深綠蔬菜 + 豆腐。⚠️ 若當日飲食鈣攝取確認不足 → 下午 14:00-15:00 隨輕食補 1 錠鈣片 500mg（Nature Made Ca+D3+K2）。禁止睡前服用（鈣與鎂競爭 DMT1 載體，同服降低兩者吸收率）。與 15:00 銅間隔 1hr+'
WHERE title LIKE '全天 鈣攝取確認%';

-- 9. 更新銅補充描述（鋅改為每日）
UPDATE plan_items SET
  description = '銅 2mg（Solaray Bisglycinate）嚴格單獨空腹服用，不與任何礦物質補劑同服。空腹可最大化吸收率，避免與鋅、鈣、鐵等礦物質競爭。與晚餐鋅間隔 4hr+（鋅每日服用）。若空腹不適可搭配少量水果（非含鈣/鐵食物）'
WHERE title LIKE '15:00-16:00 銅%';
