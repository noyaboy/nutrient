const TIMEZONE = 'Asia/Taipei';

export function getToday(): string {
  return new Date().toLocaleDateString('sv-SE', { timeZone: TIMEZONE });
}

export function getMondayOfWeek(dateStr?: string): string {
  const date = dateStr ? new Date(dateStr + 'T00:00:00') : new Date();
  const taipeiDate = new Date(date.toLocaleString('en-US', { timeZone: TIMEZONE }));
  const day = taipeiDate.getDay();
  const diff = day === 0 ? -6 : 1 - day;
  taipeiDate.setDate(taipeiDate.getDate() + diff);
  return taipeiDate.toLocaleDateString('sv-SE');
}

export function formatDateChinese(dateStr?: string): string {
  const date = dateStr ? new Date(dateStr + 'T00:00:00') : new Date();
  return date.toLocaleDateString('zh-TW', {
    timeZone: TIMEZONE,
    year: 'numeric',
    month: 'long',
    day: 'numeric',
    weekday: 'long',
  });
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
