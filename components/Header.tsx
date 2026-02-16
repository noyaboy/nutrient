'use client';

import Link from 'next/link';
import { usePathname } from 'next/navigation';
import { logout } from '@/app/actions/auth';
import { UI } from '@/lib/constants';

export default function Header() {
  const pathname = usePathname();

  return (
    <header className="sticky top-0 z-10 bg-white/80 backdrop-blur-md border-b border-gray-200">
      <div className="max-w-lg mx-auto px-4 h-14 flex items-center justify-between">
        <h1 className="text-lg font-bold text-emerald-800">{UI.appName}</h1>
        <nav className="flex items-center gap-1">
          <Link
            href="/"
            className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
              pathname === '/' ? 'bg-emerald-100 text-emerald-800' : 'text-gray-600 hover:bg-gray-100'
            }`}
          >
            {UI.nav.dashboard}
          </Link>
          <Link
            href="/shopping"
            className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
              pathname === '/shopping' ? 'bg-emerald-100 text-emerald-800' : 'text-gray-600 hover:bg-gray-100'
            }`}
          >
            {UI.nav.shopping}
          </Link>
          <Link
            href="/settings"
            className={`px-3 py-1.5 rounded-lg text-sm font-medium transition-colors ${
              pathname === '/settings' ? 'bg-emerald-100 text-emerald-800' : 'text-gray-600 hover:bg-gray-100'
            }`}
          >
            {UI.nav.settings}
          </Link>
          <form action={logout}>
            <button
              type="submit"
              className="px-3 py-1.5 rounded-lg text-sm font-medium text-gray-600 hover:bg-gray-100 transition-colors"
            >
              {UI.nav.logout}
            </button>
          </form>
        </nav>
      </div>
    </header>
  );
}
