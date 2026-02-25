'use client';

import { useState } from 'react';
import { Product } from '@/lib/types';

interface ShoppingPageClientProps {
  costcoSupplements: Product[];
  costcoFoods: Product[];
  iherbSupplements: Product[];
  equipment: Product[];
}

function StoreTag({ store }: { store: string }) {
  const colors: Record<string, string> = {
    Costco: 'bg-red-100 text-red-700',
    iHerb: 'bg-green-100 text-green-700',
    Amazon: 'bg-yellow-100 text-yellow-700',
  };
  return (
    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${colors[store] || 'bg-gray-100 text-gray-700'}`}>
      {store}
    </span>
  );
}

function ShoppingSection({ title, items }: { title: string; items: Product[] }) {
  return (
    <section className="space-y-3">
      <h2 className="text-base font-bold text-gray-900">{title}</h2>
      <div className="space-y-2">
        {items.map((item) => (
          <a
            key={item.id}
            href={item.url}
            target="_blank"
            rel="noopener noreferrer"
            className="block p-4 bg-white rounded-xl border border-gray-200 hover:border-emerald-300 hover:shadow-sm transition-all active:scale-[0.98]"
          >
            <div className="flex items-start justify-between gap-2">
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <p className="text-base font-medium text-gray-900">{item.name}</p>
                </div>
                <p className="text-sm text-gray-500">{item.description}</p>
                <p className="text-sm text-emerald-700 mt-1">{item.usage}</p>
                {item.purchase_note && (
                  <p className="text-xs text-amber-700 mt-1.5 bg-amber-50 rounded px-2 py-1">{item.purchase_note}</p>
                )}
              </div>
              <div className="flex flex-col items-end gap-1.5 flex-shrink-0">
                <StoreTag store={item.store} />
                <span className="text-xs font-semibold text-amber-700">{item.price}</span>
                <svg className="w-4 h-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
              </div>
            </div>
          </a>
        ))}
      </div>
    </section>
  );
}

function TimingTable() {
  const rows = [
    { time: '09:00 起床', items: '晨光曝曬 10-20 分鐘（不戴太陽眼鏡）' },
    { time: '09:05 補水', items: '500ml 室溫水 + 少許碘鹽 + 檸檬汁' },
    { time: '09:15 訓練前', items: '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）' },
    { time: '10:30 咖啡', items: '咖啡因 200-300mg + L-Theanine 200mg（起床 60-90 分鐘後，15:00 前）' },
    { time: '12:00 午餐', items: '蛋白質 30-40g + 十字花科蔬菜 + 肌酸 5g、D3 2000IU+K2+魚油+葉黃素+維他命C+膠原蛋白肽+CoQ10+B群' },
    { time: '15:00 午後', items: '銅 2mg（與鋅間隔 4hr+）' },
    { time: '19:00 晚餐', items: '蛋白質 30-40g + 低 FODMAP 蔬菜 + 鋅 25mg' },
    { time: '22:30 睡前', items: '豌豆蛋白 ~20g 粉（≈16g 蛋白）+甘胺酸鎂 100mg' },
  ];

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

export default function ShoppingPageClient({
  costcoSupplements,
  costcoFoods,
  iherbSupplements,
  equipment,
}: ShoppingPageClientProps) {
  const [search, setSearch] = useState('');

  function filterItems(items: Product[]): Product[] {
    if (!search) return items;
    const q = search.toLowerCase();
    return items.filter(item =>
      item.name.toLowerCase().includes(q) ||
      item.description.toLowerCase().includes(q) ||
      item.usage.toLowerCase().includes(q) ||
      (item.purchase_note && item.purchase_note.toLowerCase().includes(q))
    );
  }

  const filteredCostco = filterItems(costcoSupplements);
  const filteredCostcoFood = filterItems(costcoFoods);
  const filteredIherb = filterItems(iherbSupplements);
  const filteredEquipment = filterItems(equipment);
  const hasResults = filteredCostco.length + filteredCostcoFood.length + filteredIherb.length + filteredEquipment.length > 0;

  return (
    <div className="space-y-8">
      <h1 className="text-xl font-bold text-gray-900">採購清單</h1>

      <TimingTable />

      <div className="sticky top-12 z-[5] -mx-4 px-4 bg-gray-50 pb-3 pt-1">
        <input
          type="search"
          placeholder="搜尋品項..."
          value={search}
          onChange={e => setSearch(e.target.value)}
          className="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-sm bg-white"
        />
      </div>

      <p className="text-sm text-gray-500">點擊任一項目可直接開啟產品頁面</p>

      {hasResults ? (
        <>
          {filteredCostco.length > 0 && <ShoppingSection title="Costco 好市多 — 保健品" items={filteredCostco} />}
          {filteredCostcoFood.length > 0 && <ShoppingSection title="Costco 好市多 — 食材" items={filteredCostcoFood} />}
          {filteredIherb.length > 0 && <ShoppingSection title="iHerb — 專業補充品" items={filteredIherb} />}
          {filteredEquipment.length > 0 && <ShoppingSection title="其他 — 設備" items={filteredEquipment} />}
        </>
      ) : (
        <p className="text-center text-gray-400 py-8">找不到符合的品項</p>
      )}
    </div>
  );
}
