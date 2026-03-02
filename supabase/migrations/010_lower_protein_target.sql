-- Lower protein target from 2.4g/kg (170g+) to 2.0g/kg (146g+) for kidney safety
UPDATE plan_items
SET title = '全天 蛋白質 146g+ 目標',
    description = '每餐 30-40g 蛋白（蛋、魚、雞胸、乳清、酪蛋白）。每日 4-5 餐均勻分配，總計 146g+（2.0g/kg）。每餐達到亮氨酸門檻 2.5-3g'
WHERE title LIKE '%蛋白質 170g%';
