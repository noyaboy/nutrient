-- Replace casein with pea protein across all plan items
UPDATE plan_items
SET title = REPLACE(title, '酪蛋白', '豌豆蛋白'),
    description = REPLACE(description, '酪蛋白', '豌豆蛋白')
WHERE title LIKE '%酪蛋白%' OR description LIKE '%酪蛋白%';
