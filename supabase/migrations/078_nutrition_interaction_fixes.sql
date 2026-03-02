------------------------------------------------------------
-- Migration 078: Nutrition interaction & bioavailability fixes
-- 1. Move calcium tablet from lunch to bedtime (iron absorption)
-- 2. Fix coffee-lunch timing gap (iron absorption)
-- 3. Add copper intake enforcement plan_item
-- 4. Stabilize iodine + Ashwagandha thyroid safety
-- 5. Add iron absorption awareness tracking
-- 6. Enhance magnesium UL monitoring in bedtime item
-- 7. B6 dose verification note (already mostly done in 077, minor enhancement)
------------------------------------------------------------

-- 1. MOVE CALCIUM FROM LUNCH TO BEDTIME
-- Calcium 500mg at lunch inhibits heme & non-heme iron absorption 40-60%.
-- Calcium absorbs well at night and synergizes with bedtime magnesium for bone health.

-- 1a. Remove calcium from lunch description
UPDATE plan_items
SET description = '蛋白質 35-40g（正餐完整蛋白質，不含膠原蛋白——膠原蛋白缺乏色氨酸且亮氨酸極低，無法有效刺激肌肉蛋白合成 MPS，單餐建議 ≤45g）+ 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆（鮭魚日減為 2 顆）、D3 2000IU（2 顆）、K2、葉黃素 20mg、膠原蛋白肽 10-15g（額外，不計入蛋白質目標）、CoQ10 200mg、B群 1 顆（活化型態，隨正餐油脂+蛋白質完整食物基質服用，吸收率最佳）。⚠️ 鈣片已移至睡前服用——避免午餐高鈣抑制鐵吸收（鈣 ≥300mg 抑制鐵吸收 40-60%）。午餐搭配維他命C食物（彩椒、花椰菜）促進鐵吸收'
WHERE title = '12:00 午餐 + 訓練後補充品';

-- 1b. Add calcium to bedtime supplement slot
UPDATE plan_items
SET description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 200mg（2 錠）+ 鈣片 1 錠（500mg）+ Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。洗完熱水澡後立即服用效果最佳——熱水澡與甘胺酸皆促進周邊血管擴張降低核心體溫，兩者協同加速入睡。💊 鈣片移至睡前原因：(1) 避免午餐鐵吸收被鈣抑制 40-60%，(2) 夜間鈣吸收效率高（副甲狀腺素 PTH 夜間分泌增加），(3) 鈣+鎂協同支持骨密度與肌肉放鬆。⚠️ 鈣鎂同服注意：500mg 鈣 + 344mg 鎂同時服用，高劑量鈣可能略微競爭鎂吸收，但睡前空腹狀態下兩者均有充足轉運蛋白，臨床影響極小。⚠️ 鎂 UL 監控：補充品鎂合計 ~344mg（甘胺酸鎂 200mg + 蘇糖酸鎂 144mg），接近 IOM 補充品 UL 350mg。若出現腹瀉或腸胃不適，優先將甘胺酸鎂減為 1 錠（100mg），總計降至 244mg'
WHERE title = '22:30 睡前補充品';

-- 1c. Update calcium tracking item to reflect bedtime timing
UPDATE plan_items
SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 300g（必須，~280mg 鈣）+ 深綠蔬菜（~150-200mg）。🔴 每日睡前服用鈣片 1 錠（+500mg），已從午餐移至 22:30 睡前——避免午餐鐵吸收被高鈣抑制。板豆腐日：優格 280mg + 板豆腐 150-225mg + 鈣片 500mg + 蔬菜 150mg ≈ 1080-1155mg ✅。非板豆腐日：優格 280mg + 鈣片 500mg + 蔬菜 150mg ≈ 930mg（搭配強化食品補足）。⚠️ 睡前鈣+鎂同服：兩者協同促進肌肉放鬆與骨密度，臨床不衝突'
WHERE title = '全天 鈣攝取確認（目標 1000mg）';

-- 1d. Update green tea description to remove obsolete calcium reference
UPDATE plan_items
SET description = '午餐後 3hr+ 再飲用（~15:00），高脂高蛋白午餐胃排空需 3-4hr，3hr 內 EGCG 仍會螯合鐵鋅（午餐礦物質仍在小腸吸收中）。改用低咖啡因綠茶（白毫銀針或老白毫），配合 L-theanine 天然組合促進專注，同時避免晚間睡眠干擾。15:30 前喝完（咖啡因 cutoff）。綠茶天然 L-Theanine（40-90mg）為額外放鬆紅利，不影響早晨 L-Theanine 補劑的服用'
WHERE title = '15:00 綠茶 EGCG 2-3 杯';

-- 2. FIX COFFEE-LUNCH TIMING
-- Coffee at 11:15, lunch at 12:00 = only 45min gap.
-- Coffee polyphenols reduce non-heme iron absorption 60-90% even 1hr later.
-- Solution: Move coffee to 12:30 (post-lunch), or delay it to after first few bites.

UPDATE plan_items
SET title = '12:30 咖啡 + L-Theanine（午餐後）',
    description = '☕ 午餐後 30 分鐘飲用（~12:30）。咖啡因 150-200mg + L-Theanine 200mg（1:1 A 級 nootropic 組合，保護睡眠品質）。15:00 後禁止咖啡因。✅ 無論當天是否飲用綠茶，喝咖啡就必須同步服用 L-Theanine。⚠️ 咖啡移至午餐後原因：咖啡多酚（Chlorogenic acid）在胃腸道內會螯合非血基質鐵（non-heme iron），抑制吸收率達 60-90%。餐前 1hr 內飲用嚴重影響午餐鐵吸收。餐後 30min 飲用時，午餐鐵已開始被十二指腸吸收，影響大幅降低。⚠️ 起床後至少 60-90 分鐘再攝取咖啡因（皮質醇覺醒反應 CAR 結束後）'
WHERE title = '11:15 咖啡 + L-Theanine';

-- 3. ADD COPPER INTAKE ENFORCEMENT
-- Copper supplement is inactive. Dietary copper relies on daily dark chocolate + nuts + cocoa
-- but no active plan_item enforces this. Critical for preventing zinc-induced copper depletion.

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('全天 銅攝取確認（目標 ≥0.9mg）',
   '每日確認飲食銅攝取 ≥0.9mg（RDA）。⚠️ 長期補鋅 15mg/日可導致銅耗竭——鋅誘導腸道金屬硫蛋白（Metallothionein）優先結合銅，阻止銅吸收。必吃銅來源：🍫 黑巧克力 20g（~0.5mg 銅）+ 🥜 綜合堅果 30g（~0.3-0.5mg 銅）+ 可可粉 5g（~0.2mg 銅）= 合計 ~1.0-1.2mg。⚠️ 若任一項缺席，當日銅可能 <0.9mg。銅缺乏症狀：貧血（鐵劑無效型）、白血球低下、骨質疏鬆、神經病變。⚠️ 每半年驗血清銅+銅藍蛋白：銅藍蛋白 <20mg/dL 或血清銅 <70mcg/dL → 立即加回銅補充品 1mg/日',
   'daily', '礦物質', 30, 1, true);

-- 4. STABILIZE IODINE + ASHWAGANDHA THYROID SAFETY
-- Iodine varies 56-205mcg/day. On Ashwagandha "on" cycles, unstable iodine + thyroid
-- stimulation = risk. Add guidance to iodine tracking and Ashwagandha items.

UPDATE plan_items
SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 全日鈉預算（WHO <2400mg/日）：晨間 1g（~400mg 鈉）+ 午晚餐烹調碘鹽合計 1-1.5g（~400-600mg 鈉）+ 泡菜 30g（~200mg 鈉）+ 茶葉蛋 1 顆（~250mg 鈉）+ 食物天然鈉 ~500mg ≈ 總計 1750-1950mg。⚠️ 碘攝取穩定化策略：每日固定 4 片海苔（~100-160mcg 碘）+ 碘鹽 2-2.5g/全日（~40-50mcg）= 穩定達 RDA 150mcg。⚠️ Ashwagandha 服用期間碘攝取尤其重要：Ashwagandha 刺激 T3/T4 生成，若碘不足則甲狀腺被迫代償，增加甲狀腺結節風險。建議 Ashwagandha「on 週期」每日嚴格執行 4 片海苔不可省略'
WHERE title = '09:05 碘鹽 1g';

UPDATE plan_items
SET description = '📋 8 週用 / 4 週停 週期。第 1-5 週正常服用 450mg/日（睡前）。第 6 週起每日自評情緒冷漠。第 8 週（第 56 天）準時進入停用期。停用 4 週：甘胺酸鎂 + Cyclic Sighing 替代。⚠️ 甲狀腺-碘交互作用：Ashwagandha 提升 Free T3/T4，服用期間必須確保每日碘攝取穩定 ≥150mcg（4 片海苔 + 碘鹽）。若 Free T3 偏高（半年健檢），考慮縮短週期至 6 週用 / 4 週停'
WHERE title = 'Ashwagandha 週期管理（8 週用 / 4 週停）';

-- 5. ADD IRON ABSORPTION AWARENESS TRACKING
-- No iron tracking despite multiple inhibitors (coffee, tea, calcium, phytates).

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('全天 鐵吸收最佳化確認（目標 RDA 8mg）',
   '每日確認鐵吸收最佳化（男性 RDA 8mg，但吸收率受飲食因素影響極大）。🔴 鐵吸收促進因子：(1) 維他命C 隨餐（午餐膠原蛋白含 Vit C，或彩椒/花椰菜），可提升非血基質鐵吸收 2-6 倍。(2) 動物蛋白「肉類因子」（MFP）促進非血基質鐵吸收。(3) 鈣片已移至睡前，午餐鐵不再被鈣抑制 ✅。🔴 鐵吸收抑制因子：(1) 咖啡已移至 12:30 餐後，影響大幅降低 ✅。(2) 綠茶 15:00 飲用（3hr 後），影響有限 ✅。(3) 植酸（全穀、豆類）：午餐使用白米/冷卻米飯可降低植酸。板豆腐植酸含量低於未加工大豆。(4) 草酸（菠菜）：僅影響菠菜本身的鐵，不影響同餐其他食物的鐵。主要鐵來源：牛肉（血基質鐵，吸收率 25-35%）、雞蛋（非血基質鐵 + MFP）、菠菜/深綠蔬菜、強化穀物。⚠️ 每半年驗血清鐵蛋白（Ferritin），目標 50-150 ng/mL',
   'daily', '飲食', 31, 1, true);

-- 6. MAGNESIUM UL MONITORING (already in bedtime item, updated in step 1b above)
-- No additional changes needed — the bedtime item now has enhanced Mg UL language.

-- 7. B6 NEUROPATHY (already handled in migration 077)
-- Verify B-complex product description has P5P monitoring note.
-- Add explicit dose check reminder to B-complex product.

UPDATE products
SET description = '✓ iHerb 必買。活化型態 B 群複方：甲鈷胺（Methylcobalamin B12）、5-MTHF 葉酸（非合成 Folic Acid）、P5P（活化 B6，50mg/日）。應對 MTHFR 基因變異風險，確保 B 群被有效利用。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成。⚠️ B6（P5P）50mg/日長期安全性：UL 為 100mg/日，P5P 形式比吡哆醇（Pyridoxine）安全性更高（不經肝臟轉化、不累積毒性代謝物），但文獻有 >25mg/日長期使用的神經病變個案報告。📋 每月自我篩查：手腳有無持續性麻木、刺痛、灼熱感。若出現症狀立即停用 B-complex 並就醫。⚠️ 降級方案：若擔心風險，可改用含 P5P 25mg 的 B-complex（如 Thorne Basic B Complex），仍遠超 RDA 1.3mg 但更保守'
WHERE name = 'B群 活化型態（NOW Foods B-50 Coenzyme 60 顆）';

-- Update calcium product usage to reflect bedtime timing
UPDATE products
SET usage = '每日睡前（22:30）服用 1 錠（+500mg 鈣）。已從午餐移至睡前，避免抑制午餐鐵吸收',
    description = '碳酸鈣 + 檸檬酸鈣雙鈣源。每日睡前服用（從午餐移出——高鈣抑制鐵吸收 40-60%）。注意：本品含 D3 150IU/錠，與獨立 D3 2000IU 疊加後總計 2150IU 仍在安全範圍。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）'
WHERE name = '鈣片備用（Nature Made Ca+D3+K2 250 錠）';
