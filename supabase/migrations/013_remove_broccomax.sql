-- Remove BroccoMax supplement — fresh cruciferous at lunch is sufficient
UPDATE plan_items
SET title = '13:00 午餐 + 十字花科蔬菜',
    description = '蛋白質 30-40g + 十字花科蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）'
WHERE title LIKE '13:00 午餐%';
