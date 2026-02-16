'use client';

import { useState } from 'react';
import RecipeCard from './RecipeCard';
import type { Recipe } from '@/lib/types';

interface AllRecipesSectionProps {
  postWorkout: Recipe[];
  lunch: Recipe[];
  dinner: Recipe[];
}

const mealLabels: { key: string; label: string; recipes: 'postWorkout' | 'lunch' | 'dinner' }[] = [
  { key: 'postWorkout', label: '訓練後', recipes: 'postWorkout' },
  { key: 'lunch', label: '午餐', recipes: 'lunch' },
  { key: 'dinner', label: '晚餐', recipes: 'dinner' },
];

export default function AllRecipesSection({ postWorkout, lunch, dinner }: AllRecipesSectionProps) {
  const [expanded, setExpanded] = useState(false);
  const [activeTab, setActiveTab] = useState<'postWorkout' | 'lunch' | 'dinner'>('postWorkout');

  const recipesMap = { postWorkout, lunch, dinner };
  const activeRecipes = recipesMap[activeTab];

  return (
    <section className="space-y-3">
      <button
        type="button"
        onClick={() => setExpanded(!expanded)}
        className="w-full flex items-center justify-between"
      >
        <h2 className="text-base font-bold text-gray-900">所有食譜</h2>
        <div className="flex items-center gap-2">
          <span className="text-xs text-gray-400">{postWorkout.length + lunch.length + dinner.length} 道</span>
          <svg
            className={`w-4 h-4 text-gray-400 transition-transform ${expanded ? 'rotate-180' : ''}`}
            fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}
          >
            <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
          </svg>
        </div>
      </button>

      {expanded && (
        <div className="space-y-3">
          <div className="flex gap-2">
            {mealLabels.map(({ key, label, recipes }) => (
              <button
                key={key}
                type="button"
                onClick={() => setActiveTab(recipes)}
                className={`flex-1 py-2 text-sm font-medium rounded-lg transition-colors ${
                  activeTab === recipes
                    ? 'bg-emerald-100 text-emerald-700'
                    : 'bg-gray-100 text-gray-500'
                }`}
              >
                {label} ({recipesMap[recipes].length})
              </button>
            ))}
          </div>

          <div className="space-y-2">
            {activeRecipes.map(recipe => (
              <RecipeCard key={recipe.id} recipe={recipe} />
            ))}
          </div>
        </div>
      )}
    </section>
  );
}
