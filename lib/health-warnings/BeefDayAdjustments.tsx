import React from 'react';

interface BeefDayAdjustmentsProps {
  context: 'zinc' | 'protein' | 'egg' | 'summary';
}

export function BeefDayAdjustments({ context }: BeefDayAdjustmentsProps) {
  if (context === 'zinc') {
    return (
      <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150g，當晚無需額外補鋅</p>
    );
  }

  if (context === 'protein') {
    return (
      <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-semibold text-amber-800">⚠️ 牛肉日蛋白質分配（嚴格執行）</p>
        <p className="text-amber-700">草飼牛肉上限 <span className="font-bold text-red-700">150g</span>（≈30-37.5g 蛋白質），不可超量</p>
        <p className="text-amber-700 font-medium">強制將晚餐雞蛋 3 顆移至 15:30 下午點心（蛋 18.9g + 豌豆 16g = 34.9g，≤45g ✓），晚餐蛋白質控制在 30-37.5g</p>
      </div>
    );
  }

  if (context === 'egg') {
    return (
      <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-semibold text-amber-800">⚠️ 牛肉日規則（嚴格執行）</p>
        <p className="text-amber-700">草飼牛肉上限 <span className="font-bold text-red-700">150g</span>（≈30-37.5g 蛋白質）</p>
        <p className="text-amber-700 font-medium">強制將雞蛋 3 顆移至 15:30 下午點心（蛋 18.9g + 豌豆 16g = 34.9g，≤45g ✓），確保晚餐僅牛肉蛋白 30-37.5g</p>
        <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150g，當晚無需額外補鋅</p>
      </div>
    );
  }

  // summary context
  return (
    <>
      <p className="text-amber-700">草飼牛肉嚴格上限 150g（≈30-37.5g 蛋白），雞蛋強制移至 15:30 下午點心</p>
      <p className="text-amber-700">牛肉日取消鋅補劑（牛肉已含鋅 6-9mg）</p>
    </>
  );
}
