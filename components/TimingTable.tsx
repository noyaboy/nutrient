'use client';

export interface TimingRow {
  time: string;
  items: string;
}

interface TimingTableProps {
  rows: TimingRow[];
}

export default function TimingTable({ rows }: TimingTableProps) {
  return (
    <section className="space-y-3">
      <h2 className="text-base font-bold text-gray-900">服用時間對照</h2>
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        {rows.map((row, i) => (
          <div key={i} className={`flex px-4 py-3 ${i !== rows.length - 1 ? 'border-b border-gray-100' : ''}`}>
            <span className="text-sm font-medium text-emerald-700 w-28 flex-shrink-0">{row.time}</span>
            <span className="text-sm text-gray-700">{row.items}</span>
          </div>
        ))}
      </div>
    </section>
  );
}
