import { UI } from '@/lib/constants';

export default function Header() {
  return (
    <header className="sticky top-0 z-10 bg-white/80 backdrop-blur-md border-b border-gray-200">
      <div className="max-w-lg mx-auto px-4 h-12 flex items-center justify-center">
        <h1 className="text-lg font-bold text-emerald-800">{UI.appName}</h1>
      </div>
    </header>
  );
}
