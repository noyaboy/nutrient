-- 新增採購備註欄位
ALTER TABLE products ADD COLUMN purchase_note TEXT DEFAULT '';

-- Costco 保健品
UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 3 顆，180 顆可用 2 個月。開瓶後旋緊避免氧化，有腥味表示已變質。'
WHERE name = '緩釋魚油（Kirkland 新型緩釋 Omega-3）';

UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 1 錠，250 錠可用 8 個月以上，補貨頻率極低。開封後建議冰箱保存。'
WHERE name = '鈣 + D3 + K2（Nature Made 250 錠）';

UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 1-2 錠，500 錠可用 8-16 個月，每錠不到 $1。'
WHERE name = '維他命 C（Kirkland 500mg × 500 錠）';

-- Costco 食材
UPDATE products SET purchase_note = '賣場限定，無法線上訂。每日 3-4 顆，30 入約 7-10 天。選蛋殼完整、生產日期最近的。'
WHERE name = '平飼雞蛋（全佑牧場 LL 規格）';

UPDATE products SET purchase_note = '線上可訂（冷凍配送）。1.36kg 約 5-6 份，約 1.5-2 週用完，每月訂 2 包。解凍後勿重複冷凍。'
WHERE name = '冷凍鮭魚排（Kirkland 1.36kg）';

UPDATE products SET purchase_note = '線上可訂（冷凍配送）。每日一袋 454g，4 袋約 4 天用完，每月需 7-8 包。建議與鮭魚一起下單。'
WHERE name = '冷凍青花菜（Nature''s Touch 454g×4）';

UPDATE products SET purchase_note = '賣場蔬果區散裝。挑外皮光滑無發芽。每週約 1 袋（2.8kg）。常溫陰涼處可放 1-2 週，勿冷藏。'
WHERE name = '地瓜';

UPDATE products SET purchase_note = '賣場蔬果區散裝。常溫通風處可保存 2-4 週，耗量低，每月補一次即可。'
WHERE name = '洋蔥 / 大蒜';

UPDATE products SET purchase_note = '線上可訂（常溫配送）。2kg 約可用 6 個月以上。確認選「加碘」版本。'
WHERE name = '碘鹽（統一生機 日曬海鹽加碘）';

UPDATE products SET purchase_note = '賣場蔬果區散裝。選外皮鮮黃有光澤。每日半顆約可用 3-4 週。冷藏保存較持久。'
WHERE name = '檸檬';

UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 30g，1.13kg 約 5-6 週。開封後冷藏防油耗味。含花生油，過敏者注意。'
WHERE name = '綜合堅果（Kirkland 1.13kg）';

UPDATE products SET purchase_note = '賣場限定，無法線上訂。每日 200-300g，907g×2 約 6-9 天，每週補貨。冷藏乳品區，留意效期。'
WHERE name = '希臘優格（Kirkland 零脂 907g×2）';

UPDATE products SET purchase_note = '賣場限定，無法線上訂。每日 50-100g，120g×6 約 7-14 天，每 1-2 週補貨。'
WHERE name = '泡菜（宗家府 冷藏切塊泡菜 120g×6）';

UPDATE products SET purchase_note = '賣場蔬果區散裝。輕捏微軟代表已熟。未熟室溫放 2-3 天催熟。1.3kg 約 4-5 顆，4-7 天用完。'
WHERE name = '酪梨';

UPDATE products SET purchase_note = '冷凍版在冷凍蔬菜區，更方便保存。每日 100-150g，500g×6 約 3-4 週。新鮮版需 3-5 天內用完。'
WHERE name = '菠菜（冷凍或新鮮）';

UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 80g，935g×2 約 23 天，每月補一次。開封後密封避免受潮。'
WHERE name = '有機燕麥（桂格有機大燕麥片 935g×2）';

UPDATE products SET purchase_note = '賣場蔬果區散裝。選微青帶黃放 2-3 天自然熟成。1.4kg 約 7-8 根，4-7 天用完。'
WHERE name = '香蕉';

UPDATE products SET purchase_note = '線上可訂（冷凍配送，廠商出貨）。2.5kg×2 可用 2.5-5 週，每月訂一箱。一次解凍 2-3 天份量。'
WHERE name = '雞胸肉（大成 冷凍雞清胸肉 2.5kg×2）';

UPDATE products SET purchase_note = '線上可訂（常溫配送）。3kg 約 3-6 週。有機花蓮產。開封後密封避免蟲害，夏天建議冷藏。'
WHERE name = '有機糙米（銀川有機一等糙米 3kg）';

UPDATE products SET purchase_note = '賣場咖啡專區。Kirkland 深焙豆 1.13kg 約 $399 最經濟，可用 1-2 個月。開封後密封或冷凍保存。'
WHERE name = '咖啡豆 / 研磨咖啡';

-- iHerb 補充品
UPDATE products SET purchase_note = 'iHerb 直送台灣，滿 NT$1,245 免運。每日 ~70g，2.29kg 約 32 天，每月補貨。搭配其他品項湊免運，關注折扣碼。'
WHERE name = '乳清蛋白 Gold Standard Whey（ON 雙倍巧克力 2.29kg）';

UPDATE products SET purchase_note = 'iHerb 直送，建議與乳清同時下單。每日 5g，454g 可用 3 個月。CGN 自有品牌常有額外折扣。'
WHERE name = '肌酸 Creatine Monohydrate（CGN 454g）';

UPDATE products SET purchase_note = 'iHerb 直送。每日 2 錠，180 錠可用 3 個月，每季補一次。'
WHERE name = '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）';

UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，120 顆可用 4 個月。CGN 自有品牌 CP 值高。需隨含油脂餐食服用。'
WHERE name = '葉黃素 + 玉米黃素（CGN 20mg × 120 顆）';

UPDATE products SET purchase_note = 'iHerb 直送。每日半顆，120 顆可用 8 個月。建議隔日 1 顆替代切半。務必搭配銅。'
WHERE name = '鋅 Zinc Picolinate（NOW Foods 50mg × 120 顆）';

UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，100 顆可用 3 個多月，每季補一次。與鋅間隔至少 4 小時。'
WHERE name = '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）';

UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，360 顆可用整年。大包裝每顆僅 ~$1.27。'
WHERE name = '維他命 D3 5000IU（Doctor''s Best 360 顆）';

UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，120 顆可用 4 個月。Double Strength 200mg，每季訂一次。'
WHERE name = 'L-Theanine（NOW Foods Double Strength 200mg × 120 顆）';

-- 設備
UPDATE products SET purchase_note = '一次性購買，Amazon 或蝦皮。選琥珀色鏡片才有效阻擋藍光。$500-1,500 即可。'
WHERE name = '防藍光眼鏡（琥珀色鏡片）';

UPDATE products SET purchase_note = '一次性購買，Amazon 或蝦皮。精度 0.1-1g，最大秤量至少 5kg。$300-800 即可。'
WHERE name = '食品電子秤';

UPDATE products SET purchase_note = '一次性購買。量好窗戶尺寸，選「100% blackout」標示。邊緣可用魔鬼氈輔助密封。'
WHERE name = '全遮光窗簾';
