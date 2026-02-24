'use client';

import { useState } from 'react';

export function Section({ title, children }: { title: string; children: React.ReactNode }) {
  const [open, setOpen] = useState(true);
  return (
    <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
      <button
        type="button"
        onClick={() => setOpen(!open)}
        className="w-full flex items-center justify-between p-4"
      >
        <h3 className="text-sm font-bold text-gray-900">{title}</h3>
        <svg
          className={`w-4 h-4 text-gray-400 transition-transform ${open ? 'rotate-180' : ''}`}
          fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}
        >
          <path strokeLinecap="round" strokeLinejoin="round" d="M19 9l-7 7-7-7" />
        </svg>
      </button>
      {open && <div className="px-4 pb-4 space-y-3">{children}</div>}
    </div>
  );
}

export function TabSwitcher({ tabs, children }: {
  tabs: { key: string; label: string }[];
  children: Record<string, React.ReactNode>;
}) {
  const [tab, setTab] = useState(tabs[0].key);

  return (
    <>
      <div className="flex gap-2">
        {tabs.map(({ key, label }) => (
          <button
            key={key}
            type="button"
            onClick={() => setTab(key)}
            className={`flex-1 py-2.5 text-sm font-medium rounded-lg transition-colors ${
              tab === key
                ? 'bg-emerald-600 text-white'
                : 'bg-gray-100 text-gray-500'
            }`}
          >
            {label}
          </button>
        ))}
      </div>
      {children[tab]}
    </>
  );
}
