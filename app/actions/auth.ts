'use server';

import { signToken, setSessionCookie, clearSessionCookie } from '@/lib/auth';
import { redirect } from 'next/navigation';

export async function login(_prevState: { error: string } | null, formData: FormData) {
  const password = formData.get('password') as string;

  if (password !== process.env.APP_PASSWORD) {
    return { error: '密碼錯誤，請重試' };
  }

  const token = await signToken();
  await setSessionCookie(token);
  redirect('/');
}

export async function logout() {
  await clearSessionCookie();
  redirect('/login');
}
