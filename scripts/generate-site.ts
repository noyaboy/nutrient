import { createClient } from '@supabase/supabase-js';
import { runAuditChecks, calculateDailyNutrients, extractTimeline } from '../lib/audit-logic';
import type { PlanItem, Product, Completion, AuditIssue } from '../lib/types';
import { writeFileSync, readFileSync } from 'fs';
import { join } from 'path';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing env vars');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

// --- Helpers ---

function esc(s: string) {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

const TIMEZONE = 'Asia/Taipei';

function getToday(): string {
  return new Date().toLocaleDateString('sv-SE', { timeZone: TIMEZONE });
}

function getMondayOfWeek(dateStr: string): string {
  const date = new Date(dateStr + 'T00:00:00');
  const taipeiDate = new Date(date.toLocaleString('en-US', { timeZone: TIMEZONE }));
  const day = taipeiDate.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  taipeiDate.setDate(taipeiDate.getDate() + diff);
  return taipeiDate.toLocaleDateString('sv-SE');
}

function getSundayOfWeek(mondayStr: string): string {
  const date = new Date(mondayStr + 'T00:00:00');
  date.setDate(date.getDate() + 6);
  return date.toLocaleDateString('sv-SE');
}

function getWeekDates(mondayStr: string): string[] {
  const dates: string[] = [];
  for (let i = 0; i < 7; i++) {
    const d = new Date(mondayStr + 'T00:00:00');
    d.setDate(d.getDate() + i);
    dates.push(d.toLocaleDateString('sv-SE'));
  }
  return dates;
}

function formatDateChinese(dateStr: string): string {
  const date = new Date(dateStr + 'T00:00:00');
  return date.toLocaleDateString('zh-TW', {
    timeZone: TIMEZONE,
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long',
  });
}

const DAY_LABELS = ['一', '二', '三', '四', '五', '六', '日'];

function getWeeklyTargetCount(title: string, target_count?: number | null): number {
  if (target_count != null) return target_count;
  const targets: [string, number][] = [
    ['Zone 2', 3], ['肌力訓練', 4], ['VO2 Max', 1],
    ['學習新技能', 3], ['每週回顧', 1], ['健康檢測', 1],
  ];
  for (const [keyword, count] of targets) {
    if (title.includes(keyword)) return count;
  }
  return 1;
}

function getCategoryColor(category: string): string {
  const colors: Record<string, string> = {
    '運動': 'bg-green-100 text-green-800',
    '飲食': 'bg-orange-100 text-orange-800',
    '睡眠': 'bg-indigo-100 text-indigo-800',
    '心理': 'bg-purple-100 text-purple-800',
    '補充品': 'bg-yellow-100 text-yellow-800',
    '一般': 'bg-gray-100 text-gray-800',
  };
  return colors[category] || colors['一般'];
}

// --- Nutrient / audit helpers (reused from audit-html) ---

const NUTRIENT_LABELS: Record<string, string> = {
  protein: '蛋白質', calcium: '鈣', iron: '鐵', zinc: '鋅',
  magnesium: '鎂', fiber: '纖維', vitaminD: '維他命D', omega3: 'Omega-3',
};

function nutrientColor(ratio: number) {
  if (ratio >= 0.9) return { bg: 'bg-emerald-50', border: 'border-emerald-200', text: 'text-emerald-700', bar: 'bg-emerald-500' };
  if (ratio >= 0.7) return { bg: 'bg-amber-50', border: 'border-amber-200', text: 'text-amber-700', bar: 'bg-amber-500' };
  return { bg: 'bg-red-50', border: 'border-red-200', text: 'text-red-700', bar: 'bg-red-500' };
}

function severityClasses(severity: string) {
  switch (severity) {
    case 'CRITICAL': return { card: 'bg-red-50 border-red-200', badge: 'bg-red-500 text-white', text: 'text-red-800' };
    case 'HIGH': return { card: 'bg-amber-50 border-amber-200', badge: 'bg-amber-500 text-white', text: 'text-amber-800' };
    default: return { card: 'bg-sky-50 border-sky-200', badge: 'bg-sky-500 text-white', text: 'text-sky-700' };
  }
}

// --- Store tag colors ---
const STORE_COLORS: Record<string, string> = {
  Costco: 'bg-red-100 text-red-800',
  iHerb: 'bg-green-100 text-green-800',
  Amazon: 'bg-yellow-100 text-yellow-800',
  '7-Eleven': 'bg-blue-100 text-blue-800',
  '全家便利店': 'bg-purple-100 text-purple-800',
  '全聯': 'bg-indigo-100 text-indigo-800',
};

// --- SVG Icons ---
const homeIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"></path></svg>`;
const historyIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"></path></svg>`;
const shoppingIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z"></path></svg>`;
const auditIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z"></path></svg>`;
const settingsIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.324.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 011.37.49l1.296 2.247a1.125 1.125 0 01-.26 1.431l-1.003.827c-.293.24-.438.613-.431.992a6.759 6.759 0 010 .255c-.007.378.138.75.43.99l1.005.828c.424.35.534.954.26 1.43l-1.298 2.247a1.125 1.125 0 01-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.57 6.57 0 01-.22.128c-.331.183-.581.495-.644.869l-.213 1.28c-.09.543-.56.941-1.11.941h-2.594c-.55 0-1.02-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 01-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 01-1.369-.49l-1.297-2.247a1.125 1.125 0 01.26-1.431l1.004-.827c.292-.24.437-.613.43-.992a6.932 6.932 0 010-.255c.007-.378-.138-.75-.43-.99l-1.004-.828a1.125 1.125 0 01-.26-1.43l1.297-2.247a1.125 1.125 0 011.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.087.22-.128.332-.183.582-.495.644-.869l.214-1.281z"></path><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>`;
const checkIcon = `<svg class="w-2.5 h-2.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"></path></svg>`;
const checkIconSmall = `<svg class="w-3 h-3 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="3"><path stroke-linecap="round" stroke-linejoin="round" d="M5 13l4 4L19 7"></path></svg>`;
const externalLinkIcon = `<svg class="w-4 h-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2"><path stroke-linecap="round" stroke-linejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14"></path></svg>`;

// --- Time grouping (from DailySection) ---

interface TimeGroup { key: string; label: string; items: PlanItem[] }

function getTimeMinutes(title: string): number | null {
  const match = title.match(/^(\d{2}):(\d{2})/);
  if (!match) return null;
  return parseInt(match[1]) * 60 + parseInt(match[2]);
}

function groupDailyItems(items: PlanItem[]): TimeGroup[] {
  const groups: TimeGroup[] = [
    { key: 'morning', label: '早晨', items: [] },
    { key: 'midday', label: '中午', items: [] },
    { key: 'afternoon', label: '下午', items: [] },
    { key: 'evening', label: '晚間', items: [] },
    { key: 'allday', label: '全天', items: [] },
  ];
  for (const item of items) {
    const time = getTimeMinutes(item.title);
    if (time === null) groups[4].items.push(item);
    else if (time < 660) groups[0].items.push(item);
    else if (time < 900) groups[1].items.push(item);
    else if (time < 1140) groups[2].items.push(item);
    else groups[3].items.push(item);
  }
  return groups.filter(g => g.items.length > 0);
}

// --- Product category config ---
const PRODUCT_SECTIONS: { category: string; title: string }[] = [
  { category: 'costco_supplement', title: 'Costco 好市多 — 保健品' },
  { category: 'costco_food', title: 'Costco 好市多 — 食材' },
  { category: 'convenience_daily', title: '便利超商 — 日常必需' },
  { category: 'iherb_supplement', title: 'iHerb — 專業補充品' },
  { category: 'personal_care', title: '個人保養' },
  { category: 'equipment', title: '其他 — 設備' },
];

// ============================================================
// MAIN
// ============================================================

async function main() {
  const today = getToday();
  const monday = getMondayOfWeek(today);
  const sunday = getSundayOfWeek(monday);
  const weekDates = getWeekDates(monday);

  console.log(`📅 Today: ${today}, Week: ${monday} ~ ${sunday}`);

  // Fetch all data
  const [
    { data: allPlanItems },
    { data: allProducts },
    { data: dailyCompletions },
    { data: weeklyCompletions },
  ] = await Promise.all([
    supabase.from('plan_items').select('*').order('sort_order', { ascending: true }),
    supabase.from('products').select('*').order('sort_order', { ascending: true }),
    supabase.from('completions').select('*').eq('target_date', today),
    supabase.from('completions').select('*').gte('target_date', monday).lte('target_date', sunday),
  ]);

  const planItems = (allPlanItems || []) as PlanItem[];
  const products = (allProducts || []) as Product[];
  const todayCompletions = (dailyCompletions || []) as Completion[];
  const allWeekCompletions = (weeklyCompletions || []) as Completion[];

  const activeItems = planItems.filter(i => i.is_active);
  const dailyItems = activeItems.filter(i => i.frequency === 'daily');
  const weeklyItems = activeItems.filter(i => i.frequency === 'weekly');
  const activeProducts = products.filter(p => p.is_active);

  // Audit
  const nutrients = calculateDailyNutrients(planItems);
  const timeline = extractTimeline(planItems);
  const issues = runAuditChecks(planItems, products);

  // Completions
  const todayCompletionSet = new Set(todayCompletions.map(c => c.plan_item_id));

  // Weekly completions by item
  const weeklyCompletionsByItem = new Map<string, Completion[]>();
  for (const c of allWeekCompletions) {
    const list = weeklyCompletionsByItem.get(c.plan_item_id) || [];
    list.push(c);
    weeklyCompletionsByItem.set(c.plan_item_id, list);
  }

  // Daily completions by date (for history)
  const completionsByDate = new Map<string, Set<string>>();
  for (const c of allWeekCompletions) {
    const item = activeItems.find(i => i.id === c.plan_item_id);
    if (item?.frequency === 'daily') {
      const set = completionsByDate.get(c.target_date) || new Set();
      set.add(c.plan_item_id);
      completionsByDate.set(c.target_date, set);
    }
  }

  // History calculations
  const activeDays = weekDates.filter(d => d <= today);
  const dailyCount = dailyItems.length;
  const dailyRates = activeDays.map(d => {
    const done = completionsByDate.get(d)?.size || 0;
    return dailyCount > 0 ? done / dailyCount : 0;
  });
  const avgDailyRate = dailyRates.length > 0
    ? Math.round((dailyRates.reduce((a, b) => a + b, 0) / dailyRates.length) * 100)
    : 0;

  const trackableWeeklyItems = weeklyItems.filter(item => getWeeklyTargetCount(item.title, item.target_count) > 0);
  const weeklyGoalsMet = trackableWeeklyItems.filter(item => {
    const comps = weeklyCompletionsByItem.get(item.id) || [];
    return comps.length >= getWeeklyTargetCount(item.title, item.target_count);
  }).length;

  // Read the Tailwind CSS
  let css: string;
  const cssPath = join(__dirname, '..', '健康長壽追蹤器審計_files', '2ef3cff85cf82978.css');
  try {
    css = readFileSync(cssPath, 'utf-8');
    css = css.replace(/@font-face\{[^}]*\}/g, '');
  } catch {
    console.warn('⚠️  CSS file not found, using minimal fallback');
    css = '';
  }

  // ======================================
  // BUILD PAGES
  // ======================================

  // --- PAGE: HOME ---
  const dailyCompleted = dailyItems.filter(i => todayCompletionSet.has(i.id)).length;
  const weeklyCompleted = trackableWeeklyItems.filter(i => {
    const comps = weeklyCompletionsByItem.get(i.id) || [];
    return comps.length >= getWeeklyTargetCount(i.title, i.target_count);
  }).length;

  const groups = groupDailyItems(dailyItems);

  let homeHtml = `
    <div class="text-center">
      <p class="text-gray-500 text-sm">${esc(formatDateChinese(today))}</p>
    </div>

    <!-- Daily progress -->
    <div class="bg-white rounded-xl border border-gray-200 p-3">
      <div class="flex items-center justify-between mb-1.5">
        <span class="text-sm font-medium text-gray-700">每日項目</span>
        <span class="text-sm font-bold ${dailyCompleted === dailyItems.length ? 'text-emerald-600' : 'text-gray-500'}">${dailyCompleted}/${dailyItems.length}</span>
      </div>
      <div class="h-2 bg-gray-100 rounded-full overflow-hidden">
        <div class="h-full rounded-full bg-emerald-500 transition-all" style="width: ${dailyItems.length > 0 ? Math.round((dailyCompleted / dailyItems.length) * 100) : 0}%"></div>
      </div>
    </div>

    <!-- Weekly progress -->
    <div class="bg-white rounded-xl border border-gray-200 p-3">
      <div class="flex items-center justify-between mb-1.5">
        <span class="text-sm font-medium text-gray-700">每週目標</span>
        <span class="text-sm font-bold ${weeklyCompleted === trackableWeeklyItems.length ? 'text-emerald-600' : 'text-gray-500'}">${weeklyCompleted}/${trackableWeeklyItems.length}</span>
      </div>
      <div class="h-2 bg-gray-100 rounded-full overflow-hidden">
        <div class="h-full rounded-full bg-emerald-500 transition-all" style="width: ${trackableWeeklyItems.length > 0 ? Math.round((weeklyCompleted / trackableWeeklyItems.length) * 100) : 0}%"></div>
      </div>
    </div>`;

  // Time groups
  for (const group of groups) {
    const completed = group.items.filter(i => todayCompletionSet.has(i.id)).length;
    const total = group.items.length;
    const allDone = completed === total;

    homeHtml += `
    <div>
      <div class="flex items-center justify-between py-2 px-1">
        <span class="text-sm font-semibold text-gray-600">${group.label}</span>
        <span class="text-xs font-medium ${allDone ? 'text-emerald-600' : 'text-gray-400'}">${completed}/${total}</span>
      </div>`;

    if (group.key === 'allday') {
      homeHtml += `<div class="grid grid-cols-2 gap-2">`;
      for (const item of group.items) {
        const done = todayCompletionSet.has(item.id);
        const shortTitle = esc(item.title.replace(/^全天\s*/, ''));
        homeHtml += `
        <div class="rounded-lg ${done ? 'bg-emerald-50 border border-emerald-200' : 'bg-white border border-gray-200'}">
          <div class="flex items-center gap-2.5 p-3">
            <div class="w-4 h-4 rounded flex items-center justify-center ${done ? 'bg-emerald-500' : 'border-2 border-gray-300'}">${done ? checkIcon : ''}</div>
            <span class="text-sm font-medium leading-tight ${done ? 'line-through text-gray-400' : 'text-gray-800'}">${shortTitle}</span>
          </div>
        </div>`;
      }
      homeHtml += `</div>`;
    } else {
      homeHtml += `<div class="space-y-2">`;
      for (const item of group.items) {
        const done = todayCompletionSet.has(item.id);
        const title = esc(item.title);
        const desc = item.description ? esc(item.description) : '';
        homeHtml += `
        <div class="p-3 rounded-xl ${done ? 'bg-emerald-50 border border-emerald-200' : 'bg-white border border-gray-200'}">
          <div class="flex items-start gap-2.5">
            <div class="w-5 h-5 rounded-md flex items-center justify-center mt-0.5 flex-shrink-0 ${done ? 'bg-emerald-500' : 'border-2 border-gray-300'}">${done ? checkIcon : ''}</div>
            <div class="flex-1 min-w-0">
              <p class="text-sm font-medium ${done ? 'line-through text-gray-400' : 'text-gray-900'}">${title}</p>
              ${desc ? `<p class="text-xs text-gray-500 mt-0.5 line-clamp-2">${desc}</p>` : ''}
            </div>
          </div>
        </div>`;
      }
      homeHtml += `</div>`;
    }
    homeHtml += `</div>`;
  }

  // Weekly items on home page
  if (weeklyItems.length > 0) {
    homeHtml += `<div class="space-y-2 mt-2">`;
    for (const item of weeklyItems) {
      const comps = weeklyCompletionsByItem.get(item.id) || [];
      const completedDates = new Set(comps.map(c => c.target_date));
      const targetCount = getWeeklyTargetCount(item.title, item.target_count);
      const isGoalMet = completedDates.size >= targetCount;

      homeHtml += `
      <div class="p-3 rounded-xl ${isGoalMet ? 'bg-emerald-50 border border-emerald-200' : 'bg-white border border-gray-200'}">
        <div class="flex items-start justify-between gap-2 mb-2">
          <p class="text-sm font-medium flex-1 ${isGoalMet ? 'text-gray-400' : 'text-gray-900'}">${esc(item.title)}</p>
          <span class="text-sm font-bold ${isGoalMet ? 'text-emerald-600' : 'text-gray-400'}">${completedDates.size}/${targetCount}</span>
        </div>
        <div class="flex items-center gap-1">
          ${weekDates.map((date, i) => {
            const isDone = completedDates.has(date);
            const isFuture = date > today;
            return `<div class="flex flex-col items-center gap-1 flex-1">
              <span class="text-xs ${isFuture ? 'text-gray-300' : 'text-gray-400'}">${DAY_LABELS[i]}</span>
              <div class="w-5 h-5 rounded-full flex items-center justify-center ${isDone ? 'bg-emerald-500' : isFuture ? 'bg-gray-50 border border-gray-200' : 'bg-gray-100 border border-gray-200'}">${isDone ? checkIconSmall : ''}</div>
            </div>`;
          }).join('')}
        </div>
      </div>`;
    }
    homeHtml += `</div>`;
  }

  // --- PAGE: HISTORY ---
  let historyHtml = `
    <h1 class="text-xl font-bold text-gray-900">歷史紀錄</h1>
    <p class="text-sm text-gray-500">${monday} ~ ${sunday}（本週快照）</p>

    <!-- Summary cards -->
    <div class="grid grid-cols-2 gap-3">
      <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
        <p class="text-3xl font-bold text-emerald-600">${avgDailyRate}%</p>
        <p class="text-xs text-gray-500 mt-1">每日平均完成率</p>
      </div>
      <div class="bg-white rounded-xl border border-gray-200 p-4 text-center">
        <p class="text-3xl font-bold text-emerald-600">${weeklyGoalsMet}/${trackableWeeklyItems.length}</p>
        <p class="text-xs text-gray-500 mt-1">每週目標達成</p>
      </div>
    </div>

    <!-- Daily breakdown -->
    <section class="space-y-2">
      <h2 class="text-base font-bold text-gray-900">每日完成率</h2>
      <div class="bg-white rounded-xl border border-gray-200 overflow-hidden">`;

  for (let i = 0; i < 7; i++) {
    const date = weekDates[i];
    const done = completionsByDate.get(date)?.size || 0;
    const rate = dailyCount > 0 ? Math.round((done / dailyCount) * 100) : 0;
    const isFuture = date > today;
    const isToday = date === today;
    const d = new Date(date + 'T00:00:00');
    const dateLabel = `${d.getMonth() + 1}/${d.getDate()}`;

    historyHtml += `
        <div class="flex items-center px-4 py-3 gap-3 ${i !== 6 ? 'border-b border-gray-100' : ''} ${isFuture ? 'opacity-40' : ''}">
          <span class="text-sm font-medium w-6 text-center ${isToday ? 'text-emerald-700' : 'text-gray-500'}">${DAY_LABELS[i]}</span>
          <span class="text-xs text-gray-400 w-10">${dateLabel}</span>
          <div class="flex-1 h-2.5 bg-gray-100 rounded-full overflow-hidden">
            <div class="h-full rounded-full transition-all ${rate >= 80 ? 'bg-emerald-500' : rate >= 50 ? 'bg-yellow-400' : rate > 0 ? 'bg-orange-400' : ''}" style="width: ${rate}%"></div>
          </div>
          <span class="text-sm font-medium w-16 text-right ${isFuture ? 'text-gray-300' : rate >= 80 ? 'text-emerald-600' : 'text-gray-500'}">${isFuture ? '—' : `${done}/${dailyCount}`}</span>
        </div>`;
  }
  historyHtml += `</div></section>`;

  // Weekly goals in history
  if (weeklyItems.length > 0) {
    historyHtml += `
    <section class="space-y-2">
      <h2 class="text-base font-bold text-gray-900">每週目標</h2>
      <div class="space-y-2">`;

    for (const item of weeklyItems) {
      const comps = weeklyCompletionsByItem.get(item.id) || [];
      const completedDates = new Set(comps.map(c => c.target_date));
      const targetCount = getWeeklyTargetCount(item.title, item.target_count);
      const isGoalMet = completedDates.size >= targetCount;

      historyHtml += `
        <div class="p-4 rounded-xl ${isGoalMet ? 'bg-emerald-50 border border-emerald-200' : 'bg-white border border-gray-200'}">
          <div class="flex items-start justify-between gap-2 mb-3">
            <p class="text-sm font-medium flex-1 ${isGoalMet ? 'text-gray-400' : 'text-gray-900'}">${esc(item.title)}</p>
            <div class="flex items-center gap-2 flex-shrink-0">
              <span class="text-sm font-bold ${isGoalMet ? 'text-emerald-600' : 'text-gray-400'}">${completedDates.size}/${targetCount}</span>
              <span class="text-xs px-2 py-0.5 rounded-full ${getCategoryColor(item.category)}">${esc(item.category)}</span>
            </div>
          </div>
          <div class="flex items-center gap-1">
            ${weekDates.map((date, i) => {
              const isDone = completedDates.has(date);
              const isFuture = date > today;
              return `<div class="flex flex-col items-center gap-1 flex-1">
                <span class="text-xs ${isFuture ? 'text-gray-300' : 'text-gray-400'}">${DAY_LABELS[i]}</span>
                <div class="w-5 h-5 rounded-full flex items-center justify-center ${isDone ? 'bg-emerald-500' : isFuture ? 'bg-gray-50 border border-gray-200' : 'bg-gray-100 border border-gray-200'}">${isDone ? checkIconSmall : ''}</div>
              </div>`;
            }).join('')}
          </div>
        </div>`;
    }
    historyHtml += `</div></section>`;
  }

  // --- PAGE: SHOPPING ---
  function renderJsonEntries(data: Record<string, unknown>): string {
    const entries = Object.entries(data).filter(([, v]) => v !== null && v !== '' && v !== undefined);
    if (entries.length === 0) return '';
    return `<div class="flex flex-wrap gap-x-3 gap-y-1">${entries.map(([k, v]) =>
      `<span class="text-sm text-gray-600"><span class="text-gray-500">${esc(k)}:</span> ${esc(String(v))}</span>`
    ).join('')}</div>`;
  }

  function renderProductCard(item: Product): string {
    const hasSpecs = item.specs && Object.keys(item.specs).length > 0;
    const hasNutrition = item.nutrition && Object.keys(item.nutrition).length > 0;
    const storeColor = STORE_COLORS[item.store] || 'bg-gray-100 text-gray-800';

    const ratingHtml = item.rating != null
      ? `<div class="mt-1"><span class="text-sm text-yellow-600">${'★'.repeat(Math.round(item.rating))}${'☆'.repeat(5 - Math.round(item.rating))} ${item.rating}${item.review_count != null ? ` <span class="text-gray-500">(${item.review_count.toLocaleString()})</span>` : ''}</span></div>`
      : '';

    return `
      <a href="${esc(item.url)}" target="_blank" rel="noopener noreferrer" class="product-card block p-4 bg-white rounded-xl border border-gray-200 hover:border-emerald-300 hover:shadow-sm transition-all">
        <div class="flex items-start justify-between gap-2">
          <div class="flex-1 min-w-0">
            <div class="flex items-center gap-2 mb-1">
              ${item.image_url ? `<img src="${esc(item.image_url)}" alt="" class="w-10 h-10 rounded object-contain flex-shrink-0">` : ''}
              <div>
                <p class="text-base font-medium text-gray-900">${esc(item.name)}</p>
                ${(item.brand || item.origin) ? `<p class="text-sm text-gray-500">${esc(item.brand || '')}${item.brand && item.origin ? ' · ' : ''}${esc(item.origin || '')}</p>` : ''}
              </div>
            </div>
            <p class="text-sm text-gray-600 leading-relaxed">${esc(item.description)}</p>
            ${ratingHtml}
            ${hasSpecs ? `<div class="mt-2 bg-gray-50 rounded px-2.5 py-2"><p class="text-xs font-medium text-gray-500 mb-1">規格</p>${renderJsonEntries(item.specs)}</div>` : ''}
            ${hasNutrition ? `<div class="mt-1.5 bg-emerald-50 rounded px-2.5 py-2"><p class="text-xs font-medium text-emerald-600 mb-1">營養</p>${renderJsonEntries(item.nutrition)}</div>` : ''}
            ${item.purchase_note ? `<p class="text-sm text-amber-800 mt-2 bg-amber-50 rounded px-2.5 py-2">${esc(item.purchase_note)}</p>` : ''}
            ${item.sku ? `<div class="flex gap-2 text-sm"><span class="text-gray-500 flex-shrink-0">SKU</span><span class="text-gray-700">${esc(item.sku)}</span></div>` : ''}
          </div>
          <div class="flex flex-col items-end gap-1.5 flex-shrink-0">
            <span class="text-sm px-2.5 py-1 rounded-full font-medium ${storeColor}">${esc(item.store)}</span>
            <span class="text-sm font-semibold text-amber-800">${esc(item.price)}</span>
            ${externalLinkIcon}
          </div>
        </div>
      </a>`;
  }

  let shoppingHtml = `
    <h1 class="text-xl font-bold text-gray-900">採購清單</h1>
    <div class="sticky top-12 z-[5] -mx-4 px-4 bg-gray-50 pb-3 pt-1">
      <input type="search" placeholder="搜尋品項..." oninput="filterProducts(this.value)"
        class="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-sm bg-white">
    </div>
    <p class="text-sm text-gray-500">點擊任一項目可直接開啟產品頁面</p>`;

  for (const sec of PRODUCT_SECTIONS) {
    const sectionProducts = activeProducts.filter(p => p.category === sec.category);
    if (sectionProducts.length === 0) continue;
    shoppingHtml += `
    <section class="shopping-section space-y-3" data-category="${sec.category}">
      <h2 class="text-base font-bold text-gray-900">${esc(sec.title)}</h2>
      <div class="space-y-2">
        ${sectionProducts.map(p => renderProductCard(p)).join('\n')}
      </div>
    </section>`;
  }

  shoppingHtml += `<p class="no-results text-center text-gray-400 py-8" style="display:none">找不到符合的品項</p>`;

  // --- PAGE: AUDIT ---
  const issueCount = issues.length;

  const nutrientCards = Object.entries(nutrients).map(([key, data]) => {
    const ratio = data.rda > 0 ? data.value / data.rda : 0;
    const c = nutrientColor(ratio);
    const pct = Math.round(ratio * 100);
    return `<div class="rounded-xl border p-3 ${c.bg} ${c.border} ${c.text}">
      <div class="text-xs font-medium opacity-70">${NUTRIENT_LABELS[key] || key}</div>
      <div class="text-lg font-bold mt-0.5">${data.value > 0 ? data.value : '—'}<span class="text-xs font-normal ml-0.5">${data.unit}</span></div>
      <div class="text-xs opacity-60 mt-0.5">RDA ${data.rda}${data.unit}</div>
      <div class="mt-2 h-1.5 rounded-full bg-white/50 overflow-hidden">
        <div class="h-full rounded-full ${c.bar}" style="width: ${Math.min(pct, 100)}%;"></div>
      </div>
      <div class="text-xs mt-1 font-medium">${data.value > 0 ? pct + '%' : '未偵測'}</div>
    </div>`;
  }).join('\n');

  const timelineHtml = timeline.map(slot => {
    const itemsHtml = slot.items.map(item => {
      const title = esc(item.title.replace(/^\d{2}:\d{2}\s*/, ''));
      const weeklyBadge = item.frequency === 'weekly'
        ? ' <span class="inline-block mt-1 px-1.5 py-0.5 rounded text-xs bg-blue-50 text-blue-600">每週</span>' : '';
      return `<div class="bg-white rounded-lg border border-gray-100 p-2 px-2.5 text-sm mb-1.5">
        <div class="font-medium text-gray-800">${title}</div>${weeklyBadge}
      </div>`;
    }).join('\n');
    return `<div class="relative pl-6 mb-4">
      <div class="absolute left-0 top-0 bottom-0 w-0.5 bg-gray-200"></div>
      <div class="absolute left-[-4px] top-1 w-2.5 h-2.5 rounded-full bg-emerald-500 border-2 border-white"></div>
      <div class="text-sm font-bold text-emerald-700 mb-1.5">${slot.time}</div>
      ${itemsHtml}
    </div>`;
  }).join('\n');

  // Issues with severity summary
  const grouped = {
    CRITICAL: issues.filter(i => i.severity === 'CRITICAL'),
    HIGH: issues.filter(i => i.severity === 'HIGH'),
    MEDIUM: issues.filter(i => i.severity === 'MEDIUM'),
  };

  const issuesHtml = issues.length === 0
    ? '<div class="text-center py-12 text-gray-400"><div class="text-2xl mb-2">✅</div><div>沒有發現問題</div></div>'
    : `<div class="flex gap-2 text-sm mb-3">
        <span class="px-2 py-0.5 rounded-full bg-red-100 text-red-700 font-medium">${grouped.CRITICAL.length} 嚴重</span>
        <span class="px-2 py-0.5 rounded-full bg-amber-100 text-amber-700 font-medium">${grouped.HIGH.length} 重要</span>
        <span class="px-2 py-0.5 rounded-full bg-sky-100 text-sky-700 font-medium">${grouped.MEDIUM.length} 一般</span>
      </div>` +
      issues.map(issue => {
        const sc = severityClasses(issue.severity);
        return `<div class="rounded-xl border p-3 mb-2 ${sc.card}">
          <div class="flex items-start gap-2">
            <span class="text-xs px-1.5 py-0.5 rounded font-bold shrink-0 ${sc.badge}">${issue.severity}</span>
            <div>
              <div class="text-sm font-medium ${sc.text}">${esc(issue.title)}</div>
              <div class="text-xs text-gray-500 mt-1 whitespace-pre-line">${esc(issue.detail)}</div>
            </div>
          </div>
        </div>`;
      }).join('\n');

  let auditHtml = `
    <h1 class="text-xl font-bold text-gray-800 mb-4">審計儀表板</h1>
    <div class="flex bg-gray-100 rounded-xl p-1 mb-4" id="audit-tabs">
      <button class="flex-1 py-2 text-sm font-medium rounded-lg transition-colors bg-white text-emerald-700 shadow-sm" onclick="switchAuditTab(this,'nutrients')">營養總計</button>
      <button class="flex-1 py-2 text-sm font-medium rounded-lg transition-colors text-gray-500" onclick="switchAuditTab(this,'timeline')">時間軸</button>
      <button class="flex-1 py-2 text-sm font-medium rounded-lg transition-colors text-gray-500" onclick="switchAuditTab(this,'issues')">問題檢查${issueCount > 0 ? `<span class="ml-1 inline-flex items-center justify-center w-5 h-5 text-xs rounded-full bg-red-500 text-white">${issueCount}</span>` : ''}</button>
    </div>
    <div id="audit-panel-nutrients">
      <div class="grid grid-cols-2 gap-3">${nutrientCards}</div>
    </div>
    <div id="audit-panel-timeline" style="display:none">${timelineHtml}</div>
    <div id="audit-panel-issues" style="display:none">${issuesHtml}</div>`;

  // --- PAGE: SETTINGS ---
  let settingsHtml = `<h1 class="text-xl font-bold text-gray-900">設定</h1>`;

  function renderSettingsSection(items: PlanItem[], label: string) {
    let html = `
    <section class="space-y-3">
      <h2 class="text-base font-bold text-gray-900">${label}</h2>`;
    if (items.length === 0) {
      html += `<p class="text-gray-400 text-sm py-4 text-center">尚無項目</p>`;
    } else {
      html += `<div class="space-y-2">`;
      for (const item of items) {
        html += `
        <div class="flex items-center gap-2 p-3 bg-white rounded-xl border border-gray-200">
          <div class="flex-1 min-w-0">
            <p class="text-base font-medium text-gray-900">${esc(item.title)}</p>
            ${item.description ? `<p class="text-sm text-gray-500 line-clamp-2">${esc(item.description)}</p>` : ''}
          </div>
          <span class="flex-shrink-0 text-xs px-2 py-1 rounded-full ${getCategoryColor(item.category)}">${esc(item.category)}</span>
        </div>`;
      }
      html += `</div>`;
    }
    html += `</section>`;
    return html;
  }

  settingsHtml += renderSettingsSection(dailyItems, '每日項目');
  settingsHtml += renderSettingsSection(weeklyItems, '每週目標');

  // ======================================
  // ASSEMBLE HTML
  // ======================================

  const html = `<!DOCTYPE html>
<html lang="zh-TW">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1, viewport-fit=cover">
  <title>健康長壽追蹤器</title>
  <style>
    :root { --font-geist-sans: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, "Noto Sans TC", sans-serif; }
${css}
    .pb-safe { padding-bottom: env(safe-area-inset-bottom, 0px); }
    .line-clamp-2 { display: -webkit-box; -webkit-line-clamp: 2; -webkit-box-orient: vertical; overflow: hidden; }
  </style>
</head>
<body class="font-sans antialiased">
  <div class="min-h-screen bg-gray-50">
    <header class="sticky top-0 z-10 bg-white/80 backdrop-blur-md border-b border-gray-200">
      <div class="max-w-lg mx-auto px-4 h-12 flex items-center justify-center">
        <h1 class="text-xl font-bold text-emerald-800">健康長壽追蹤器</h1>
      </div>
    </header>
    <main class="max-w-lg mx-auto px-4 py-6 pb-24">
      <div id="page-home" class="space-y-4">${homeHtml}</div>
      <div id="page-history" class="space-y-5" style="display:none">${historyHtml}</div>
      <div id="page-shopping" class="space-y-8" style="display:none">${shoppingHtml}</div>
      <div id="page-audit" style="display:none">${auditHtml}</div>
      <div id="page-settings" class="space-y-8" style="display:none">${settingsHtml}</div>
    </main>
    <nav class="fixed bottom-0 left-0 right-0 bg-white/80 backdrop-blur-md border-t border-gray-200 z-10 pb-safe">
      <div class="max-w-lg mx-auto flex">
        <button onclick="switchPage('home')" id="nav-home" class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-emerald-600">${homeIcon}<span class="text-xs mt-1 font-medium">首頁</span></button>
        <button onclick="switchPage('history')" id="nav-history" class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400">${historyIcon}<span class="text-xs mt-1 font-medium">歷史</span></button>
        <button onclick="switchPage('shopping')" id="nav-shopping" class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400">${shoppingIcon}<span class="text-xs mt-1 font-medium">採購</span></button>
        <button onclick="switchPage('audit')" id="nav-audit" class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400">${auditIcon}<span class="text-xs mt-1 font-medium">審計</span></button>
        <button onclick="switchPage('settings')" id="nav-settings" class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400">${settingsIcon}<span class="text-xs mt-1 font-medium">設定</span></button>
      </div>
    </nav>
  </div>
  <script>
    var pages = ['home','history','shopping','audit','settings'];

    function switchPage(name) {
      pages.forEach(function(p) {
        document.getElementById('page-' + p).style.display = (p === name) ? '' : 'none';
        document.getElementById('nav-' + p).className =
          'flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors ' +
          (p === name ? 'text-emerald-600' : 'text-gray-400');
      });
      window.scrollTo(0, 0);
    }

    function switchAuditTab(btn, name) {
      ['nutrients','timeline','issues'].forEach(function(n) {
        document.getElementById('audit-panel-' + n).style.display = (n === name) ? '' : 'none';
      });
      document.querySelectorAll('#audit-tabs button').forEach(function(t) {
        t.className = 'flex-1 py-2 text-sm font-medium rounded-lg transition-colors text-gray-500';
      });
      btn.className = 'flex-1 py-2 text-sm font-medium rounded-lg transition-colors bg-white text-emerald-700 shadow-sm';
    }

    function filterProducts(query) {
      var q = query.toLowerCase();
      var anyVisible = false;
      document.querySelectorAll('.product-card').forEach(function(card) {
        var text = card.textContent.toLowerCase();
        var show = !q || text.indexOf(q) !== -1;
        card.style.display = show ? '' : 'none';
        if (show) anyVisible = true;
      });
      // Hide empty sections
      document.querySelectorAll('.shopping-section').forEach(function(sec) {
        var visibleCards = sec.querySelectorAll('.product-card:not([style*="display: none"])');
        sec.style.display = visibleCards.length > 0 ? '' : 'none';
      });
      var noResults = document.querySelector('.no-results');
      if (noResults) noResults.style.display = anyVisible ? 'none' : '';
    }
  </script>
  <div class="text-center text-xs text-gray-400 pb-4" style="position:fixed;bottom:60px;left:0;right:0;pointer-events:none;">
    Generated ${new Date().toISOString().slice(0, 16).replace('T', ' ')} UTC
  </div>
</body>
</html>`;

  const outPath = join(__dirname, '..', 'audit.html');
  writeFileSync(outPath, html, 'utf-8');
  console.log(`✅ Written to ${outPath} (${(html.length / 1024).toFixed(0)} KB)`);
  console.log(`   Open in browser: file://${outPath}`);
}

main().catch(err => {
  console.error('❌', err);
  process.exit(1);
});
