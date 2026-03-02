import type { PlanItem, Product, AuditIssue, NutrientData, TimeSlot } from './types';

interface FallbackRule {
  titleMatch: string;
  pattern?: RegExp;
  fixed?: number;
}

interface NutrientDef {
  key: keyof NutrientData;
  unit: string;
  rda: number;
  titlePattern: RegExp;
  titleExtract: RegExp;
  fallbackRules: FallbackRule[];
}

function extractRange(text: string, pattern: RegExp): number {
  pattern.lastIndex = 0;
  const m = pattern.exec(text);
  if (!m) return 0;
  if (m[2]) return (parseFloat(m[1]) + parseFloat(m[2])) / 2;
  return parseFloat(m[1]);
}

const NUTRIENT_DEFS: NutrientDef[] = [
  {
    key: 'protein', unit: 'g', rda: 197,
    titlePattern: /蛋白質\s*\d/,
    titleExtract: /(\d+)[-.~～](\d+)\s*g/,
    fallbackRules: [
      { titleMatch: '訓練前營養', pattern: /乳清蛋白.*?(\d+)\s*g\s*蛋白/ },
      { titleMatch: '午餐', pattern: /蛋白質\s*(\d+)[-.~～](\d+)\s*g/ },
      { titleMatch: '下午點心', pattern: /豌豆蛋白.*?(\d+)\s*g\s*蛋白/ },
      { titleMatch: '晚餐', pattern: /蛋白質\s*(\d+)[-.~～](\d+)\s*g/ },
      { titleMatch: '酪蛋白', pattern: /(\d+)\s*g\s*蛋白質/ },
    ],
  },
  {
    key: 'calcium', unit: 'mg', rda: 1000,
    titlePattern: /鈣攝取確認/,
    titleExtract: /目標\s*(\d+)\s*mg/,
    fallbackRules: [
      { titleMatch: '下午點心', pattern: /~(\d+)\s*mg\s*鈣/ },
      { titleMatch: '17:00', fixed: 500 },
      { titleMatch: '酪蛋白', pattern: /鈣含量僅\s*~(\d+)[-.~～](\d+)\s*mg/ },
    ],
  },
  {
    key: 'iron', unit: 'mg', rda: 8,
    titlePattern: /鐵吸收最佳化/,
    titleExtract: /RDA\s*(\d+)\s*mg/,
    fallbackRules: [
      { titleMatch: '膽鹼攝取', fixed: 3.6 },
      { titleMatch: '午餐 +', fixed: 2.5 },
      { titleMatch: '晚餐', fixed: 2.5 },
      { titleMatch: '菠菜', fixed: 1.5 },
    ],
  },
  {
    key: 'zinc', unit: 'mg', rda: 11,
    titlePattern: /鋅/,
    titleExtract: /鋅\s*(\d+)\s*mg/,
    fallbackRules: [
      { titleMatch: '膽鹼攝取', fixed: 2.0 },
      { titleMatch: '下午點心', fixed: 5.5 },
      { titleMatch: '晚餐', fixed: 4.0 },
    ],
  },
  {
    key: 'magnesium', unit: 'mg', rda: 400,
    titlePattern: /鎂攝取/,
    titleExtract: /(\d+)\s*mg/,
    fallbackRules: [
      { titleMatch: '睡前補充品', fixed: 150 },
      { titleMatch: 'Magtein', fixed: 144 },
      { titleMatch: '下午點心', fixed: 80 },
      { titleMatch: '晚餐', fixed: 50 },
      { titleMatch: '希臘優格', fixed: 30 },
    ],
  },
  {
    key: 'fiber', unit: 'g', rda: 38,
    titlePattern: /膳食纖維/,
    titleExtract: /(\d+)[-.~～](\d+)\s*g/,
    fallbackRules: [
      { titleMatch: '奇亞籽', fixed: 5 },
      { titleMatch: '洋車前子殼', pattern: /共\s*(\d+)\s*g\s*纖維/ },
      { titleMatch: '酪梨', fixed: 7 },
      { titleMatch: '下午點心', fixed: 5 },
    ],
  },
  {
    key: 'vitaminD', unit: 'IU', rda: 2000,
    titlePattern: /D3 補充/,
    titleExtract: /(\d+)\s*IU/,
    fallbackRules: [
      { titleMatch: '午餐 + 訓練後', pattern: /D3\s*(\d+)\s*IU/ },
    ],
  },
  {
    key: 'omega3', unit: 'mg', rda: 1400,
    titlePattern: /omega|Omega|魚油/i,
    titleExtract: /EPA\+DHA\s*(?:共\s*)?(\d+)\s*mg/,
    fallbackRules: [
      { titleMatch: '午餐 + 訓練後', fixed: 1400 },
      { titleMatch: '訓練前營養', fixed: 0 },
    ],
  },
];

export function calculateDailyNutrients(planItems: PlanItem[]): NutrientData {
  const activeDaily = planItems.filter(i => i.is_active && i.frequency === 'daily');
  const result = {} as NutrientData;

  for (const def of NUTRIENT_DEFS) {
    const targetItem = activeDaily.find(i => def.titlePattern.test(i.title));
    if (targetItem) {
      const text = `${targetItem.title} ${targetItem.description}`;
      const val = extractRange(text, def.titleExtract);
      if (val > 0) {
        result[def.key] = { value: val, unit: def.unit, rda: def.rda };
        continue;
      }
    }

    let total = 0;
    for (const rule of def.fallbackRules) {
      const item = activeDaily.find(i => i.title.includes(rule.titleMatch));
      if (!item) continue;
      if (rule.fixed !== undefined) {
        total += rule.fixed;
      } else if (rule.pattern) {
        total += extractRange(item.description, rule.pattern);
      }
    }
    result[def.key] = { value: total, unit: def.unit, rda: def.rda };
  }

  return result;
}

export function extractTimeline(planItems: PlanItem[]): TimeSlot[] {
  const active = planItems.filter(i => i.is_active);
  const timeMap = new Map<string, PlanItem[]>();

  for (const item of active) {
    const match = item.title.match(/^(\d{2}:\d{2})/);
    const time = match ? match[1] : '全天';
    if (!timeMap.has(time)) timeMap.set(time, []);
    timeMap.get(time)!.push(item);
  }

  return Array.from(timeMap.entries())
    .sort(([a], [b]) => {
      if (a === '全天') return 1;
      if (b === '全天') return -1;
      return a.localeCompare(b);
    })
    .map(([time, items]) => ({ time, items }));
}

export function runAuditChecks(planItems: PlanItem[], products: Product[]): AuditIssue[] {
  const issues: AuditIssue[] = [];
  checkDuplicates(planItems, issues);
  checkStaleProducts(products, issues);
  checkTimingConflicts(planItems, issues);
  checkOrphanedProducts(planItems, products, issues);
  checkNutrientTotals(planItems, issues);
  return issues.sort((a, b) => {
    const order: Record<string, number> = { CRITICAL: 0, HIGH: 1, MEDIUM: 2 };
    return order[a.severity] - order[b.severity];
  });
}

function checkDuplicates(items: PlanItem[], issues: AuditIssue[]) {
  const active = items.filter(i => i.is_active);
  const byTimeAndCategory = new Map<string, PlanItem[]>();

  for (const item of active) {
    const timeMatch = item.title.match(/^(\d{2}:\d{2})/);
    if (!timeMatch) continue;
    const key = `${timeMatch[1]}|${item.category}`;
    if (!byTimeAndCategory.has(key)) byTimeAndCategory.set(key, []);
    byTimeAndCategory.get(key)!.push(item);
  }

  for (const [key, group] of byTimeAndCategory) {
    if (group.length <= 1) continue;
    const [time, category] = key.split('|');
    const titles = group.map(i => i.title.replace(/^\d{2}:\d{2}\s*/, ''));
    const seen = new Set<string>();
    const dupes: PlanItem[] = [];

    for (let i = 0; i < titles.length; i++) {
      const normalized = titles[i].slice(0, 10);
      if (seen.has(normalized)) {
        dupes.push(group[i]);
      } else {
        seen.add(normalized);
        for (let j = 0; j < i; j++) {
          if (titles[i].includes(titles[j].slice(0, 8)) || titles[j].includes(titles[i].slice(0, 8))) {
            dupes.push(group[i]);
            break;
          }
        }
      }
    }

    if (dupes.length > 0) {
      issues.push({
        severity: 'HIGH',
        category: '重複項目',
        title: `${time} ${category} 有疑似重複項目`,
        detail: group.map(i => `- ${i.title}`).join('\n'),
        itemIds: group.map(i => i.id),
      });
    }
  }
}

function checkStaleProducts(products: Product[], issues: AuditIssue[]) {
  for (const p of products.filter(p => p.is_active)) {
    if (p.description.includes('已停用') || p.description.includes('⛔') || p.purchase_note.includes('已停用')) {
      issues.push({
        severity: 'CRITICAL',
        category: '過期產品',
        title: `產品「${p.name}」標記已停用但仍為 active`,
        detail: `description 包含停用標記，但 is_active=true`,
        itemIds: [p.id],
      });
    }
  }
}

function parseTime(title: string): number | null {
  const m = title.match(/^(\d{2}):(\d{2})/);
  return m ? parseInt(m[1]) * 60 + parseInt(m[2]) : null;
}

function checkTimingConflicts(items: PlanItem[], issues: AuditIssue[]) {
  const active = items.filter(i => i.is_active);

  const calciumItems = active.filter(i =>
    i.title.includes('鈣') || i.description.includes('鈣片') || i.description.includes('500mg 鈣')
  );
  const ironItems = active.filter(i =>
    (i.title.includes('午餐') || i.title.includes('晚餐')) &&
    (i.description.includes('鐵') || i.description.includes('鐵質'))
  );

  for (const ca of calciumItems) {
    const caTime = parseTime(ca.title);
    if (caTime === null) continue;
    for (const fe of ironItems) {
      const feTime = parseTime(fe.title);
      if (feTime === null) continue;
      const diff = Math.abs(caTime - feTime);
      if (diff > 0 && diff < 120) {
        issues.push({
          severity: 'HIGH',
          category: '時間衝突',
          title: `鈣（${ca.title.slice(0, 5)}）距鐵餐（${fe.title.slice(0, 5)}）僅 ${diff} 分鐘`,
          detail: `鈣抑制鐵吸收，建議間隔 ≥2 小時`,
          itemIds: [ca.id, fe.id],
        });
      }
    }
  }

  const egcgItems = active.filter(i => i.title.includes('綠茶') || i.description.includes('EGCG'));
  const mineralItems = active.filter(i =>
    (i.description.includes('鎂') || i.description.includes('鋅') || i.description.includes('鐵')) &&
    i.category === '補充品'
  );

  for (const tea of egcgItems) {
    const teaTime = parseTime(tea.title);
    if (teaTime === null) continue;
    for (const min of mineralItems) {
      const minTime = parseTime(min.title);
      if (minTime === null) continue;
      const diff = Math.abs(teaTime - minTime);
      if (diff > 0 && diff < 180) {
        issues.push({
          severity: 'MEDIUM',
          category: '時間衝突',
          title: `綠茶 EGCG（${tea.title.slice(0, 5)}）距礦物質補充（${min.title.slice(0, 5)}）僅 ${diff} 分鐘`,
          detail: `EGCG 螯合二價陽離子，建議間隔 ≥3 小時`,
          itemIds: [tea.id, min.id],
        });
      }
    }
  }
}

function checkOrphanedProducts(items: PlanItem[], products: Product[], issues: AuditIssue[]) {
  const allText = items.filter(i => i.is_active).map(i => `${i.title} ${i.description}`).join('\n');

  for (const p of products.filter(p => p.is_active)) {
    const name = p.name.replace(/[（）()]/g, ' ').trim();
    const keywords = name.split(/[\s/×]+/).filter(w => w.length >= 2);
    const mentioned = keywords.some(kw => allText.includes(kw));
    const categoryMentioned = allText.includes(p.brand || '') ||
      (p.category === 'equipment' || p.category === 'personal_care');

    if (!mentioned && !categoryMentioned) {
      issues.push({
        severity: 'MEDIUM',
        category: '孤立產品',
        title: `產品「${p.name}」未被任何計畫項目引用`,
        detail: `active 產品但在計畫描述中找不到相關引用`,
        itemIds: [p.id],
      });
    }
  }
}

function checkNutrientTotals(items: PlanItem[], issues: AuditIssue[]) {
  const nutrients = calculateDailyNutrients(items);
  const labels: Record<string, string> = {
    protein: '蛋白質', calcium: '鈣', iron: '鐵', zinc: '鋅',
    magnesium: '鎂', fiber: '纖維', vitaminD: '維他命D', omega3: 'Omega-3',
  };

  for (const [key, data] of Object.entries(nutrients)) {
    const { value, unit, rda } = data as { value: number; unit: string; rda: number };
    if (value === 0) continue;
    const ratio = value / rda;
    const label = labels[key] || key;

    if (ratio < 0.7) {
      issues.push({
        severity: 'CRITICAL', category: '營養缺口',
        title: `${label} 嚴重不足：${value}${unit} / ${rda}${unit}（${Math.round(ratio * 100)}%）`,
        detail: `低於 RDA 70%，需立即補充`,
      });
    } else if (ratio < 0.9) {
      issues.push({
        severity: 'HIGH', category: '營養缺口',
        title: `${label} 略有不足：${value}${unit} / ${rda}${unit}（${Math.round(ratio * 100)}%）`,
        detail: `低於 RDA 90%，建議調整`,
      });
    }
  }
}
