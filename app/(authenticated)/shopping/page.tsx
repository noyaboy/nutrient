'use client';

import { useState } from 'react';

interface ShoppingItem {
  name: string;
  description: string;
  usage: string;
  price: string;
  url: string;
  store: string;
}

const costcoItems: ShoppingItem[] = [
  {
    name: '緩釋魚油（Kirkland 新型緩釋 Omega-3）',
    description: '每 1200mg 魚油含 Omega-3 約 700mg（EPA 419mg + DHA 281mg）。沙丁魚、鯷魚、鯖魚來源，緩釋不打嗝。產地加拿大',
    usage: '每日隨餐 3 顆（EPA+DHA 共 2100mg）',
    price: 'NT$579 / 180 顆',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Enteric-Omega-3-Fish-Oil-180-Softgel/p/240669',
    store: 'Costco',
  },
  {
    name: '鈣 + D3 + K2（Nature Made 250 錠）',
    description: '碳酸鈣 + 檸檬酸鈣雙鈣源，K2 為 MK-7 型（納豆來源）。防骨鬆 + 防動脈鈣化。產地美國',
    usage: '每日隨訓練後餐（09:00），D3+K2 協同作用',
    price: 'NT$759 / 250 錠',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453',
    store: 'Costco',
  },
  {
    name: '維他命 C（Kirkland 500mg × 500 錠）',
    description: '抗氧化、膠原蛋白合成、增強鐵吸收。產地加拿大',
    usage: '每日 1-2 錠（500-1000mg）',
    price: 'NT$399 / 500 錠',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Multi-Letter-Vitamins/Kirkland-Signature-Vitamin-C-500-mg-500-Tablet/p/684654',
    store: 'Costco',
  },
];

const costcoFoodItems: ShoppingItem[] = [
  {
    name: '平飼雞蛋（全佑牧場 LL 規格）',
    description: '高蛋白第一餐，富含亮氨酸 Leucine。冷藏平飼蛋，非籠飼。賣場限定商品',
    usage: '每日 3-4 顆',
    price: '~NT$274 / 30 入',
    url: 'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/QUAN-YOU-FARM-Cage-Free-Eggs-LL-30-Count/p/128970',
    store: 'Costco',
  },
  {
    name: '冷凍鮭魚排（Kirkland 1.36kg）',
    description: '挪威養殖大西洋鮭魚，優質蛋白 + Omega-3 來源。成分：鮭魚、水、食鹽',
    usage: '每週 3-4 份',
    price: 'NT$1,229 / 1.36kg',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/Kirkland-Signature-Frozen-Atlantic-Salmon-136-kg/p/1286092',
    store: 'Costco',
  },
  {
    name: '冷凍青花菜（Nature\'s Touch 454g×4）',
    description: '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）。切碎後靜置 40 分鐘可最大化黑芥子酶轉化。產地厄瓜多',
    usage: '每日一份',
    price: 'NT$329 / 454g×4',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Fruits-Vegetables/Natures-Touch-Frozen-Broccoli-454-g-X-4-Pack/p/122199',
    store: 'Costco',
  },
  {
    name: '地瓜',
    description: '原型碳水來源。訓練前能量補充，晚餐助色氨酸→血清素→褪黑激素。冷卻後產生抗性澱粉（益生元）',
    usage: '訓練前/晚餐適量',
    price: '~NT$135 / 2.8kg',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '洋蔥 / 大蒜',
    description: '膳食纖維與益生元（菊糖 Inulin）來源',
    usage: '日常入菜',
    price: '~NT$149',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '碘鹽（統一生機 日曬海鹽加碘）',
    description: '西班牙日曬海鹽 + 碘化鉀。海鹽/玫瑰鹽碘含量極低，十字花科蔬菜攝取量高時需確保碘攝取',
    usage: '日常用鹽，每日少許',
    price: 'NT$179 / 2kg',
    url: 'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/Uni-President-Iodized-Solar-Sea-Salt-2-kg/p/283283',
    store: 'Costco',
  },
  {
    name: '檸檬',
    description: '早晨補水，促進消化',
    usage: '每日半顆',
    price: '~NT$329 / 2.2kg',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '綜合堅果（Kirkland 1.13kg）',
    description: '腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅來源。產地越南',
    usage: '每日一把',
    price: 'NT$585 / 1.13kg',
    url: 'https://www.costco.com.tw/Food-Dining/Snacks/Nuts-Jerky/Kirkland-Signature-Mixed-Nuts-113-kg/p/1669722',
    store: 'Costco',
  },
  {
    name: '希臘優格（Kirkland 零脂 907g×2）',
    description: '5 種活菌（保加利亞乳桿菌、嗜熱鏈球菌、嗜酸乳桿菌、雙歧桿菌、乾酪乳桿菌）。零脂，每 100g 含 9.4g 蛋白質。賣場限定商品',
    usage: '每日 200-300g',
    price: 'NT$479 / 907g×2',
    url: 'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/Kirkland-Signature-Chilled-Nonfat-Greek-Yogurt-907-g-X-2-Count/p/599369',
    store: 'Costco',
  },
  {
    name: '泡菜（宗家府 冷藏切塊泡菜 120g×6）',
    description: '韓國產冷藏泡菜，活性乳酸菌來源。成分含白菜、蘿蔔、辣椒、大蒜、韭菜、蝦醬、鯷魚醬。賣場限定商品',
    usage: '每日 50-100g 隨餐',
    price: '~NT$259 / 120g×6',
    url: 'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/JONGGA-Sliced-Kimchi-120-g-X-6-Pack/p/137728',
    store: 'Costco',
  },
  {
    name: '酪梨',
    description: '修復鉀缺口（每顆 ~700mg 鉀）+ 健康單元不飽和脂肪 + 膳食纖維 7g',
    usage: '每日半顆至一顆',
    price: '~NT$329 / 1.3kg',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '菠菜（冷凍或新鮮）',
    description: '鉀、鎂、鐵、葉酸來源。搭配維他命C增強鐵吸收',
    usage: '每日 100-150g 入菜',
    price: 'NT$379 / 500g×6',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '有機燕麥（桂格有機大燕麥片 935g×2）',
    description: '澳洲有機燕麥，已完全煮熟。β-葡聚醣降膽固醇，優質碳水 + 膳食纖維 8g/份（GI~55，中升糖）',
    usage: '每日 1 份（80g），訓練後或早餐',
    price: 'NT$439 / 935g×2',
    url: 'https://www.costco.com.tw/Food-Dining/Drinks/Powdered-Drink-Mix-Cereal-Oats/Quaker-Organic-Whole-Oats-935-g-X-2-Count/p/116958',
    store: 'Costco',
  },
  {
    name: '香蕉',
    description: '訓練前後快速碳水，富含鉀。青香蕉含抗性澱粉（益生元）',
    usage: '每日 1-2 根（訓練前後）',
    price: '~NT$99 / 1.4kg',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '雞胸肉（大成 冷凍雞清胸肉 2.5kg×2）',
    description: '台灣產清雞胸肉，高蛋白低脂，每 100g 約 31g 蛋白質。增肌期核心蛋白來源',
    usage: '每週 1-2kg',
    price: 'NT$1,179 / 2.5kg×2',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/DaChan-Taiwan-Frozen-Chicken-Breast-25-kg-X-2-Count/p/133602',
    store: 'Costco',
  },
  {
    name: '有機糙米（銀川有機一等糙米 3kg）',
    description: '花蓮產有機糙米。基礎碳水來源，冷卻後產生抗性澱粉（益生元）。提供膳食纖維與鎂',
    usage: '每日適量，訓練日增加碳水攝取',
    price: 'NT$359 / 3kg',
    url: 'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Greenme-Organic-Brown-Rice-3-kg/p/124095',
    store: 'Costco',
  },
  {
    name: '咖啡豆 / 研磨咖啡',
    description: '起床 60-90 分鐘後飲用，咖啡因 200-300mg。多酚抗氧化、增強專注力',
    usage: '每日 1-2 杯，08:30-13:00 之間',
    price: '~NT$399 / 1.13kg',
    url: 'https://www.costco.com.tw/Coffee-Beans/c/hero_coffeebean',
    store: 'Costco',
  },
];

const iherbItems: ShoppingItem[] = [
  {
    name: '乳清蛋白 Gold Standard Whey（ON 雙倍巧克力 2.29kg）',
    description: '每份 31g 粉：24g 蛋白、120kcal、1.5g 脂肪、3g 碳水、130mg 鈣。WPI（分離乳清蛋白）為主要成分，5.5g BCAA',
    usage: '訓練前 1 份（30g 粉 ≈ 24g 蛋白），訓練後 1.5 份（~40g 粉 ≈ 33g 蛋白）',
    price: 'NT$3,268 / 2.29kg',
    url: 'https://tw.iherb.com/pr/optimum-nutrition-gold-standard-100-whey-double-rich-chocolate-5-lbs-2-27-kg/27509',
    store: 'iHerb',
  },
  {
    name: '肌酸 Creatine Monohydrate（CGN 454g）',
    description: '養肌肉 + 養腦，改善認知與工作記憶',
    usage: '每日 5g',
    price: 'NT$420 / 454g',
    url: 'https://tw.iherb.com/pr/california-gold-nutrition-sport-creatine-monohydrate-unflavored-1-lb-454-g/71026',
    store: 'iHerb',
  },
  {
    name: '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）',
    description: '甘胺酸是抑制性神經傳導物質，降低核心體溫助眠。高吸收率，每日補充鎂 200mg',
    usage: '睡前 2 錠（200mg）',
    price: 'NT$399 / 180 錠',
    url: 'https://tw.iherb.com/pr/now-foods-magnesium-glycinate-180-tablets-100-mg-per-tablet/88819',
    store: 'iHerb',
  },
  {
    name: '葉黃素 + 玉米黃素（CGN 20mg × 120 顆）',
    description: '沉積於視網膜黃斑部，保護眼睛抵禦藍光與氧化傷害',
    usage: '每日 1 顆隨餐（需搭配油脂吸收）',
    price: 'NT$914 / 120 顆',
    url: 'https://tw.iherb.com/pr/california-gold-nutrition-lutein-with-zeaxanthin-from-marigold-extract-120-veggie-softgels/94824',
    store: 'iHerb',
  },
  {
    name: '鋅 Zinc Picolinate（NOW Foods 50mg × 120 顆）',
    description: '免疫與睪固酮合成必需。每日 25mg（半顆），搭配銅 2mg 維持平衡',
    usage: '每日半顆（25mg）隨晚餐（避開鈣，與銅間隔 4hr+）',
    price: 'NT$710 / 120 顆',
    url: 'https://tw.iherb.com/pr/now-foods-zinc-picolinate-50-mg-120-veg-capsules/878',
    store: 'iHerb',
  },
  {
    name: '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）',
    description: '長期補鋅必須搭配銅。甘胺酸銅吸收率優於檸檬酸銅，鋅銅比維持 10-15:1，防止銅缺乏導致貧血與神經損傷。100 顆裝省 13%/顆',
    usage: '每日 1 顆隨午餐或午後（與鋅間隔 4hr+）',
    price: 'NT$529 / 100 顆',
    url: 'https://tw.iherb.com/pr/solaray-copper-2-mg-100-vegcaps/70102',
    store: 'iHerb',
  },
  {
    name: '維他命 D3 5000IU（Doctor\'s Best 360 顆）',
    description: '鈣+D3+K2 複合錠含 1000IU D3，額外補充 5000IU，每日總計約 6000IU。目標血清 40-60 ng/mL。360 顆大包裝更划算（-32%/顆）',
    usage: '每日 1 顆隨訓練後餐（需搭配油脂吸收）',
    price: 'NT$457 / 360 顆',
    url: 'https://tw.iherb.com/pr/doctor-s-best-vitamin-d3-125-mcg-5-000-iu-360-softgels/36580',
    store: 'iHerb',
  },
  {
    name: 'L-Theanine（NOW Foods Double Strength 200mg × 120 顆）',
    description: '搭配咖啡的最強 nootropic 組合（A 級證據）。促進專注 + 放鬆，消除咖啡因焦慮感。120 顆大包裝更划算',
    usage: '每日 1 顆（200mg）搭配早晨咖啡',
    price: 'NT$399 / 120 顆',
    url: 'https://tw.iherb.com/pr/now-foods-double-strength-l-theanine-200-mg-120-veg-capsules/54096',
    store: 'iHerb',
  },
];

const equipmentItems: ShoppingItem[] = [
  {
    name: '防藍光眼鏡（琥珀色鏡片）',
    description: '阻擋 400-550nm 藍光，保護褪黑激素分泌',
    usage: '20:00 後佩戴',
    price: 'NT$500~1,500',
    url: 'https://www.amazon.com/amber-blue-light-blocking-glasses/s?k=amber+blue+light+blocking+glasses',
    store: 'Amazon',
  },
  {
    name: '食品電子秤',
    description: '精準測量蛋白粉、食材重量，確保每日蛋白質攝取達標',
    usage: '每餐使用，精度 0.1-1g',
    price: 'NT$300~800',
    url: 'https://www.amazon.com/digital-kitchen-food-scale/s?k=digital+kitchen+food+scale',
    store: 'Amazon',
  },
  {
    name: '全遮光窗簾',
    description: '確保臥室全黑環境，維持褪黑激素正常分泌。配合 22:00 入睡方案',
    usage: '安裝於臥室窗戶',
    price: 'NT$1,000~3,000',
    url: 'https://www.amazon.com/100-percent-blackout-curtains/s?k=100+percent+blackout+curtains',
    store: 'Amazon',
  },
];

function StoreTag({ store }: { store: string }) {
  const colors: Record<string, string> = {
    Costco: 'bg-red-100 text-red-700',
    iHerb: 'bg-green-100 text-green-700',
    Amazon: 'bg-yellow-100 text-yellow-700',
  };
  return (
    <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${colors[store] || 'bg-gray-100 text-gray-700'}`}>
      {store}
    </span>
  );
}

function ShoppingSection({ title, items }: { title: string; items: ShoppingItem[] }) {
  return (
    <section className="space-y-3">
      <h2 className="text-base font-bold text-gray-900">{title}</h2>
      <div className="space-y-2">
        {items.map((item, i) => (
          <a
            key={i}
            href={item.url}
            target="_blank"
            rel="noopener noreferrer"
            className="block p-4 bg-white rounded-xl border border-gray-200 hover:border-emerald-300 hover:shadow-sm transition-all active:scale-[0.98]"
          >
            <div className="flex items-start justify-between gap-2">
              <div className="flex-1 min-w-0">
                <div className="flex items-center gap-2 mb-1">
                  <p className="text-base font-medium text-gray-900">{item.name}</p>
                </div>
                <p className="text-sm text-gray-500">{item.description}</p>
                <p className="text-sm text-emerald-700 mt-1">{item.usage}</p>
              </div>
              <div className="flex flex-col items-end gap-1.5 flex-shrink-0">
                <StoreTag store={item.store} />
                <span className="text-xs font-semibold text-amber-700">{item.price}</span>
                <svg className="w-4 h-4 text-gray-400" fill="none" viewBox="0 0 24 24" stroke="currentColor" strokeWidth={2}>
                  <path strokeLinecap="round" strokeLinejoin="round" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
                </svg>
              </div>
            </div>
          </a>
        ))}
      </div>
    </section>
  );
}

function TimingTable() {
  const rows = [
    { time: '07:00 起床', items: '晨光曝曬 10-20 分鐘（不戴太陽眼鏡）' },
    { time: '07:05 補水', items: '500ml 室溫水 + 少許碘鹽 + 檸檬汁' },
    { time: '07:15 訓練前', items: '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈24g 蛋白）' },
    { time: '08:30 咖啡', items: '咖啡因 200-300mg + L-Theanine 200mg（起床 60-90 分鐘後，13:00 前）' },
    { time: '09:00 訓練後', items: '乳清蛋白 ~40g 粉（≈33g 蛋白）+ 碳水 60-80g + 肌酸 5g、D3 ~6000IU+K2+魚油+葉黃素+維他命C' },
    { time: '13:00 午餐', items: '蛋白質 40-50g' },
    { time: '14:00 午後', items: '銅 2mg（與鋅間隔 4hr+）' },
    { time: '18:00 晚餐', items: '鋅 25mg（與銅間隔 4hr+）' },
    { time: '21:00 睡前', items: '希臘優格 300g（≈30g 蛋白）+甘胺酸鎂 200mg' },
  ];

  return (
    <section className="space-y-3">
      <h2 className="text-base font-bold text-gray-900">服用時間對照</h2>
      <div className="bg-white rounded-xl border border-gray-200 overflow-hidden">
        {rows.map((row, i) => (
          <div key={i} className={`flex px-4 py-3 ${i !== rows.length - 1 ? 'border-b border-gray-100' : ''}`}>
            <span className="text-sm font-medium text-emerald-700 w-28 flex-shrink-0">{row.time}</span>
            <span className="text-sm text-gray-700">{row.items}</span>
          </div>
        ))}
      </div>
    </section>
  );
}

export default function ShoppingPage() {
  const [search, setSearch] = useState('');

  function filterItems(items: ShoppingItem[]): ShoppingItem[] {
    if (!search) return items;
    const q = search.toLowerCase();
    return items.filter(item =>
      item.name.toLowerCase().includes(q) ||
      item.description.toLowerCase().includes(q) ||
      item.usage.toLowerCase().includes(q)
    );
  }

  const filteredCostco = filterItems(costcoItems);
  const filteredCostcoFood = filterItems(costcoFoodItems);
  const filteredIherb = filterItems(iherbItems);
  const filteredEquipment = filterItems(equipmentItems);
  const hasResults = filteredCostco.length + filteredCostcoFood.length + filteredIherb.length + filteredEquipment.length > 0;

  return (
    <div className="space-y-8">
      <h1 className="text-xl font-bold text-gray-900">採購清單</h1>

      <TimingTable />

      <div className="sticky top-12 z-[5] -mx-4 px-4 bg-gray-50 pb-3 pt-1">
        <input
          type="search"
          placeholder="搜尋品項..."
          value={search}
          onChange={e => setSearch(e.target.value)}
          className="w-full px-4 py-2.5 rounded-lg border border-gray-200 focus:ring-2 focus:ring-emerald-500 focus:border-emerald-500 outline-none text-sm bg-white"
        />
      </div>

      <p className="text-sm text-gray-500">點擊任一項目可直接開啟產品頁面</p>

      {hasResults ? (
        <>
          {filteredCostco.length > 0 && <ShoppingSection title="Costco 好市多 — 保健品" items={filteredCostco} />}
          {filteredCostcoFood.length > 0 && <ShoppingSection title="Costco 好市多 — 食材" items={filteredCostcoFood} />}
          {filteredIherb.length > 0 && <ShoppingSection title="iHerb — 專業補充品" items={filteredIherb} />}
          {filteredEquipment.length > 0 && <ShoppingSection title="其他 — 設備" items={filteredEquipment} />}
        </>
      ) : (
        <p className="text-center text-gray-400 py-8">找不到符合的品項</p>
      )}
    </div>
  );
}
