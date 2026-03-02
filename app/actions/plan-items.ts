'use server';

import { supabase } from '@/lib/supabase';
import { revalidatePath } from 'next/cache';

export async function createPlanItem(formData: FormData) {
  const title = formData.get('title') as string;
  const description = (formData.get('description') as string) || '';
  const frequency = formData.get('frequency') as string;
  const category = formData.get('category') as string;
  const targetCount = formData.get('target_count') ? Number(formData.get('target_count')) : 1;

  const { data: maxOrder } = await supabase
    .from('plan_items')
    .select('sort_order')
    .eq('frequency', frequency)
    .order('sort_order', { ascending: false })
    .limit(1)
    .single();

  await supabase.from('plan_items').insert({
    title,
    description,
    frequency,
    category,
    sort_order: (maxOrder?.sort_order ?? 0) + 1,
    ...(frequency === 'weekly' ? { target_count: targetCount } : {}),
  });

  revalidatePath('/settings');
  revalidatePath('/');
}

export async function updatePlanItem(id: string, formData: FormData) {
  const title = formData.get('title') as string;
  const description = (formData.get('description') as string) || '';
  const category = formData.get('category') as string;
  const targetCount = formData.get('target_count') ? Number(formData.get('target_count')) : undefined;

  await supabase
    .from('plan_items')
    .update({
      title,
      description,
      category,
      ...(targetCount !== undefined ? { target_count: targetCount } : {}),
      updated_at: new Date().toISOString(),
    })
    .eq('id', id);

  revalidatePath('/settings');
  revalidatePath('/');
}

export async function deletePlanItem(id: string) {
  await supabase.from('completions').delete().eq('plan_item_id', id);
  await supabase.from('plan_items').delete().eq('id', id);
  revalidatePath('/settings');
  revalidatePath('/');
}

export async function movePlanItem(id: string, frequency: string, direction: 'up' | 'down') {
  const { data: items } = await supabase
    .from('plan_items')
    .select('id, sort_order')
    .eq('frequency', frequency)
    .eq('is_active', true)
    .order('sort_order', { ascending: true });

  if (!items) return;

  const idx = items.findIndex(item => item.id === id);
  if (idx === -1) return;

  const swapIdx = direction === 'up' ? idx - 1 : idx + 1;
  if (swapIdx < 0 || swapIdx >= items.length) return;

  await Promise.all([
    supabase.from('plan_items').update({ sort_order: items[swapIdx].sort_order }).eq('id', items[idx].id),
    supabase.from('plan_items').update({ sort_order: items[idx].sort_order }).eq('id', items[swapIdx].id),
  ]);

  revalidatePath('/settings');
  revalidatePath('/');
}
