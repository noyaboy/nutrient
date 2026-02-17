import { supabase } from '@/lib/supabase';
import { Product } from '@/lib/types';
import ShoppingPageClient from '@/components/ShoppingPageClient';

export const dynamic = 'force-dynamic';

export default async function ShoppingPage() {
  const { data: products } = await supabase
    .from('products')
    .select('*')
    .eq('is_active', true)
    .order('sort_order');

  const items = (products || []) as Product[];

  const costcoSupplements = items.filter(p => p.category === 'costco_supplement');
  const costcoFoods = items.filter(p => p.category === 'costco_food');
  const iherbSupplements = items.filter(p => p.category === 'iherb_supplement');
  const equipment = items.filter(p => p.category === 'equipment');

  return (
    <ShoppingPageClient
      costcoSupplements={costcoSupplements}
      costcoFoods={costcoFoods}
      iherbSupplements={iherbSupplements}
      equipment={equipment}
    />
  );
}
