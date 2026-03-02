------------------------------------------------------------
-- 068_consolidate_descriptions.sql
-- Consolidate & streamline plan item descriptions
-- Removes redundancy between related items
------------------------------------------------------------

-- Consolidate iodine description - remove redundant detail since product exists
UPDATE plan_items
SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。⚠️ 當前策略僅提供 32-76mcg（vs RDA 150mcg）。✅ 補救：iHerb NOW Foods 碘補充劑 75mcg/日（詳見採購清單）'
WHERE title = '09:05 碘鹽 1g';

-- Simplify calcium description
UPDATE plan_items
SET description = '鈣攝取確認與補充策略改進。食物源（希臘優格 200-300g）+ 每日補充 500mg（Nature Made，隨午餐）= 700-780mg/day（vs RDA 1000mg，但已大幅改善）'
WHERE title = '全天 鈣攝取確認（目標 1000mg）';

-- Simplify NMN/TMG (already discontinued)
UPDATE plan_items
SET description = '【已停用】成本效益不高 & 當前補充品已涵蓋主要需求。若要恢復，告知後可添加產品到採購清單'
WHERE title = '09:15 NMN + TMG（空腹）';

-- Consolidate Magtein reminder into main sleep item
UPDATE plan_items
SET description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 450mg。洗完熱水澡後立即服用。⚠️ Magtein 月度重訂提醒：改為 iHerb 訂閱或 3 個月批次購買'
WHERE title = '22:30 睡前補充品';

-- Consolidate Ashwagandha with specific dates (keep concise)
UPDATE plan_items
SET description = '8 週用 / 4 週停循環。開始日：2026-03-01，停用日：2026-04-25。血檢日：第 4 週（2026-03-29）& 第 12 週（2026-05-23）。每週自評情緒 [1-10 量表]'
WHERE title = 'Ashwagandha 週期管理（8 週用 / 4 週停）';

-- Blood test baseline (concise)
UPDATE plan_items
SET description = '6 個月檢查計畫：基線 2026-03-31，後續 2026-09-30。核心指標：ApoB <80、HbA1c <5.3%、空腹胰島素 <7、hs-CRP <1.0、Omega-3 >8%、D [25(OH)D] 40-60 ng/mL。⚠️ 前置準備：抽血前 7 天停肌酸'
WHERE title = '【每半年】健康檢測';

-- FMD protocol (structured, concise)
UPDATE plan_items
SET description = '季度 5 日斷食。日期：Q1 2026-03-31至04-04、Q2 06-30至07-04、Q3 09-30至10-04、Q4 12-30至2027-01-03。每日 macros：~1000-1200 kcal、蛋白 30-40g、脂肪 25-35g、碳水 100-150g。禁用：肌酸、魚油、NMN、白藜蘆醇'
WHERE title = '【每季】FMD 斷食模擬飲食（5 天）';

-- Dinner carbs (explicit list, concise)
UPDATE plan_items
SET description = '蛋白質 35-40g + 低植酸碳水 + 低 FODMAP 蔬菜。順序：纖維→蛋白→碳水。鋅 15mg「最後一口」吞服。【碳水選項】✓ 白米、義大利麵、去皮馬鈴薯、地瓜｜✗ 避免：糙米、燕麥、豆類。⚠️ 牛肉日：上限 150g，蛋移至午餐'
WHERE title = '19:00 晚餐 + 低 FODMAP 蔬菜';

-- Update or keep broccoli cooking note (check if exists first)
-- If new item was added, this will preserve it; if not, create it
INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active)
SELECT '午餐 花椰菜烹調法（促甲狀腺物質管理）',
       '新鮮花椰菜含促甲狀腺物質。沸騰 10-15 分鐘減少 40-60%（vs 生食）。與碘補間隔 4+ 小時建議（現已補碘，風險降低）',
       'daily',
       '飲食',
       7.2,
       1,
       true
WHERE NOT EXISTS (
  SELECT 1 FROM plan_items WHERE title = '午餐 花椰菜烹調法（促甲狀腺物質管理）'
);
