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

  const sortOrder = (maxOrder?.sort_order ?? 0) + 1;

  await supabase.from('plan_items').insert({
    title,
    description,
    frequency,
    category,
    sort_order: sortOrder,
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
  await supabase
    .from('completions')
    .delete()
    .eq('plan_item_id', id);

  await supabase
    .from('plan_items')
    .delete()
    .eq('id', id);

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

  const currentIndex = items.findIndex(item => item.id === id);
  if (currentIndex === -1) return;

  const swapIndex = direction === 'up' ? currentIndex - 1 : currentIndex + 1;
  if (swapIndex < 0 || swapIndex >= items.length) return;

  const currentOrder = items[currentIndex].sort_order;
  const swapOrder = items[swapIndex].sort_order;

  await Promise.all([
    supabase.from('plan_items').update({ sort_order: swapOrder }).eq('id', items[currentIndex].id),
    supabase.from('plan_items').update({ sort_order: currentOrder }).eq('id', items[swapIndex].id),
  ]);

  revalidatePath('/settings');
  revalidatePath('/');
}
