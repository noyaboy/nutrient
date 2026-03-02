-- Fix all validation errors and warnings from validate_products.py

------------------------------------------------------------
-- 1. Costco price updates (2 items)
------------------------------------------------------------
UPDATE products SET price = 'NT$339 / 454g×4'
WHERE name LIKE '冷凍綠花椰菜%' AND store = 'Costco';

UPDATE products SET price = 'NT$599 / 1.13kg'
WHERE name LIKE '綜合堅果%' AND store = 'Costco';

------------------------------------------------------------
-- 2. K2 MK-7: fix broken URL + add sku/rating/image_url
------------------------------------------------------------
UPDATE products SET
  url = 'https://tw.iherb.com/pr/now-foods-mk-7-vitamin-k-2-100-mcg-120-veg-capsules/78992',
  price = 'NT$887 / 120 顆',
  sku = 'NOW-00993',
  rating = 4.8,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00993/g/86.jpg'
WHERE name LIKE '維他命 K2 MK-7%' AND store = 'iHerb';

------------------------------------------------------------
-- 3. iHerb items: add missing rating + image_url (8 items)
------------------------------------------------------------
-- CollagenUP CGN (sku already correct CGN-01033)
UPDATE products SET
  rating = 4.7,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01033/g/255.jpg'
WHERE name LIKE '膠原蛋白肽 CollagenUP%' AND store = 'iHerb';

-- CoQ10 NOW (fix sku: NOW-03153 → NOW-03144)
UPDATE products SET
  sku = 'NOW-03144',
  rating = 4.8,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now03144/g/38.jpg'
WHERE name LIKE 'CoQ10 Ubiquinol%' AND store = 'iHerb';

-- B-50 NOW (fix sku: NOW-00426 → NOW-00420)
UPDATE products SET
  sku = 'NOW-00420',
  rating = 4.7,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00420/g/74.jpg'
WHERE name LIKE 'B群 B-50%' AND store = 'iHerb';

-- 豌豆蛋白 NOW (fix sku: NOW-02136 → NOW-02135)
UPDATE products SET
  sku = 'NOW-02135',
  rating = 4.4,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now02135/g/41.jpg'
WHERE name LIKE '豌豆蛋白 Pea Protein%' AND store = 'iHerb';

-- 甘胺酸粉 NOW (fix sku: NOW-00228 → NOW-00225)
UPDATE products SET
  sku = 'NOW-00225',
  rating = 4.8,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00225/g/32.jpg'
WHERE name LIKE '甘胺酸 Glycine%' AND store = 'iHerb';

-- 蘇糖酸鎂 NOW (fix sku: NOW-01295 → NOW-02390)
UPDATE products SET
  sku = 'NOW-02390',
  rating = 4.8,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now02390/g/50.jpg'
WHERE name LIKE '蘇糖酸鎂 Magtein%' AND store = 'iHerb';

-- Ashwagandha NOW
UPDATE products SET
  rating = 4.7,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now04603/g/83.jpg'
WHERE name LIKE 'Ashwagandha KSM-66%' AND store = 'iHerb';

-- 電解質粉 CGN (fix sku: CGN-01964 → CGN-01402)
UPDATE products SET
  sku = 'CGN-01402',
  rating = 4.5,
  image_url = 'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01402/g/75.jpg'
WHERE name LIKE '電解質粉 Sport Hydration%' AND store = 'iHerb';

------------------------------------------------------------
-- 4. Fix ingredient prefix warnings (scraped has "成分:" prefix)
------------------------------------------------------------
-- #3 維他命C: DB lacks "成分:" prefix but content is same → align with scraped
-- #6 綠花椰菜: DB="青花菜" vs scraped="青花菜。" → add period
-- #13 泡菜: DB lacks "成份:" prefix → content is same
-- #17 燕麥: DB="有機燕麥(澳洲)" vs scraped="有機燕麥(澳洲)。" → add period
-- These are cosmetic; update specs.ingredients to match scraped source exactly

UPDATE products SET specs = jsonb_set(specs, '{ingredients}',
  to_jsonb('青花菜。'::text))
WHERE name LIKE '冷凍綠花椰菜%' AND store = 'Costco';

UPDATE products SET specs = jsonb_set(specs, '{ingredients}',
  to_jsonb('有機燕麥(澳洲)。'::text))
WHERE name LIKE '有機燕麥%' AND store = 'Costco';

------------------------------------------------------------
-- 5. Fix brand warnings
------------------------------------------------------------
-- #21 Tryall: DB="Tryall" vs scraped="TRYALL" → use scraped
UPDATE products SET brand = 'TRYALL'
WHERE name LIKE 'Tryall%' AND store = 'Costco';
