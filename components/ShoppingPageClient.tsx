'use client';

import { useState } from 'react';
import { Product } from '@/lib/types';

interface ShoppingPageClientProps {
  costcoSupplements: Product[];
  costcoFoods: Product[];
  iherbSupplements: Product[];
  personalCare: Product[];
  equipment: Product[];
  convenienceDaily: Product[];
}

function StoreTag({ store }: { store: string }) {
  const colors: Record<string, string> = {
    Costco: 'bg-red-100 text-red-700',
    iHerb: 'bg-green-100 text-green-700',
    Amazon: 'bg-yellow-100 text-yellow-700',
    '7-Eleven': 'bg-blue-100 text-blue-700',
    '全家便利店': 'bg-purple-100 text-purple-700',
    '全聯': 'bg-indigo-100 text-indigo-700',
  };
  return (
    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${colors[store] || 'bg-gray-100 text-gray-700'}`}>
      {store}
    </span>
  );
}

function InfoRow({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex gap-2 text-xs">
      <span className="text-gray-400 flex-shrink-0">{label}</span>
      <span className="text-gray-600">{value}</span>
    </div>
  );
}

function JsonEntries({ data }: { data: Record<string, unknown> }) {
  const entries = Object.entries(data).filter(([, v]) => v !== null && v !== '' && v !== undefined);
  if (entries.length === 0) return null;
  return (
    <div className="flex flex-wrap gap-x-3 gap-y-0.5">
      {entries.map(([k, v]) => (
        <span key={k} className="text-xs text-gray-500">
          <span className="text-gray-400">{k}:</span> {String(v)}
        </span>
      ))}
    </div>
  );
}

function RatingStars({ rating, reviewCount }: { rating: number; reviewCount?: number | null }) {
  return (
    <span className="text-xs text-yellow-600">
      {'★'.repeat(Math.round(rating))}{'☆'.repeat(5 - Math.round(rating))}
      {' '}{rating}
      {reviewCount != null && <span className="text-gray-400"> ({reviewCount.toLocaleString()})</span>}
    </span>
  );
}

function ShoppingSection({ title, items }: { title: string; items: Product[] }) {
  return (
    <section className="space-y-3">
      <h2 className="text-base font-bold text-gray-900">{title}</h2>
      <div className="space-y-2">
        {items.map((item) => {
          const hasSpecs = item.specs && Object.keys(item.specs).length > 0;
          const hasNutrition = item.nutrition && Object.keys(item.nutrition).length > 0;
          return (
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
                    {item.image_url && (
                      <img src={item.image_url} alt="" className="w-10 h-10 rounded object-contain flex-shrink-0" />
                    )}
                    <div>
                      <p className="text-base font-medium text-gray-900">{item.name}</p>
                      {(item.brand || item.origin) && (
                        <p className="text-xs text-gray-400">
                          {item.brand}{item.brand && item.origin && ' · '}{item.origin}
                        </p>
                      )}
                    </div>
                  </div>
                  <p className="text-sm text-gray-500">{item.description}</p>
                  <p className="text-sm text-emerald-700 mt-1">{item.usage}</p>

                  {item.rating != null && (
                    <div className="mt-1">
                      <RatingStars rating={item.rating} reviewCount={item.review_count} />
                    </div>
                  )}

                  {hasSpecs && (
                    <div className="mt-1.5 bg-gray-50 rounded px-2 py-1">
                      <p className="text-[10px] font-medium text-gray-400 mb-0.5">規格</p>
                      <JsonEntries data={item.specs} />
                    </div>
                  )}

                  {hasNutrition && (
                    <div className="mt-1 bg-emerald-50 rounded px-2 py-1">
                      <p className="text-[10px] font-medium text-emerald-400 mb-0.5">營養</p>
                      <JsonEntries data={item.nutrition} />
                    </div>
                  )}

                  {item.purchase_note && (
                    <p className="text-xs text-amber-700 mt-1.5 bg-amber-50 rounded px-2 py-1">{item.purchase_note}</p>
                  )}

                  {item.sku && (
                    <InfoRow label="SKU" value={item.sku} />
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
          );
        })}
      </div>
    </section>
  );
}

function TimingTable() {
  const rows = [
    { time: '09:00 起床', items: '晨光曝曬 10-20 分鐘（不戴太陽眼鏡）' },
    { time: '09:05 補水', items: '500ml 室溫水 + 少許碘鹽 + 檸檬汁' },
    { time: '09:15 訓練前', items: '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（水溶性，隨餐）' },
    { time: '10:30 咖啡', items: '咖啡因 200-300mg + L-Theanine 200mg（A 級 nootropic 組合）' },
    { time: '12:00 午餐', items: '蛋白質 45-50g + 橄欖油 1 大匙+酪梨半顆 + 肌酸 5g（CGN）、D3 1000IU（半顆）+K2 MK-7+魚油+葉黃素+膠原蛋白肽+CoQ10 200mg（米飯建議冷卻再加熱保留抗性澱粉）' },
    { time: '12:00 鈣', items: '若當日飲食鈣不足 → 午餐隨餐補 1 錠鈣片 500mg（⚠️ 補鈣當日停用午餐 D3，鈣片已含 D3 150IU）' },
    { time: '15:00 午後', items: 'NSDR (Yoga Nidra)' },
    { time: '16:00-17:00 銅', items: '銅 2mg 嚴格單獨空腹服用（不與礦物質同服，12:00 鈣→16:00 銅→19:00 鋅）' },
    { time: '15:30 點心', items: '豌豆蛋白 ~20g 粉（≈16g 蛋白），分散蛋白質攝取' },
    { time: '19:00 晚餐', items: '蛋白質 40-45g + 橄欖油 2 大匙（28g）+ 維他命C 500mg（半錠）+ 鋅 25mg（每兩天）' },
    { time: '22:00 睡前', items: '甘胺酸 3g+蘇糖酸鎂+甘胺酸鎂 100mg（1錠）+Ashwagandha' },
    { time: '22:00-23:00', items: '熱水澡 40-42°C 10-15 分鐘' },
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
  personalCare,
  equipment,
  convenienceDaily,
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
  const filteredPersonalCare = filterItems(personalCare);
  const filteredEquipment = filterItems(equipment);
  const filteredConvenience = filterItems(convenienceDaily);
  const hasResults = filteredCostco.length + filteredCostcoFood.length + filteredIherb.length + filteredPersonalCare.length + filteredEquipment.length + filteredConvenience.length > 0;

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
          {filteredConvenience.length > 0 && <ShoppingSection title="便利超商 — 日常必需" items={filteredConvenience} />}
          {filteredIherb.length > 0 && <ShoppingSection title="iHerb — 專業補充品" items={filteredIherb} />}
          {filteredPersonalCare.length > 0 && <ShoppingSection title="個人保養" items={filteredPersonalCare} />}
          {filteredEquipment.length > 0 && <ShoppingSection title="其他 — 設備" items={filteredEquipment} />}
        </>
      ) : (
        <p className="text-center text-gray-400 py-8">找不到符合的品項</p>
      )}
    </div>
  );
}
