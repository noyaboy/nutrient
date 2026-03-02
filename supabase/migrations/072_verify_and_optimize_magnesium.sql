-- Migration 072: Verify & Optimize Magnesium Intake
-- Implements CORR-MG-001 from Comprehensive Nutrition Evaluation 2026-03-01
--
-- ISSUE:
-- Current magnesium estimate ~240 mg (60% of RDA 400 mg).
-- BUT: Unclear if sleep stack "甘胺酸鎂 100mg" means:
--   A) 100 mg elemental magnesium (actual); OR
--   B) 100 mg magnesium glycinate compound (~14 mg elemental)
-- Need to verify before optimizing.
--
-- TARGET:
-- Confirm exact magnesium content in sleep stack.
-- If 100 mg elemental confirmed: Increase to 200-250 mg (target 350-400 mg daily including dietary).
-- RDA: 400 mg/day (from all sources)
-- UL: 350 mg/day from *supplements only* (food has no limit)

-- Update sleep stack plan item to clarify magnesium verification
UPDATE plan_items
SET description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。洗完熱水澡後立即服用效果最佳 — 熱水澡與甘胺酸皆促進周邊血管擴張降低核心體溫，兩者協同加速入睡。
⚠️ 待確認：甘胺酸鎂 100mg 是指「100mg 鎂元素」還是「100mg 甘胺酸鎂絡合物 (~14mg 鎂元素)」？請查看瓶身成分標示「Magnesium」欄位。若為 14mg，則全日鎂攝入僅 ~240mg（60% RDA），建議增至 200-250mg 元素鎂。'
WHERE title = '22:30 睡前補充品'
AND frequency = 'daily'
AND category = '補充品';

-- Add informational plan item: Magnesium verification & optimization
INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  '鎂攝取優化（待確認補充劑含量）',
  '🔍 當前鎂狀態：估計 ~240mg/日（60% RDA 400mg）
   - 睡前補充品：甘胺酸鎂 「100mg」（需確認是否為元素鎂或絡合物）
   - 蔬菜來源：菠菜、南瓜子 ~80mg
   - 堅果/可可：~60mg
   = 總計 ~240mg（差 160mg 到達 RDA）

💡 優化方案（待確認後選擇）：
   A) 若甘胺酸鎂為 100mg 元素鎂（確認無誤）：增至 200-250mg / 日
      ✅ 建議：改用 Magnesium Glycinate 150-200mg（同時提供甘胺酸協同效果）
      ✅ 來源：NOW Foods 或 iHerb 皆有 Mg Glycinate 120-200mg 規格
   B) 若為 100mg 絣合物（含 ~14mg 元素鎂）：增至 250mg 絣合物
      ✅ 建議：檢查現有瓶身；考慮換牌至更高劑量
   C) 混合方案：保留睡前補充品 + 增加食物鎂
      ✅ 建議：增加菠菜份量或日常加入南瓜子/黑巧克力 + 補充增至 150mg

⚠️ 注意 UL：350mg/日 適用於補充劑，食物來源無 UL 限制。',
  'daily',
  '補充品',
  31,
  1,
  false
);

-- Add note on magnesium-rich food sources for dietary enhancement
INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  '鎂豐富食物選項（非補充劑）',
  '若優化策略選擇混合方案，可增加下列食物鎂攝取（無 UL 限制）：
   • 菠菜 100g → ~50mg 鎂（晚餐推薦，低 FODMAP，低植酸對鋅無影響）
   • 南瓜子 30g → ~150mg 鎂（下午點心或沙拉灑末）
   • 深黑巧克力（85% 可可）10g → ~20mg 鎂（可加入豌豆蛋白飲品）
   • 杏仁 30g → ~80mg 鎂（堅果混合包中已含）
   • 燕麥 80g → ~60mg 鎂（休息日早餐；訓練日避開與鋅同餐）

   💡 建議組合：菠菜 100g（晚餐）+ 南瓜子 30g（下午點心或午餐灑末）= +200mg → 總計 440mg（達成 RDA + 10% 安全裕度）',
  'daily',
  '飲食',
  32,
  1,
  false
);
