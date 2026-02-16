import { UI } from '@/lib/constants';

interface ShoppingItem {
  name: string;
  description: string;
  usage: string;
  url: string;
  store: string;
}

const costcoItems: ShoppingItem[] = [
  {
    name: '魚油 Omega-3（Kirkland 野生魚油 1400mg）',
    description: 'EPA + DHA 支持心血管與 BDNF 腦部健康',
    usage: '每日隨餐 2-3 顆（EPA > 1g, DHA 1-2g）',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Pure-Alaska-Omega-Wild-Alaskan-Fish-Oil-1400-mg-X-230-Softgel/p/113415',
    store: 'Costco',
  },
  {
    name: '緩釋魚油（Kirkland 新型緩釋 Omega-3）',
    description: '高濃度 EPA/DHA，緩釋不易打嗝',
    usage: '替代上方魚油，每日 2 顆',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Enteric-Omega-3-Fish-Oil-180-Softgel/p/240669',
    store: 'Costco',
  },
  {
    name: '鈣 + D3 + K2（Nature Made）',
    description: '鈣調節三位一體，防骨鬆 + 防動脈鈣化',
    usage: '每日隨餐，D3 2000-5000 IU + K2 100-200mcg',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453',
    store: 'Costco',
  },
  {
    name: '鈣鎂鋅複合錠（Kirkland）',
    description: '基礎鎂 + 鋅補充',
    usage: '每日 1-2 錠',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Calcium-Magnesium-Zinc-300-Tablets/p/408393',
    store: 'Costco',
  },
];

const costcoFoodItems: ShoppingItem[] = [
  {
    name: '有機雞蛋 / 放牧蛋',
    description: '高蛋白第一餐，富含亮氨酸 Leucine',
    usage: '每日 3-4 顆',
    url: 'https://www.costco.com.tw/Grocery/Dairy-Eggs-Bread/Eggs/c/cos_2.4.3',
    store: 'Costco',
  },
  {
    name: '冷凍鮭魚排',
    description: '優質蛋白 + Omega-3 來源',
    usage: '每週 3-4 份',
    url: 'https://www.costco.com.tw/Frozen/Frozen-Seafood/c/cos_3.2',
    store: 'Costco',
  },
  {
    name: '冷凍綠花椰菜',
    description: '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）',
    usage: '每日一份',
    url: 'https://www.costco.com.tw/Frozen/Frozen-Vegetables/c/cos_3.4',
    store: 'Costco',
  },
  {
    name: '地瓜',
    description: '晚餐原型碳水，助色氨酸→血清素→褪黑激素',
    usage: '晚餐適量',
    url: 'https://www.costco.com.tw/Fresh-Food/Vegetables/c/cos_1.3',
    store: 'Costco',
  },
  {
    name: '洋蔥 / 大蒜',
    description: '膳食纖維與益生元（菊糖 Inulin）來源',
    usage: '日常入菜',
    url: 'https://www.costco.com.tw/Fresh-Food/Vegetables/c/cos_1.3',
    store: 'Costco',
  },
  {
    name: '綠茶 / 抹茶粉',
    description: 'EGCG 來源，抑制 mTOR 促進自噬',
    usage: '每日 2-3 杯',
    url: 'https://www.costco.com.tw/Grocery/Tea-Coffee-Cocoa/Tea/c/cos_2.2.1',
    store: 'Costco',
  },
  {
    name: '海鹽 / 玫瑰鹽',
    description: '早晨電解質補充',
    usage: '每日少許',
    url: 'https://www.costco.com.tw/Grocery/Oils-Vinegar-Seasonings/Salts-Seasonings/c/cos_2.6.2',
    store: 'Costco',
  },
  {
    name: '檸檬',
    description: '早晨補水，平衡 pH 值',
    usage: '每日半顆',
    url: 'https://www.costco.com.tw/Fresh-Food/Fruits/c/cos_1.2',
    store: 'Costco',
  },
  {
    name: '綜合堅果（Kirkland）',
    description: '健康脂肪、鎂、鋅來源',
    usage: '每日一把',
    url: 'https://www.costco.com.tw/Grocery/Nuts-Seeds/c/cos_2.8',
    store: 'Costco',
  },
];

const iherbItems: ShoppingItem[] = [
  {
    name: '肌酸 Creatine Monohydrate（NOW Foods 500g）',
    description: '養肌肉 + 養腦，改善認知與工作記憶',
    usage: '每日 5g',
    url: 'https://tw.iherb.com/pr/now-foods-sports-micronized-creatine-monohydrate-1-1-lbs-500-g/687',
    store: 'iHerb',
  },
  {
    name: '蘇糖酸鎂 Mg L-Threonate（Life Extension Neuro-Mag）',
    description: '唯一穿透血腦屏障的鎂，上調 NR2B 增強記憶',
    usage: '睡前 3 顆',
    url: 'https://www.iherb.com/pr/life-extension-neuro-mag-magnesium-l-threonate-90-vegetarian-capsules-48-mg-per-capsule/40244',
    store: 'iHerb',
  },
  {
    name: '蘋果酸鎂 Mg Malate（NOW Foods 180 錠）',
    description: '白天能量支持，Krebs 循環中間物',
    usage: '早上 1-2 錠',
    url: 'https://tw.iherb.com/pr/now-foods-magnesium-malate-1-000-mg-180-tablets/692',
    store: 'iHerb',
  },
  {
    name: 'NMN Pro Complete（ProHealth Longevity）',
    description: 'NMN + 白藜蘆醇 + TMG 三合一，提升 NAD+ 支持 Sirtuins',
    usage: '早晨空腹，有活躍癌症者避免',
    url: 'https://www.iherb.com/pr/prohealth-longevity-nmn-pro-complete-120-capsules/127502',
    store: 'iHerb',
  },
  {
    name: 'TMG 三甲基甘氨酸（NOW Foods 1000mg）',
    description: '搭配 NMN 防止甲基耗竭',
    usage: '每日 1 錠 1000mg',
    url: 'https://www.iherb.com/r/now-foods-tmg-1-000-mg-100-tablets/3344',
    store: 'iHerb',
  },
  {
    name: 'Ashwagandha KSM-66（NOW Foods 600mg）',
    description: '調節 HPA 軸，降皮質醇 14-28%，助眠',
    usage: '睡前 1 顆 600mg',
    url: 'https://www.iherb.com/pr/now-foods-ksm-66-ashwagandha-600-mg-90-veg-capsules/145913',
    store: 'iHerb',
  },
  {
    name: 'Quercetin 槲皮素（NOW Foods 500mg）',
    description: 'Senolytic 清除衰老殭屍細胞',
    usage: '每週 2-3 天，每次 500mg',
    url: 'https://www.iherb.com/pr/now-foods-quercetin-500-mg-100-veg-capsules/774',
    store: 'iHerb',
  },
  {
    name: 'Fisetin 漆黃素（Doctor\'s Best 100mg）',
    description: 'Senolytic 清除衰老殭屍細胞，搭配 Quercetin',
    usage: '每週 2-3 天，每次 100mg',
    url: 'https://www.iherb.com/pr/doctor-s-best-fisetin-100-mg-30-veggie-caps/43592',
    store: 'iHerb',
  },
  {
    name: '蘿蔔硫素 BroccoMax（Jarrow Formulas）',
    description: '最強 Nrf2 激活劑，含肌紅素酶確保轉化',
    usage: '每日 1-2 顆',
    url: 'https://www.iherb.com/pr/jarrow-formulas-vegan-broccomax-35-mg-120-veggie-capsules/68704',
    store: 'iHerb',
  },
];

const equipmentItems: ShoppingItem[] = [
  {
    name: '防藍光眼鏡（琥珀色鏡片）',
    description: '阻擋 400-550nm 藍光，保護褪黑激素分泌',
    usage: '20:00 後佩戴',
    url: 'https://www.amazon.com/amber-blue-light-blocking-glasses/s?k=amber+blue+light+blocking+glasses',
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
              <div className="flex flex-col items-end gap-2 flex-shrink-0">
                <StoreTag store={item.store} />
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
    { time: '早晨空腹', items: 'NMN + TMG' },
    { time: '早上隨餐', items: '蘋果酸鎂、肌酸 5g' },
    { time: '10:00 第一餐', items: 'D3 + K2 + 魚油' },
    { time: '兩餐之間', items: '綠茶 EGCG、蘿蔔硫素' },
    { time: '每週 2-3 天', items: 'Quercetin + Fisetin' },
    { time: '睡前 21:00', items: '蘇糖酸鎂、Ashwagandha' },
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
  return (
    <div className="space-y-8">
      <h1 className="text-xl font-bold text-gray-900">採購清單</h1>
      <p className="text-sm text-gray-500">點擊任一項目可直接開啟產品頁面</p>

      <ShoppingSection title="Costco 好市多 — 保健品" items={costcoItems} />
      <ShoppingSection title="Costco 好市多 — 食材" items={costcoFoodItems} />
      <ShoppingSection title="iHerb — 專業補充品" items={iherbItems} />
      <ShoppingSection title="其他 — 設備" items={equipmentItems} />
      <TimingTable />
    </div>
  );
}
