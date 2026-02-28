-- Update daily protein target to match actual recipe macros after chicken reduction
-- Old: 午餐 35-40g + 晚餐 35-40g = 113-123g (1.5-1.7g/kg)
-- New: 午餐 41-44g + 晚餐 38-45g = 122-132g (1.7-1.8g/kg)

UPDATE plan_items
SET title = '全天 蛋白質 122-132g+（1.7-1.8g/kg）',
    description = '訓練前乳清 27g + 午餐 41-44g + 下午豌豆 16g + 晚餐 38-45g ≈ 122-132g。每餐 ≤45g，每日 4-5 餐均勻分配，總計約 1.7-1.8g/kg'
WHERE title LIKE '全天 蛋白質 113-123g%';
