-- =====================================================
-- 054: Expert review fixes
-- 1. 右上腹 → 右上腹（肝臟位置）across all DILI references
-- 2. eGFR: remove "永久", clarify washout-first flow
-- 3. Beef day: egg allowed if <45g, copper conditional on nuts
-- 4. Vitamin C: add high-veggie-day reduction note
-- 5. Sweet potato: add 200g portion note
-- 6. Salmon: fix "唯一" → "唯一大型"
-- =====================================================

-- ===== 1. DILI: 右上腹 → 右上腹（肝臟位置）=====

-- 1a. 睡前補充品
UPDATE plan_items SET description = REPLACE(description, '右上腹不適/隱痛', '右上腹不適/隱痛（肝臟位置）')
WHERE title LIKE '%22:00%睡前%' AND description LIKE '%右上腹不適/隱痛%';

-- 1b. Ashwagandha 週期管理
UPDATE plan_items SET description = REPLACE(description, '右上腹不適', '右上腹不適（肝臟位置）')
WHERE title LIKE '%Ashwagandha%週期%' AND description LIKE '%右上腹不適%';

-- 1c. Ashwagandha 肝功能追蹤
UPDATE plan_items SET description = REPLACE(description, '右上腹不適', '右上腹不適（肝臟位置）')
WHERE title LIKE '%肝功能追蹤%' AND description LIKE '%右上腹不適%';

-- 1d. 健康檢測
UPDATE plan_items SET description = REPLACE(description, '右上腹不適', '右上腹不適（肝臟位置）')
WHERE title LIKE '%健康檢測%' AND description LIKE '%右上腹不適%';

-- 1e. Ashwagandha product
UPDATE products SET purchase_note = REPLACE(purchase_note, '右上腹不適', '右上腹不適（肝臟位置）')
WHERE name LIKE '%Ashwagandha%' AND purchase_note LIKE '%右上腹不適%';


-- ===== 2. eGFR: remove "永久停止肌酸", clarify flow =====

-- 2a. 蛋白質 plan_item
UPDATE plan_items SET description = REPLACE(
  REPLACE(description,
    '永久停止肌酸，3 個月後複檢',
    '停止肌酸，3 個月後複檢確認趨勢（單次異常不宜貿然定義為「永久」）'
  ),
  '永久停止肌酸',
  '停止肌酸'
)
WHERE title LIKE '%蛋白質%' AND description LIKE '%永久停止肌酸%';

-- 2b. 健康檢測 plan_item
UPDATE plan_items SET description = REPLACE(description, '永久停肌酸', '停肌酸、3 個月複檢確認趨勢')
WHERE title LIKE '%健康檢測%' AND description LIKE '%永久停肌酸%';


-- ===== 3. Beef day: egg allowed + copper conditional on nuts =====

-- 3a. 晚餐 plan_item: egg logic
UPDATE plan_items SET description = REPLACE(
  description,
  '取消雞蛋（牛肉已接近單餐上限，加蛋超出 ≤45g），雞蛋可移至 15:30 下午點心與豌豆蛋白同食',
  '可保留 1 顆雞蛋（+6.3g = 36-42g，仍 <45g 上限），或移至 15:30 下午點心以優化吸收分配'
)
WHERE title LIKE '%19:00%晚餐%' AND description LIKE '%取消雞蛋%';

-- 3b. 蛋白質 plan_item: egg logic
UPDATE plan_items SET description = REPLACE(
  description,
  '取消雞蛋（牛肉已接近單餐上限，加蛋可能超出 ≤45g）。雞蛋可移至 15:30 下午點心與豌豆蛋白同食',
  '可保留 1 顆雞蛋（+6.3g = 36-42g，仍 <45g 上限），或移至 15:30 下午點心以優化吸收分配'
)
WHERE title LIKE '%蛋白質%' AND description LIKE '%取消雞蛋%';

-- 3c. 15:30 下午點心: update egg note
UPDATE plan_items SET description = REPLACE(
  description,
  '牛肉日加 1 顆水煮蛋：牛肉日晚餐取消雞蛋後，1 顆蛋（~6.3g 蛋白）移至此處與豌豆蛋白同食（合計 22.3g，仍在合理範圍）',
  '牛肉日可加 1 顆水煮蛋：若選擇將雞蛋從晚餐移至此處以優化吸收分配，蛋 6.3g + 豌豆 16g = 22.3g（仍在合理範圍）'
)
WHERE title LIKE '%15:30%下午點心%';

-- 3d. 銅 plan_item: conditional on nuts
UPDATE plan_items SET description = REPLACE(
  description,
  '牛肉日免補銅：牛肉 150-180g + 堅果已提供足夠銅，當日取消銅補劑避免逼近 UL 10mg/日',
  '牛肉日銅補劑：牛肉本身含銅極低（150g ≈ 0.1-0.2mg），若當日堅果攝取充足（≥30g，含銅 ~0.3-0.5mg）可免補銅，否則仍需補充'
)
WHERE title LIKE '%銅%2mg%' AND description LIKE '%牛肉日免補銅%';

-- 3e. 銅 product: update usage + purchase_note
UPDATE products SET
  usage = REPLACE(usage, '牛肉日免補銅', '牛肉日若堅果充足（≥30g）可免補銅'),
  purchase_note = REPLACE(purchase_note, '牛肉日免補銅：牛肉 150-180g 含銅 ~0.1-0.2mg + 堅果一把含銅 ~0.3-0.5mg，當日銅攝取已足', '牛肉日銅補劑視堅果攝取量決定：牛肉含銅極低（150g ≈ 0.1-0.2mg），需搭配堅果 ≥30g（~0.3-0.5mg）才能免補')
WHERE name LIKE '%銅%Bisglycinate%' OR (name LIKE '%Copper%' AND description LIKE '%銅%');

-- 3f. 草飼牛肉 product: egg logic
UPDATE products SET usage = REPLACE(
  usage,
  '牛肉日晚餐取消雞蛋（牛肉已接近單餐上限 ≤45g），雞蛋移至 15:30 下午點心',
  '牛肉日晚餐可保留雞蛋（+6.3g = 36-42g，仍 <45g），或移至 15:30 下午點心以優化吸收'
)
WHERE name LIKE '%草飼牛%' OR (name LIKE '%牛肉%' AND usage LIKE '%取消雞蛋%');


-- ===== 4. Vitamin C: high-veggie-day note =====

-- 4a. 晚餐 plan_item (the description is very long, append note)
-- Not modifying the long description to avoid risk; the frontend component already has the note.

-- 4b. Vit C product: add note to purchase_note
UPDATE products SET purchase_note = purchase_note || ' ⚠️ 補劑 ~660mg + 蔬菜/檸檬汁天然 Vit C 合計每日可達 800-900mg（仍安全，UL 2000mg）。若當日蔬菜攝取量極大，500mg 錠可改兩天一次。'
WHERE name LIKE '%維他命 C%500%' OR (name LIKE '%Vitamin C%' AND description LIKE '%500mg%');


-- ===== 5. Sweet potato: add 200g portion note =====

UPDATE products SET
  usage = '訓練日建議 200g（≈50g 碳水）。訓練前/晚餐適量',
  purchase_note = purchase_note || ' ⚠️ 訓練日建議攝取 200g（≈50g 碳水），前晚蒸好冷藏產生抗性澱粉 RS3。'
WHERE name = '地瓜' AND category = 'costco_food';


-- ===== 6. Salmon: fix "唯一" description =====

UPDATE products SET purchase_note = REPLACE(
  purchase_note,
  '鮭魚是唯一需要長期冷凍的高價值食材',
  '鮭魚是唯一大型需要長期冷凍的食材（藍莓等小包裝另計）'
)
WHERE name LIKE '%鮭魚%' AND purchase_note LIKE '%唯一需要長期冷凍%';
