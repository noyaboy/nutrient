------------------------------------------------------------
-- 清理全天重複項目、合併數位衛生到藍光管理
------------------------------------------------------------

-- 停用「週末睡眠一致性」（與 00:00 準時入睡 重複）
UPDATE plan_items SET is_active = false
WHERE title = '全天 週末睡眠一致性（±30 分鐘）';

-- 停用「數位衛生」（合併到藍光管理）
UPDATE plan_items SET is_active = false
WHERE title = '全天 數位衛生';

-- 合併數位衛生白天部分到藍光管理
UPDATE plan_items
SET description = '調暗燈光或佩戴防藍光眼鏡（琥珀色鏡片）。白天：娛樂螢幕 <2hr、社群媒體 <30min、專注時段手機勿擾模式'
WHERE title = '22:00 藍光管理';

-- 更新蛋白質描述（反映實際分配）
UPDATE plan_items
SET description = '訓練前乳清 27g + 午晚餐各 45-50g + 睡前豌豆 16g ≈ 143g。每餐達亮氨酸門檻 2.5-3g。每日 4-5 餐均勻分配，總計 146g+（2.0g/kg）'
WHERE title = '全天 蛋白質 146g+ 目標';

-- 精簡飲水描述（時間線與各時段項目重複）
UPDATE plan_items
SET description = '尿液淡黃色為適當水合指標。有氧日訓練中改用電解質粉'
WHERE title = '全天 飲水 3-3.5L';
