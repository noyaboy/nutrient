------------------------------------------------------------
-- 030: 鋅降頻 + 鈣檢核 + 維他命C統一 + 冷水浴細化 + 碘鹽強調
-- 1. 鋅從每週 2-3 次降至每週 1-2 次
-- 2. 新增每日鈣攝取檢核點 + 睡前補鈣
-- 3. 維他命 C 午晚餐統一（避免重複高劑量）
-- 4. 冷水浴明確標註週六日早晨 + 間隔 4hr
-- 5. 碘鹽強調確認加碘版本
-- 6. 咖啡 purchase_note 補充 L-Theanine 搭配提示
-- 7. B群在咖啡豆 purchase_note 交叉引用
------------------------------------------------------------

-- === 1. 鋅降至每週 1-2 次 ===

UPDATE plan_items SET
  description = '每週 1-2 次服用鋅 25mg（Zinc Picolinate 半顆），建議週二、週六隨晚餐服用。與銅間隔 4hr+。降低長期高劑量風險，維持鋅銅比 10-15:1',
  target_count = 2
WHERE title = '鋅 25mg 補充';

UPDATE products SET
  usage = '每週 1-2 次，每次半顆（25mg）隨晚餐（避開鈣，與銅間隔 4hr+）',
  description = '免疫與睪固酮合成必需。每週 1-2 次 25mg（半顆），搭配銅 2mg 維持平衡。降低每日高劑量長期風險',
  purchase_note = 'iHerb 直送。每週 1-2 次（週二、六），每次半顆 25mg，120 顆可用 1 年以上。降低每日補充的長期風險。與銅保持 10-15:1 比例。'
WHERE name LIKE '鋅 Zinc Picolinate%';

-- === 2. 新增每日鈣攝取檢核 + 睡前條件補鈣 ===

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('全天 鈣攝取確認（目標 1000mg）',
   '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（~200-300mg）+ 牛奶/起司 + 深綠蔬菜 + 豆腐。⚠️ 若當日飲食鈣攝取確認不足 → 睡前補 1 錠鈣片 500mg（Nature Made Ca+D3+K2）。食物優先，鈣片僅為安全網',
   'daily', '飲食', 23, 1, true);

-- === 3. 維他命 C 統一（午餐膠原蛋白已含 ~160mg，晚餐僅需 500mg）===

UPDATE plan_items SET
  description = '蛋白質 45-50g + 菠菜、櫛瓜等低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 1 大匙（14g）入菜或涼拌 + 堅果一把 30g（~15g 脂肪）≈ 20-25g。隨餐服用維他命 C 500mg（1 錠，午餐膠原蛋白已含 ~160mg Vit C，每日總計 ~660mg 已達 RDA，無需 1000mg 避免過量）。固體食物睡前 3-4hr 結束'
WHERE title LIKE '19:00 晚餐%';

-- 更新膠原蛋白描述，明確標示已含 Vit C
UPDATE products SET
  description = '水解海洋膠原蛋白肽 + 玻尿酸 + 維他命 C（每 6.5g 含 80mg Vit C）。午餐服用 10-15g 已提供 ~120-160mg Vit C，與晚餐 500mg 合計每日 ~660mg，無需額外疊加',
  purchase_note = 'iHerb 直送。每日 10-15g，206g 約可用 2-3 週。已內含維他命 C（~160mg/份），與晚餐 500mg Vit C 合計每日 ~660mg（充足且不過量）。搭配其他 iHerb 品項湊免運。'
WHERE name LIKE '膠原蛋白肽 CollagenUP%';

-- 更新 Vit C 產品描述
UPDATE products SET
  usage = '每日 1 錠（500mg）隨晚餐服用。午餐膠原蛋白已含 ~160mg，每日總計 ~660mg',
  purchase_note = '線上可訂（常溫配送）。每日 1 錠（500mg），500 錠可用 16 個月。午餐膠原蛋白已提供 ~160mg Vit C，晚餐 1 錠 500mg 即可，無需 2 錠避免過量。'
WHERE name LIKE '維他命 C（Kirkland%';

-- === 4. 冷水浴明確標註週六日早晨 ===

UPDATE plan_items SET
  description = '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘。每次 60-90 分鐘。🚫 冷水浴嚴格限制：週六/日 Zone 2 日可在早晨執行冷水浴（運動前 4hr+ 或運動後 4hr+）。重訓日（一二四五）絕對禁止冷水浴（抑制 mTOR/IGF-1 肌肥大信號）'
WHERE title LIKE '10:00 運動%';

-- === 5. 碘鹽強調確認加碘版本 ===

UPDATE products SET
  purchase_note = '線上可訂（常溫配送）。2kg 約可用 6 個月以上。⚠️ 務必確認現有庫存為「加碘」版本（包裝標示「碘化鉀」成分）。海鹽/玫瑰鹽碘含量極低，十字花科攝取量高時碘不足風險大增。'
WHERE name LIKE '碘鹽%';

-- === 6. 咖啡豆 purchase_note 加入 L-Theanine 提示 ===

UPDATE products SET
  purchase_note = '賣場咖啡專區。Kirkland 深焙豆 1.13kg 約 $399 最經濟，可用 1-2 個月。開封後密封或冷凍保存。⚠️ 搭配 L-Theanine 200mg（iHerb NOW Foods）一起服用，構成 A 級 nootropic 組合。'
WHERE name LIKE '咖啡豆%';

-- === 7. 銅 description 更新鋅頻率 ===

UPDATE plan_items SET
  description = '銅 2mg（Solaray Bisglycinate）嚴格單獨空腹服用，不與任何礦物質補劑同服。空腹可最大化吸收率，避免與鋅、鈣、鐵等礦物質競爭。與晚餐鋅間隔 4hr+（鋅僅週二、六服用）。若空腹不適可搭配少量水果（非含鈣/鐵食物）'
WHERE title LIKE '15:00-16:00 銅%';
