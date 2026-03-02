import React from 'react';

interface Props {
  minerals: ('calcium' | 'zinc')[];
  showTimeline?: boolean;
}

export function MineralTimingGuidance({ minerals, showTimeline = true }: Props) {
  const hasCa = minerals.includes('calcium');
  const hasZn = minerals.includes('zinc');

  if (!showTimeline || (!hasCa && !hasZn)) return null;

  return (
    <p className="text-amber-700">
      {hasCa && '12:00 午餐（鈣隨餐）'}
      {hasCa && hasZn && ' → '}
      {hasZn && '19:00 晚餐最後一口鋅'}
    </p>
  );
}
