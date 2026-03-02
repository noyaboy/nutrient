------------------------------------------------------------
-- 059: 四項修正方案
-- 1. 移除維他命 C 500mg（晚餐草酸風險）
-- 2. 移除銅 2mg 補劑（15mg 鋅不需搭配）
-- 3. L-Theanine 固定隨咖啡（廢除綠茶日停用規則）
-- 4. 牛肉日上限 150g + 雞蛋強制移至下午點心
------------------------------------------------------------

-- === 1. 晚餐移除 Vit C 500mg ===
UPDATE plan_items
SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。鋅 15mg 在晚餐「最後一口」吞服。⚠️ 牛肉日：牛肉上限 150g，雞蛋強制移至 15:30 下午點心'
WHERE title = '19:00 晚餐 + 低 FODMAP 蔬菜';

-- 更新 Vit C 產品為停用狀態
UPDATE products
SET description = '⛔ 已停用 — 夜間高劑量 Vit C 代謝為草酸有腎結石風險。每日 Vit C 改由膠原蛋白肽（~160mg）+ 檸檬汁 + 蔬菜天然攝取，遠超 RDA 100mg',
    usage = '已停用。若未來需要恢復，可每日 1 錠隨午餐（非晚餐）'
WHERE name LIKE '%維他命 C%NOW Foods%500mg%';

-- 更新膠原蛋白描述（移除晚餐 500mg 引用）
UPDATE products
SET description = '水解海洋膠原蛋白肽 + 玻尿酸 + 維他命 C（每 6.5g 含 80mg Vit C）。午餐服用 10-15g 已提供 ~120-160mg Vit C，為每日主要 Vit C 來源（搭配檸檬汁與蔬菜已遠超 RDA 100mg）。每日隨午餐服用'
WHERE name LIKE '%CollagenUP%';

-- === 2. 移除銅 2mg 補劑 ===
UPDATE plan_items
SET is_active = false
WHERE title LIKE '%銅 2mg%';

-- 更新銅產品為停用
UPDATE products
SET description = '⛔ 已停用 — 15mg 鋅屬安全生理劑量，不會觸發金屬硫蛋白阻斷銅吸收。銅由堅果、可可粉、全穀類天然提供，免除游離銅蓄積導致的神經與肝臟毒性風險',
    usage = '已停用。不再需要額外補充銅',
    purchase_note = '⛔ 已停用。15mg 鋅不需要搭配銅補劑，銅由天然食物提供。'
WHERE name LIKE '%銅 Copper%';

-- 更新鋅補充品描述（移除銅引用）
UPDATE plan_items
SET description = '每日隨晚餐服用鋅 15mg（Picolinate 錠劑 1 錠）。補充品 15mg + 飲食鋅 ~10-15mg = 每日總計 25-30mg（安全低於 UL 40mg/日）。15mg 屬安全生理劑量，不會觸發金屬硫蛋白阻斷銅吸收，銅由堅果/可可粉/全穀類天然提供。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 150g 已含鋅 6-9mg。🚫 補鈣日豁免：當日服用鈣片 500mg 者，晚餐不補鋅（鈣殘餘競爭 DMT1），單日不補鋅不影響整體鋅營養狀態'
WHERE title = '鋅 15mg 每日補充';

-- 更新鋅產品描述（移除銅引用）
UPDATE products
SET usage = '每日隨晚餐服用 1 錠（15mg）。15mg 為安全生理劑量，銅由天然食物提供'
WHERE name LIKE '%鋅 Zinc Picolinate%';

-- === 3. L-Theanine 固定隨咖啡 ===
UPDATE plan_items
SET description = '起床後 90-135 分鐘再喝（避免干擾皮質醇覺醒反應，且與 09:15 B群間隔 2hr+）。咖啡因 200-300mg + L-Theanine 200mg（1:1 A 級 nootropic 組合）。15:00 後禁止咖啡因。✅ 無論當天是否飲用綠茶，喝咖啡就必須同步服用 L-Theanine'
WHERE title = '11:15 咖啡 + L-Theanine';

UPDATE plan_items
SET description = '午餐後 1hr+ 再飲用（~13:00），避免螯合鈣、鐵、鋅。EGCG + L-theanine 天然組合促進專注。15:00 前喝完（咖啡因 cutoff）。綠茶天然 L-Theanine（40-90mg）為額外放鬆紅利，不影響早晨 L-Theanine 補劑的服用'
WHERE title LIKE '%綠茶 EGCG%';

UPDATE products
SET usage = '每日 1 顆（200mg）隨咖啡服用，無論當天是否飲用綠茶。下午綠茶另含天然 L-Theanine 40-90mg 為額外紅利'
WHERE name LIKE '%L-Theanine%NOW Foods%';

-- === 4. 牛肉日上限 150g + 雞蛋移至下午點心 ===
UPDATE products
SET usage = '每週 1-2 次晚餐（嚴格上限 150g/次），牛肉日雞蛋強制移至 15:30 下午點心',
    purchase_note = '每週 1-2 次作為紅肉來源（嚴格上限 150g/次）。牛肉日雞蛋移至下午點心。草飼優於穀飼。瘦部位脂肪 <10g/100g。'
WHERE name LIKE '%草飼牛肉%';
