-- 計畫項目模板
CREATE TABLE plan_items (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title         TEXT NOT NULL,
  description   TEXT DEFAULT '',
  frequency     TEXT NOT NULL CHECK (frequency IN ('daily', 'weekly')),
  category      TEXT DEFAULT '一般',
  sort_order    INTEGER DEFAULT 0,
  is_active     BOOLEAN DEFAULT TRUE,
  created_at    TIMESTAMPTZ DEFAULT now(),
  updated_at    TIMESTAMPTZ DEFAULT now()
);

-- 完成紀錄
CREATE TABLE completions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_item_id  UUID NOT NULL REFERENCES plan_items(id) ON DELETE CASCADE,
  target_date   DATE NOT NULL,
  notes         TEXT DEFAULT '',
  completed_at  TIMESTAMPTZ DEFAULT now(),
  created_at    TIMESTAMPTZ DEFAULT now(),
  UNIQUE (plan_item_id, target_date)
);

-- 索引
CREATE INDEX idx_completions_target_date ON completions(target_date);
CREATE INDEX idx_completions_plan_item ON completions(plan_item_id);
CREATE INDEX idx_plan_items_frequency ON plan_items(frequency) WHERE is_active = TRUE;

-- 預設每日計畫項目
INSERT INTO plan_items (title, description, frequency, category, sort_order) VALUES
  ('冥想 15 分鐘', '正念冥想，專注呼吸', 'daily', '心理', 1),
  ('運動 30 分鐘', '有氧或力量訓練', 'daily', '運動', 2),
  ('喝水 2000ml', '分次補充水分', 'daily', '飲食', 3),
  ('服用補充品', '維生素D、魚油、鎂', 'daily', '補充品', 4),
  ('蔬果攝取 5 份', '多樣化蔬菜水果', 'daily', '飲食', 5),
  ('11 點前就寢', '維持規律作息', 'daily', '睡眠', 6),
  ('閱讀 30 分鐘', '持續學習成長', 'daily', '心理', 7),
  ('拉伸/瑜伽 10 分鐘', '維持身體柔軟度', 'daily', '運動', 8);

-- 預設每週計畫項目
INSERT INTO plan_items (title, description, frequency, category, sort_order) VALUES
  ('重訓 3 次', '漸進式超負荷訓練', 'weekly', '運動', 1),
  ('戶外日照 2 小時', '接觸自然陽光', 'weekly', '一般', 2),
  ('社交互動', '與朋友或家人聚會', 'weekly', '心理', 3),
  ('每週回顧', '回顧本週完成情況', 'weekly', '一般', 4),
  ('採買健康食材', '準備下週健康飲食', 'weekly', '飲食', 5);
