import LoginForm from '@/components/LoginForm';
import { UI } from '@/lib/constants';

export default function LoginPage() {
  return (
    <div className="min-h-screen flex flex-col items-center justify-center px-4 bg-gradient-to-b from-emerald-50 to-white">
      <div className="mb-8 text-center">
        <h1 className="text-2xl font-bold text-emerald-800">{UI.appName}</h1>
        <p className="text-gray-500 mt-2">{UI.login.tagline}</p>
      </div>
      <LoginForm />
    </div>
  );
}
