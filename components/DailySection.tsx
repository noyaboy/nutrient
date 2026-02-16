'use client';

import { useState, useTransition } from 'react';
import { toggleCompletion } from '@/app/actions/completions';
import TaskItem from './TaskItem';
import RecipeCard from './RecipeCard';
import type { PlanItemWithCompletion, DailyRecipes, Recipe } from '@/lib/types';

interface DailySectionProps {
  items: PlanItemWithCompletion[];
  targetDate: string;
  recipes?: DailyRecipes | null;
}

function getRecipeForItem(item: PlanItemWithCompletion, recipes: DailyRecipes | null | undefined): Recipe | null {
  if (!recipes) return null;
  if (item.title.includes('訓練後')) return recipes.postWorkout;
  if (item.title.includes('午餐')) return recipes.lunch;
  if (item.title.includes('晚餐')) return recipes.dinner;
  return null;
}

interface TimeGroup {
  key: string;
  label: string;
  items: PlanItemWithCompletion[];
}

function getTimeMinutes(title: string): number | null {
  const match = title.match(/^(\d{2}):(\d{2})/);
  if (!match) return null;
  return parseInt(match[1]) * 60 + parseInt(match[2]);
}

function groupItems(items: PlanItemWithCompletion[]): TimeGroup[] {
  const groups: TimeGroup[] = [
    { key: 'morning', label: '早晨', items: [] },
    { key: 'midday', label: '中午', items: [] },
    { key: 'afternoon', label: '下午', items: [] },
    { key: 'evening', label: '晚間', items: [] },
    { key: 'allday', label: '全天', items: [] },
  ];

  for (const item of items) {
    const time = getTimeMinutes(item.title);
    if (time === null) {
      groups[4].items.push(item);
    } else if (time < 660) {
      groups[0].items.push(item);
    } else if (time < 900) {
      groups[1].items.push(item);
    } else if (time < 1140) {
      groups[2].items.push(item);
    } else {
      groups[3].items.push(item);
    }
  }

  return groups.filter(g => g.items.length > 0);
}

function AllDayItem({ item, targetDate }: { item: PlanItemWithCompletion; targetDate: string }) {
  const [isPending, startTransition] = useTransition();
  const isCompleted = !!item.completion;
  const shortTitle = item.title.replace(/^全天\s*/, '');

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
      className={`flex items-center gap-2.5 p-3 rounded-lg text-left transition-all active:scale-[0.97] ${
        isCompleted
          ? 'bg-emerald-50 border border-emerald-200'
          : 'bg-white border border-gray-200'
      } ${isPending ? 'opacity-60' : ''}`}
    >
      <div
        className={`w-4 h-4 rounded flex-shrink-0 flex items-center justify-center transition-colors ${
          isCompleted ? 'bg-emerald-500' : 'border-2 border-gray-300'
        }`}
      >
        {isCompleted && (
          <svg className="w-2.5 h-2.5 text-white" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={3}>
            <path strokeLinecap="round" strokeLinejoin="round" d="M5 13l4 4L19 7" />
          </svg>
        )}
      </div>
      <span className={`text-sm font-medium leading-tight ${isCompleted ? 'line-through text-gray-400' : 'text-gray-700'}`}>
        {shortTitle}
      </span>
    </button>
  );
}

export default function DailySection({ items, targetDate, recipes }: DailySectionProps) {
  const groups = groupItems(items);
  const [collapsedGroups, setCollapsedGroups] = useState<Set<string>>(new Set());

  function toggleGroup(key: string) {
    setCollapsedGroups(prev => {
      const next = new Set(prev);
      if (next.has(key)) next.delete(key);
      else next.add(key);
      return next;
    });
  }

  return (
    <div className="space-y-4">
      {groups.map(group => {
        const completed = group.items.filter(i => i.completion).length;
        const total = group.items.length;
        const isCollapsed = collapsedGroups.has(group.key);
        const allDone = completed === total;

        return (
          <div key={group.key}>
            <button
              type="button"
              onClick={() => toggleGroup(group.key)}
              className="w-full flex items-center justify-between py-2 px-1"
            >
              <div className="flex items-center gap-2">
                <svg
                  className={`w-4 h-4 text-gray-400 transition-transform ${isCollapsed ? '-rotate-90' : ''}`}
                  fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}
                >
                  <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
                </svg>
                <span className="text-sm font-semibold text-gray-500">{group.label}</span>
              </div>
              <span className={`text-xs font-medium ${allDone ? 'text-emerald-600' : 'text-gray-400'}`}>
                {completed}/{total}
              </span>
            </button>

            {!isCollapsed && (
              group.key === 'allday' ? (
                <div className="grid grid-cols-2 gap-2 mt-1">
                  {group.items.map(item => (
                    <AllDayItem key={item.id} item={item} targetDate={targetDate} />
                  ))}
                </div>
              ) : (
                <div className="space-y-2 mt-1">
                  {group.items.map(item => {
                    const recipe = getRecipeForItem(item, recipes);
                    return (
                      <div key={item.id} className="space-y-2">
                        <TaskItem item={item} targetDate={targetDate} />
                        {recipe && <RecipeCard recipe={recipe} />}
                      </div>
                    );
                  })}
                </div>
              )
            )}
          </div>
        );
      })}
    </div>
  );
}
