import { supabase } from '@/lib/supabase';
import { getToday, getMondayOfWeek, getSundayOfWeek, getWeekDates, getWeeklyTargetCount, getCategoryColor } from '@/lib/utils';
import type { Completion } from '@/lib/types';
import WeekSelector from '@/components/WeekSelector';

export const dynamic = 'force-dynamic';

const DAY_LABELS = ['一', '二', '三', '四', '五', '六', '日'];

interface Props {
  searchParams: Promise<{ week?: string }>;
}

export default async function HistoryPage({ searchParams }: Props) {
  const params = await searchParams;
  const today = getToday();
  const currentMonday = getMondayOfWeek(today);

  // Use provided week or default to current week
  const monday = params.week && /^\d{4}-\d{2}-\d{2}$/.test(params.week)
    ? params.week
    : currentMonday;
  const sunday = getSundayOfWeek(monday);
  const weekDates = getWeekDates(monday);
  const isCurrentWeek = monday === currentMonday;

  // Fetch plan items and all completions for this week
  const [{ data: planItems }, { data: completions }] = await Promise.all([
    supabase
      .from('plan_items')
      .select('*')
      .eq('is_active', true)
      .order('sort_order', { ascending: true }),
    supabase
      .from('completions')
      .select('*')
      .gte('target_date', monday)
      .lte('target_date', sunday),
  ]);

  const items = planItems || [];
  const allCompletions = completions || [];
  const dailyItems = items.filter(i => i.frequency === 'daily');
  const weeklyItems = items.filter(i => i.frequency === 'weekly');
  const dailyCount = dailyItems.length;

  // Group completions by date for daily stats
  const completionsByDate = new Map<string, Set<string>>();
  for (const c of allCompletions) {
    const item = items.find(i => i.id === c.plan_item_id);
    if (item?.frequency === 'daily') {
      const set = completionsByDate.get(c.target_date) || new Set();
      set.add(c.plan_item_id);
      completionsByDate.set(c.target_date, set);
    }
  }

  // Weekly goal completions
  const weeklyCompletionsByItem = new Map<string, Completion[]>();
  for (const c of allCompletions) {
    const item = items.find(i => i.id === c.plan_item_id);
    if (item?.frequency === 'weekly') {
      const list = weeklyCompletionsByItem.get(c.plan_item_id) || [];
      list.push(c);
      weeklyCompletionsByItem.set(c.plan_item_id, list);
    }
  }

  // Calculate averages
  const activeDays = weekDates.filter(d => d <= today);
  const dailyRates = activeDays.map(d => {
    const done = completionsByDate.get(d)?.size || 0;
    return dailyCount > 0 ? done / dailyCount : 0;
  });
  const avgDailyRate = dailyRates.length > 0
    ? Math.round((dailyRates.reduce((a, b) => a + b, 0) / dailyRates.length) * 100)
    : 0;

  const weeklyGoalsMet = weeklyItems.filter(item => {
    const comps = weeklyCompletionsByItem.get(item.id) || [];
    return comps.length >= getWeeklyTargetCount(item.title);
  }).length;

  return (
    <div className="space-y-5">
      <h1 className="text-xl font-bold text-gray-900">歷史紀錄</h1>

      <WeekSelector monday={monday} sunday={sunday} isCurrentWeek={isCurrentWeek} />

      {/* Weekly Summary */}
      <div className="grid grid-cols-2 gap-3">
        <div className="bg-white rounded-xl border border-gray-200 p-4 text-center">
          <p className="text-3xl font-bold text-emerald-600">{avgDailyRate}%</p>
          <p className="text-xs text-gray-500 mt-1">每日平均完成率</p>
        </div>
        <div className="bg-white rounded-xl border border-gray-200 p-4 text-center">
          <p className="text-3xl font-bold text-emerald-600">{weeklyGoalsMet}/{weeklyItems.length}</p>
          <p className="text-xs text-gray-500 mt-1">每週目標達成</p>
        </div>
      </div>

      {/* Daily Breakdown */}
      <section className="space-y-2">
        <h2 className="text-base font-bold text-gray-900">每日完成率</h2>
        <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
          {weekDates.map((date, i) => {
            const done = completionsByDate.get(date)?.size || 0;
            const rate = dailyCount > 0 ? Math.round((done / dailyCount) * 100) : 0;
            const isFuture = date > today;
            const isToday = date === today;
            const d = new Date(date + 'T00:00:00');
            const dateLabel = `${d.getMonth() + 1}/${d.getDate()}`;

            return (
              <div
                key={date}
                className={`flex items-center px-4 py-3 gap-3 ${
                  i !== 6 ? 'border-b border-gray-100' : ''
                } ${isFuture ? 'opacity-40' : ''}`}
              >
                <span className={`text-sm font-medium w-6 text-center ${isToday ? 'text-emerald-700' : 'text-gray-500'}`}>
                  {DAY_LABELS[i]}
                </span>
                <span className="text-xs text-gray-400 w-10">{dateLabel}</span>
                <div className="flex-1 h-2.5 bg-gray-100 rounded-full overflow-hidden">
                  <div
                    className={`h-full rounded-full transition-all ${
                      rate >= 80 ? 'bg-emerald-500' : rate >= 50 ? 'bg-yellow-400' : rate > 0 ? 'bg-orange-400' : ''
                    }`}
                    style={{ width: `${rate}%` }}
                  />
                </div>
                <span className={`text-sm font-medium w-16 text-right ${
                  isFuture ? 'text-gray-300' : rate >= 80 ? 'text-emerald-600' : 'text-gray-500'
                }`}>
                  {isFuture ? '—' : `${done}/${dailyCount}`}
                </span>
              </div>
            );
          })}
        </div>
      </section>

      {/* Weekly Goals */}
      {weeklyItems.length > 0 && (
        <section className="space-y-2">
          <h2 className="text-base font-bold text-gray-900">每週目標</h2>
          <div className="space-y-2">
            {weeklyItems.map(item => {
              const comps = weeklyCompletionsByItem.get(item.id) || [];
              const completedDates = new Set(comps.map(c => c.target_date));
              const targetCount = getWeeklyTargetCount(item.title);
              const isGoalMet = completedDates.size >= targetCount;

              return (
                <div
                  key={item.id}
                  className={`p-4 rounded-xl ${
                    isGoalMet
                      ? 'bg-emerald-50 border border-emerald-200'
                      : 'bg-white border border-gray-200'
                  }`}
                >
                  <div className="flex items-start justify-between gap-2 mb-3">
                    <p className={`text-sm font-medium flex-1 ${isGoalMet ? 'text-gray-400' : 'text-gray-900'}`}>
                      {item.title}
                    </p>
                    <div className="flex items-center gap-2 flex-shrink-0">
                      <span className={`text-sm font-bold ${isGoalMet ? 'text-emerald-600' : 'text-gray-400'}`}>
                        {completedDates.size}/{targetCount}
                      </span>
                      <span className={`text-xs px-2 py-0.5 rounded-full ${getCategoryColor(item.category)}`}>
                        {item.category}
                      </span>
                    </div>
                  </div>
                  <div className="flex items-center gap-1">
                    {weekDates.map((date, i) => {
                      const isDone = completedDates.has(date);
                      const isFuture = date > today;
                      return (
                        <div key={date} className="flex flex-col items-center gap-1 flex-1">
                          <span className={`text-xs ${isFuture ? 'text-gray-300' : 'text-gray-400'}`}>
                            {DAY_LABELS[i]}
                          </span>
                          <div
                            className={`w-5 h-5 rounded-full flex items-center justify-center ${
                              isDone
                                ? 'bg-emerald-500'
                                : isFuture
                                  ? 'bg-gray-50 border border-gray-200'
                                  : 'bg-gray-100 border border-gray-200'
                            }`}
                          >
                            {isDone && (
                              <svg className="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                                <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                              </svg>
                            )}
                          </div>
                        </div>
                      );
                    })}
                  </div>
                </div>
              );
            })}
          </div>
        </section>
      )}
    </div>
  );
}
