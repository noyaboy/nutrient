const TZ = 'Asia/Taipei';

export function getToday(): string {
  return new Date().toLocaleDateString('sv-SE', { timeZone: TZ });
}

export function getMondayOfWeek(dateStr?: string): string {
  const date = dateStr ? new Date(dateStr + 'T00:00:00') : new Date();
  const taipeiDate = new Date(date.toLocaleString('en-US', { timeZone: TZ }));
  const day = taipeiDate.getDay();
  taipeiDate.setDate(taipeiDate.getDate() + (day === 0 ? -6 : 1 - day));
  return taipeiDate.toLocaleDateString('sv-SE');
}

export function formatDateChinese(dateStr?: string): string {
  const date = dateStr ? new Date(dateStr + 'T00:00:00') : new Date();
  return date.toLocaleDateString('zh-TW', {
    timeZone: TZ,
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long',
  });
}

export function getSundayOfWeek(mondayStr: string): string {
  const d = new Date(mondayStr + 'T00:00:00');
  d.setDate(d.getDate() + 6);
  return d.toLocaleDateString('sv-SE');
}

export function getWeekDates(mondayStr: string): string[] {
  const dates: string[] = [];
  for (let i = 0; i < 7; i++) {
    const d = new Date(mondayStr + 'T00:00:00');
    d.setDate(d.getDate() + i);
    dates.push(d.toLocaleDateString('sv-SE'));
  }
  return dates;
}

export const DAY_LABELS = ['一', '二', '三', '四', '五', '六', '日'];

export function getWeeklyTargetCount(title: string): number {
  const targets: [string, number][] = [
    ['Zone 2', 3],
    ['肌力訓練', 4],
    ['VO2 Max', 1],
    ['學習新技能', 3],
    ['每週回顧', 1],
    ['健康檢測', 1],
  ];
  for (const [keyword, count] of targets) {
    if (title.includes(keyword)) return count;
  }
  return 1;
}

export function getCategoryColor(category: string): string {
  const colors: Record<string, string> = {
    '運動': 'bg-green-100 text-green-800',
    '飲食': 'bg-orange-100 text-orange-800',
    '睡眠': 'bg-indigo-100 text-indigo-800',
    '心理': 'bg-purple-100 text-purple-800',
    '補充品': 'bg-yellow-100 text-yellow-800',
    '一般': 'bg-gray-100 text-gray-800',
  };
  return colors[category] || colors['一般'];
}

export function parseTimeMinutes(title: string): number | null {
  const m = title.match(/^(\d{2}):(\d{2})/);
  return m ? parseInt(m[1]) * 60 + parseInt(m[2]) : null;
}
