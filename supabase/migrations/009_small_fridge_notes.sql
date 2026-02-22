-- 小冰箱儲存優化（50×50×80cm 單門，冷凍室僅 ~7L）
-- 調整 4 項冷凍品的 purchase_note：購買方式、分裝方式、頻率

UPDATE products SET purchase_note = '線上可訂（冷凍配送，廠商出貨）。2.5kg×2 可用 3-4 週，每月訂一箱。小冰箱無法整袋冷凍：買回當天全部煮熟，分裝 zip bag 壓扁，冷藏 3-4 天份 + 冷凍其餘（約佔 3L）。'
WHERE name = '雞胸肉（大成 冷凍雞清胸肉 2.5kg×2）';

UPDATE products SET purchase_note = '線上可訂（冷凍配送）。1.36kg 約 5-6 份，每 2 週買 1 包。買回立即分裝 5-6 份 zip bag（佔冷凍約 2.5L），每 2-3 天取 1 份冷藏解凍。避免與雞胸肉同週購買。'
WHERE name = '冷凍鮭魚排（Kirkland 1.36kg）';

UPDATE products SET purchase_note = '線上可訂（冷凍配送）。每日一袋 454g，4 袋約 4 天用完。每週買 1 包即可（佔冷凍約 3L），不需囤貨。'
WHERE name = '冷凍青花菜（Nature''s Touch 454g×4）';

UPDATE products SET purchase_note = '建議買新鮮版：Costco 蔬果區或傳統市場，每次 300-400g 放冷藏，3-5 天內用完，每週補貨。冷凍版 500g×6 佔冷凍室 70%，小冰箱不適合。'
WHERE name = '菠菜（冷凍或新鮮）';
