-- Expert review: 5 corrections based on physiology/nutrition science
-- 1. B群 → 12:00 lunch only (remove from 09:15)
-- 2. Calcium-zinc: 7hr gap sufficient, no need to skip zinc on calcium days
-- 3. Hot bath + glycine: synergistic (both promote peripheral vasodilation), not antagonistic
-- 4. Spinach: oxalate (not phytate) is the anti-nutrient; weak effect on zinc
-- 5. Creatine washout: 7 days insufficient (need 4-6 weeks); rely on Cystatin C instead

-- === Issue #1: B群 from 09:15 → confirmed 12:00 only ===
UPDATE plan_items SET
  description = '香蕉 1 根 + 乳清蛋白 ~30g 粉（≈27g 蛋白）。⚠️ 距訓練僅 45 分鐘，只吃流質乳清+好消化的香蕉。地瓜需 60-90 分鐘消化（含抗性澱粉），若要吃地瓜請提前至 08:00 進食'
WHERE title LIKE '09:15 訓練前營養%' AND is_active = true;

-- === Issue #2: Calcium day → keep zinc at 19:00 (7hr gap is safe) ===
UPDATE plan_items SET
  description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。鋅 15mg 在晚餐「最後一口」吞服（每日固定，含補鈣日 — 午餐鈣至 19:00 已間隔 7hr，不存在吸收競爭）。⚠️ 牛肉日：牛肉上限 150g，雞蛋強制移至 15:30 下午點心'
WHERE title LIKE '19:00 晚餐%' AND is_active = true;

-- === Issue #3: Hot bath + glycine are synergistic ===
UPDATE plan_items SET
  description = '40-42°C 10-15 分鐘。熱水澡促進周邊血管擴張（Peripheral Vasodilation），將核心熱量帶到皮膚表面散發，加速核心體溫下降。甘胺酸的降溫機制相同（促進周邊血管擴張），兩者為協同關係。洗完澡後即可服用甘胺酸，無需等待體溫回落'
WHERE title LIKE '21:30-22:15 熱水澡%' AND is_active = true;

UPDATE plan_items SET
  description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。洗完熱水澡後立即服用效果最佳 — 熱水澡與甘胺酸皆促進周邊血管擴張降低核心體溫，兩者協同加速入睡'
WHERE title LIKE '22:30 睡前補充品%' AND is_active = true;

-- === Issue #4: Spinach — oxalate (not phytate); weak effect on zinc ===
-- Dinner description: spinach is not a phytate threat, allow moderate use
UPDATE plan_items SET
  description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。鋅 15mg 在晚餐「最後一口」吞服（每日固定，含補鈣日 — 午餐鈣至 19:00 已間隔 7hr，不存在吸收競爭）。⚠️ 晚餐避開全穀類（糙米、燕麥）的植酸干擾鋅吸收；菠菜主要含草酸（非植酸），對鋅影響較弱，可適量食用。⚠️ 牛肉日：牛肉上限 150g，雞蛋強制移至 15:30 下午點心'
WHERE title LIKE '19:00 晚餐%' AND is_active = true;

-- === Issue #5: Creatine washout 7 days → rely on Cystatin C ===
-- No more 7-day creatine washout requirement; Cystatin C is the gold standard
