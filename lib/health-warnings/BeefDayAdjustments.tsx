import React from 'react';

interface BeefDayAdjustmentsProps {
  context: 'copper' | 'zinc' | 'protein' | 'egg' | 'summary';
}

export function BeefDayAdjustments({ context }: BeefDayAdjustmentsProps) {
  if (context === 'copper') {
    return (
      <p className="text-amber-600 font-medium">⚠️ 牛肉日免補銅：牛肉 + 堅果已提供足夠銅，當日取消銅補劑避免逼近 UL 10mg/日</p>
    );
  }

  if (context === 'zinc') {
    return (
      <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150-180g，當晚無需額外補鋅</p>
    );
  }

  if (context === 'protein') {
    return (
      <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-semibold text-amber-800">⚠️ 牛肉日蛋白質分配</p>
        <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白（晚餐），取消雞蛋（牛肉已接近單餐上限 ≤45g）</p>
        <p className="text-amber-700">雞蛋移至 15:30 下午點心與豌豆蛋白同食（蛋 6.3g + 豌豆 16g = 22.3g）</p>
      </div>
    );
  }

  if (context === 'egg') {
    return (
      <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-semibold text-amber-800">⚠️ 牛肉日注意</p>
        <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白，取消雞蛋（牛肉已接近單餐上限 ≤45g）</p>
        <p className="text-amber-700">雞蛋移至 15:30 下午點心與豌豆蛋白同食（蛋 6.3g + 豌豆 16g = 22.3g）</p>
        <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150-180g，當晚無需額外補鋅</p>
      </div>
    );
  }

  // summary context
  return (
    <>
      <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白（晚餐），取消雞蛋（牛肉已接近單餐上限 ≤45g）</p>
      <p className="text-amber-700">雞蛋移至 15:30 下午點心與豌豆蛋白同食（蛋 6.3g + 豌豆 16g = 22.3g）</p>
      <p className="text-amber-700">牛肉日免補銅 + 取消鋅補劑</p>
    </>
  );
}
