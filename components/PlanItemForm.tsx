'use client';

import { useRef } from 'react';
import { createPlanItem, updatePlanItem } from '@/app/actions/plan-items';
import { UI } from '@/lib/constants';
import type { PlanItem } from '@/lib/types';

interface PlanItemFormProps {
  item?: PlanItem;
  defaultFrequency: 'daily' | 'weekly';
  onClose: () => void;
}

export default function PlanItemForm({ item, defaultFrequency, onClose }: PlanItemFormProps) {
  const formRef = useRef<HTMLFormElement>(null);

  async function handleSubmit(formData: FormData) {
    if (item) {
      await updatePlanItem(item.id, formData);
    } else {
      await createPlanItem(formData);
    }
    onClose();
  }

  return (
    <div className="fixed inset-0 z-50 flex items-end sm:items-center justify-center bg-black/50" onClick={onClose}>
      <div
        className="w-full max-w-lg bg-white rounded-t-2xl sm:rounded-2xl p-6 space-y-4 animate-slide-up"
        onClick={e => e.stopPropagation()}
      >
        <h2 className="text-lg font-bold text-gray-900">
          {item ? UI.settings.editItem : UI.settings.addItem}
        </h2>
        <form ref={formRef} action={handleSubmit} className="space-y-4">
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">{UI.settings.titleLabel}</label>
            <input
              name="title"
              type="text"
              required
              defaultValue={item?.title || ''}
              className="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-base"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">{UI.settings.descriptionLabel}</label>
            <input
              name="description"
              type="text"
              defaultValue={item?.description || ''}
              className="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-base"
            />
          </div>
          <div>
            <label className="block text-sm font-medium text-gray-700 mb-1">{UI.settings.categoryLabel}</label>
            <select
              name="category"
              defaultValue={item?.category || '一般'}
              className="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-base bg-white"
            >
              {UI.categories.map(cat => (
                <option key={cat} value={cat}>{cat}</option>
              ))}
            </select>
          </div>
          {!item && (
            <input type="hidden" name="frequency" value={defaultFrequency} />
          )}
          <div className="flex gap-3 pt-2">
            <button
              type="button"
              onClick={onClose}
              className="flex-1 py-3 px-4 bg-gray-100 hover:bg-gray-200 text-gray-700 font-medium rounded-lg transition-colors text-base"
            >
              {UI.settings.cancel}
            </button>
            <button
              type="submit"
              className="flex-1 py-3 px-4 bg-emerald-600 hover:bg-emerald-700 text-white font-medium rounded-lg transition-colors text-base"
            >
              {UI.settings.save}
            </button>
          </div>
        </form>
      </div>
    </div>
  );
}
