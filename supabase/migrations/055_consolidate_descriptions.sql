-- =====================================================
-- 055: Consolidate descriptions
-- Shorten plan_items.description for items that have
-- getHealthDetails() coverage in the frontend.
-- TaskItem.tsx renders BOTH description AND healthDetails,
-- causing massive duplication. Keep descriptions as brief
-- summaries; let getHealthDetails handle the detail.
-- =====================================================

-- === 1. 09:15 訓練前營養 ===
UPDATE plan_items SET description = '地瓜（推薦）或香蕉 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（活化型態 Coenzyme B-Complex）。09:05 先補水 → 09:15 進食'
WHERE title LIKE '%09:15%訓練前營養%' AND is_active = true;

-- === 2. 10:00 運動 ===
UPDATE plan_items SET description = '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘'
WHERE title LIKE '%10:00%運動%' AND is_active = true;

-- === 3. 咖啡 + L-Theanine ===
UPDATE plan_items SET description = '起床後 90-135 分鐘再喝（避免干擾皮質醇覺醒反應，且與 09:15 B群間隔 2hr+）。咖啡因 200-300mg + L-Theanine 200mg（1:1 A 級 nootropic 組合）。15:00 後禁止咖啡因'
WHERE title LIKE '%咖啡%L-Theanine%' AND is_active = true;

-- === 4. 12:00 午餐 + 訓練後補充品 ===
UPDATE plan_items SET description = '蛋白質 35-40g（正餐食物，單餐建議 ≤45g）+ 肌酸 5g + 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。隨餐服用：魚油 3 顆、D3 1000IU、K2、葉黃素 20mg、膠原蛋白肽 10-15g、CoQ10 200mg'
WHERE title LIKE '%12:00%午餐%' AND is_active = true;

-- === 5. 14:00-15:00 銅 2mg 補充 ===
UPDATE plan_items SET description = '銅 2mg（Solaray Bisglycinate）隨低鈣/低鐵小點心服用（少量水果、幾片餅乾）。避免空腹引發噁心嘔吐，不與鋅、鈣、鐵同服'
WHERE title LIKE '%銅 2mg%補充%' AND is_active = true;

-- === 6. 15:30 下午點心 ===
UPDATE plan_items SET description = 'Tryall 豌豆蛋白 ~20g 粉（≈16g 蛋白）。非乳製植物蛋白，下午點心時段分散蛋白質攝取壓力'
WHERE title LIKE '%15:30%下午點心%' AND is_active = true;

-- === 7. 19:00 晚餐 + 低 FODMAP 蔬菜 ===
UPDATE plan_items SET description = '蛋白質 35-40g（單餐建議 ≤45g）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。維他命 C 500mg（1 錠，每日服用）+ 鋅 15mg 在晚餐「最後一口」吞服'
WHERE title LIKE '%19:00%晚餐%' AND is_active = true;

-- === 8. 22:00 睡前補充品 ===
UPDATE plan_items SET description = '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 450mg（KSM-66，嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。22:30 洗完澡後服用'
WHERE title LIKE '%22:00%睡前補充品%' AND is_active = true;

-- === 9. 22:00 藍光管理 ===
UPDATE plan_items SET description = '調暗燈光或佩戴防藍光眼鏡（琥珀色鏡片）。白天：娛樂螢幕 <2hr、社群媒體 <30min、專注時段手機勿擾模式'
WHERE title LIKE '%藍光管理%' AND is_active = true;

-- === 10. 00:00 準時入睡 ===
UPDATE plan_items SET description = '目標 8-8.5 小時睡眠。全黑、低溫 18-19°C。深層睡眠啟動腦部排毒系統'
WHERE title LIKE '%00:00%準時入睡%' AND is_active = true;

-- === 11. Ashwagandha 週期管理 ===
UPDATE plan_items SET description = '📋 8 週用 / 4 週停 週期。第 1-5 週正常服用 450mg/日（睡前）。第 6 週起每日自評情緒冷漠。第 8 週（第 56 天）準時進入停用期。停用 4 週：甘胺酸鎂 + Cyclic Sighing 替代'
WHERE title LIKE '%Ashwagandha%週期管理%' AND is_active = true;

-- === 12. Ashwagandha 肝功能追蹤 ===
UPDATE plan_items SET description = '⚠️ 開始服用新品牌 Ashwagandha 後，第 4 週及第 12 週各安排一次 ALT/AST 抽血。藥源性肝損傷多發於數週內，早期發現可避免惡化'
WHERE title LIKE '%肝功能追蹤%第4/12週%' AND is_active = true;

-- === 13. 全天 蛋白質 ===
UPDATE plan_items SET description = '訓練前乳清 27g + 午餐 35-40g + 下午豌豆 16g + 晚餐 35-40g ≈ 113-123g。每餐 ≤45g，每日 4-5 餐均勻分配，總計約 1.5-1.7g/kg'
WHERE title LIKE '%蛋白質%113%' AND is_active = true;

-- === 14. 全天 膳食纖維 ===
UPDATE plan_items SET description = '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜（抗性澱粉）。搭配發酵食物（優格、泡菜）增強腸道多樣性'
WHERE title LIKE '%膳食纖維%' AND is_active = true;

-- === 15. 全天 碳水循環 ===
UPDATE plan_items SET description = '重訓日 5-6g/kg (360-430g)、有氧日 3-4g/kg (215-290g)、休息日 2-3g/kg (145-215g)。重訓日熱量目標 3,100-3,400 kcal。⚠️ 高碳水日嚴格執行低纖維替換'
WHERE title LIKE '%碳水循環%' AND is_active = true;

-- === 16. 全天 鈣攝取確認 ===
UPDATE plan_items SET description = '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g + 深綠蔬菜 + 豆腐。食物鈣優先，不足時鈣片隨午餐服用'
WHERE title LIKE '%鈣攝取%' AND is_active = true;

-- === 17. 全天 飲水 ===
UPDATE plan_items SET description = '尿液淡黃色為適當水合指標。💧 補鈣日飲水目標 3.5L+（維持良好水合，支持腎臟代謝）'
WHERE title LIKE '%飲水%3%' AND is_active = true;

-- === 18. 健康檢測 ===
UPDATE plan_items SET description = '每半年一次全面健康檢查。🔴 絕對前提：抽血前 7 天停用肌酸 + 48-72 小時暫停高強度重訓。必檢：腎功能（BUN/Creatinine/eGFR/Cystatin C）、肝功能（ALT/AST）、甲狀腺（TSH/Free T4）'
WHERE title LIKE '%健康檢測%' AND is_active = true;

-- === 19. Zone 2 有氧 ===
UPDATE plan_items SET description = '週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機。⚠️ Zone 2 日補水策略：09:05 改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水'
WHERE title LIKE '%Zone 2 有氧%' AND is_active = true;

-- === 20. 肌力訓練 ===
UPDATE plan_items SET description = '一上半身A/二下半身A/四上半身B/五下半身B。每肌群每週 12-20 組。3 週漸進超負荷 + 第 4 週 Deload（量減 40-50%，強度維持 85%）。記錄每組重量/次數'
WHERE title LIKE '%肌力訓練%' AND is_active = true;

-- === 21. VO2 Max ===
UPDATE plan_items SET description = 'Peter Attia 4×4 法 — 4 分鐘全力（90-95% HRmax）+ 4 分鐘恢復 × 4 組。週三進行'
WHERE title LIKE '%VO2 Max%訓練%' AND is_active = true;

-- === 22. 09:05 補水 & 電解質: remove long iodine strategy (in 訓練前營養) ===
UPDATE plan_items SET description = '起床後盡快補水。500ml 室溫水 + 碘鹽 1g（食品電子秤測量 0.1g 精度，約 400mg 鈉）+ 檸檬汁。可搭配晨光曝曬同時進行。⚠️ Zone 2 日（週六/日）改用電解質粉沖泡 500ml（CGN Sport Hydration），碘鹽併入其他餐次'
WHERE title LIKE '%09:05%補水%電解質%' AND is_active = true;

-- === 23. 09:05 碘鹽: shorten, add cross-reference ===
UPDATE plan_items SET description = '500ml 室溫水 + 碘鹽 1g（電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽確保碘攝取。⚠️ 晨間碘鹽僅 1g 控鈉（WHO <2400mg/日），碘攝取主力仰賴午晚餐碘鹽 + 每週 2-3 次海帶/紫菜'
WHERE title LIKE '%碘鹽 1g%' AND is_active = true;

-- === 24. 21:30-22:15 熱水澡: shorten (details in 睡前補充品 getHealthDetails) ===
UPDATE plan_items SET description = '40-42°C 10-15 分鐘。⚠️ 必須在 22:15 前結束洗澡：熱水澡短暫升高核心體溫，而 22:30 甘胺酸的作用是降低核心體溫促進入睡 — 若洗完澡立刻服用甘胺酸，體溫尚未從升高狀態回落，甘胺酸降溫效果被抵消。正確流程：21:30-22:15 洗澡結束 → 22:30 服用甘胺酸（體溫已開始自然回落）→ 散熱 60-90 分鐘 → 00:00 入睡時核心體溫降至最低點'
WHERE title LIKE '%熱水澡%' AND is_active = true;
