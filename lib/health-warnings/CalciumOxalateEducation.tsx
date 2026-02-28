import React from 'react';

export function CalciumOxalateEducation({ className }: { className?: string }) {
  return (
    <div className={`bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 ${className || 'mt-1'}`}>
      <p className="font-semibold text-emerald-800">✅ 草酸鈣正確觀念</p>
      <p className="text-emerald-700">鈣與草酸在「腸道」同餐攝取 → 結合為不溶性草酸鈣隨糞便排出（保護機制）</p>
      <p className="text-emerald-700">若刻意分開，游離草酸被吸收入血 → 在「腎臟」與尿鈣結合形成結石</p>
      <p className="text-emerald-700 font-medium">因此：高草酸蔬菜（菠菜）搭配含鈣食物同餐食用才是正確防結石策略</p>
    </div>
  );
}
