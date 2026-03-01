-- Migration 073: Add Explicit Deload Week Protocol
-- Implements CORR-DELOAD-001 from Comprehensive Nutrition Evaluation 2026-03-01
--
-- ISSUE:
-- Current plan mentions "3 週漸進超負荷 + 第 4 週 Deload" in weekly plan items.
-- BUT: Deload week macronutrient targets NOT explicitly stated.
-- Missing clarity on carbohydrate reduction during deload (should be 2-3 g/kg to match rest-day protocol).
--
-- TARGET:
-- Add explicit plan item stating:
--   Protein: Maintain 1.75 g/kg (122-132g daily)
--   Carbs: Reduce to 2-3 g/kg (~146-219g daily) — matches rest-day targets
--   Training: Maintain intensity 85%, reduce volume 40-50% (6-10 sets per muscle group vs. 12-20 normal)
--   Purpose: CNS recovery, connective tissue repair, insulin sensitivity reset

INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  'Deload 週（5 週期中的第 4 週）：降低碳水化合物',
  '⚠️ 每 5 週重訓期中，第 4 週實施 Deload（減量周）以恢復中樞神經系統、修復結締組織、重啟胰島素敏感性。

📋 Deload 週巨量營養元素目標：
   • 蛋白質：維持 1.75g/kg（122-132g/日）— 不減少，持續支持肌肉修復
   • 碳水化合物：降至 2-3g/kg（~146-219g/日） — 與休息日相同，減少胰島素驅動
   • 脂肪：維持 80-90g/日
   • 熱量：從訓練日 3100-3400 kcal 降至 ~2400-2700 kcal（減量）

🏋️ Deload 週訓練調整：
   • 訓練強度：維持 85% 1RM（不減弱，避免肌肉流失）
   • 訓練量：每肌群降至 6-10 組（正常 12-20 組），減 40-50%
   • 訓練頻率：維持 4×/週時間表
   • 備註：訓練強度不變，體積減量 → 神經系統恢復，代謝負擔↓

⏰ Deload 實施建議：
   • 監測指標：晨起心率、睡眠品質、主觀精力
   • 若晨起心率 ↑ 5-10 bpm（過度訓練訊號），提前進入 Deload
   • 若精力充沛且心率正常，可按計劃第 4 週進行

🔬 科學基礎：
   • Deload 在 12 週期、6 週期、甚至 4 週期後都有支持證據
   • 減量周使用重量不減但組數減，較使用輕重量更有效保留肌肉
   • 碳水減少但維持蛋白質 = 保持合成代謝同時允許代謝休息',
  'weekly',
  '運動',
  25,
  1,
  true
);

-- Also update the existing weekly training plan item to cross-reference new deload protocol
UPDATE plan_items
SET description = '一上半身A/二下半身A/四上半身B/五下半身B。每肌群每週 12-20 組。3 週漸進超負荷 + 第 4 週 Deload（量減 40-50%，強度維持 85%）。📌 詳見獨立「Deload 週」計畫項目（第 4 週碳水、訓練調整）。記錄每組重量/次數'
WHERE title = '肌力訓練 4 次（Upper/Lower）'
AND frequency = 'weekly'
AND category = '運動';

-- Add practical Deload week checklist
INSERT INTO plan_items (
  title, description, frequency, category, sort_order, target_count, is_active
) VALUES (
  'Deload 週檢查清單',
  '📋 Deload 週 (第 4 週) 實施清單：

✅ 營養端：
   □ 碳水目標設定：～150-160g/日（vs. 訓練日 370-430g）
   □ 蛋白質：維持 127.5g/日（早餐、午餐、晚餐份量不變）
   □ 跳過碳水載體食物（不需額外加熱米飯、馬鈴薯）
   □ 鹽份、電解質維持相同（非減鹽期）

✅ 訓練端：
   □ 重量不變（85% 1RM）
   □ 組數：每肌群降至 6-10 組（簽到表記錄）
   □ 休息時間：正常 2-3 分鐘（無需加長）
   □ 主觀難度評分：感到「輕鬆 / 可控」（正常感覺），不會「過度疲勞」

✅ 恢復指標：
   □ 晨起心率：測量 RHR，記錄是否 ↓ 2-3 bpm（恢復訊號）
   □ 睡眠品質：目標 8-9 小時（與訓練日相同）
   □ 主觀精力：週五應感受「充滿精力」感（vs. 訓練周 Thursday 疲勞）
   □ 肌肉酸痛：應減少（恢復周特性）

✅ 心理：
   □ 無需焦慮「肌肉流失」（學科證據：維持強度下，減量周無肌肉損失）
   □ 視為「積極恢復」，為下一個 3 週漸進超負荷作準備',
  'weekly',
  '一般',
  26,
  1,
  false
);
