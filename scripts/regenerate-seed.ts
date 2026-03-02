import { createClient } from '@supabase/supabase-js';
import { writeFileSync } from 'fs';
import { join } from 'path';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

function escapeSQL(str: string): string {
  return str.replace(/'/g, "''");
}

function formatValue(val: unknown): string {
  if (val === null || val === undefined) return 'NULL';
  if (typeof val === 'boolean') return val ? 'true' : 'false';
  if (typeof val === 'number') return String(val);
  if (typeof val === 'object') {
    const json = JSON.stringify(val);
    return json === '{}' ? "'{}'" : `'${escapeSQL(json)}'`;
  }
  return `'${escapeSQL(String(val))}'`;
}

interface PlanItemRow {
  title: string;
  description: string;
  frequency: string;
  category: string;
  sort_order: number;
  target_count: number | null;
  is_active: boolean;
}

interface ProductRow {
  name: string;
  description: string;
  usage: string;
  price: string;
  url: string;
  store: string;
  category: string;
  brand: string | null;
  image_url: string | null;
  rating: number | null;
  review_count: number | null;
  sku: string | null;
  origin: string | null;
  specs: Record<string, unknown>;
  nutrition: Record<string, unknown>;
  sort_order: number;
  is_active: boolean;
  purchase_note: string;
}

function classifyPlanTime(title: string): string {
  const match = title.match(/^(\d{2}):/);
  if (!match) {
    if (title.startsWith('全天') || title.startsWith('訓練日')) return 'Daily Tracking';
    return 'Other';
  }
  const hour = parseInt(match[1]);
  if (hour < 12) return 'Morning (< 12:00)';
  if (hour < 15) return 'Midday (12:00-15:00)';
  if (hour < 19) return 'Afternoon (15:00-18:59)';
  return 'Evening (19:00+)';
}

async function main() {
  console.log('🔄 Fetching data from Supabase...');

  const [{ data: planItems, error: e1 }, { data: products, error: e2 }] = await Promise.all([
    supabase.from('plan_items').select('title, description, frequency, category, sort_order, target_count, is_active').order('sort_order'),
    supabase.from('products').select('name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, origin, specs, nutrition, sort_order, is_active, purchase_note').order('sort_order'),
  ]);

  if (e1 || e2 || !planItems || !products) {
    console.error('❌ Failed to fetch data:', e1?.message || e2?.message);
    process.exit(1);
  }

  const activePI = planItems.filter((i: PlanItemRow) => i.is_active).length;
  const inactivePI = planItems.filter((i: PlanItemRow) => !i.is_active).length;
  const activeProd = products.filter((p: ProductRow) => p.is_active).length;
  const inactiveProd = products.filter((p: ProductRow) => !p.is_active).length;

  let sql = '';

  // Plan items header
  sql += `------------------------------------------------------------\n`;
  sql += `-- 每日計畫項目 (${activePI} active + ${inactivePI} inactive = ${planItems.length} items)\n`;
  sql += `-- Matches live DB state as of ${new Date().toISOString().slice(0, 10)}\n`;
  sql += `------------------------------------------------------------\n\n`;
  sql += `INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES\n`;

  // Group plan items by time section
  const piGroups = new Map<string, PlanItemRow[]>();
  for (const item of planItems as PlanItemRow[]) {
    const section = classifyPlanTime(item.title);
    if (!piGroups.has(section)) piGroups.set(section, []);
    piGroups.get(section)!.push(item);
  }

  const sectionOrder = ['Morning (< 12:00)', 'Midday (12:00-15:00)', 'Afternoon (15:00-18:59)', 'Evening (19:00+)', 'Daily Tracking', 'Other'];
  const piLines: string[] = [];

  for (const section of sectionOrder) {
    const items = piGroups.get(section);
    if (!items || items.length === 0) continue;
    piLines.push(`  -- === ${section} ===`);
    for (const item of items) {
      const vals = [
        formatValue(item.title),
        formatValue(item.description),
        formatValue(item.frequency),
        formatValue(item.category),
        String(item.sort_order),
        item.target_count === null ? 'NULL' : String(item.target_count),
        String(item.is_active),
      ].join(', ');
      piLines.push(`  (${vals})`);
    }
  }

  sql += piLines.join(',\n') + ';\n\n';

  // Products header
  sql += `------------------------------------------------------------\n`;
  sql += `-- 產品清單 (${activeProd} active + ${inactiveProd} inactive = ${products.length} items)\n`;
  sql += `------------------------------------------------------------\n\n`;
  sql += `INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, origin, specs, nutrition, sort_order, is_active, purchase_note) VALUES\n`;

  // Group products by category
  const prodGroups = new Map<string, ProductRow[]>();
  for (const p of products as ProductRow[]) {
    if (!prodGroups.has(p.category)) prodGroups.set(p.category, []);
    prodGroups.get(p.category)!.push(p);
  }

  const prodLines: string[] = [];
  for (const [cat, prods] of prodGroups) {
    prodLines.push(`  -- === ${cat} ===`);
    for (const p of prods) {
      const vals = [
        formatValue(p.name), formatValue(p.description), formatValue(p.usage),
        formatValue(p.price), formatValue(p.url), formatValue(p.store),
        formatValue(p.category), formatValue(p.brand), formatValue(p.image_url),
        formatValue(p.rating), formatValue(p.review_count), formatValue(p.sku),
        formatValue(p.origin), formatValue(p.specs), formatValue(p.nutrition),
        String(p.sort_order), String(p.is_active), formatValue(p.purchase_note),
      ].join(', ');
      prodLines.push(`  (${vals})`);
    }
  }

  sql += prodLines.join(',\n') + ';\n';

  const outPath = join(__dirname, '..', 'supabase', 'migrations', '002_seed_data.sql');
  writeFileSync(outPath, sql, 'utf-8');
  console.log(`✅ Wrote ${outPath}`);
  console.log(`   Plan items: ${planItems.length} (${activePI} active)`);
  console.log(`   Products: ${products.length} (${activeProd} active)`);
}

main().catch(err => {
  console.error('❌ Unexpected error:', err);
  process.exit(1);
});
