import { createClient } from '@supabase/supabase-js';
import { runAuditChecks, calculateDailyNutrients, extractTimeline } from '../lib/audit-logic';
import type { PlanItem, Product, AuditSeverity } from '../lib/types';

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing NEXT_PUBLIC_SUPABASE_URL or SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

const COLORS: Record<AuditSeverity, string> = {
  CRITICAL: '\x1b[31m', // red
  HIGH: '\x1b[33m',     // yellow
  MEDIUM: '\x1b[36m',   // cyan
};
const RESET = '\x1b[0m';
const BOLD = '\x1b[1m';

async function main() {
  console.log(`${BOLD}🔍 Nutrient Audit Report${RESET}\n`);

  const [{ data: planItems, error: e1 }, { data: products, error: e2 }] = await Promise.all([
    supabase.from('plan_items').select('*'),
    supabase.from('products').select('*'),
  ]);

  if (e1 || e2 || !planItems || !products) {
    console.error('❌ Failed to fetch data:', e1?.message || e2?.message);
    process.exit(1);
  }

  // Section 1: Nutrient Totals
  console.log(`${BOLD}📊 Daily Nutrient Totals${RESET}`);
  console.log('─'.repeat(50));
  const nutrients = calculateDailyNutrients(planItems as PlanItem[]);
  for (const [key, data] of Object.entries(nutrients)) {
    const { value, unit, rda } = data;
    const ratio = rda > 0 ? value / rda : 0;
    const status = ratio >= 0.9 ? '✅' : ratio >= 0.7 ? '⚠️' : '❌';
    const label = {
      protein: '蛋白質', calcium: '鈣', iron: '鐵', zinc: '鋅',
      magnesium: '鎂', fiber: '纖維', vitaminD: '維他命D', omega3: 'Omega-3',
    }[key] || key;
    console.log(`  ${status} ${label.padEnd(10)} ${String(value).padStart(6)}${unit} / ${rda}${unit} (${Math.round(ratio * 100)}%)`);
  }

  // Section 2: Timeline
  console.log(`\n${BOLD}⏰ Daily Timeline${RESET}`);
  console.log('─'.repeat(50));
  const timeline = extractTimeline(planItems as PlanItem[]);
  for (const slot of timeline) {
    console.log(`  ${BOLD}${slot.time}${RESET}`);
    for (const item of slot.items) {
      const freq = item.frequency === 'weekly' ? ' [週]' : '';
      console.log(`    · ${item.title.replace(/^\d{2}:\d{2}\s*/, '')}${freq}`);
    }
  }

  // Section 3: Issues
  const issues = runAuditChecks(planItems as PlanItem[], products as Product[]);
  const critical = issues.filter(i => i.severity === 'CRITICAL');
  const high = issues.filter(i => i.severity === 'HIGH');
  const medium = issues.filter(i => i.severity === 'MEDIUM');

  console.log(`\n${BOLD}🔎 Audit Issues (${issues.length} total)${RESET}`);
  console.log('─'.repeat(50));

  for (const issue of issues) {
    const color = COLORS[issue.severity];
    console.log(`  ${color}[${issue.severity}]${RESET} ${issue.title}`);
    console.log(`    ${issue.detail.split('\n').join('\n    ')}`);
  }

  // Summary
  console.log(`\n${BOLD}📋 Summary${RESET}`);
  console.log(`  🔴 CRITICAL: ${critical.length}`);
  console.log(`  🟡 HIGH:     ${high.length}`);
  console.log(`  🔵 MEDIUM:   ${medium.length}`);

  if (critical.length > 0) {
    console.log(`\n${COLORS.CRITICAL}❌ ${critical.length} CRITICAL issues found!${RESET}`);
    process.exit(1);
  } else {
    console.log(`\n✅ No CRITICAL issues found.`);
  }
}

main().catch(err => {
  console.error('❌ Unexpected error:', err);
  process.exit(1);
});
