-- Queueless Campus Canteen database schema (PostgreSQL)

CREATE TABLE IF NOT EXISTS menu_items (
  id SERIAL PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  category VARCHAR(50) NOT NULL DEFAULT 'Other',
  price_paise INTEGER NOT NULL CHECK (price_paise > 0),
  is_available BOOLEAN NOT NULL DEFAULT TRUE,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS orders (
  id SERIAL PRIMARY KEY,
  token_no INTEGER UNIQUE,
  customer_name VARCHAR(100) NOT NULL,
  status VARCHAR(20) NOT NULL DEFAULT 'Placed'
    CHECK (status IN ('Placed', 'Preparing', 'Ready', 'Collected')),
  total_paise INTEGER NOT NULL DEFAULT 0 CHECK (total_paise >= 0),
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE TABLE IF NOT EXISTS order_items (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
  menu_item_id INTEGER NOT NULL REFERENCES menu_items(id),
  name_snapshot VARCHAR(100) NOT NULL,
  unit_price_paise INTEGER NOT NULL CHECK (unit_price_paise > 0),
  quantity INTEGER NOT NULL CHECK (quantity BETWEEN 1 AND 50)
);

CREATE INDEX IF NOT EXISTS idx_orders_created_at ON orders(created_at DESC);
CREATE INDEX IF NOT EXISTS idx_order_items_order_id ON order_items(order_id);

-- Starter menu. This inserts the sample dishes only when the table is empty.
INSERT INTO menu_items (name, category, price_paise)
SELECT seed.name, seed.category, seed.price_paise
FROM (VALUES
  ('Masala Dosa', 'Breakfast', 5000),
  ('Idli Sambar', 'Breakfast', 3500),
  ('Upma', 'Breakfast', 3000),
  ('Veg Thali', 'Meals', 9000),
  ('Veg Biryani', 'Meals', 8000),
  ('Chole Bhature', 'Meals', 6000),
  ('Fried Rice', 'Meals', 7000),
  ('Samosa', 'Snacks', 1500),
  ('Vada Pav', 'Snacks', 2000),
  ('Paneer Roll', 'Snacks', 5500),
  ('Veg Sandwich', 'Snacks', 4000),
  ('Masala Chai', 'Drinks', 1200),
  ('Filter Coffee', 'Drinks', 2000),
  ('Cold Coffee', 'Drinks', 4000),
  ('Lime Soda', 'Drinks', 2500)
) AS seed(name, category, price_paise)
WHERE NOT EXISTS (SELECT 1 FROM menu_items);
