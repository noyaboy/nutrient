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
    Costco: 'bg-red-100 text-red-800',
    iHerb: 'bg-green-100 text-green-800',
    Amazon: 'bg-yellow-100 text-yellow-800',
    '7-Eleven': 'bg-blue-100 text-blue-800',
    '全家便利店': 'bg-purple-100 text-purple-800',
    '全聯': 'bg-indigo-100 text-indigo-800',
  };
  return (
    <span className={`text-sm px-2.5 py-1 rounded-full font-medium ${colors[store] || 'bg-gray-100 text-gray-800'}`}>
      {store}
    </span>
  );
}

function InfoRow({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex gap-2 text-sm">
      <span className="text-gray-500 flex-shrink-0">{label}</span>
      <span className="text-gray-700">{value}</span>
    </div>
  );
}

function JsonEntries({ data }: { data: Record<string, unknown> }) {
  const entries = Object.entries(data).filter(([, v]) => v !== null && v !== '' && v !== undefined);
  if (entries.length === 0) return null;
  return (
    <div className="flex flex-wrap gap-x-3 gap-y-1">
      {entries.map(([k, v]) => (
        <span key={k} className="text-sm text-gray-600">
          <span className="text-gray-500">{k}:</span> {String(v)}
        </span>
      ))}
    </div>
  );
}

function RatingStars({ rating, reviewCount }: { rating: number; reviewCount?: number | null }) {
  return (
    <span className="text-sm text-yellow-600">
      {'★'.repeat(Math.round(rating))}{'☆'.repeat(5 - Math.round(rating))}
      {' '}{rating}
      {reviewCount != null && <span className="text-gray-500"> ({reviewCount.toLocaleString()})</span>}
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
              className="block p-4.5 bg-white rounded-xl border border-gray-200 hover:border-emerald-300 hover:shadow-sm transition-all active:scale-[0.98]"
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
                        <p className="text-sm text-gray-500">
                          {item.brand}{item.brand && item.origin && ' · '}{item.origin}
                        </p>
                      )}
                    </div>
                  </div>
                  <p className="text-sm text-gray-600 leading-relaxed">{item.description}</p>

                  {item.rating != null && (
                    <div className="mt-1">
                      <RatingStars rating={item.rating} reviewCount={item.review_count} />
                    </div>
                  )}

                  {hasSpecs && (
                    <div className="mt-2 bg-gray-50 rounded px-2.5 py-2">
                      <p className="text-xs font-medium text-gray-500 mb-1">規格</p>
                      <JsonEntries data={item.specs} />
                    </div>
                  )}

                  {hasNutrition && (
                    <div className="mt-1.5 bg-emerald-50 rounded px-2.5 py-2">
                      <p className="text-xs font-medium text-emerald-600 mb-1">營養</p>
                      <JsonEntries data={item.nutrition} />
                    </div>
                  )}

                  {item.purchase_note && (
                    <p className="text-sm text-amber-800 mt-2 bg-amber-50 rounded px-2.5 py-2">{item.purchase_note}</p>
                  )}

                  {item.sku && (
                    <InfoRow label="SKU" value={item.sku} />
                  )}
                </div>
                <div className="flex flex-col items-end gap-1.5 flex-shrink-0">
                  <StoreTag store={item.store} />
                  <span className="text-sm font-semibold text-amber-800">{item.price}</span>
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
