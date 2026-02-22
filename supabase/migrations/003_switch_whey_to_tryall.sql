------------------------------------------------------------
-- 乳清蛋白：iHerb ON Gold Standard → Costco Tryall 分離乳清
------------------------------------------------------------

UPDATE products SET
  name = 'Tryall 無調味分離乳清蛋白 2kg',
  description = '台灣品牌，無調味無添加。分離乳清蛋白（WPI），約 90% 蛋白質含量，每份 25g 含 ~24g 蛋白、~120kcal。美國乳源，過濾大部分乳糖與脂肪，乳糖不耐者也適合',
  usage = '訓練前 1 份（~30g 粉 ≈ 24g 蛋白），訓練後 ~1.3 份（~40g 粉 ≈ 31g 蛋白）',
  price = '約 NT$1,899~2,199 / 2kg',
  url = 'https://www.costco.com.tw/Health-Beauty/Supplements/Sports-Performance/Tryall-Whey-Protein-Isolate-Unflavored-2-kg/p/155648',
  store = 'Costco',
  category = 'costco_supplement',
  brand = 'Tryall',
  image_url = NULL,
  rating = NULL,
  review_count = NULL,
  sku = '155648',
  origin = '台灣（品牌）/ 美國（乳源）',
  specs = '{"ingredients":"分離乳清蛋白（美國乳源）","form":"無調味粉末","weight":"2kg","features":"無添加糖、甜味劑、人工色素、香料"}'::jsonb,
  nutrition = '{"serving_size":"25g","calories":"~120kcal","protein":"~24g","fat":"~2g","carbs":"~4g","bcaa":"~4.7g","protein_pct":"約90%"}'::jsonb,
  purchase_note = 'Costco 線上可訂。每日 ~70g，2kg 約 28 天，每月補貨。無調味可搭配咖啡、黑芝麻粉等調味。從 iHerb 改為 Costco 購買，省去國際運費。',
  updated_at = now()
WHERE name LIKE '%Gold Standard%' OR name LIKE '%乳清蛋白%ON%';
