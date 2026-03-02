import React from 'react';

interface MineralTimingGuidanceProps {
  minerals: ('calcium' | 'zinc')[];
  showTimeline?: boolean;
}

export function MineralTimingGuidance({ minerals, showTimeline = true }: MineralTimingGuidanceProps) {
  const hasCa = minerals.includes('calcium');
  const hasZn = minerals.includes('zinc');

  return (
    <>
      {showTimeline && (hasCa || hasZn) && (
        <p className="text-amber-700">
          {hasCa && '12:00 午餐（鈣隨餐）'}
          {hasCa && hasZn && ' → '}
          {hasZn && '19:00 晚餐最後一口鋅'}
        </p>
      )}
    </>
  );
}
