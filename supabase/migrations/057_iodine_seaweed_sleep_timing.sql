-- Fix 1: Iodine strategy — downgrade seaweed from primary source to occasional side dish
-- (daily iodized salt already meets RDA; seaweed 3-5g = 1500-15000mcg far exceeds UL 1100mcg)

UPDATE plan_items
SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 晨間碘鹽僅 1g 控鈉（WHO <2400mg/日），碘攝取主力仰賴午晚餐烹調碘鹽（每餐 1-2g，合計已達 RDA 150mcg）'
WHERE title = '09:05 碘鹽 1g';

UPDATE products
SET description = '偶爾食用的配菜，提供鈣、鐵、膳食纖維。⚠️ 每 3-5g 乾海帶含碘 1500-15000mcg，遠超 UL 1100mcg/日，日常已用碘鹽達 RDA，海帶不宜作為主力碘來源',
    usage = '偶爾配菜（每週 0-1 次）：海帶味噌湯（1-2g 乾昆布）或涼拌紫菜（1 片）',
    specs = '{"storage":"常溫密封保存 6-12 個月","varieties":"昆布（煮湯用）、海帶芽（涼拌用）、紫菜/海苔（直接食用或入湯）","portion":"每次 1-2g 乾重（控制碘攝取）"}'::jsonb,
    purchase_note = '偶爾購買即可（乾貨耐儲存）。⚠️ 已用碘鹽者不需頻繁食用海帶補碘，過量碘（>UL 1100mcg/日）有甲狀腺風險，尤其與 Ashwagandha 併用時需格外注意。常溫密封保存，開封後放密封袋/罐。'
WHERE name = '乾海帶（昆布）/ 紫菜';

-- Fix 2: Sleep supplement timing — align title with actual execution logic (22:30, not 22:00)

UPDATE plan_items
SET title = '22:30 睡前補充品',
    description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。洗完澡後核心體溫開始回落時服用'
WHERE title = '22:00 睡前補充品';
