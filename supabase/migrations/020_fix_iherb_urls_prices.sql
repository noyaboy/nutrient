------------------------------------------------------------
-- 修正 iHerb 產品 URL（失效連結）與價格（爬蟲驗證 2026-02-26）
------------------------------------------------------------

-- CoQ10: URL 變更 + 價格微調
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-ubiquinol-200-mg-60-softgels/23657',
  price = 'NT$1,109 / 60 顆'
WHERE name LIKE 'CoQ10 Ubiquinol%';

-- B群 B-50: URL 變更 + 價格更新
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-b-50-100-veg-capsules/39670',
  price = 'NT$332 / 100 顆'
WHERE name LIKE 'B群 B-50%';

-- 膠原蛋白肽 CollagenUP: 價格大幅上漲
UPDATE products SET
  price = 'NT$1,279 / 206g'
WHERE name LIKE '膠原蛋白肽 CollagenUP%';

-- 銅 Solaray: 價格大幅下降
UPDATE products SET
  price = 'NT$217 / 100 顆'
WHERE name LIKE '銅 Copper Bisglycinate%';

-- 豌豆蛋白: URL 變更 + 價格下降
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-sports-pea-protein-pure-unflavored-2-lbs-907-g/9858',
  price = 'NT$600 / 907g'
WHERE name LIKE '豌豆蛋白 Pea Protein%';

-- 甘胺酸粉: URL 變更 + 價格上漲
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-glycine-pure-powder-1-lb-454-g/615',
  price = 'NT$710 / 454g'
WHERE name LIKE '甘胺酸 Glycine Pure Powder%';

-- 蘇糖酸鎂 Magtein: URL 變更 + 價格微調
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-magtein-magnesium-l-threonate-90-veg-capsules/57577',
  price = 'NT$874 / 90 顆'
WHERE name LIKE '蘇糖酸鎂 Magtein%';

-- Ashwagandha: URL 變更 + 價格大幅下降
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-ashwagandha-standardized-extract-450-mg-90-veg-capsules/310',
  price = 'NT$288 / 90 顆'
WHERE name LIKE 'Ashwagandha KSM-66%';

-- 電解質粉: URL 變更 + 價格上漲
UPDATE products SET
  url = 'https://tw.iherb.com/pr/california-gold-nutrition-hydrationup-electrolyte-drink-mix-variety-pack-20-packets-0-14-oz-0-17-oz-4-g-4-8-g-each/94823',
  price = 'NT$600 / 20 包'
WHERE name LIKE '電解質粉 Sport Hydration%';
