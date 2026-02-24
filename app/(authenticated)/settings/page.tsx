import { supabase } from '@/lib/supabase';
import { logout } from '@/app/actions/auth';
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

      <form action={logout} className="pt-4 border-t border-gray-200">
        <button
          type="submit"
          className="w-full py-3 text-sm text-gray-500 hover:text-red-600 transition-colors"
        >
          {UI.nav.logout}
        </button>
      </form>

      <p className="text-center text-[10px] text-gray-300 pt-2">
        Build: {process.env.NEXT_PUBLIC_BUILD_TIME?.slice(0, 16).replace('T', ' ')}
      </p>
    </div>
  );
}
