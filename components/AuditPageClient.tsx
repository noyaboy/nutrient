'use client';

import { useState } from 'react';
import type { NutrientData, TimeSlot, AuditIssue } from '@/lib/types';

type Tab = 'nutrients' | 'timeline' | 'issues';

const TAB_LABELS: Record<Tab, string> = {
  nutrients: '營養總計',
  timeline: '時間軸',
  issues: '問題檢查',
};

const NUTRIENT_LABELS: Record<string, string> = {
  protein: '蛋白質',
  calcium: '鈣',
  iron: '鐵',
  zinc: '鋅',
  magnesium: '鎂',
  fiber: '纖維',
  vitaminD: '維他命D',
  omega3: 'Omega-3',
};

function NutrientCard({ label, value, unit, rda }: { label: string; value: number; unit: string; rda: number }) {
  const ratio = rda > 0 ? value / rda : 0;
  const color = ratio >= 0.9 ? 'bg-emerald-50 border-emerald-200 text-emerald-700'
    : ratio >= 0.7 ? 'bg-amber-50 border-amber-200 text-amber-700'
    : 'bg-red-50 border-red-200 text-red-700';
  const barColor = ratio >= 0.9 ? 'bg-emerald-500'
    : ratio >= 0.7 ? 'bg-amber-500'
    : 'bg-red-500';

  return (
    <div className={`rounded-xl border p-3 ${color}`}>
      <div className="text-xs font-medium opacity-70">{label}</div>
      <div className="text-lg font-bold mt-0.5">
        {value > 0 ? value : '—'}<span className="text-xs font-normal ml-0.5">{unit}</span>
      </div>
      <div className="text-xs opacity-60 mt-0.5">RDA {rda}{unit}</div>
      {value > 0 && (
        <div className="mt-2 h-1.5 rounded-full bg-white/50 overflow-hidden">
          <div className={`h-full rounded-full ${barColor}`} style={{ width: `${Math.min(ratio * 100, 100)}%` }} />
        </div>
      )}
      <div className="text-xs mt-1 font-medium">{value > 0 ? `${Math.round(ratio * 100)}%` : '未偵測'}</div>
    </div>
  );
}

function NutrientsTab({ nutrients }: { nutrients: NutrientData }) {
  return (
    <div className="grid grid-cols-2 gap-3">
      {Object.entries(nutrients).map(([key, data]) => (
        <NutrientCard
          key={key}
          label={NUTRIENT_LABELS[key] || key}
          value={data.value}
          unit={data.unit}
          rda={data.rda}
        />
      ))}
    </div>
  );
}

function TimelineTab({ timeline }: { timeline: TimeSlot[] }) {
  return (
    <div className="space-y-4">
      {timeline.map(slot => (
        <div key={slot.time} className="relative pl-6">
          <div className="absolute left-0 top-0 bottom-0 w-0.5 bg-gray-200" />
          <div className="absolute left-[-4px] top-1 w-2.5 h-2.5 rounded-full bg-emerald-500 border-2 border-white" />
          <div className="text-sm font-bold text-emerald-700 mb-1">{slot.time}</div>
          <div className="space-y-1.5">
            {slot.items.map(item => (
              <div key={item.id} className="bg-white rounded-lg border border-gray-100 p-2.5 text-sm">
                <div className="font-medium text-gray-800">
                  {item.title.replace(/^\d{2}:\d{2}\s*/, '')}
                </div>
                {item.frequency === 'weekly' && (
                  <span className="inline-block mt-1 px-1.5 py-0.5 rounded text-xs bg-blue-50 text-blue-600">每週</span>
                )}
              </div>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}

const SEVERITY_STYLE: Record<string, string> = {
  CRITICAL: 'bg-red-50 border-red-200',
  HIGH: 'bg-amber-50 border-amber-200',
  MEDIUM: 'bg-sky-50 border-sky-200',
};

const SEVERITY_BADGE: Record<string, string> = {
  CRITICAL: 'bg-red-500 text-white',
  HIGH: 'bg-amber-500 text-white',
  MEDIUM: 'bg-sky-500 text-white',
};

function IssuesTab({ issues }: { issues: AuditIssue[] }) {
  if (issues.length === 0) {
    return (
      <div className="text-center py-12 text-gray-400">
        <div className="text-4xl mb-2">✅</div>
        <div>沒有發現問題</div>
      </div>
    );
  }

  const grouped = {
    CRITICAL: issues.filter(i => i.severity === 'CRITICAL'),
    HIGH: issues.filter(i => i.severity === 'HIGH'),
    MEDIUM: issues.filter(i => i.severity === 'MEDIUM'),
  };

  return (
    <div className="space-y-3">
      <div className="flex gap-2 text-sm">
        <span className="px-2 py-0.5 rounded-full bg-red-100 text-red-700 font-medium">
          {grouped.CRITICAL.length} 嚴重
        </span>
        <span className="px-2 py-0.5 rounded-full bg-amber-100 text-amber-700 font-medium">
          {grouped.HIGH.length} 重要
        </span>
        <span className="px-2 py-0.5 rounded-full bg-sky-100 text-sky-700 font-medium">
          {grouped.MEDIUM.length} 一般
        </span>
      </div>
      {issues.map((issue, i) => (
        <div key={i} className={`rounded-xl border p-3 ${SEVERITY_STYLE[issue.severity]}`}>
          <div className="flex items-start gap-2">
            <span className={`text-xs px-1.5 py-0.5 rounded font-bold shrink-0 ${SEVERITY_BADGE[issue.severity]}`}>
              {issue.severity}
            </span>
            <div>
              <div className="text-sm font-medium text-gray-800">{issue.title}</div>
              <div className="text-xs text-gray-500 mt-1 whitespace-pre-line">{issue.detail}</div>
            </div>
          </div>
        </div>
      ))}
    </div>
  );
}

export default function AuditPageClient({
  nutrients,
  timeline,
  issues,
}: {
  nutrients: NutrientData;
  timeline: TimeSlot[];
  issues: AuditIssue[];
}) {
  const [tab, setTab] = useState<Tab>('nutrients');

  return (
    <div>
      <h1 className="text-xl font-bold text-gray-800 mb-4">審計儀表板</h1>

      {/* Tabs */}
      <div className="flex bg-gray-100 rounded-xl p-1 mb-4">
        {(Object.keys(TAB_LABELS) as Tab[]).map(t => (
          <button
            key={t}
            onClick={() => setTab(t)}
            className={`flex-1 py-2 text-sm font-medium rounded-lg transition-colors ${
              tab === t ? 'bg-white text-emerald-700 shadow-sm' : 'text-gray-500'
            }`}
          >
            {TAB_LABELS[t]}
            {t === 'issues' && issues.length > 0 && (
              <span className="ml-1 inline-flex items-center justify-center w-5 h-5 text-xs rounded-full bg-red-500 text-white">
                {issues.length}
              </span>
            )}
          </button>
        ))}
      </div>

      {/* Content */}
      {tab === 'nutrients' && <NutrientsTab nutrients={nutrients} />}
      {tab === 'timeline' && <TimelineTab timeline={timeline} />}
      {tab === 'issues' && <IssuesTab issues={issues} />}
    </div>
  );
}
