import { createClient } from '@supabase/supabase-js';
import { runAuditChecks, calculateDailyNutrients, extractTimeline } from '../lib/audit-logic';
import type { PlanItem, Product, AuditIssue } from '../lib/types';
import { writeFileSync, readFileSync } from 'fs';
import { join } from 'path';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing env vars');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

const NUTRIENT_LABELS: Record<string, string> = {
  protein: '蛋白質', calcium: '鈣', iron: '鐵', zinc: '鋅',
  magnesium: '鎂', fiber: '纖維', vitaminD: '維他命D', omega3: 'Omega-3',
};

function nutrientColor(ratio: number): { bg: string; border: string; text: string; bar: string } {
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

function escapeHtml(s: string) {
  return s.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
}

async function main() {
  const [{ data: planItems }, { data: products }] = await Promise.all([
    supabase.from('plan_items').select('*'),
    supabase.from('products').select('*'),
  ]);

  const items = (planItems || []) as PlanItem[];
  const prods = (products || []) as Product[];

  const nutrients = calculateDailyNutrients(items);
  const timeline = extractTimeline(items);
  const issues = runAuditChecks(items, prods);

  // Read the Tailwind CSS from the saved website
  let css: string;
  const cssPath = join(__dirname, '..', '健康長壽追蹤器審計_files', '2ef3cff85cf82978.css');
  try {
    css = readFileSync(cssPath, 'utf-8');
    // Remove font-face references to external woff2 files (won't resolve locally)
    css = css.replace(/@font-face\{[^}]*\}/g, '');
  } catch {
    console.warn('⚠️  CSS file not found, using minimal fallback');
    css = '';
  }

  const issueCount = issues.length;

  // Build nutrient cards
  const nutrientCards = Object.entries(nutrients).map(([key, data]) => {
    const ratio = data.rda > 0 ? data.value / data.rda : 0;
    const c = nutrientColor(ratio);
    const pct = Math.round(ratio * 100);
    return `          <div class="rounded-xl border p-3 ${c.bg} ${c.border} ${c.text}">
            <div class="text-xs font-medium opacity-70">${NUTRIENT_LABELS[key] || key}</div>
            <div class="text-lg font-bold mt-0.5">${data.value > 0 ? data.value : '—'}<span class="text-xs font-normal ml-0.5">${data.unit}</span></div>
            <div class="text-xs opacity-60 mt-0.5">RDA ${data.rda}${data.unit}</div>
            <div class="mt-2 h-1.5 rounded-full bg-white/50 overflow-hidden">
              <div class="h-full rounded-full ${c.bar}" style="width: ${Math.min(pct, 100)}%;"></div>
            </div>
            <div class="text-xs mt-1 font-medium">${data.value > 0 ? pct + '%' : '未偵測'}</div>
          </div>`;
  }).join('\n');

  // Build timeline
  const timelineHtml = timeline.map(slot => {
    const itemsHtml = slot.items.map(item => {
      const title = escapeHtml(item.title.replace(/^\d{2}:\d{2}\s*/, ''));
      const weeklyBadge = item.frequency === 'weekly'
        ? ' <span class="inline-block mt-1 px-1.5 py-0.5 rounded text-xs bg-blue-50 text-blue-600">每週</span>' : '';
      return `            <div class="bg-white rounded-lg border border-gray-100 p-2 px-2.5 text-sm mb-1.5">
              <div class="font-medium text-gray-800">${title}</div>${weeklyBadge}
            </div>`;
    }).join('\n');
    return `          <div class="relative pl-6 mb-4">
            <div class="absolute left-0 top-0 bottom-0 w-0.5 bg-gray-200"></div>
            <div class="absolute left-[-4px] top-1 w-2.5 h-2.5 rounded-full bg-emerald-500 border-2 border-white"></div>
            <div class="text-sm font-bold text-emerald-700 mb-1.5">${slot.time}</div>
${itemsHtml}
          </div>`;
  }).join('\n');

  // Build issues
  const issuesHtml = issues.length === 0
    ? '          <div class="text-center py-12 text-gray-400"><div class="text-2xl mb-2">✅</div><div>沒有發現問題</div></div>'
    : issues.map(issue => {
        const sc = severityClasses(issue.severity);
        return `          <div class="rounded-xl border p-3 mb-2 ${sc.card}">
            <div class="flex items-start gap-2">
              <span class="text-xs px-1.5 py-0.5 rounded font-bold shrink-0 ${sc.badge}">${issue.severity}</span>
              <div>
                <div class="text-sm font-medium ${sc.text}">${escapeHtml(issue.title)}</div>
                <div class="text-xs text-gray-500 mt-1 whitespace-pre-line">${escapeHtml(issue.detail)}</div>
              </div>
            </div>
          </div>`;
      }).join('\n');

  // SVG icons (from the saved website)
  const homeIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 12l8.954-8.955c.44-.439 1.152-.439 1.591 0L21.75 12M4.5 9.75v10.125c0 .621.504 1.125 1.125 1.125H9.75v-4.875c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125V21h4.125c.621 0 1.125-.504 1.125-1.125V9.75M8.25 21h8.25"></path></svg>`;
  const historyIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M3 13.125C3 12.504 3.504 12 4.125 12h2.25c.621 0 1.125.504 1.125 1.125v6.75C7.5 20.496 6.996 21 6.375 21h-2.25A1.125 1.125 0 013 19.875v-6.75zM9.75 8.625c0-.621.504-1.125 1.125-1.125h2.25c.621 0 1.125.504 1.125 1.125v11.25c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V8.625zM16.5 4.125c0-.621.504-1.125 1.125-1.125h2.25C20.496 3 21 3.504 21 4.125v15.75c0 .621-.504 1.125-1.125 1.125h-2.25a1.125 1.125 0 01-1.125-1.125V4.125z"></path></svg>`;
  const shoppingIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M2.25 3h1.386c.51 0 .955.343 1.087.835l.383 1.437M7.5 14.25a3 3 0 00-3 3h15.75m-12.75-3h11.218c1.121-2.3 2.1-4.684 2.924-7.138a60.114 60.114 0 00-16.536-1.84M7.5 14.25L5.106 5.272M6 20.25a.75.75 0 11-1.5 0 .75.75 0 011.5 0zm12.75 0a.75.75 0 11-1.5 0 .75.75 0 011.5 0z"></path></svg>`;
  const auditIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M9 12.75L11.25 15 15 9.75m-3-7.036A11.959 11.959 0 013.598 6 11.99 11.99 0 003 9.749c0 5.592 3.824 10.29 9 11.623 5.176-1.332 9-6.03 9-11.622 0-1.31-.21-2.571-.598-3.751h-.152c-3.196 0-6.1-1.248-8.25-3.285z"></path></svg>`;
  const settingsIcon = `<svg class="w-7 h-7" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="1.5"><path stroke-linecap="round" stroke-linejoin="round" d="M9.594 3.94c.09-.542.56-.94 1.11-.94h2.593c.55 0 1.02.398 1.11.94l.213 1.281c.063.374.313.686.645.87.074.04.147.083.22.127.324.196.72.257 1.075.124l1.217-.456a1.125 1.125 0 011.37.49l1.296 2.247a1.125 1.125 0 01-.26 1.431l-1.003.827c-.293.24-.438.613-.431.992a6.759 6.759 0 010 .255c-.007.378.138.75.43.99l1.005.828c.424.35.534.954.26 1.43l-1.298 2.247a1.125 1.125 0 01-1.369.491l-1.217-.456c-.355-.133-.75-.072-1.076.124a6.57 6.57 0 01-.22.128c-.331.183-.581.495-.644.869l-.213 1.28c-.09.543-.56.941-1.11.941h-2.594c-.55 0-1.02-.398-1.11-.94l-.213-1.281c-.062-.374-.312-.686-.644-.87a6.52 6.52 0 01-.22-.127c-.325-.196-.72-.257-1.076-.124l-1.217.456a1.125 1.125 0 01-1.369-.49l-1.297-2.247a1.125 1.125 0 01.26-1.431l1.004-.827c.292-.24.437-.613.43-.992a6.932 6.932 0 010-.255c.007-.378-.138-.75-.43-.99l-1.004-.828a1.125 1.125 0 01-.26-1.43l1.297-2.247a1.125 1.125 0 011.37-.491l1.216.456c.356.133.751.072 1.076-.124.072-.044.146-.087.22-.128.332-.183.582-.495.644-.869l.214-1.281z"></path><path stroke-linecap="round" stroke-linejoin="round" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path></svg>`;

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
      <div>
        <h1 class="text-xl font-bold text-gray-800 mb-4">審計儀表板</h1>
        <div class="flex bg-gray-100 rounded-xl p-1 mb-4">
          <button class="flex-1 py-2 text-sm font-medium rounded-lg transition-colors bg-white text-emerald-700 shadow-sm" onclick="switchTab(this,'nutrients')">營養總計</button>
          <button class="flex-1 py-2 text-sm font-medium rounded-lg transition-colors text-gray-500" onclick="switchTab(this,'timeline')">時間軸</button>
          <button class="flex-1 py-2 text-sm font-medium rounded-lg transition-colors text-gray-500" onclick="switchTab(this,'issues')">問題檢查${issueCount > 0 ? `<span class="ml-1 inline-flex items-center justify-center w-5 h-5 text-xs rounded-full bg-red-500 text-white">${issueCount}</span>` : ''}</button>
        </div>

        <!-- Nutrients -->
        <div id="panel-nutrients" class="panel">
          <div class="grid grid-cols-2 gap-3">
${nutrientCards}
          </div>
        </div>

        <!-- Timeline -->
        <div id="panel-timeline" class="panel" style="display:none;">
${timelineHtml}
        </div>

        <!-- Issues -->
        <div id="panel-issues" class="panel" style="display:none;">
${issuesHtml}
        </div>

        <div class="text-center text-xs text-gray-400 mt-4">Generated ${new Date().toISOString().slice(0, 16).replace('T', ' ')} UTC</div>
      </div>
    </main>
    <nav class="fixed bottom-0 left-0 right-0 bg-white/80 backdrop-blur-md border-t border-gray-200 z-10 pb-safe">
      <div class="max-w-lg mx-auto flex">
        <a class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400" href="#">${homeIcon}<span class="text-xs mt-1 font-medium">首頁</span></a>
        <a class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400" href="#">${historyIcon}<span class="text-xs mt-1 font-medium">歷史</span></a>
        <a class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400" href="#">${shoppingIcon}<span class="text-xs mt-1 font-medium">採購</span></a>
        <a class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-emerald-600" href="#">${auditIcon}<span class="text-xs mt-1 font-medium">審計</span></a>
        <a class="flex-1 flex flex-col items-center pt-2.5 pb-1.5 transition-colors text-gray-400" href="#">${settingsIcon}<span class="text-xs mt-1 font-medium">設定</span></a>
      </div>
    </nav>
  </div>
  <script>
    function switchTab(btn, name) {
      document.querySelectorAll('.panel').forEach(p => p.style.display = 'none');
      document.querySelectorAll('.flex.bg-gray-100 button').forEach(t => {
        t.className = 'flex-1 py-2 text-sm font-medium rounded-lg transition-colors text-gray-500';
      });
      btn.className = 'flex-1 py-2 text-sm font-medium rounded-lg transition-colors bg-white text-emerald-700 shadow-sm';
      document.getElementById('panel-' + name).style.display = '';
    }
  </script>
</body>
</html>`;

  const outPath = join(__dirname, '..', 'audit.html');
  writeFileSync(outPath, html, 'utf-8');
  console.log(`✅ Written to ${outPath}`);
  console.log(`   Open in browser: file://${outPath}`);
}

main().catch(err => {
  console.error('❌', err);
  process.exit(1);
});
