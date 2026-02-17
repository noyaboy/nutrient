-- 修正 Ca+D3+K2 劑量：2-3 錠 → 1 錠
-- 原因：24 歲男性補充鈣 1000-1500mg/天過高（JAHA 研究顯示心血管風險）
-- 飲食鈣 ~560mg + 補充 500mg (1 錠) = ~1060mg，接近 RDA 1000mg

-- 更新產品 usage
UPDATE products SET
  usage = '每日 1 錠隨訓練後餐（09:00），D3+K2 協同作用'
WHERE name = '鈣 + D3 + K2（Nature Made 250 錠）';

-- 更新 plan_items 09:00 描述
UPDATE plan_items SET
  description = '乳清蛋白 ~40g 粉（≈31g 蛋白）+ 肌酸 5g + 碳水 80-105g；魚油 3 顆、D3 5000IU、鈣+D3+K2 1 錠、維他命 C、葉黃素 20mg'
WHERE title = '09:00 訓練後早餐 + 補充品';
