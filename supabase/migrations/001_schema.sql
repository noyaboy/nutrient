------------------------------------------------------------
-- Schema: plan_items + completions + products
------------------------------------------------------------

CREATE TABLE plan_items (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  title         TEXT NOT NULL,
  description   TEXT DEFAULT '',
  frequency     TEXT NOT NULL CHECK (frequency IN ('daily', 'weekly')),
  category      TEXT DEFAULT '一般',
  sort_order    INTEGER DEFAULT 0,
  is_active     BOOLEAN DEFAULT TRUE,
  target_count  INTEGER DEFAULT 1,
  created_at    TIMESTAMPTZ DEFAULT now(),
  updated_at    TIMESTAMPTZ DEFAULT now()
);

CREATE TABLE completions (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  plan_item_id  UUID NOT NULL REFERENCES plan_items(id) ON DELETE CASCADE,
  target_date   DATE NOT NULL,
  notes         TEXT DEFAULT '',
  completed_at  TIMESTAMPTZ DEFAULT now(),
  created_at    TIMESTAMPTZ DEFAULT now(),
  UNIQUE (plan_item_id, target_date)
);

CREATE INDEX idx_completions_target_date ON completions(target_date);
CREATE INDEX idx_completions_plan_item ON completions(plan_item_id);
CREATE INDEX idx_plan_items_frequency ON plan_items(frequency) WHERE is_active = TRUE;

CREATE TABLE products (
  id            UUID PRIMARY KEY DEFAULT gen_random_uuid(),
  name          TEXT NOT NULL,
  description   TEXT NOT NULL DEFAULT '',
  usage         TEXT NOT NULL DEFAULT '',
  price         TEXT NOT NULL DEFAULT '',
  url           TEXT NOT NULL DEFAULT '',
  store         TEXT NOT NULL,
  category      TEXT NOT NULL,
  brand         TEXT,
  image_url     TEXT,
  rating        NUMERIC(2,1),
  review_count  INTEGER,
  sku           TEXT,
  origin        TEXT,
  specs         JSONB DEFAULT '{}',
  nutrition     JSONB DEFAULT '{}',
  purchase_note TEXT DEFAULT '',
  sort_order    INTEGER DEFAULT 0,
  is_active     BOOLEAN DEFAULT TRUE,
  created_at    TIMESTAMPTZ DEFAULT now(),
  updated_at    TIMESTAMPTZ DEFAULT now()
);

CREATE INDEX idx_products_category ON products(category);
CREATE INDEX idx_products_store ON products(store);
CREATE INDEX idx_products_is_active ON products(is_active);
