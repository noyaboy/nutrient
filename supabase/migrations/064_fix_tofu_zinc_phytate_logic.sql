-- Fix #2: Remove incorrect "tofu day skip zinc" restriction
-- Physiological basis: lunch phytic acid clears small intestine in ~7hr (gastric emptying 2-4hr + small intestine transit 3-5hr)
-- Zinc absorption occurs in duodenum/jejunum; by 19:00 lunch phytate is in colon, no interference

-- Fix calcium tracking plan item: remove tofu-zinc restriction
UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（無植酸，補鈣日首選）+ 深綠蔬菜 + 板豆腐（100g ~150mg 鈣）。午餐板豆腐的植酸在 7hr 後已進入大腸，不影響 19:00 鋅吸收。食物鈣優先，不足時鈣片隨午餐服用'
WHERE title LIKE '%鈣攝取確認%';

-- Fix zinc 15mg plan item: remove tofu exemption, remove calcium exemption (already contradicted by homepage)
UPDATE plan_items
SET description = '每日隨晚餐服用鋅 15mg（Picolinate 錠劑 1 錠）。補充品 15mg + 飲食鋅 ~10-15mg = 每日總計 25-30mg（安全低於 UL 40mg/日）。15mg 屬安全生理劑量，不會觸發金屬硫蛋白阻斷銅吸收，銅由堅果/可可粉/全穀類天然提供。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 150g 已含鋅 6-9mg。✅ 午餐板豆腐不影響晚餐鋅：午餐植酸經 7hr 已通過小腸吸收段進入大腸，不干擾 19:00 鋅吸收'
WHERE title LIKE '%鋅 15mg 每日%';

-- Fix tofu product description and usage
UPDATE products
SET description = '優質植物蛋白 + 鈣質來源。100g 板豆腐含鈣 ~150mg + 蛋白質 ~8g。大豆製品含植酸，但午餐食用後經 7hr 消化（胃排空 2-4hr + 小腸轉運 3-5hr），植酸已進入大腸，不影響 19:00 晚餐鋅吸收（鋅主要在十二指腸與空腸吸收）。⚠️ 晚餐碳水仍應避開全穀類（糙米、燕麥）：同餐植酸才是鋅吸收的真正干擾源',
    usage = '每週 2-3 次午餐入菜（100-150g），晚間正常補鋅'
WHERE name LIKE '%板豆腐%';
