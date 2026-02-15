import { supabase } from '@/lib/supabase';
import { getToday, getMondayOfWeek, formatDateChinese } from '@/lib/utils';
import { UI } from '@/lib/constants';
import type { PlanItemWithCompletion } from '@/lib/types';
import TaskItem from '@/components/TaskItem';
import ProgressBar from '@/components/ProgressBar';
import Link from 'next/link';

export const dynamic = 'force-dynamic';

export default async function DashboardPage() {
  const today = getToday();
  const monday = getMondayOfWeek(today);

  const [{ data: planItems }, { data: dailyCompletions }, { data: weeklyCompletions }] = await Promise.all([
    supabase
      .from('plan_items')
      .select('*')
      .eq('is_active', true)
      .order('sort_order', { ascending: true }),
    supabase
      .from('completions')
      .select('*')
      .eq('target_date', today),
    supabase
      .from('completions')
      .select('*')
      .eq('target_date', monday),
  ]);

  const dailyItems: PlanItemWithCompletion[] = (planItems || [])
    .filter(item => item.frequency === 'daily')
    .map(item => ({
      ...item,
      completion: (dailyCompletions || []).find(c => c.plan_item_id === item.id) || null,
    }));

  const weeklyItems: PlanItemWithCompletion[] = (planItems || [])
    .filter(item => item.frequency === 'weekly')
    .map(item => ({
      ...item,
      completion: (weeklyCompletions || []).find(c => c.plan_item_id === item.id) || null,
    }));

  const dailyCompleted = dailyItems.filter(i => i.completion).length;
  const weeklyCompleted = weeklyItems.filter(i => i.completion).length;

  return (
    <div className="space-y-6">
      <div className="text-center">
        <p className="text-gray-500 text-sm">{formatDateChinese(today)}</p>
      </div>

      {dailyItems.length === 0 && weeklyItems.length === 0 ? (
        <div className="text-center py-12">
          <p className="text-gray-500">{UI.dashboard.empty}</p>
          <Link
            href="/settings"
            className="inline-block mt-4 px-4 py-2 bg-emerald-600 text-white rounded-lg text-sm hover:bg-emerald-700 transition-colors"
          >
            {UI.dashboard.addFirst}
          </Link>
        </div>
      ) : (
        <>
          {dailyItems.length > 0 && (
            <section className="space-y-3">
              <ProgressBar completed={dailyCompleted} total={dailyItems.length} label={UI.dashboard.dailyTitle} />
              <div className="space-y-2">
                {dailyItems.map(item => (
                  <TaskItem key={item.id} item={item} targetDate={today} />
                ))}
              </div>
            </section>
          )}

          {weeklyItems.length > 0 && (
            <section className="space-y-3">
              <ProgressBar completed={weeklyCompleted} total={weeklyItems.length} label={UI.dashboard.weeklyTitle} />
              <div className="space-y-2">
                {weeklyItems.map(item => (
                  <TaskItem key={item.id} item={item} targetDate={monday} />
                ))}
              </div>
            </section>
          )}
        </>
      )}
    </div>
  );
}
