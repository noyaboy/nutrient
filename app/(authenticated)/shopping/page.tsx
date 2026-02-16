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
    name: '緩釋魚油（Kirkland 新型緩釋 Omega-3）',
    description: '高濃度 EPA 419mg + DHA 281mg，緩釋不打嗝',
    usage: '每日隨餐 3 顆（EPA+DHA 共 2100mg）',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Enteric-Omega-3-Fish-Oil-180-Softgel/p/240669',
    store: 'Costco',
  },
  {
    name: '鈣 + D3 + K2（Nature Made 250 錠）',
    description: '鈣調節三位一體，防骨鬆 + 防動脈鈣化',
    usage: '每日隨餐，D3 2000-5000 IU + K2 100-200mcg',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453',
    store: 'Costco',
  },
  {
    name: '維他命 C（Kirkland 500mg × 500 錠）',
    description: '抗氧化、膠原蛋白合成、增強鐵吸收',
    usage: '每日 1-2 錠（500-1000mg）',
    url: 'https://www.costco.com.tw/Health-Beauty/Supplements/Multi-Letter-Vitamins/Kirkland-Signature-Vitamin-C-500-mg-500-Tablet/p/684654',
    store: 'Costco',
  },
];

const costcoFoodItems: ShoppingItem[] = [
  {
    name: '有機雞蛋 / 放牧蛋',
    description: '高蛋白第一餐，富含亮氨酸 Leucine',
    usage: '每日 3-4 顆',
    url: 'https://www.costco.com.tw/Chilled-Fresh-Foods/Cheese-Dairy-Eggs/c/90903',
    store: 'Costco',
  },
  {
    name: '冷凍鮭魚排',
    description: '優質蛋白 + Omega-3 來源',
    usage: '每週 3-4 份',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/c/90802',
    store: 'Costco',
  },
  {
    name: '冷凍綠花椰菜',
    description: '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）',
    usage: '每日一份',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Fruits-Vegetables/Natures-Touch-Frozen-Broccoli-454-g-X-4-Pack/p/122199',
    store: 'Costco',
  },
  {
    name: '地瓜',
    description: '原型碳水來源。訓練前能量補充，晚餐助色氨酸→血清素→褪黑激素。冷卻後產生抗性澱粉（益生元）',
    usage: '訓練前/晚餐適量',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '洋蔥 / 大蒜',
    description: '膳食纖維與益生元（菊糖 Inulin）來源',
    usage: '日常入菜',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '綠茶 / 抹茶粉',
    description: 'EGCG + L-theanine 天然組合。抗氧化、促進專注。須在餐後 1hr+ 飲用避免螯合礦物質',
    usage: '每日 2-3 杯（13:00 前，避免咖啡因影響睡眠）',
    url: 'https://www.costco.com.tw/Food-Dining/Drinks/Tea/c/90207',
    store: 'Costco',
  },
  {
    name: '碘鹽（取代一般海鹽）',
    description: '早晨電解質補充。海鹽/玫瑰鹽碘含量極低，十字花科蔬菜攝取量高時需確保碘攝取',
    usage: '日常用鹽，每日少許',
    url: 'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/c/90702',
    store: 'Costco',
  },
  {
    name: '檸檬',
    description: '早晨補水，促進消化',
    usage: '每日半顆',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '綜合堅果（Kirkland）',
    description: '健康脂肪、鎂、鋅來源',
    usage: '每日一把',
    url: 'https://www.costco.com.tw/Food-Dining/Snacks/Nuts-Jerky/c/90104',
    store: 'Costco',
  },
  {
    name: '希臘優格（FAGE 或 Kirkland）',
    description: '活菌培養（嗜酸乳桿菌、雙歧桿菌）+ 高蛋白。Stanford 研究：發酵食物增加腸道多樣性、降低 19 種發炎蛋白',
    usage: '每日 200-300g',
    url: 'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/Kirkland-Signature-Chilled-Nonfat-Greek-Yogurt-907-g-X-2-Count/p/599369',
    store: 'Costco',
  },
  {
    name: '泡菜 / 酸菜（冷藏未殺菌）',
    description: '活性乳酸菌來源，增強腸道微生物多樣性。選冷藏區（非罐頭）確保活菌',
    usage: '每日 50-100g 隨餐',
    url: 'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/JONGGA-Sliced-Kimchi-120-g-X-6-Pack/p/137728',
    store: 'Costco',
  },
  {
    name: '酪梨',
    description: '修復鉀缺口（每顆 ~700mg 鉀）+ 健康單元不飽和脂肪 + 膳食纖維 7g',
    usage: '每日半顆至一顆',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '菠菜（冷凍或新鮮）',
    description: '鉀、鎂、鐵、葉酸來源。搭配維他命C增強鐵吸收',
    usage: '每日 100-150g 入菜',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
  {
    name: '燕麥（Quaker 大包裝）',
    description: 'β-葡聚醣降膽固醇，優質碳水+膳食纖維 8g/份。訓練後快速碳水搭配乳清蛋白',
    usage: '每日 1 份（80g），訓練後或早餐',
    url: 'https://www.costco.com.tw/Food-Dining/Drinks/Powdered-Drink-Mix-Cereal-Oats/Quaker-Organic-Whole-Oats-935-g-X-2-Count/p/116958',
    store: 'Costco',
  },
  {
    name: '香蕉',
    description: '訓練前後快速碳水，富含鉀。青香蕉含抗性澱粉（益生元）',
    usage: '每日 1-2 根（訓練前後）',
    url: 'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
    store: 'Costco',
  },
];

const iherbItems: ShoppingItem[] = [
  {
    name: '乳清蛋白 Gold Standard Whey（ON 雙倍巧克力 2.27kg）',
    description: '每份 24g 蛋白 + 5.5g BCAA + 4g 麩醯胺酸。WPI 為主要成分',
    usage: '訓練前/後各 1 份（25-30g），或加餐補足蛋白目標',
    url: 'https://tw.iherb.com/pr/optimum-nutrition-gold-standard-100-whey-double-rich-chocolate-5-lbs-2-27-kg/27509',
    store: 'iHerb',
  },
  {
    name: '肌酸 Creatine Monohydrate（CGN 454g）',
    description: '養肌肉 + 養腦，改善認知與工作記憶',
    usage: '每日 5g',
    url: 'https://tw.iherb.com/pr/california-gold-nutrition-sport-creatine-monohydrate-unflavored-1-lb-454-g/71026',
    store: 'iHerb',
  },
  {
    name: '蘇糖酸鎂 Mg L-Threonate（Life Extension Neuro-Mag）',
    description: '唯一穿透血腦屏障的鎂，上調 NR2B 增強記憶',
    usage: '睡前 3 顆',
    url: 'https://tw.iherb.com/pr/life-extension-neuro-mag-magnesium-l-threonate-90-vegetarian-capsules-48-mg-per-capsule/40244',
    store: 'iHerb',
  },
  {
    name: '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）',
    description: '甘胺酸是抑制性神經傳導物質，降低核心體溫助眠。高吸收率',
    usage: '睡前 2 錠（200mg），搭配蘇糖酸鎂',
    url: 'https://tw.iherb.com/pr/now-foods-magnesium-glycinate-180-tablets-100-mg-per-tablet/88819',
    store: 'iHerb',
  },
  {
    name: 'Ashwagandha KSM-66（NOW Foods 600mg）',
    description: '調節 HPA 軸，降皮質醇 14-28%，助眠。建議 8 週用 / 4 週停循環使用（停用期改服紅景天）',
    usage: '睡前 1 顆 600mg',
    url: 'https://tw.iherb.com/pr/now-foods-ksm-66-ashwagandha-600-mg-90-veg-capsules/145913',
    store: 'iHerb',
  },
  {
    name: '蘿蔔硫素 BroccoMax（Jarrow Formulas 60 顆）',
    description: '最強 Nrf2 激活劑，含肌紅素酶確保轉化。每顆 17.5mg SGS（2 顆 = 35mg）',
    usage: '每日 1-2 顆',
    url: 'https://tw.iherb.com/pr/jarrow-formulas-vegan-broccomax-60-veggie-capsules-17-50-mg-per-capsule/4297',
    store: 'iHerb',
  },
  {
    name: '葉黃素 + 玉米黃素（CGN 20mg × 120 顆）',
    description: '沉積於視網膜黃斑部，保護眼睛抵禦藍光與氧化傷害',
    usage: '每日 1 顆隨餐（需搭配油脂吸收）',
    url: 'https://tw.iherb.com/pr/california-gold-nutrition-lutein-with-zeaxanthin-from-marigold-extract-120-veggie-softgels/94824',
    store: 'iHerb',
  },
  {
    name: '鋅 Zinc Picolinate（NOW Foods 50mg × 120 顆）',
    description: 'EGCG 會螯合鋅，需額外補充。免疫與睪固酮合成必需。每日 25mg（半顆），搭配銅 2mg 維持平衡',
    usage: '每日半顆（25mg）隨晚餐（避開鈣與 EGCG，與銅間隔 4hr+）',
    url: 'https://tw.iherb.com/pr/now-foods-zinc-picolinate-50-mg-120-veg-capsules/878',
    store: 'iHerb',
  },
  {
    name: '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）',
    description: '長期補鋅必須搭配銅。甘胺酸銅吸收率優於檸檬酸銅，鋅銅比維持 10-15:1，防止銅缺乏導致貧血與神經損傷。100 顆裝省 13%/顆',
    usage: '每日 1 顆隨午餐（與鋅間隔 4hr+）',
    url: 'https://tw.iherb.com/pr/solaray-copper-2-mg-100-vegcaps/70102',
    store: 'iHerb',
  },
  {
    name: '維他命 D3 5000IU（Doctor\'s Best 360 顆）',
    description: '鈣+D3+K2 複合錠僅含 1000IU D3，不足。額外補充至每日共 5000IU，目標血清 40-60 ng/mL。360 顆大包裝更划算（-32%/顆）',
    usage: '每日 1 顆隨早餐（需搭配油脂吸收）',
    url: 'https://tw.iherb.com/pr/doctor-s-best-vitamin-d3-125-mcg-5-000-iu-360-softgels/36580',
    store: 'iHerb',
  },
  {
    name: '酪蛋白 Casein-FX（ALLMAX 巧克力 907g）',
    description: '100% 酪蛋白，睡前 40g 增加 22% 夜間肌蛋白合成（Res et al. 2012）。每份 25g 酪蛋白，8-10hr 緩釋。比 ON 同級省 ~10%',
    usage: '睡前 30 分鐘，40g 配水或牛奶',
    url: 'https://tw.iherb.com/pr/allmax-nutrition-caseinfx-100-casein-micellar-protein-chocolate-2-lbs-907-g/67639',
    store: 'iHerb',
  },
  {
    name: '甘胺酸粉 Glycine Powder（NOW Foods 454g）',
    description: '抑制性神經傳導物質，降低核心體溫助眠，促進膠原蛋白合成',
    usage: '睡前 3g（約半匙），搭配酪蛋白一起服用',
    url: 'https://tw.iherb.com/pr/now-foods-glycine-pure-powder-1-lb-454-g/615',
    store: 'iHerb',
  },
  {
    name: '紅景天 Rhodiola Rosea（NOW Foods 500mg × 120 顆）',
    description: 'Ashwagandha 停用期的替代適應原。抗疲勞、提升專注力，3% rosavins 標準化。120 顆裝比 60 顆裝省 26%/顆',
    usage: 'Ashwagandha 停用 4 週期間，每日早上 1 顆',
    url: 'https://tw.iherb.com/pr/now-foods-rhodiola-500-mg-120-veg-capsules/123463',
    store: 'iHerb',
  },
  {
    name: '電解質粉 Nutricost Electrolytes（綜合口味 40 包）',
    description: '含 7 種維生素礦物質（鈉、鉀、鈣、鎂等），Stevia 天然甜味。40 包比 BPN 30 包省 ~50%/份',
    usage: '有氧訓練日，運動中沖泡飲用',
    url: 'https://tw.iherb.com/pr/nutricost-electrolytes-advanced-hydration-complex-variety-pack-40-stick-packs-0-14-oz-4-g-each/147238',
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
    { time: '07:00 起床', items: '晨光曝曬 10-20 分鐘（不戴太陽眼鏡）' },
    { time: '07:15 訓練前', items: '香蕉/地瓜 + 乳清蛋白 25g + 咖啡 200-300mg' },
    { time: '09:00 訓練後', items: '乳清蛋白 40g + 快速碳水 60-80g（香蕉+燕麥）' },
    { time: '10:00 第一餐', items: '肌酸 5g、D3 5000IU+K2+魚油+葉黃素+維他命C' },
    { time: '11:00 兩餐間', items: '綠茶 EGCG（餐後 1hr+，13:00 前）' },
    { time: '12:00 午餐', items: '銅 2mg、蘿蔔硫素 BroccoMax' },
    { time: '18:00 晚餐', items: '鋅 25mg（與銅間隔 4hr+，避開 EGCG）' },
    { time: '21:00 睡前', items: '酪蛋白 40g+甘胺酸 3g+蘇糖酸鎂+甘胺酸鎂+Ashwagandha（8週/4週循環）' },
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
