'use client';

import { useState, useTransition } from 'react';
import { toggleWeeklyDayCompletion } from '@/app/actions/completions';
import { getCategoryColor, DAY_LABELS } from '@/lib/utils';
import type { WeeklyItemWithCompletions } from '@/lib/types';

interface WeeklyTaskItemProps {
  item: WeeklyItemWithCompletions;
  weekDates: string[];
  today: string;
  details?: React.ReactNode;
}

export default function WeeklyTaskItem({ item, weekDates, today, details }: WeeklyTaskItemProps) {
  const [isPending, startTransition] = useTransition();
  const [expanded, setExpanded] = useState(true);
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
      className={`rounded-xl transition-all ${
        isGoalMet
          ? 'bg-emerald-50 border border-emerald-200'
          : 'bg-white border border-gray-200'
      } ${isPending ? 'opacity-60' : ''}`}
    >
      <div className="p-4">
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
            <span className={`text-base font-bold ${isGoalMet ? 'text-emerald-600' : 'text-gray-400'}`}>
              {completedCount}/{item.targetCount}
            </span>
            <span className={`text-sm px-2.5 py-1 rounded-full ${getCategoryColor(item.category)}`}>
              {item.category}
            </span>
            {details && (
              <button
                type="button"
                onClick={() => setExpanded(!expanded)}
                className="p-1 text-gray-400 hover:text-gray-600 transition-colors"
              >
                <svg
                  className={`w-4 h-4 transition-transform ${expanded ? 'rotate-180' : ''}`}
                  fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}
                >
                  <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
                </svg>
              </button>
            )}
          </div>
        </div>

        <div className="flex items-center gap-1.5">
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
                className={`flex flex-col items-center gap-1.5 flex-1 py-2 rounded-lg transition-all ${
                  isFuture ? 'cursor-not-allowed' : 'active:scale-95'
                } ${isToday ? 'ring-2 ring-emerald-400 ring-offset-1' : ''}`}
              >
                <span className={`text-sm font-medium ${
                  isToday ? 'text-emerald-800' : isFuture ? 'text-gray-300' : 'text-gray-600'
                }`}>
                  {DAY_LABELS[i]}
                </span>
                <div
                  className={`w-9 h-9 rounded-full flex items-center justify-center transition-colors ${
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
                    <svg className="w-4.5 h-4.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                      <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
                    </svg>
                  )}
                </div>
              </button>
            );
          })}
        </div>
      </div>

      {expanded && details && (
        <div className="px-4 pb-4 border-t border-gray-100 pt-3">
          {details}
        </div>
      )}
    </div>
  );
}
