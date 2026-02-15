import { supabase } from '@/lib/supabase';
import { UI } from '@/lib/constants';
import type { PlanItem } from '@/lib/types';
import PlanItemList from '@/components/PlanItemList';

export const dynamic = 'force-dynamic';

export default async function SettingsPage() {
  const { data: planItems } = await supabase
    .from('plan_items')
    .select('*')
    .eq('is_active', true)
    .order('sort_order', { ascending: true });

  const dailyItems: PlanItem[] = (planItems || []).filter(item => item.frequency === 'daily');
  const weeklyItems: PlanItem[] = (planItems || []).filter(item => item.frequency === 'weekly');

  return (
    <div className="space-y-8">
      <h1 className="text-xl font-bold text-gray-900">{UI.settings.title}</h1>
      <PlanItemList items={dailyItems} frequency="daily" />
      <PlanItemList items={weeklyItems} frequency="weekly" />
    </div>
  );
}
