'use client';

import { useTransition } from 'react';
import { toggleWeeklyDayCompletion } from '@/app/actions/completions';
import { getCategoryColor } from '@/lib/utils';
import type { WeeklyItemWithCompletions } from '@/lib/types';

interface WeeklyTaskItemProps {
  item: WeeklyItemWithCompletions;
  weekDates: string[];
  today: string;
}

const DAY_LABELS = ['一', '二', '三', '四', '五', '六', '日'];

export default function WeeklyTaskItem({ item, weekDates, today }: WeeklyTaskItemProps) {
  const [isPending, startTransition] = useTransition();
  const completedDates = new Set(item.completions.map(c => c.target_date));
  const completedCount = completedDates.size;
  const isGoalMet = completedCount >= item.targetCount;

  function handleDayToggle(date: string) {
    const isCompleted = completedDates.has(date);
    startTransition(() => {
      toggleWeeklyDayCompletion(item.id, date, isCompleted);
    });
  }

  return (
    <div
      className={`p-4 rounded-xl transition-all ${
        isGoalMet
          ? 'bg-emerald-50 border border-emerald-200'
          : 'bg-white border border-gray-200'
      } ${isPending ? 'opacity-60' : ''}`}
    >
      <div className="flex items-start justify-between gap-2 mb-3">
        <div className="flex-1 min-w-0">
          <p className={`text-base font-medium ${isGoalMet ? 'text-gray-400' : 'text-gray-900'}`}>
            {item.title}
          </p>
          {item.description && (
            <p className="text-sm text-gray-500 mt-0.5">{item.description}</p>
          )}
        </div>
        <div className="flex items-center gap-2 flex-shrink-0">
          <span className={`text-sm font-bold ${isGoalMet ? 'text-emerald-600' : 'text-gray-400'}`}>
            {completedCount}/{item.targetCount}
          </span>
          <span className={`text-xs px-2 py-1 rounded-full ${getCategoryColor(item.category)}`}>
            {item.category}
          </span>
        </div>
      </div>

      <div className="flex items-center gap-1">
        {weekDates.map((date, i) => {
          const isDone = completedDates.has(date);
          const isToday = date === today;
          const isFuture = date > today;

          return (
            <button
              key={date}
              type="button"
              onClick={() => handleDayToggle(date)}
              disabled={isPending || isFuture}
              className={`flex flex-col items-center gap-1 flex-1 py-1.5 rounded-lg transition-all ${
                isFuture ? 'cursor-not-allowed' : 'active:scale-95'
              } ${isToday ? 'ring-2 ring-emerald-400 ring-offset-1' : ''}`}
            >
              <span className={`text-xs font-medium ${
                isToday ? 'text-emerald-700' : isFuture ? 'text-gray-300' : 'text-gray-500'
              }`}>
                {DAY_LABELS[i]}
              </span>
              <div
                className={`w-8 h-8 rounded-full flex items-center justify-center transition-colors ${
                  isDone
                    ? 'bg-emerald-500'
                    : isToday
                      ? 'bg-emerald-100 border-2 border-emerald-300'
                      : isFuture
                        ? 'bg-gray-50 border border-gray-200'
                        : 'bg-gray-100 border border-gray-200'
                }`}
              >
                {isDone && (
                  <svg className="w-4 h-4 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                    <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                  </svg>
                )}
              </div>
            </button>
          );
        })}
      </div>
    </div>
  );
}
