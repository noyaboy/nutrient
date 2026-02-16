import { supabase } from '@/lib/supabase';
import { getToday, getMondayOfWeek, getSundayOfWeek, getWeekDates, getWeeklyTargetCount, formatDateChinese } from '@/lib/utils';
import { UI } from '@/lib/constants';
import type { PlanItemWithCompletion, WeeklyItemWithCompletions, Completion } from '@/lib/types';
import DailySection from '@/components/DailySection';
import WeeklyTaskItem from '@/components/WeeklyTaskItem';
import ProgressBar from '@/components/ProgressBar';
import Link from 'next/link';

export const dynamic = 'force-dynamic';

export default async function DashboardPage() {
  const today = getToday();
  const monday = getMondayOfWeek(today);
  const sunday = getSundayOfWeek(monday);
  const weekDates = getWeekDates(monday);

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
      .gte('target_date', monday)
      .lte('target_date', sunday),
  ]);

  const dailyItems: PlanItemWithCompletion[] = (planItems || [])
    .filter(item => item.frequency === 'daily')
    .map(item => ({
      ...item,
      completion: (dailyCompletions || []).find(c => c.plan_item_id === item.id) || null,
    }));

  // Group weekly completions by plan_item_id
  const weeklyCompletionsByItem = new Map<string, Completion[]>();
  for (const c of (weeklyCompletions || [])) {
    const list = weeklyCompletionsByItem.get(c.plan_item_id) || [];
    list.push(c);
    weeklyCompletionsByItem.set(c.plan_item_id, list);
  }

  const weeklyItems: WeeklyItemWithCompletions[] = (planItems || [])
    .filter(item => item.frequency === 'weekly')
    .map(item => ({
      ...item,
      completions: weeklyCompletionsByItem.get(item.id) || [],
      targetCount: item.target_count ?? getWeeklyTargetCount(item.title),
    }));

  const dailyCompleted = dailyItems.filter(i => i.completion).length;
  const trackableWeeklyItems = weeklyItems.filter(i => i.targetCount > 0);
  const weeklyCompleted = trackableWeeklyItems.filter(i => i.completions.length >= i.targetCount).length;

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
              <DailySection items={dailyItems} targetDate={today} />
            </section>
          )}

          {weeklyItems.length > 0 && (
            <section className="space-y-3">
              <ProgressBar completed={weeklyCompleted} total={trackableWeeklyItems.length} label={UI.dashboard.weeklyTitle} />
              <div className="space-y-2">
                {weeklyItems.map(item => (
                  <WeeklyTaskItem key={item.id} item={item} weekDates={weekDates} today={today} />
                ))}
              </div>
            </section>
          )}
        </>
      )}
    </div>
  );
}
