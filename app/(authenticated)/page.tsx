import { supabase } from '@/lib/supabase';
import { getToday, getMondayOfWeek, getSundayOfWeek, getWeekDates, getWeeklyTargetCount, formatDateChinese } from '@/lib/utils';
import { UI } from '@/lib/constants';
import type { PlanItemWithCompletion, WeeklyItemWithCompletions, Completion } from '@/lib/types';
import DailySection from '@/components/DailySection';
import WeeklyTaskItem from '@/components/WeeklyTaskItem';
import ProgressBar from '@/components/ProgressBar';
import AllRecipesSection from '@/components/AllRecipesSection';
import Link from 'next/link';
import { getTodayRecipes, postWorkoutRecipes, lunchRecipes, dinnerRecipes } from '@/lib/recipes';

export const dynamic = 'force-dynamic';

export default async function DashboardPage() {
  const today = getToday();
  const todayRecipes = getTodayRecipes(today);
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
              <DailySection items={dailyItems} targetDate={today} recipes={todayRecipes} />
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

      <Link
        href="/health"
        className="block p-4 bg-gradient-to-r from-emerald-50 to-blue-50 rounded-xl border border-emerald-200 hover:border-emerald-300 transition-colors"
      >
        <div className="flex items-center justify-between">
          <div>
            <p className="text-sm font-bold text-gray-900">健康優化計劃</p>
            <p className="text-xs text-gray-500 mt-0.5">訓練計劃 · 抗老化策略 · 補充品時間表</p>
          </div>
          <svg className="w-5 h-5 text-emerald-500 flex-shrink-0" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
          </svg>
        </div>
      </Link>

      <AllRecipesSection
        postWorkout={postWorkoutRecipes}
        lunch={lunchRecipes}
        dinner={dinnerRecipes}
      />
    </div>
  );
}
