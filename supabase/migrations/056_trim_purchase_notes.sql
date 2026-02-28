------------------------------------------------------------
-- 020: Trim purchase_note fields - Remove medical/timing info
-- Keep only: logistics, specs, storage, inventory management
-- Remove: dosage timing, interactions, medical warnings
------------------------------------------------------------

-- Fish oil: remove biochemistry explanation, keep storage instructions
UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 3 顆，180 顆可用 2 個月。⚠️ 開瓶後必須冷藏（2-8°C），每次取用後迅速旋緊瓶蓋。📋 在瓶身標註開瓶日期，開瓶後 60 天內用完或丟棄（即使剩餘也不再服用）。⚠️ 有腥味或苦味表示已氧化變質，立即丟棄。'
WHERE name = '緩釋魚油（Kirkland 新型緩釋 Omega-3）';

-- Calcium: remove medical dosage info
UPDATE products SET purchase_note = '線上可訂（常溫配送）。250 錠可用非常久。碳酸鈣+檸檬酸鈣錠劑常溫陰涼處即可穩定保存。'
WHERE name = '鈣片備用（Nature Made Ca+D3+K2 250 錠）';

-- Vitamin C: remove dosage calculation and biochemistry
UPDATE products SET purchase_note = 'iHerb 直送。✅ 每日 1 錠（500mg），免切免切藥器。100 錠可用約 3 個月。開瓶後標記日期，6 個月內用完。'
WHERE name = '維他命 C（NOW Foods 500mg × 100 錠）';

-- Broccoli: remove sulforaphane timing, keep storage
UPDATE products SET purchase_note = '每週補貨 2 次，每次買 3-4 顆（每顆約 300-400g）。裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。小冰箱用戶不建議買 Costco 冷凍版（454g×4 佔冷凍 3L 直接爆倉）'
WHERE name = '新鮮綠花椰菜（傳統市場/超市）';

-- Iodized salt: remove dosage and timing
UPDATE products SET purchase_note = '線上可訂（常溫配送）。2kg 約可用 6 個月以上。⚠️ 務必確認為「加碘」版本（包裝標示「碘化鉀」成分）。海鹽/玫瑰鹽碘含量極低。'
WHERE name = '碘鹽（統一生機 日曬海鹽加碘）';

-- Spinach: remove daily intake calculation
UPDATE products SET purchase_note = '每週補貨 2 次，每次買 400-500g。放入大保鮮袋、裡面墊一張廚房紙巾吸濕，平放於保鮮抽屜底部，3-5 天內用完。小冰箱用戶不建議買 Costco 冷凍版（500g×6 佔冷凍室 70%）'
WHERE name = '新鮮菠菜（傳統市場/超市）';

-- Zucchini: remove FODMAP and daily intake calculation
UPDATE products SET purchase_note = '每週補貨 1-2 次，每次買 500-700g。選外表光滑無軟爛。裝入大保鮮袋平放保鮮抽屜，5-7 天內用完。'
WHERE name = '櫛瓜（美國/加拿大）';

-- Napa cabbage: remove zinc interaction advice
UPDATE products SET purchase_note = '每週補貨 1-2 次。高麗菜最耐儲存（5-7 天），大白菜次之（3-5 天切半保鮮膜包），小白菜最短（2-3 天墊廚房紙巾）。'
WHERE name = '大白菜 / 高麗菜 / 小白菜';

-- Kelp: remove iodine RDA and thyroid warning
UPDATE products SET purchase_note = '每月購買 1-2 包即可（乾貨耐儲存）。常溫密封保存，開封後放密封袋/罐。'
WHERE name = '乾海帶（昆布）/ 紫菜';

-- Tofu: remove calcium/nutrition advice
UPDATE products SET purchase_note = '每週補貨 2-3 次（保質期短）。'
WHERE name = '板豆腐（傳統硬豆腐）';

-- Dental floss: remove timing
UPDATE products SET purchase_note = '每 2-3 個月購買 1 盒。Costco 有大包裝（3 入組更划算）。建議選含蠟牙線（滑順不易卡牙縫）。'
WHERE name LIKE '牙線%';

-- Honey/cocoa: remove nutrition info
UPDATE products SET purchase_note = '蜂蜜常溫保存（永不過期）；可可粉開封後密封保存 6 個月。每日用量極少（5-10g），一罐可用數月。'
WHERE name = '蜂蜜 / 無糖可可粉';

-- Coffee: remove L-Theanine pairing advice
UPDATE products SET purchase_note = '賣場咖啡專區。Kirkland 深焙豆 1.13kg 約 $399 最經濟，可用 1-2 個月。開封後密封或冷凍保存。'
WHERE name = '咖啡豆 / 研磨咖啡';

-- Olive oil: remove meal allocation and cooking temp
UPDATE products SET purchase_note = '線上可訂（常溫配送）。每日 42g，2L（≈1840g）約 1.5 個月用完。⚠️ 建議每 1.5 個月補貨，或趁 Costco 促銷時一次購入 2 瓶（3 個月份）。開封後陰涼避光處保存，3-6 個月內用完。'
WHERE name = '特級初榨橄欖油（Kirkland 2L）';

-- Beef: remove meal adjustments and supplement interactions
UPDATE products SET purchase_note = '每週 1-2 次作為紅肉來源，替代 1-2 餐雞胸肉（150-180g/次）。草飼優於穀飼。瘦部位脂肪 <10g/100g。'
WHERE name = '冷凍草飼牛肉片（澳洲）';

-- Green tea: remove timing and mineral interaction
UPDATE products SET purchase_note = 'Costco 茶飲區或超市購買。散裝綠茶葉 CP 值最高。'
WHERE name = '綠茶（茶葉/茶包）';

-- Blueberry: remove daily serving suggestion
UPDATE products SET purchase_note = E'新鮮藍莓在 Costco 蔬果區（季節性）。小冰箱建議買新鮮版每週 1 盒（510g），放保鮮抽屜 3-5 天用完。若買冷凍版（Nature''s Touch 600g），僅佔冷凍約 0.5L 可接受。'
WHERE name = '藍莓 / 冷凍莓果';

-- White rice: remove training day advice
UPDATE products SET purchase_note = '線上可訂（常溫配送）。3kg約3-6週。開封後密封避免蟲害，夏天建議冷藏。'
WHERE name = '有機白米（銀川一等白米 3kg）';

-- Pasta: remove training day usage
UPDATE products SET purchase_note = '線上可訂（常溫配送）。500g×6共3kg，可用1-2個月。開封後每包密封防潮。常溫存放不佔冰箱空間。Costco另有其他品牌（Barilla, De Cecco）可替換。'
WHERE name = '義大利麵（Garofalo 500g×6）';

-- Potato: remove cooking/training day advice
UPDATE products SET purchase_note = '賣場蔬果區散裝，約NT$199/3kg（6-8顆）。選外皮光滑無發芽。常溫通風處可放2-3週，勿冷藏。每週補1次約可用7-10天。'
WHERE name = '馬鈴薯（美國/加拿大）';

------------------------------------------------------------
-- iHerb Supplements
------------------------------------------------------------

-- Creatine: remove eGFR protocol
UPDATE products SET purchase_note = 'iHerb 直送。每日 5g，454g 可用 90 天（3 個月）。⚠️ 建議設定每 3 個月定期補貨提醒。CGN 自有品牌常有額外折扣。搭配其他 iHerb 品項湊免運。'
WHERE name = '肌酸 Creatine Monohydrate（CGN 454g）';

-- Magnesium glycinate: remove dosage timing and diarrhea warning
UPDATE products SET purchase_note = 'iHerb 直送。180 錠可用 6 個月。⚠️ 產品標示 serving size 為 2 錠 200mg，但本計畫僅用 1 錠。'
WHERE name = '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）';

-- Lutein: remove fat-soluble absorption advice
UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，120 顆可用 4 個月。CGN 自有品牌 CP 值高。'
WHERE name = '葉黃素 + 玉米黃素（CGN 20mg × 120 顆）';

-- Zinc: remove timing, interactions, exemption rules
UPDATE products SET purchase_note = 'iHerb 直送。✅ 15mg 錠劑（非 50mg 膠囊），可精確控量。每日 1 錠，120 錠可用 4 個月。'
WHERE name = '鋅 Zinc Picolinate（NOW Foods 15mg × 120 錠）';

-- Copper: remove timing, interactions, exemption rules
UPDATE products SET purchase_note = 'iHerb 直送。非紅肉日每日 1 顆，100 顆可用 4 個月+（因牛肉日免補）。'
WHERE name = '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）';

-- D3: remove fat-soluble absorption advice
UPDATE products SET purchase_note = 'iHerb 直送。✅ 每日 1 顆（1000IU），無需切割。180 顆可用 6 個月。'
WHERE name = '維他命 D3 1000IU（NOW Foods 180 顆）';

-- K2: remove half-life and Nature Made replacement info
UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，120 顆可用 4 個月。'
WHERE name = '維他命 K2 MK-7（NOW Foods 100mcg × 120 顆）';

-- L-Theanine: remove timing and green tea day rule
UPDATE products SET purchase_note = 'iHerb 直送。Double Strength 200mg 素食膠囊。60 顆約可用 2 個月。搭配其他 iHerb 品項湊免運。'
WHERE name LIKE 'L-Theanine%';

-- CollagenUP: remove Vit C calculation and oxalate info
UPDATE products SET purchase_note = 'iHerb 直送。每日 10-15g，206g 約可用 2-3 週。搭配其他 iHerb 品項湊免運。'
WHERE name LIKE '膠原蛋白肽 CollagenUP%';

-- CoQ10: remove fat-soluble absorption advice
UPDATE products SET purchase_note = 'iHerb 直送。每日 1 顆，60 顆可用 2 個月。'
WHERE name = 'CoQ10 Ubiquinol 200mg（NOW Foods 60 顆）';

-- B-Complex: remove timing and meal pairing
UPDATE products SET purchase_note = 'iHerb 必買品項。✅ 活化型態（Coenzyme）優於普通合成 B-50：甲鈷胺 B12（非氰鈷胺）、5-MTHF 葉酸（非 Folic Acid，應對 MTHFR 基因變異）、P5P B6。60 顆可用 2 個月。'
WHERE name LIKE 'B群 活化型態%';

-- Pea protein: remove timing
UPDATE products SET purchase_note = 'Tryall 官網或 Costco 線上可訂。每日 ~20g，1kg 可用約 50 天。無調味可搭配少量蜂蜜或可可粉。與 Tryall 乳清同品牌，統一採購更方便'
WHERE name = '豌豆蛋白 Pea Protein（Tryall 1kg）';

-- Magtein: remove total magnesium warning
UPDATE products SET purchase_note = 'iHerb 直送。每日 3 顆，90 顆僅可用 30 天（⚠️ 每月必須補貨）。建議與甘胺酸鎂（180 錠/3 個月）合併訂購以節省運費：每 3 個月訂 3 罐蘇糖酸鎂 + 1 罐甘胺酸鎂。'
WHERE name LIKE '蘇糖酸鎂 Magtein%';

-- Ashwagandha: remove all medical warnings, keep logistics only
UPDATE products SET purchase_note = 'iHerb 直送。每瓶 90 顆可完成 1 個完整週期（56 顆用 + 剩 34 顆留下一輪）。建議在瓶身標記「開始日」與「第 56 天停用日」。'
WHERE name = 'Ashwagandha KSM-66（NOW Foods 90 顆）';

-- Electrolyte: remove usage timing and health check cycle
UPDATE products SET purchase_note = 'iHerb 直送。20 包約 10 週。每年需約 5-6 盒。💡 建議一次購入 3 盒（半年份）。CGN 自有品牌有折扣，3 盒同購可湊 iHerb 免運門檻。'
WHERE name LIKE '電解質粉 Sport Hydration%';
