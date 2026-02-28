import { supabase } from '@/lib/supabase';
import { Product } from '@/lib/types';
import { extractTime, condenseDescription } from '@/lib/utils';
import ShoppingPageClient from '@/components/ShoppingPageClient';

export const dynamic = 'force-dynamic';

export default async function ShoppingPage() {
  const [{ data: products }, { data: planItems }] = await Promise.all([
    supabase
      .from('products')
      .select('*')
      .eq('is_active', true)
      .order('sort_order'),
    supabase
      .from('plan_items')
      .select('title, description')
      .eq('is_active', true)
      .eq('frequency', 'daily')
      .order('sort_order', { ascending: true }),
  ]);

  const items = (products || []) as Product[];

  const costcoSupplements = items.filter(p => p.category === 'costco_supplement');
  const costcoFoods = items.filter(p => p.category === 'costco_food');
  const iherbSupplements = items.filter(p => p.category === 'iherb_supplement');
  const personalCare = items.filter(p => p.category === 'personal_care');
  const equipment = items.filter(p => p.category === 'equipment');
  const convenienceDaily = items.filter(p => p.category === 'convenience_daily');

  const timingRows = (planItems || []).map(item => ({
    time: extractTime(item.title),
    items: condenseDescription(item.description),
  }));

  return (
    <ShoppingPageClient
      costcoSupplements={costcoSupplements}
      costcoFoods={costcoFoods}
      iherbSupplements={iherbSupplements}
      personalCare={personalCare}
      equipment={equipment}
      convenienceDaily={convenienceDaily}
      timingRows={timingRows}
    />
  );
}
