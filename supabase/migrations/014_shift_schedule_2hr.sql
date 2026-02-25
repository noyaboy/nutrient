------------------------------------------------------------
-- 時間表後移 2 小時 + 合併訓練後與午餐
-- 起床 07:00→09:00, 入睡 22:00→00:00
-- 訓練後補充品 row 合併至午餐
------------------------------------------------------------

-- === Morning items ===
UPDATE plan_items SET title = '09:00 起床 & 晨光曝曬' WHERE title = '07:00 起床 & 晨光曝曬';
UPDATE plan_items SET title = '09:05 補水 & 電解質' WHERE title = '07:05 補水 & 電解質';
UPDATE plan_items SET title = '09:15 NMN + TMG（空腹）' WHERE title = '07:15 NMN + TMG（空腹）';
UPDATE plan_items SET title = '09:15 訓練前營養' WHERE title = '07:15 訓練前營養';
UPDATE plan_items SET title = '09:45 穩定性訓練暖身' WHERE title = '07:45 穩定性訓練暖身';
UPDATE plan_items SET title = '10:00 運動' WHERE title = '08:00 運動';

-- Coffee: time shift + cutoff 13:00→15:00
UPDATE plan_items
SET title = '10:30 咖啡 + L-Theanine',
    description = '起床後 60-90 分鐘再喝。咖啡因 200-300mg（約 1-2 杯黑咖啡）+ L-Theanine 200mg（A 級 nootropic 組合，消除焦慮、增強專注）。15:00 後禁止咖啡因（半衰期 5-6 小時影響睡眠）'
WHERE title = '08:30 咖啡 + L-Theanine';

-- === Merge post-workout into lunch ===
-- Update lunch row with merged content
UPDATE plan_items
SET title = '12:00 午餐 + 訓練後補充品',
    description = '蛋白質 30-40g（正餐食物）+ 肌酸 5g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日）。魚油 3 顆、D3 2000IU（5+2）、D3+K2（不額外補鈣片，鈣從食物攝取）、維他命 C、葉黃素 20mg。不再額外沖乳清蛋白（正餐蛋白質已足夠）',
    sort_order = 7
WHERE title = '13:00 午餐 + 十字花科蔬菜';

-- Delete the old post-workout row
DELETE FROM plan_items WHERE title = '09:00 訓練後營養 + 補充品';

-- === Green tea: 11:00→13:00, cutoff 13:00→15:00 ===
UPDATE plan_items
SET title = '13:00 綠茶 EGCG 2-3 杯',
    description = '午餐後 1hr+ 再飲用（~13:00），避免螯合鈣、鐵、鋅。EGCG + L-theanine 天然組合促進專注。15:00 前喝完（咖啡因 cutoff）'
WHERE title = '11:00 綠茶 EGCG 2-3 杯';

-- === NSDR: 14:00→15:00 ===
UPDATE plan_items
SET title = '15:00 NSDR + 銅 2mg',
    description = '使用引導式 Yoga Nidra 音檔（非單純休息）。11 分鐘有 RCT 支持，促進深度放鬆與多巴胺恢復。銅 2mg 搭配少量堅果或水果服用（與 EGCG 間隔 2hr+）'
WHERE title = '14:00 NSDR + 銅 2mg';

-- === Afternoon/Evening ===
-- 17:00 社交不動
UPDATE plan_items
SET title = '19:00 晚餐 + 低 FODMAP 蔬菜'
WHERE title = '18:00 晚餐 + 低 FODMAP 蔬菜';

UPDATE plan_items SET title = '19:30 餐後散步 15 分鐘' WHERE title = '18:30 餐後散步 15 分鐘';

-- === Night ===
UPDATE plan_items SET title = '22:00 藍光管理' WHERE title = '20:00 藍光管理';

UPDATE plan_items
SET title = '22:30 睡前：熱水澡 + 豌豆蛋白 + 補充品'
WHERE title = '20:30 睡前：熱水澡 + 豌豆蛋白 + 補充品';

UPDATE plan_items SET title = '23:30 Cyclic Sighing + 專注冥想' WHERE title = '21:30 Cyclic Sighing + 專注冥想';
UPDATE plan_items SET title = '23:50 口腔衛生：刷牙 + 牙線' WHERE title = '21:50 口腔衛生：刷牙 + 牙線';
UPDATE plan_items SET title = '00:00 準時入睡' WHERE title = '22:00 準時入睡';
UPDATE plan_items SET title = '00:00 感恩練習' WHERE title = '22:00 感恩練習';

-- === All-day items ===
UPDATE plan_items
SET description = '娛樂螢幕 <2hr、社群媒體 <30min。23:00 後無螢幕、專注時段手機勿擾模式'
WHERE title = '全天 數位衛生';

UPDATE plan_items
SET description = '09:05 起床 500ml（碘鹽+檸檬）→ 10:00 訓練中 500ml → 12:00 隨餐 500ml → 13:00 綠茶 500ml → 15:00 下午補水 250ml → 19:00 隨餐 250ml → 22:30 豌豆蛋白沖泡 250ml。有氧日訓練中改用電解質粉。尿液淡黃色為適當水合指標'
WHERE title = '全天 飲水 3-3.5L';

-- === Products ===
UPDATE products SET usage = '每日 1-2 杯，10:30-15:00 之間' WHERE name = '咖啡豆 / 研磨咖啡';
UPDATE products SET usage = '22:00 後佩戴' WHERE name = '防藍光眼鏡（琥珀色鏡片）';
UPDATE products SET description = '確保臥室全黑環境，維持褪黑激素正常分泌。配合 00:00 入睡方案' WHERE name = '全遮光窗簾';
UPDATE products SET usage = '訓練前 1 份（~30g 粉 ≈ 27g 蛋白）。午餐改為正餐蛋白質，不再額外沖乳清' WHERE name = 'Tryall 無調味分離乳清蛋白 2kg';
