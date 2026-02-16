'use client';

import { useRouter } from 'next/navigation';

interface WeekSelectorProps {
  monday: string;
  sunday: string;
  isCurrentWeek: boolean;
}

function formatShort(dateStr: string): string {
  const d = new Date(dateStr + 'T00:00:00');
  return `${d.getMonth() + 1}/${d.getDate()}`;
}

export default function WeekSelector({ monday, sunday, isCurrentWeek }: WeekSelectorProps) {
  const router = useRouter();

  function navigate(offset: number) {
    const d = new Date(monday + 'T00:00:00');
    d.setDate(d.getDate() + offset * 7);
    const newMonday = d.toLocaleDateString('sv-SE');
    router.push(`/history?week=${newMonday}`);
  }

  return (
    <div className="flex items-center justify-between bg-white rounded-xl border border-gray-200 px-4 py-3">
      <button
        type="button"
        onClick={() => navigate(-1)}
        className="p-2 rounded-lg hover:bg-gray-100 active:scale-95 transition-all"
      >
        <svg className="w-5 h-5 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
          <path strokeLinecap="round" strokeLinejoin="round" d="M15 19l-7-7 7-7" />
        </svg>
      </button>

      <div className="text-center">
        <p className="text-sm font-semibold text-gray-900">
          {formatShort(monday)} — {formatShort(sunday)}
        </p>
        {isCurrentWeek && (
          <p className="text-xs text-emerald-600 font-medium">本週</p>
        )}
      </div>

      <button
        type="button"
        onClick={() => navigate(1)}
        disabled={isCurrentWeek}
        className={`p-2 rounded-lg transition-all active:scale-95 ${
          isCurrentWeek ? 'opacity-30 cursor-not-allowed' : 'hover:bg-gray-100'
        }`}
      >
        <svg className="w-5 h-5 text-gray-600" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
          <path strokeLinecap="round" strokeLinejoin="round" d="M9 5l7 7-7 7" />
        </svg>
      </button>
    </div>
  );
}
