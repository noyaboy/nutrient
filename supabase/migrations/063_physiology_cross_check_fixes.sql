-- Physiology cross-check: 4 corrections (iodine math, green tea timing, beef day eggs, RS3 myth)
-- Severity: High→Low

-- === Issue #1 (HIGH): Iodine/salt math paradox ===
-- 2.5g salt/day = only 50-82mcg iodine (RDA=150mcg). Fix: seaweed 1x→2-3x/week
-- Update iodine salt plan item: remove "主力仰賴午晚餐" claim
UPDATE plan_items SET
  description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 全日鈉預算（WHO <2400mg/日）：晨間 1g（~400mg 鈉）+ 午晚餐烹調碘鹽合計 1-1.5g（~400-600mg 鈉）+ 泡菜 30g（~200mg 鈉）+ 茶葉蛋 1 顆（~250mg 鈉）+ 食物天然鈉 ~500mg ≈ 總計 1750-1950mg。⚠️ 午晚餐烹調碘鹽嚴格控制在合計 1-1.5g 內。⚠️ 全日碘鹽僅提供 ~50-82mcg 碘（不足 RDA 150mcg），主力碘來源為每週 2-3 次紫菜/海苔'
WHERE title LIKE '09:05 碘鹽%' AND is_active = true;

-- Update seaweed product: 1x→2-3x/week
UPDATE products SET
  usage = '每週固定 2-3 次微量攝取（紫菜/海苔 1-2 片），補足碘鹽無法覆蓋的每日碘缺口',
  purchase_note = '每週固定 2-3 次微量攝取（乾貨耐儲存，每次 1-2g 乾重即可）。紫菜/海苔每片僅 ~12-43mcg 碘，安全可控。⚠️ 不購買昆布：碘含量極高且變異大（1-2g = 300-6000mcg），與精確碘鹽控制策略衝突。常溫密封保存，開封後放密封袋/罐。'
WHERE name = '紫菜 / 海苔';

-- === Issue #2 (MEDIUM): Green tea EGCG chelation — 1hr gap insufficient ===
-- High-fat/protein lunch: gastric emptying 2-4hrs. Push tea to 14:00-14:30
UPDATE plan_items SET
  title = '14:00 綠茶 EGCG 2-3 杯',
  description = '午餐後 2hr+ 再飲用（~14:00），高脂高蛋白午餐胃排空需 2-4hr，1hr 仍會螯合鐵鋅鈣。EGCG + L-theanine 天然組合促進專注。15:00 前喝完（咖啡因 cutoff）。綠茶天然 L-Theanine（40-90mg）為額外放鬆紅利，不影響早晨 L-Theanine 補劑的服用'
WHERE title LIKE '13:00 綠茶%' AND is_active = true;

-- Update green tea product usage time
UPDATE products SET
  usage = '每日午餐後 2-3 杯（14:00-15:00）'
WHERE name = '綠茶（茶葉/茶包）';

-- === Issue #3 (MEDIUM): Beef day afternoon snack overload ===
-- 3 eggs + pea protein at 15:30 = too heavy (15g fat + protein), only 3.5hr before dinner
-- Fix: move 1-2 eggs to lunch, keep 1 egg + pea protein at 15:30
UPDATE plan_items SET
  description = 'Tryall 豌豆蛋白 22g 粉（≈16g 蛋白）+ 雞蛋 1 顆（牛肉日從晚餐移入）。非乳製植物蛋白，下午點心時段分散蛋白質攝取壓力。⚠️ 牛肉日：僅 1 顆蛋（6.3g 蛋白）+ 豌豆 16g = 22.3g，消化負擔輕，不影響 19:00 晚餐食慾'
WHERE title LIKE '15:30 下午點心%' AND is_active = true;

UPDATE plan_items SET
  description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。鋅 15mg 在晚餐「最後一口」吞服（每日固定，含補鈣日 — 午餐鈣至 19:00 已間隔 7hr，不存在吸收競爭）。⚠️ 晚餐避開全穀類（糙米、燕麥）的植酸干擾鋅吸收；菠菜主要含草酸（非植酸），對鋅影響較弱，可適量食用。⚠️ 牛肉日：牛肉上限 150g，雞蛋 1-2 顆移至午餐、1 顆移至 15:30 下午點心'
WHERE title LIKE '19:00 晚餐%' AND is_active = true;

-- Update egg product description
UPDATE products SET
  description = '晚餐蛋白質主力（常規日隨晚餐食用，牛肉日 1-2 顆移至午餐、1 顆移至 15:30 下午點心）。富含亮氨酸 Leucine。冷藏平飼蛋，非籠飼。賣場限定商品'
WHERE name LIKE '平飼雞蛋%';

-- Update beef product description
UPDATE products SET
  usage = '每週 1-2 次晚餐（嚴格上限 150g/次），牛肉日雞蛋分散至午餐（1-2 顆）與下午點心（1 顆）',
  purchase_note = '每週 1-2 次作為紅肉來源（嚴格上限 150g/次）。牛肉日雞蛋分散至午餐與下午點心。草飼優於穀飼。瘦部位脂肪 <10g/100g。'
WHERE name LIKE '冷凍草飼牛肉%';

-- === Issue #4 (LOW): RS3 55°C myth ===
-- RS3 melting temperature is 100-120°C+. Normal reheating (70-80°C) is perfectly safe.
-- No data changes needed; only UI text in health-details.tsx
