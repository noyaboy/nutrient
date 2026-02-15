export interface PlanItem {
  id: string;
  title: string;
  description: string;
  frequency: 'daily' | 'weekly';
  category: string;
  sort_order: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}

export interface Completion {
  id: string;
  plan_item_id: string;
  target_date: string;
  notes: string;
  completed_at: string;
  created_at: string;
}

export interface PlanItemWithCompletion extends PlanItem {
  completion: Completion | null;
}
