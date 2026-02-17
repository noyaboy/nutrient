'use server';

import { supabase } from '@/lib/supabase';
import { revalidatePath } from 'next/cache';

export async function toggleCompletion(planItemId: string, targetDate: string, isCurrentlyCompleted: boolean) {
  if (isCurrentlyCompleted) {
    await supabase
      .from('completions')
      .delete()
      .eq('plan_item_id', planItemId)
      .eq('target_date', targetDate);
  } else {
    await supabase
      .from('completions')
      .upsert({
        plan_item_id: planItemId,
        target_date: targetDate,
      }, {
        onConflict: 'plan_item_id,target_date',
      });
  }

  revalidatePath('/');
  revalidatePath('/history');
}

export async function toggleWeeklyDayCompletion(planItemId: string, date: string, isCurrentlyCompleted: boolean) {
  if (isCurrentlyCompleted) {
    await supabase
      .from('completions')
      .delete()
      .eq('plan_item_id', planItemId)
      .eq('target_date', date);
  } else {
    await supabase
      .from('completions')
      .upsert({
        plan_item_id: planItemId,
        target_date: date,
      }, {
        onConflict: 'plan_item_id,target_date',
      });
  }

  revalidatePath('/');
  revalidatePath('/history');
}
