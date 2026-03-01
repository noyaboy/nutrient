'use client';

import { useState } from 'react';
import type { Recipe } from '@/lib/types';

interface RecipeCardProps {
  recipe: Recipe;
}

export default function RecipeCard({ recipe }: RecipeCardProps) {
  const [expanded, setExpanded] = useState(false);

  return (
    <div className="border border-dashed border-amber-300 bg-amber-50/50 rounded-xl overflow-hidden">
      <button
        type="button"
        onClick={() => setExpanded(!expanded)}
        className="w-full flex items-center gap-3 p-4 text-left"
      >
        <span className="text-lg flex-shrink-0">
          {recipe.cookingMethod === '免煮' ? '🥣' : '🍚'}
        </span>
        <div className="flex-1 min-w-0">
          <p className="text-sm font-semibold text-amber-900">{recipe.name}</p>
          <p className="text-sm text-amber-800 mt-1 leading-relaxed">
            P {recipe.macros.protein}g · C {recipe.macros.carbs}g · F {recipe.macros.fat}g
            <span className="ml-1.5 text-amber-600">{recipe.macros.calories} kcal</span>
          </p>
        </div>
        <div className="flex items-center gap-2 flex-shrink-0">
          <span className="text-sm text-amber-700 bg-amber-100 px-2.5 py-1 rounded-full">
            {recipe.cookingMethod}
          </span>
          <svg
            className={`w-4 h-4 text-amber-400 transition-transform ${expanded ? 'rotate-180' : ''}`}
            fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}
          >
            <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
          </svg>
        </div>
      </button>

      {expanded && (
        <div className="px-4 pb-4 space-y-3 border-t border-amber-200/60">
          <p className="text-sm text-amber-700 pt-2 leading-relaxed">
            準備時間：約 {recipe.prepTime} 分鐘
          </p>

          <div>
            <p className="text-sm font-semibold text-amber-900 mb-1.5">食材</p>
            <div className="flex flex-wrap gap-1.5">
              {recipe.ingredients.map((ing, i) => (
                <span key={i} className="text-sm bg-white/80 text-amber-900 px-2.5 py-1.5 rounded border border-amber-200">
                  {ing.name} {ing.amount}
                </span>
              ))}
            </div>
          </div>

          <div>
            <p className="text-sm font-semibold text-amber-900 mb-1.5">步驟</p>
            <ol className="space-y-1.5">
              {recipe.steps.map((step, i) => (
                <li key={i} className="text-sm text-amber-900 flex gap-2.5">
                  <span className="text-amber-500 font-medium flex-shrink-0">{i + 1}.</span>
                  <span>{step}</span>
                </li>
              ))}
            </ol>
          </div>

          {recipe.tips && (
            <p className="text-sm text-amber-700 bg-amber-100/60 rounded-lg px-3 py-2 leading-relaxed">
              {recipe.tips}
            </p>
          )}
        </div>
      )}
    </div>
  );
}
