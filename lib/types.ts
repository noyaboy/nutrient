export interface PlanItem {
  id: string;
  title: string;
  description: string;
  frequency: 'daily' | 'weekly';
  category: string;
  sort_order: number;
  is_active: boolean;
  target_count?: number | null;
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

export interface WeeklyItemWithCompletions extends PlanItem {
  completions: Completion[];
  targetCount: number;
}

export interface RecipeIngredient {
  name: string;
  amount: string;
}

export interface Recipe {
  id: string;
  name: string;
  mealSlot: 'post-workout' | 'lunch' | 'dinner';
  cookingMethod: '電子鍋' | '免煮';
  prepTime: number;
  macros: {
    protein: number;
    carbs: number;
    fat: number;
    calories: number;
  };
  ingredients: RecipeIngredient[];
  steps: string[];
  tips?: string;
}

export interface DailyRecipes {
  postWorkout: Recipe;
  lunch: Recipe;
  dinner: Recipe;
}

export interface Product {
  id: string;
  name: string;
  description: string;
  usage: string;
  price: string;
  url: string;
  store: string;
  category: string;
  brand: string | null;
  image_url: string | null;
  rating: number | null;
  review_count: number | null;
  sku: string | null;
  origin: string | null;
  specs: Record<string, unknown>;
  nutrition: Record<string, unknown>;
  purchase_note: string;
  sort_order: number;
  is_active: boolean;
  created_at: string;
  updated_at: string;
}
