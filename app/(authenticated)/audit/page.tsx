export const dynamic = 'force-dynamic';

import { supabase } from '@/lib/supabase';
import { runAuditChecks, calculateDailyNutrients, extractTimeline } from '@/lib/audit-logic';
import type { PlanItem, Product } from '@/lib/types';
import AuditPageClient from '@/components/AuditPageClient';

export default async function AuditPage() {
  const [{ data: planItems }, { data: products }] = await Promise.all([
    supabase.from('plan_items').select('*'),
    supabase.from('products').select('*'),
  ]);

  const items = (planItems || []) as PlanItem[];
  const prods = (products || []) as Product[];

  const nutrients = calculateDailyNutrients(items);
  const timeline = extractTimeline(items);
  const issues = runAuditChecks(items, prods);

  return (
    <AuditPageClient
      nutrients={nutrients}
      timeline={timeline}
      issues={issues}
    />
  );
}
