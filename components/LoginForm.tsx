'use client';

import { useActionState } from 'react';
import { login } from '@/app/actions/auth';

export default function LoginForm() {
  const [state, formAction, pending] = useActionState(login, null);

  return (
    <form action={formAction} className="w-full max-w-sm space-y-4">
      <div>
        <label htmlFor="password" className="block text-sm font-medium text-gray-700 mb-1">
          請輸入密碼
        </label>
        <input
          id="password"
          name="password"
          type="password"
          required
          autoFocus
          placeholder="密碼"
          className="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-base"
        />
      </div>
      {state?.error && (
        <p className="text-red-600 text-sm">{state.error}</p>
      )}
      <button
        type="submit"
        disabled={pending}
        className="w-full py-3 px-4 bg-emerald-600 hover:bg-emerald-700 disabled:bg-emerald-400 text-white font-medium rounded-lg transition-colors text-base"
      >
        {pending ? '登入中...' : '登入'}
      </button>
    </form>
  );
}
