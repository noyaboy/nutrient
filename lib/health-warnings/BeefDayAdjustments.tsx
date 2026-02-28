import React from 'react';

interface BeefDayAdjustmentsProps {
  context: 'copper' | 'zinc' | 'protein' | 'egg' | 'summary';
}

export function BeefDayAdjustments({ context }: BeefDayAdjustmentsProps) {
  if (context === 'copper') {
    return (
      <p className="text-amber-600 font-medium">⚠️ 牛肉日銅補劑：牛肉本身含銅極低（150g ≈ 0.1-0.2mg），若當日堅果攝取充足（≥30g，含銅 ~0.3-0.5mg）可免補銅，否則仍需補充 2mg 銅</p>
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
        <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白（晚餐），可保留 1 顆雞蛋（+6.3g = 36-42g，仍 &lt;45g 上限）</p>
        <p className="text-amber-700">若追求最佳吸收分配，可將雞蛋移至 15:30 下午點心與豌豆蛋白同食（蛋 6.3g + 豌豆 16g = 22.3g）</p>
      </div>
    );
  }

  if (context === 'egg') {
    return (
      <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-semibold text-amber-800">⚠️ 牛肉日注意</p>
        <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白，可保留 1 顆雞蛋（+6.3g = 36-42g，仍 &lt;45g）</p>
        <p className="text-amber-700">建議將雞蛋移至 15:30 下午點心以優化吸收分配（蛋 6.3g + 豌豆 16g = 22.3g）</p>
        <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150-180g，當晚無需額外補鋅</p>
      </div>
    );
  }

  // summary context
  return (
    <>
      <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白（晚餐），雞蛋可保留或移至下午點心以優化吸收</p>
      <p className="text-amber-700">牛肉日銅補劑視堅果攝取量決定 + 取消鋅補劑</p>
    </>
  );
}
