-- Rename 電子鍋 product to remove legacy 電鍋 reference
UPDATE products
SET name = '電子鍋（多功能）',
    purchase_note = '一次性購買。推薦：象印微電腦電子鍋 3 人份（~$2,500-4,000，煮飯品質佳，有預約定時功能可前晚設定早上煮好）或大同電子鍋 6 人份（~$1,800，經典耐用）。Costco 線上有多款可比較。'
WHERE name LIKE '電子鍋%多功能%';
