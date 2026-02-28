import React from 'react';

interface ColdBathRulesProps {
  context: 'exercise' | 'zone2' | 'vo2max' | 'general';
}

export function ColdBathRules({ context }: ColdBathRulesProps) {
  if (context === 'exercise') {
    return (
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-bold text-red-800">🚫 冷水浴統一規定</p>
        <p className="text-red-700 font-bold">重訓日（一二四五）及 VO2 Max 日（三）嚴格禁止</p>
        <p className="text-red-700">冷水浴會抑制肌肥大信號（mTOR、IGF-1）+ 線粒體適應</p>
        <p className="text-emerald-600 font-semibold">✓ 僅週六/日（Zone 2 日）早晨 07:00-08:00 可執行</p>
        <p className="text-emerald-600">與 Zone 2 運動間隔 4hr 以上（例：07:00 冷水浴 → 11:00 Zone 2）</p>
      </div>
    );
  }

  if (context === 'zone2') {
    return (
      <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-medium text-blue-800">冷水浴僅限週六/日早晨</p>
        <p className="text-blue-700">07:00-08:00 執行冷水浴，與 Zone 2 運動間隔 4hr+</p>
        <p className="text-blue-700">例：07:00 冷水浴（10 分鐘）→ 11:00 Zone 2 有氧（45-60 分鐘）</p>
        <p className="text-blue-700">Zone 2 為低強度有氧，冷水浴對其影響較小（非肌肥大目標）</p>
      </div>
    );
  }

  if (context === 'vo2max') {
    return (
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-bold text-red-800">🚫 VO2 Max 日禁止冷水浴</p>
        <p className="text-red-700">高強度間歇訓練後冷水浴會抑制線粒體適應信號，降低 VO2 Max 訓練效果</p>
        <p className="text-red-700">比照重訓日嚴格禁止</p>
      </div>
    );
  }

  // general context (for HealthNotes in page.tsx)
  return (
    <div>
      <p className="font-semibold text-blue-700 mb-1">冷水浴（2-4 次/週，休息日）</p>
      <p>10-15°C，1-5 分鐘</p>
      <p className="text-red-600 font-medium">重訓後 4-6 小時內禁止冷水浴（會抑制肌肥大信號）</p>
      <p>最佳時機：休息日早晨或訓練前</p>
    </div>
  );
}
