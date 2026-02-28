import React from 'react';

interface MineralTimingGuidanceProps {
  minerals: ('calcium' | 'copper' | 'zinc')[];
  showTimeline?: boolean;
}

export function MineralTimingGuidance({ minerals, showTimeline = true }: MineralTimingGuidanceProps) {
  const hasCa = minerals.includes('calcium');
  const hasCu = minerals.includes('copper');
  const hasZn = minerals.includes('zinc');

  return (
    <>
      {showTimeline && (hasCa || hasCu || hasZn) && (
        <p className="text-amber-700">
          {hasCa && '12:00 午餐（鈣隨餐）'}
          {hasCa && hasCu && ' → '}
          {hasCu && '14:00-15:00 銅（避開含鈣點心）'}
          {(hasCa || hasCu) && hasZn && ' → '}
          {hasZn && '19:00 晚餐最後一口鋅'}
        </p>
      )}
    </>
  );
}
