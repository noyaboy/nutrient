import type { PlanItem, Product, AuditIssue, NutrientData, TimeSlot } from './types';

// --- Nutrient parsing ---

interface NutrientPattern {
  key: keyof NutrientData;
  patterns: RegExp[];
  unit: string;
  rda: number;
}

const NUTRIENT_PATTERNS: NutrientPattern[] = [
  {
    key: 'protein',
    patterns: [/蛋白質?\s*(\d+)[-.~～](\d+)\s*g/g, /蛋白質?\s*(\d+)\s*g/g, /蛋白\s*(\d+)\s*g/g, /(\d+)\s*g\s*蛋白/g],
    unit: 'g',
    rda: 197, // midpoint of 191-203
  },
  {
    key: 'calcium',
    patterns: [/鈣\s*(\d+)[-.~～](\d+)\s*mg/g, /鈣\s*(\d+)\s*mg/g, /(\d+)\s*mg\s*鈣/g],
    unit: 'mg',
    rda: 1000,
  },
  {
    key: 'iron',
    patterns: [/鐵\s*(\d+)[-.~～](\d+)\s*mg/g, /鐵\s*(\d+)\s*mg/g],
    unit: 'mg',
    rda: 8,
  },
  {
    key: 'zinc',
    patterns: [/鋅\s*(\d+)[-.~～](\d+)\s*mg/g, /鋅\s*(\d+)\s*mg/g],
    unit: 'mg',
    rda: 11,
  },
  {
    key: 'magnesium',
    patterns: [/鎂\s*(\d+)[-.~～](\d+)\s*mg/g, /鎂\s*(\d+)\s*mg/g],
    unit: 'mg',
    rda: 400,
  },
  {
    key: 'fiber',
    patterns: [/纖維\s*(\d+)[-.~～](\d+)\s*g/g, /纖維\s*(\d+)\s*g/g],
    unit: 'g',
    rda: 38,
  },
  {
    key: 'vitaminD',
    patterns: [/D3?\s*(\d+)[-.~～](\d+)\s*IU/g, /D3?\s*(\d+)\s*IU/g],
    unit: 'IU',
    rda: 2000,
  },
  {
    key: 'omega3',
    patterns: [/EPA\+DHA\s*(?:共\s*)?(\d+)\s*mg/g, /[Oo]mega.?3\s*(?:約\s*)?(\d+)\s*mg/g],
    unit: 'mg',
    rda: 1400,
  },
];

function parseNumber(text: string, patterns: RegExp[]): number {
  let total = 0;
  for (const pattern of patterns) {
    pattern.lastIndex = 0;
    let match;
    while ((match = pattern.exec(text)) !== null) {
      if (match[2]) {
        // Range: use midpoint
        total += (parseFloat(match[1]) + parseFloat(match[2])) / 2;
      } else {
        total += parseFloat(match[1]);
      }
    }
  }
  return total;
}

export function calculateDailyNutrients(planItems: PlanItem[]): NutrientData {
  const activeDaily = planItems.filter(i => i.is_active && i.frequency === 'daily');
  const combined = activeDaily.map(i => `${i.title} ${i.description}`).join('\n');

  const result = {} as NutrientData;
  for (const np of NUTRIENT_PATTERNS) {
    result[np.key] = {
      value: parseNumber(combined, np.patterns),
      unit: np.unit,
      rda: np.rda,
    };
  }
  return result;
}

// --- Timeline extraction ---

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

// --- Audit checks ---

export function runAuditChecks(planItems: PlanItem[], products: Product[]): AuditIssue[] {
  const issues: AuditIssue[] = [];

  // 1. Duplicate time-slot items
  checkDuplicates(planItems, issues);

  // 2. Stale products
  checkStaleProducts(products, issues);

  // 3. Timing conflicts
  checkTimingConflicts(planItems, issues);

  // 4. Orphaned products
  checkOrphanedProducts(planItems, products, issues);

  // 5. Nutrient totals vs RDA
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
    if (group.length > 1) {
      const [time, category] = key.split('|');
      // Check for genuinely duplicate content (similar titles)
      const titles = group.map(i => i.title.replace(/^\d{2}:\d{2}\s*/, ''));
      const seen = new Set<string>();
      const dupes: PlanItem[] = [];
      for (let i = 0; i < titles.length; i++) {
        const normalized = titles[i].slice(0, 10);
        if (seen.has(normalized)) {
          dupes.push(group[i]);
        } else {
          seen.add(normalized);
          // Check if any previous title is very similar
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
}

function checkStaleProducts(products: Product[], issues: AuditIssue[]) {
  const stale = products.filter(p => p.is_active && (
    p.description.includes('已停用') ||
    p.description.includes('⛔') ||
    p.purchase_note.includes('已停用')
  ));

  for (const p of stale) {
    issues.push({
      severity: 'CRITICAL',
      category: '過期產品',
      title: `產品「${p.name}」標記已停用但仍為 active`,
      detail: `description 包含停用標記，但 is_active=true`,
      itemIds: [p.id],
    });
  }
}

function parseTime(title: string): number | null {
  const m = title.match(/^(\d{2}):(\d{2})/);
  if (!m) return null;
  return parseInt(m[1]) * 60 + parseInt(m[2]);
}

function checkTimingConflicts(items: PlanItem[], issues: AuditIssue[]) {
  const active = items.filter(i => i.is_active);

  // Find calcium items
  const calciumItems = active.filter(i =>
    i.title.includes('鈣') || i.description.includes('鈣片') || i.description.includes('500mg 鈣')
  );

  // Find iron meal items
  const ironItems = active.filter(i =>
    (i.title.includes('午餐') || i.title.includes('晚餐')) &&
    (i.description.includes('鐵') || i.description.includes('鐵質'))
  );

  // Calcium <2hr from iron meals
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

  // EGCG <3hr from mineral supplements
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
  const activeProducts = products.filter(p => p.is_active);
  const allText = items.filter(i => i.is_active).map(i => `${i.title} ${i.description}`).join('\n');

  for (const p of activeProducts) {
    // Extract meaningful keywords from product name
    const name = p.name.replace(/[（）\(\)]/g, ' ').trim();
    const keywords = name.split(/[\s\/×]+/).filter(w => w.length >= 2);

    // Check if any keyword appears in plan items
    const mentioned = keywords.some(kw => allText.includes(kw));

    // Also check category-level mentions
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

  for (const [key, data] of Object.entries(nutrients)) {
    const { value, unit, rda } = data as { value: number; unit: string; rda: number };
    if (value === 0) continue; // Skip if we couldn't parse

    const ratio = value / rda;
    const label = {
      protein: '蛋白質', calcium: '鈣', iron: '鐵', zinc: '鋅',
      magnesium: '鎂', fiber: '纖維', vitaminD: '維他命D', omega3: 'Omega-3',
    }[key] || key;

    if (ratio < 0.7) {
      issues.push({
        severity: 'CRITICAL',
        category: '營養缺口',
        title: `${label} 嚴重不足：${value}${unit} / ${rda}${unit}（${Math.round(ratio * 100)}%）`,
        detail: `低於 RDA 70%，需立即補充`,
      });
    } else if (ratio < 0.9) {
      issues.push({
        severity: 'HIGH',
        category: '營養缺口',
        title: `${label} 略有不足：${value}${unit} / ${rda}${unit}（${Math.round(ratio * 100)}%）`,
        detail: `低於 RDA 90%，建議調整`,
      });
    }
  }
}
