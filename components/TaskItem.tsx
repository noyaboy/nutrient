'use client';

import { useState, useTransition } from 'react';
import { toggleCompletion } from '@/app/actions/completions';
import { getCategoryColor } from '@/lib/utils';
import type { PlanItemWithCompletion } from '@/lib/types';

interface TaskItemProps {
  item: PlanItemWithCompletion;
  targetDate: string;
}

export default function TaskItem({ item, targetDate }: TaskItemProps) {
  const [isPending, startTransition] = useTransition();
  const [expanded, setExpanded] = useState(false);
  const isCompleted = !!item.completion;

  function handleToggle() {
    startTransition(() => {
      toggleCompletion(item.id, targetDate, isCompleted);
    });
  }

  return (
    <div
      className={`rounded-xl transition-all ${
        isCompleted
          ? 'bg-emerald-50 border border-emerald-200'
          : 'bg-white border border-gray-200'
      } ${isPending ? 'opacity-60' : ''}`}
    >
      <div className="flex items-center gap-3 p-4">
        <button
          type="button"
          onClick={handleToggle}
          disabled={isPending}
          className="flex-shrink-0 active:scale-90 transition-transform"
        >
          <div
            className={`w-6 h-6 rounded-full border-2 flex items-center justify-center transition-colors ${
              isCompleted ? 'bg-emerald-500 border-emerald-500' : 'border-gray-300'
            }`}
          >
            {isCompleted && (
              <svg className="w-3.5 h-3.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
                <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
              </svg>
            )}
          </div>
        </button>
        <button
          type="button"
          onClick={handleToggle}
          disabled={isPending}
          className="flex-1 min-w-0 text-left"
        >
          <p className={`text-base font-medium ${isCompleted ? 'line-through text-gray-400' : 'text-gray-900'}`}>
            {item.title}
          </p>
        </button>
        <span className={`flex-shrink-0 text-xs px-2 py-1 rounded-full ${getCategoryColor(item.category)}`}>
          {item.category}
        </span>
        {item.description && (
          <button
            type="button"
            onClick={() => setExpanded(!expanded)}
            className="flex-shrink-0 p-2 -mr-2 text-gray-400 hover:text-gray-600 transition-colors"
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
      {expanded && item.description && (
        <div className="px-4 pb-3 pl-[52px]">
          <p className="text-sm text-gray-500">{item.description}</p>
        </div>
      )}
    </div>
  );
}
