'use client';

import { useTransition } from 'react';
import { toggleCompletion } from '@/app/actions/completions';
import { getCategoryColor } from '@/lib/utils';
import type { PlanItemWithCompletion } from '@/lib/types';

interface TaskItemProps {
  item: PlanItemWithCompletion;
  targetDate: string;
}

export default function TaskItem({ item, targetDate }: TaskItemProps) {
  const [isPending, startTransition] = useTransition();
  const isCompleted = !!item.completion;

  function handleToggle() {
    startTransition(() => {
      toggleCompletion(item.id, targetDate, isCompleted);
    });
  }

  return (
    <button
      type="button"
      onClick={handleToggle}
      disabled={isPending}
      className={`w-full flex items-center gap-3 p-4 rounded-xl transition-all active:scale-[0.98] text-left ${
        isCompleted
          ? 'bg-emerald-50 border border-emerald-200'
          : 'bg-white border border-gray-200'
      } ${isPending ? 'opacity-60' : ''}`}
    >
      <div
        className={`flex-shrink-0 w-6 h-6 rounded-full border-2 flex items-center justify-center transition-colors ${
          isCompleted
            ? 'bg-emerald-500 border-emerald-500'
            : 'border-gray-300'
        }`}
      >
        {isCompleted && (
          <svg className="w-3.5 h-3.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
          </svg>
        )}
      </div>
      <div className="flex-1 min-w-0">
        <p className={`text-base font-medium ${isCompleted ? 'line-through text-gray-400' : 'text-gray-900'}`}>
          {item.title}
        </p>
        {item.description && (
          <p className="text-sm text-gray-500 truncate">{item.description}</p>
        )}
      </div>
      <span className={`flex-shrink-0 text-xs px-2 py-1 rounded-full ${getCategoryColor(item.category)}`}>
        {item.category}
      </span>
    </button>
  );
}
