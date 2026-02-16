import Header from '@/components/Header';
import BottomNav from '@/components/BottomNav';

export default function AuthenticatedLayout({
  children,
}: {
  children: React.ReactNode;
}) {
  return (
    <div className="min-h-screen bg-gray-50">
      <Header />
      <main className="max-w-lg mx-auto px-4 py-6 pb-24">
        {children}
      </main>
      <BottomNav />
    </div>
  );
}
