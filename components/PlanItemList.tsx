'use client';

import { useState, useTransition } from 'react';
import { deletePlanItem, movePlanItem } from '@/app/actions/plan-items';
import { getCategoryColor } from '@/lib/utils';
import { UI } from '@/lib/constants';
import type { PlanItem } from '@/lib/types';
import PlanItemForm from './PlanItemForm';

interface PlanItemListProps {
  items: PlanItem[];
  frequency: 'daily' | 'weekly';
}

export default function PlanItemList({ items, frequency }: PlanItemListProps) {
  const [editingItem, setEditingItem] = useState<PlanItem | null>(null);
  const [showAddForm, setShowAddForm] = useState(false);
  const [isPending, startTransition] = useTransition();

  function handleDelete(id: string) {
    if (!confirm(UI.settings.deleteConfirm)) return;
    startTransition(() => {
      deletePlanItem(id);
    });
  }

  function handleMove(id: string, direction: 'up' | 'down') {
    startTransition(() => {
      movePlanItem(id, frequency, direction);
    });
  }

  return (
    <div className="space-y-3">
      <div className="flex items-center justify-between">
        <h2 className="text-base font-bold text-gray-900">
          {frequency === 'daily' ? UI.settings.dailyTab : UI.settings.weeklyTab}
        </h2>
        <button
          onClick={() => setShowAddForm(true)}
          className="px-3 py-1.5 bg-emerald-600 hover:bg-emerald-700 text-white text-sm font-medium rounded-lg transition-colors"
        >
          + {UI.settings.addItem}
        </button>
      </div>

      {items.length === 0 ? (
        <p className="text-gray-400 text-sm py-4 text-center">{UI.dashboard.empty}</p>
      ) : (
        <div className={`space-y-2 ${isPending ? 'opacity-60' : ''}`}>
          {items.map((item, index) => (
            <div key={item.id} className="flex items-center gap-2 p-3 bg-white rounded-xl border border-gray-200">
              <div className="flex flex-col gap-0.5">
                <button
                  onClick={() => handleMove(item.id, 'up')}
                  disabled={index === 0 || isPending}
                  className="p-1 text-gray-400 hover:text-gray-600 disabled:opacity-30"
                >
                  <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                    <path strokeLinecap="round" strokeLinejoin="round" d="M5 15l7-7 7 7" />
                  </svg>
                </button>
                <button
                  onClick={() => handleMove(item.id, 'down')}
                  disabled={index === items.length - 1 || isPending}
                  className="p-1 text-gray-400 hover:text-gray-600 disabled:opacity-30"
                >
                  <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                    <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
                  </svg>
                </button>
              </div>
              <div className="flex-1 min-w-0">
                <p className="text-base font-medium text-gray-900">{item.title}</p>
                {item.description && (
                  <p className="text-sm text-gray-500 line-clamp-2">{item.description}</p>
                )}
              </div>
              <span className={`flex-shrink-0 text-xs px-2 py-1 rounded-full ${getCategoryColor(item.category)}`}>
                {item.category}
              </span>
              <button
                onClick={() => setEditingItem(item)}
                className="p-2 text-gray-400 hover:text-emerald-600 transition-colors"
              >
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M11 5H6a2 2 0 00-2 2v11a2 2 0 002 2h11a2 2 0 002-2v-5m-1.414-9.414a2 2 0 112.828 2.828L11.828 15H9v-2.828l8.586-8.586z" />
                </svg>
              </button>
              <button
                onClick={() => handleDelete(item.id)}
                className="p-2 text-gray-400 hover:text-red-600 transition-colors"
              >
                <svg className="w-4 h-4" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M19 7l-.867 12.142A2 2 0 0116.138 21H7.862a2 2 0 01-1.995-1.858L5 7m5 4v6m4-6v6m1-10V4a1 1 0 00-1-1h-4a1 1 0 00-1 1v3M4 7h16" />
                </svg>
              </button>
            </div>
          ))}
        </div>
      )}

      {showAddForm && (
        <PlanItemForm defaultFrequency={frequency} onClose={() => setShowAddForm(false)} />
      )}
      {editingItem && (
        <PlanItemForm item={editingItem} defaultFrequency={frequency} onClose={() => setEditingItem(null)} />
      )}
    </div>
  );
}
