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
import { getHealthDetails } from '@/lib/health-details';
import { Section } from '@/components/HealthTabs';

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
                  <WeeklyTaskItem key={item.id} item={item} weekDates={weekDates} today={today} details={getHealthDetails(item.title)} />
                ))}
              </div>
            </section>
          )}
        </>
      )}

      <HealthNotes />

      <AllRecipesSection
        postWorkout={postWorkoutRecipes}
        lunch={lunchRecipes}
        dinner={dinnerRecipes}
      />
    </div>
  );
}

function HealthNotes() {
  return (
    <div className="space-y-4">
      <div>
        <h2 className="text-lg font-bold text-gray-900">健康備註</h2>
        <p className="text-xs text-gray-500 mt-0.5">無法對應到計畫項目的重要健康資訊</p>
      </div>

      <Section title="冷熱暴露">
        <div className="text-xs text-gray-700 space-y-3">
          <div>
            <p className="font-semibold text-blue-700 mb-1">冷水浴（2-4 次/週，休息日）</p>
            <p>10-15°C，1-5 分鐘</p>
            <p className="text-red-600 font-medium">重訓後 4-6 小時內禁止冷水浴（會抑制肌肥大信號）</p>
            <p>最佳時機：休息日早晨或訓練前</p>
          </div>
          <div>
            <p className="font-semibold text-red-700 mb-1">三溫暖（3-7 次/週）</p>
            <p>80-100°C，15-20 分鐘/次</p>
            <p>不會影響肌肥大，反而可能透過熱休克蛋白（HSP70/HSP90）增強肌肉保護</p>
          </div>
        </div>
      </Section>

      <Section title="壓力管理">
        <div className="text-xs text-gray-700 space-y-2">
          <div className="bg-purple-50 rounded-lg p-3">
            <p className="font-semibold text-purple-800 mb-1">生理嘆息法 Physiological Sigh</p>
            <p className="text-purple-700">鼻子快速吸氣兩次 → 嘴巴長呼氣。Stanford 研究證實最有效的即時壓力緩解工具，只需 30 秒。</p>
          </div>
          <p>每日 5 分鐘循環嘆息呼吸練習（exhale-focused breathing）</p>
        </div>
      </Section>

      <Section title="血液檢查（每 6 個月）→ 補劑調整">
        <div className="text-xs text-gray-700 space-y-2">
          <div>
            <p className="font-semibold text-gray-900 mb-1">核心指標</p>
            <div className="space-y-0.5">
              <p>ApoB — 目標 &lt;80 mg/dL</p>
              <p>HbA1c — 目標 &lt;5.3%</p>
              <p>空腹胰島素 — 目標 &lt;7 uIU/mL</p>
              <p>hs-CRP — 目標 &lt;1.0 mg/L</p>
              <p>Omega-3 指數 — 目標 &gt;8%</p>
              <p>維他命 D [25(OH)D] — 目標 40-60 ng/mL</p>
            </div>
          </div>
          <div className="bg-blue-50 rounded-lg p-3 space-y-1">
            <p className="font-semibold text-blue-800">D3 動態調整</p>
            <p className="text-blue-700">25(OH)D 達 40-60 ng/mL + 每日晨光曝曬 → D3 2000 IU 減半或改兩天一次</p>
          </div>
          <div className="bg-red-50 rounded-lg p-3 space-y-1">
            <p className="font-semibold text-red-800">代謝壓力監控</p>
            <p className="text-red-700">BUN / Creatinine（腎功能）· ALT / AST（肝功能）— 監控補充品與高蛋白飲食的代謝壓力</p>
            <p className="text-red-700 font-medium">一旦數值出現爬升趨勢 → 立刻全面停用非必要合成補劑</p>
          </div>
          <div>
            <p className="font-semibold text-gray-900 mb-1">荷爾蒙指標（每年）</p>
            <p>Testosterone · SHBG · Estradiol · 甲狀腺 · IGF-1 · DHEA-S</p>
          </div>
          <div>
            <p className="font-semibold text-gray-900 mb-1">一次性基因檢測</p>
            <p>Lp(a)（心血管風險）· APOE 基因型（阿茲海默症風險）</p>
          </div>
        </div>
      </Section>

      <Section title="護膚基礎">
        <div className="text-xs text-gray-700 space-y-1">
          <p><span className="font-semibold">防曬</span>（SPF 30-50）每日早上 — #1 抗皮膚老化措施</p>
          <p><span className="font-semibold">洗面乳</span>（CeraVe / Cetaphil）早晚 · <span className="font-semibold">保濕</span>（玻尿酸/神經醯胺）洗臉後</p>
          <p><span className="font-semibold">A醇</span>（0.25-1%）僅晚上 2-3 次/週 · <span className="font-semibold">Vit C 精華</span>（10-20%）早上防曬前</p>
        </div>
      </Section>

      <Section title="應避免的事項">
        <div className="text-xs text-gray-700 space-y-1">
          <p><span className="font-semibold text-red-600">酒精</span> — 加速端粒縮短，抑制蛋白質合成達 37%</p>
          <p><span className="font-semibold text-red-600">超加工食品</span> — UPF 每增加 10% 攝取，生物年齡差距增 2.4 個月</p>
          <p><span className="font-semibold text-red-600">塑膠容器加熱</span> — BPA/鄰苯二甲酸酯為內分泌干擾物，用玻璃或不鏽鋼</p>
        </div>
      </Section>

      <Section title="建議新增補充品">
        <div className="text-xs text-gray-700 space-y-2">
          <p><span className="font-semibold">膠原蛋白肽</span> 10-15g/天（搭配 Vit C，關節/肌腱保護）</p>
          <p><span className="font-semibold">B 群</span>（能量代謝、甲基化）</p>
          <p><span className="font-semibold">CoQ10 Ubiquinol</span> 100-200mg/天（粒線體能量、心臟保護）</p>
        </div>
      </Section>
    </div>
  );
}
