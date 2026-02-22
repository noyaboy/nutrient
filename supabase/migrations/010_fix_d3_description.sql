-- 修正 D3 產品描述：配合鈣片從 2-3 錠改為 1 錠後的總量計算
UPDATE products SET
  description = '鈣+D3+K2 複合錠每錠含 150 IU D3（每日 1 錠 = 150 IU），額外補充 5000 IU，每日總計約 5,150 IU。超過 IOM UL（4000 IU）但低於內分泌學會安全上限（10,000 IU）。目標血清 40-60 ng/mL。360 顆大包裝更划算（-32%/顆）'
WHERE name = '維他命 D3 5000IU（Doctor''s Best 360 顆）';
