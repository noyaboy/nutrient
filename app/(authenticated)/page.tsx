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
                  <WeeklyTaskItem key={item.id} item={item} weekDates={weekDates} today={today} />
                ))}
              </div>
            </section>
          )}
        </>
      )}

      <HealthSection />

      <AllRecipesSection
        postWorkout={postWorkoutRecipes}
        lunch={lunchRecipes}
        dinner={dinnerRecipes}
      />
    </div>
  );
}

function Tag({ children, color = 'gray' }: { children: React.ReactNode; color?: string }) {
  const colors: Record<string, string> = {
    green: 'bg-emerald-100 text-emerald-700',
    blue: 'bg-blue-100 text-blue-700',
    amber: 'bg-amber-100 text-amber-700',
    gray: 'bg-gray-100 text-gray-700',
    red: 'bg-red-100 text-red-700',
  };
  return <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${colors[color]}`}>{children}</span>;
}

function ExerciseTable({ title, exercises }: { title: string; exercises: { name: string; sets: string; rest: string }[] }) {
  return (
    <div>
      <p className="text-xs font-semibold text-emerald-700 mb-2">{title}</p>
      <div className="space-y-1">
        {exercises.map((ex, i) => (
          <div key={i} className="flex items-center gap-2 text-xs">
            <span className="text-gray-400 w-4 flex-shrink-0">{i + 1}.</span>
            <span className="flex-1 text-gray-800 font-medium">{ex.name}</span>
            <span className="text-gray-500 flex-shrink-0">{ex.sets}</span>
            <span className="text-gray-400 flex-shrink-0 w-12 text-right">{ex.rest}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

function WorkoutTab() {
  const age = new Date().getFullYear() - 2002;
  const hrMax = 220 - age;
  const zone2Low = Math.round(hrMax * 0.6);
  const zone2High = Math.round(hrMax * 0.7);
  const vo2Low = Math.round(hrMax * 0.9);
  const vo2High = Math.round(hrMax * 0.95);

  return (
    <div className="space-y-4">
      <Section title="週計劃總覽">
        <div className="space-y-1 text-xs text-gray-700">
          {[
            { day: '週一', content: 'Upper A（力量）', tag: '肌力', color: 'green' },
            { day: '週二', content: 'Lower A（力量）+ Zone 2（晚）', tag: '肌力+有氧', color: 'green' },
            { day: '週三', content: 'Zone 2 有氧 60 分鐘', tag: '有氧', color: 'blue' },
            { day: '週四', content: 'Upper B（肌肥大）', tag: '肌力', color: 'green' },
            { day: '週五', content: 'Lower B（肌肥大）+ Zone 2（晚）', tag: '肌力+有氧', color: 'green' },
            { day: '週六', content: 'VO2 Max 訓練 4x4', tag: 'VO2 Max', color: 'red' },
            { day: '週日', content: '完全休息', tag: '休息', color: 'gray' },
          ].map(({ day, content, tag, color }) => (
            <div key={day} className="flex items-center gap-2 py-1.5 border-b border-gray-50 last:border-0">
              <span className="font-semibold text-gray-900 w-10">{day}</span>
              <span className="flex-1">{content}</span>
              <Tag color={color}>{tag}</Tag>
            </div>
          ))}
        </div>
        <p className="text-xs text-gray-400 mt-2">每週：肌力 4 次 · Zone 2 有氧 3 次 · VO2 Max 1 次 · 總訓練 ~7.5 小時</p>
        <p className="text-xs text-gray-400">若週三/週六訓練品質下降，可將週二或週五的 Zone 2 移至週日</p>
      </Section>

      <Section title="Upper A — 週一（力量重點）">
        <ExerciseTable
          title="~65 分鐘"
          exercises={[
            { name: '槓鈴臥推 Bench Press', sets: '4×5-8', rest: '3-4 min' },
            { name: '槓鈴划船 Bent-Over Row', sets: '4×6-8', rest: '3 min' },
            { name: '肩推 Overhead Press', sets: '3×6-10', rest: '2-3 min' },
            { name: '負重引體向上 Weighted Chin-Up', sets: '3×6-10', rest: '2-3 min' },
            { name: '斜板彎舉 Incline DB Curl', sets: '3×8-12', rest: '90 sec' },
            { name: '過頭三頭伸展 Overhead Tricep Extension', sets: '3×10-12', rest: '90 sec' },
            { name: '面拉 Face Pull', sets: '3×15-20', rest: '60 sec' },
          ]}
        />
      </Section>

      <Section title="Lower A — 週二（力量重點）">
        <ExerciseTable
          title="~60 分鐘"
          exercises={[
            { name: '槓鈴深蹲 Back Squat', sets: '4×5-8', rest: '3-4 min' },
            { name: '羅馬尼亞硬舉 Romanian Deadlift', sets: '3×8-10', rest: '2-3 min' },
            { name: '保加利亞分腿蹲 Bulgarian Split Squat', sets: '3×8-12', rest: '90 sec' },
            { name: '坐姿腿彎舉 Seated Leg Curl', sets: '3×10-12', rest: '90 sec' },
            { name: '站姿小腿推舉 Standing Calf Raise', sets: '4×10-15', rest: '60 sec' },
          ]}
        />
      </Section>

      <Section title="Upper B — 週四（肌肥大重點）">
        <ExerciseTable
          title="~65 分鐘"
          exercises={[
            { name: '上斜啞鈴臥推 Incline DB Press', sets: '3×8-12', rest: '2-3 min' },
            { name: '纜繩飛鳥 Cable Fly', sets: '3×12-15', rest: '90 sec' },
            { name: '胸靠划船 Chest-Supported Row', sets: '4×8-12', rest: '2 min' },
            { name: '滑輪下拉 Lat Pulldown', sets: '3×10-12', rest: '2 min' },
            { name: '側平舉 Lateral Raise', sets: '4×12-15', rest: '60 sec' },
            { name: '槓鈴彎舉 Barbell Curl', sets: '3×8-12', rest: '90 sec' },
            { name: '纜繩下壓 Cable Pushdown', sets: '3×10-15', rest: '90 sec' },
          ]}
        />
      </Section>

      <Section title="Lower B — 週五（肌肥大重點）">
        <ExerciseTable
          title="~60 分鐘"
          exercises={[
            { name: '腿推 Leg Press', sets: '4×8-12', rest: '2-3 min' },
            { name: '槓鈴臀推 Barbell Hip Thrust', sets: '3×8-12', rest: '2 min' },
            { name: '走路弓步 Walking Lunge', sets: '3×10-12', rest: '90 sec' },
            { name: '俯臥腿彎舉 Lying Leg Curl', sets: '3×10-12', rest: '90 sec' },
            { name: '坐姿小腿推舉 Seated Calf Raise', sets: '4×12-15', rest: '60 sec' },
          ]}
        />
      </Section>

      <Section title="有氧訓練">
        <div className="space-y-3">
          <div>
            <p className="text-xs font-semibold text-blue-700 mb-1">Zone 2 有氧（3次/週：週二晚、週三、週五晚）</p>
            <div className="text-xs text-gray-700 space-y-0.5">
              <p>時間：45-60 分鐘持續運動</p>
              <p>心率：最大心率 60-70%（約 {zone2Low}-{zone2High} bpm）</p>
              <p>方式：固定式腳踏車、飛輪或划船機（避免跑步以減少對肌肥大的干擾）</p>
              <p>強度：可以說話但無法唱歌，鼻呼吸為佳</p>
            </div>
          </div>
          <div>
            <p className="text-xs font-semibold text-red-700 mb-1">VO2 Max 訓練（1次/週：週六）</p>
            <div className="text-xs text-gray-700 space-y-0.5">
              <p>方式：Peter Attia 4×4 法 — 4 分鐘全力 + 4 分鐘恢復，重複 4 組</p>
              <p>心率：最大心率 90-95%（約 {vo2Low}-{vo2High} bpm）</p>
              <p>器材：衝刺飛輪、划船機或上坡跑</p>
              <p>總時間：含暖身和收操約 45 分鐘</p>
            </div>
          </div>
        </div>
      </Section>

      <Section title="漸進式超負荷策略">
        <div className="text-xs text-gray-700 space-y-2">
          <p className="font-semibold text-gray-900">雙重遞增法 Double Progression</p>
          <ol className="space-y-1 list-decimal list-inside">
            <li>以處方次數的下限開始（例如 8-12 次，從 8 次開始）</li>
            <li>每次訓練嘗試多做 1-2 次</li>
            <li>當所有組數都能完成上限次數（12 次），增加重量</li>
            <li>上肢 +2.5kg，下肢 +5kg，隔離動作 +1-2.5kg</li>
          </ol>
          <div className="mt-2 bg-gray-50 rounded-lg p-3">
            <p className="font-semibold text-gray-900 mb-1">RPE 進度（每個中週期）</p>
            <div className="space-y-0.5">
              <p>第 1 週：RPE 7（離力竭 2-3 次）</p>
              <p>第 2 週：RPE 7.5-8（離力竭 1-2 次）</p>
              <p>第 3 週：RPE 8-8.5</p>
              <p>第 4 週：RPE 8.5-9</p>
              <p>第 5 週：RPE 9-9.5（接近力竭）</p>
              <p>第 6 週：減量週 Deload</p>
            </div>
          </div>
        </div>
      </Section>

      <Section title="減量週 Deload（每 5-6 週）">
        <div className="text-xs text-gray-700 space-y-1">
          <p>訓練量：減至 MEV（約正常的 50%）</p>
          <p>負荷：使用第 1 週重量</p>
          <p>次數：每組約第 1 週次數的 50%</p>
          <p>努力程度：RPE 5-6（遠離力竭）</p>
          <p>有氧：Zone 2 縮短至 30 分鐘，跳過 VO2 Max</p>
        </div>
      </Section>
    </div>
  );
}

function AntiAgingTab() {
  return (
    <div className="space-y-4">
      <Section title="睡眠優化">
        <div className="text-xs text-gray-700 space-y-2">
          <p>目標 <span className="font-semibold">7.5-8.5 小時</span>實際睡眠（不只是躺在床上的時間）</p>
          <p>固定起床時間比固定就寢時間更重要（每天同一時間起床）</p>
          <p>就寢時間：理想 22:00-23:00 入睡</p>
          <p>最後正餐在睡前 2-3 小時完成（睡前小份優格不影響）</p>
          <div className="bg-indigo-50 rounded-lg p-3 mt-2">
            <p className="font-semibold text-indigo-800 mb-1">睡眠衛生</p>
            <ul className="space-y-0.5 text-indigo-700">
              <li>睡前 60 分鐘關閉螢幕（或戴防藍光眼鏡）</li>
              <li>室溫 18-19°C（涼爽環境增加深層睡眠和生長激素分泌）</li>
              <li>完全遮光（全遮光窗簾 + 遮蓋 LED 指示燈）</li>
              <li>下午 13:00 後不攝取咖啡因</li>
            </ul>
          </div>
        </div>
      </Section>

      <Section title="晨光與晝夜節律">
        <div className="text-xs text-gray-700 space-y-1">
          <p>起床後 30-60 分鐘內<span className="font-semibold">到戶外曝曬陽光</span>（不要隔著玻璃）</p>
          <p>晴天：5 分鐘 / 陰天：10 分鐘 / 多雲：20-30 分鐘</p>
          <p>觸發皮質醇覺醒反應，設定生物鐘</p>
          <p>下午 20-30 分鐘日曬（皮膚）可提升睪固酮</p>
        </div>
      </Section>

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
            <p>訓練後三溫暖是可以的（與冷水浴不同）</p>
          </div>
        </div>
      </Section>

      <Section title="壓力管理">
        <div className="text-xs text-gray-700 space-y-2">
          <div className="bg-purple-50 rounded-lg p-3">
            <p className="font-semibold text-purple-800 mb-1">生理嘆息法 Physiological Sigh</p>
            <p className="text-purple-700">鼻子快速吸氣兩次 → 嘴巴長呼氣。Stanford 研究證實這是最有效的即時壓力緩解工具。任何感到壓力時使用，只需 30 秒。</p>
          </div>
          <p>每日 5 分鐘循環嘆息呼吸練習（exhale-focused breathing）</p>
          <p>規律運動已能抵消壓力對端粒的影響</p>
        </div>
      </Section>

      <Section title="營養策略">
        <div className="text-xs text-gray-700 space-y-2">
          <p><span className="font-semibold">蛋白質目標：1.6-2.2g/kg（MPS 最大化區間）</span>，增肌期上限 2.7g/kg（~200g/天）。過高蛋白的飽足感可能增加達成熱量盈餘的難度</p>
          <p>採用溫和熱量盈餘（+200-300 kcal），避免極端增/減脂循環</p>
          <p>體脂維持在 10-18% 以減少慢性發炎</p>
          <p>蛋白質分配：每餐 30-50g，每日 3-4 餐</p>
          <div className="bg-amber-50 rounded-lg p-3 mt-2">
            <p className="font-semibold text-amber-800 mb-1">抗發炎食物（已在採購清單中）</p>
            <ul className="space-y-0.5 text-amber-700">
              <li>十字花科蔬菜（花椰菜）— Nrf2 活化</li>
              <li>鮭魚（EPA/DHA Omega-3）</li>
              <li>發酵食物（希臘優格、泡菜）— 腸道多樣性</li>
              <li>堅果 — 抗發炎脂肪和礦物質</li>
            </ul>
          </div>
        </div>
      </Section>

      <Section title="應避免的事項">
        <div className="text-xs text-gray-700 space-y-2">
          <div className="flex items-start gap-2">
            <span className="text-red-500 font-bold flex-shrink-0">1.</span>
            <div><span className="font-semibold">酒精</span> — Oxford 基因研究證實加速端粒縮短，每週 &gt;29 單位 = 額外老化 1-2 年。同時抑制蛋白質合成達 37%。</div>
          </div>
          <div className="flex items-start gap-2">
            <span className="text-red-500 font-bold flex-shrink-0">2.</span>
            <div><span className="font-semibold">超加工食品</span> — UPF 每增加 10% 攝取，生物年齡與實際年齡差距增加 2.4 個月。</div>
          </div>
          <div className="flex items-start gap-2">
            <span className="text-red-500 font-bold flex-shrink-0">3.</span>
            <div><span className="font-semibold">慢性睡眠不足</span>（&lt;6 小時）— 與胰島素阻抗、認知衰退、心血管疾病相關。</div>
          </div>
          <div className="flex items-start gap-2">
            <span className="text-red-500 font-bold flex-shrink-0">4.</span>
            <div><span className="font-semibold">塑膠容器加熱食物</span> — BPA 和鄰苯二甲酸酯是內分泌干擾物。使用玻璃或不鏽鋼容器。</div>
          </div>
        </div>
      </Section>

      <Section title="血液檢查（每 6 個月）">
        <div className="text-xs text-gray-700 space-y-2">
          <div>
            <p className="font-semibold text-gray-900 mb-1">核心指標</p>
            <div className="space-y-0.5">
              <p>ApoB（心血管風險 #1 指標）— 目標 &lt;80 mg/dL</p>
              <p>HbA1c（3個月平均血糖）— 目標 &lt;5.3%</p>
              <p>空腹胰島素 — 目標 &lt;7 uIU/mL</p>
              <p>hs-CRP（全身發炎指標）— 目標 &lt;1.0 mg/L</p>
              <p>Omega-3 指數 — 目標 &gt;8%</p>
              <p>維他命 D [25(OH)D] — 目標 40-60 ng/mL</p>
              <p>BUN / Creatinine — 腎功能基線（高蛋白 + 肌酸長期追蹤）</p>
              <p>ALT / AST — 肝功能基線</p>
            </div>
          </div>
          <div>
            <p className="font-semibold text-gray-900 mb-1">荷爾蒙指標（每年）</p>
            <div className="space-y-0.5">
              <p>Total &amp; Free Testosterone</p>
              <p>SHBG、Estradiol</p>
              <p>甲狀腺（TSH, Free T3, Free T4）</p>
              <p>IGF-1、DHEA-S</p>
            </div>
          </div>
          <div>
            <p className="font-semibold text-gray-900 mb-1">一次性基因檢測</p>
            <div className="space-y-0.5">
              <p>Lp(a) — 遺傳性心血管風險</p>
              <p>APOE 基因型 — 阿茲海默症風險</p>
            </div>
          </div>
        </div>
      </Section>

      <Section title="護膚基礎">
        <div className="text-xs text-gray-700 space-y-1">
          <p><span className="font-semibold">防曬</span>（SPF 30-50）每日早上 — #1 抗皮膚老化措施</p>
          <p><span className="font-semibold">溫和洗面乳</span>（CeraVe / Cetaphil）早晚各一次</p>
          <p><span className="font-semibold">保濕</span>（含玻尿酸或神經醯胺）洗臉後</p>
          <p><span className="font-semibold">A醇 Retinol</span>（0.25-0.5%，漸進到 1%）僅晚上，每週 2-3 次</p>
          <p><span className="font-semibold">維他命C精華</span>（10-20% L-ascorbic acid）早上防曬前</p>
        </div>
      </Section>
    </div>
  );
}

function SupplementsTab() {
  return (
    <div className="space-y-4">
      <Section title="最佳服用時間表">
        <div className="text-xs text-gray-700 space-y-3">
          <div>
            <p className="font-semibold text-amber-700 mb-1">07:00 起床</p>
            <p>晨光曝曬 10-20 分鐘（不戴太陽眼鏡）</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">07:05 補水</p>
            <p>500ml 室溫水 + 少許碘鹽 + 檸檬汁</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">07:15 訓練前</p>
            <p>香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）</p>
            <p className="text-gray-400">下肢大重量日（深蹲/硬舉）若腸胃不適，可提前至訓練前 60-90 分鐘進食或減量</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">08:30 咖啡</p>
            <p>咖啡因 200-300mg + L-Theanine 200mg（起床 60-90 分鐘後，13:00 前）</p>
            <p className="text-gray-400">偏好更平靜專注可調為 1:2 比例（如 100mg 咖啡因 + 200mg L-Theanine）</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">09:00 訓練後（含油脂的餐點）</p>
            <div className="space-y-0.5">
              <p>乳清蛋白 ~40g 粉（≈36g 蛋白）+ 肌酸 5g</p>
              <p>魚油 3 顆（2100mg EPA+DHA）</p>
              <p>維他命 D3 2000 IU</p>
              <p>鈣 + D3 + K2（1 錠）</p>
              <p>維他命 C 500-1000mg</p>
              <p>葉黃素 20mg</p>
            </div>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">13:00 午餐</p>
            <p>蛋白質 40-50g + 十字花科蔬菜</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">14:00 午後</p>
            <p>銅 2mg（與鋅間隔 4hr+）</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">18:00 晚餐</p>
            <p>鋅 25mg（與銅間隔 4hr+，隨餐服用避免噁心）</p>
          </div>
          <div>
            <p className="font-semibold text-amber-700 mb-1">21:00 睡前（搭配希臘優格）</p>
            <div className="space-y-0.5">
              <p>希臘優格 300g（~28g 蛋白）</p>
              <p>甘胺酸鎂 200mg</p>
            </div>
          </div>
        </div>
      </Section>

      <Section title="搭配原理">
        <div className="text-xs text-gray-700 space-y-2">
          <div className="flex items-start gap-2">
            <Tag color="green">D3 + K2</Tag>
            <span className="flex-1">D3 增加鈣吸收，K2 引導鈣至骨骼而非動脈</span>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="green">維他命 C + 魚油</Tag>
            <span className="flex-1">維他命 C 抗氧化保護 Omega-3 免受氧化降解</span>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="green">L-Theanine + 咖啡</Tag>
            <span className="flex-1">L-Theanine 緩衝咖啡因焦慮，達到平靜專注</span>
          </div>
        </div>
      </Section>

      <Section title="建議新增補充品">
        <div className="text-xs text-gray-700 space-y-2">
          <div className="flex items-start gap-2">
            <Tag color="green">高優先</Tag>
            <div>
              <p className="font-semibold">膠原蛋白肽 Collagen Peptides 10-15g/天</p>
              <p className="text-gray-500">搭配維他命 C 促進膠原蛋白合成。重訓者的關節/肌腱保護必備。2025 年 npj Aging 研究：6 個月降低生物年齡 1.4 歲。</p>
            </div>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="blue">中優先</Tag>
            <div>
              <p className="font-semibold">B 群複合維他命</p>
              <p className="text-gray-500">支持能量代謝、甲基化、同半胱氨酸控制。</p>
            </div>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="blue">中優先</Tag>
            <div>
              <p className="font-semibold">CoQ10 Ubiquinol 100-200mg/天</p>
              <p className="text-gray-500">粒線體能量產生、心臟保護。30 歲後更重要。</p>
            </div>
          </div>
        </div>
      </Section>
    </div>
  );
}

function HealthSection() {
  return (
    <div className="space-y-4">
      <div>
        <h2 className="text-lg font-bold text-gray-900">健康優化計劃</h2>
        <p className="text-xs text-gray-500 mt-0.5">{new Date().getFullYear() - 2002} 歲男性 · 182cm · 73kg · 重訓為主 · 兼顧長壽</p>
      </div>
      <WorkoutTab />
      <AntiAgingTab />
      <SupplementsTab />
    </div>
  );
}
