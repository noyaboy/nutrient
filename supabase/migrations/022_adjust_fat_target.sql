-- 脂肪目標微調：50-70g → 80-90g
UPDATE plan_items SET
  description = REPLACE(description, '每日脂肪目標 50-70g（20-30% 總熱量）', '每日脂肪目標 80-90g（22-25% 總熱量）')
WHERE description LIKE '%每日脂肪目標 50-70g%';
