import React from 'react';

function Detail({ children }: { children: React.ReactNode }) {
  return <div className="text-xs text-gray-600 space-y-1.5">{children}</div>;
}

function Label({ children }: { children: React.ReactNode }) {
  return <p className="text-xs font-semibold text-gray-800">{children}</p>;
}

function Tip({ children }: { children: React.ReactNode }) {
  return <p className="text-xs text-amber-700 bg-amber-50 rounded-lg px-3 py-2">{children}</p>;
}

function Tag({ children, color = 'gray' }: { children: React.ReactNode; color?: string }) {
  const colors: Record<string, string> = {
    green: 'bg-emerald-100 text-emerald-700',
    blue: 'bg-blue-100 text-blue-700',
    amber: 'bg-amber-100 text-amber-700',
    gray: 'bg-gray-100 text-gray-700',
    red: 'bg-red-100 text-red-700',
  };
  return <span className={`text-xs px-2 py-0.5 rounded-full font-medium ${colors[color]}`}>{children}</span>;
}

function ExerciseTable({ title, exercises }: { title: string; exercises: { name: string; sets: string; rest: string }[] }) {
  return (
    <div>
      <p className="text-xs font-semibold text-emerald-700 mb-2">{title}</p>
      <div className="space-y-1">
        {exercises.map((ex, i) => (
          <div key={i} className="flex items-center gap-2 text-xs">
            <span className="text-gray-400 w-4 flex-shrink-0">{i + 1}.</span>
            <span className="flex-1 text-gray-800 font-medium">{ex.name}</span>
            <span className="text-gray-500 flex-shrink-0">{ex.sets}</span>
            <span className="text-gray-400 flex-shrink-0 w-12 text-right">{ex.rest}</span>
          </div>
        ))}
      </div>
    </div>
  );
}

function getHeartRateZones() {
  const age = new Date().getFullYear() - 2002;
  const hrMax = 220 - age;
  return {
    zone2Low: Math.round(hrMax * 0.6),
    zone2High: Math.round(hrMax * 0.7),
    vo2Low: Math.round(hrMax * 0.9),
    vo2High: Math.round(hrMax * 0.95),
  };
}

export function getHealthDetails(title: string): React.ReactNode | null {
  // Match by key phrase in title
  if (title.includes('起床') && title.includes('曝曬')) {
    return (
      <Detail>
        <Label>晨光曝曬指南</Label>
        <p>起床後 30-60 分鐘內到戶外曝曬陽光（不要隔著玻璃、不戴太陽眼鏡）</p>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-blue-800">曝曬時長</p>
          <p className="text-blue-700">晴天：5 分鐘 / 陰天：10 分鐘 / 多雲：20-30 分鐘</p>
        </div>
        <p>觸發皮質醇覺醒反應 → 設定生物鐘 → 改善夜間褪黑激素分泌</p>
        <p>下午額外 20-30 分鐘日曬（皮膚暴露）可提升睪固酮</p>
      </Detail>
    );
  }

  if (title.includes('訓練前') && title.includes('營養')) {
    return (
      <Detail>
        <Label>訓練前營養</Label>
        <p>⏰ 09:05 先補水 → 09:15 訓練前營養</p>
        <p>地瓜（推薦）或香蕉 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（活化型態 Coenzyme B-Complex：甲鈷胺 B12 + 5-MTHF 葉酸 + P5P B6，水溶性需隨餐）</p>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">⏰ 正確順序</p>
          <p className="text-blue-700">09:05 補水：500ml 室溫水 + 碘鹽 1g（標準 1/4 茶匙量勺）+ 檸檬汁</p>
          <p className="text-blue-700">09:15 進食：地瓜/香蕉 + 乳清蛋白 + B群</p>
          <p className="text-blue-700">先喝水再吃固體食物+B群，確保胃中有食物基質時 B群才進入</p>
        </div>
        <p className="text-amber-600">⚠️ 確認碘鹽為「加碘」版本（統一生機日曬海鹽加碘，包裝標示「碘化鉀」）。使用量勺精確測量，避免估量</p>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">⚠️ B群需隨餐服用</p>
          <p className="text-amber-700">水溶性維生素需食物基質減緩胃排空以提升吸收</p>
          <p className="text-amber-700">推薦：地瓜（前晚蒸好冷藏產生抗性澱粉 RS3）</p>
          <p className="text-amber-700">替代：香蕉（快速碳水 + 鉀）</p>
        </div>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">抗性澱粉 RS3 落實</p>
          <p className="text-blue-700">地瓜建議前晚用電子鍋蒸好冷藏（產生抗性澱粉 RS3）</p>
          <p className="text-blue-700">隔日微波 30 秒加溫即可食用，抗性澱粉仍保留大部分</p>
        </div>
        <Tip>下肢大重量日（深蹲/硬舉）若腸胃不適，可提前至訓練前 60-90 分鐘進食或減量</Tip>
      </Detail>
    );
  }

  if (title.includes('咖啡') && title.includes('Theanine')) {
    return (
      <Detail>
        <Label>咖啡因 + L-Theanine（11:15+）</Label>
        <p>起床後 90-135 分鐘再喝（避免干擾皮質醇覺醒反應）</p>
        <p>1:1 比例：咖啡因 200-300mg + L-Theanine 200mg（NOW Foods Double Strength 200mg，iHerb），A 級 nootropic 組合</p>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">⚠️ B群吸收保護：與 09:15 B群間隔 2hr+</p>
          <p className="text-amber-700">咖啡因利尿作用加速水溶性 B 群（尤其 B1）排出</p>
          <p className="text-amber-700">最早 11:15 飲用（09:15 + 2hr = 11:15）</p>
        </div>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">⚠️ 綠茶日 L-Theanine 微調</p>
          <p className="text-blue-700">若 13:00 飲用綠茶 2-3 杯（天然 L-Theanine ~20-30mg/杯，合計 40-90mg）</p>
          <p className="text-blue-700">當日 L-Theanine 補劑可減半（100mg）或跳過，避免總量過高導致過度放鬆</p>
        </div>
        <p className="text-red-600 font-medium">15:00 前為咖啡因截止時間（保護睡眠品質）</p>
      </Detail>
    );
  }

  if (title.includes('10:00') && title.includes('運動')) {
    return (
      <Detail>
        <Label>訓練計畫</Label>
        <p>週一：上半身 A（推 + 垂直拉）</p>
        <p>週二：下半身 A（深蹲 + 腿後側）</p>
        <p>週三：VO2 Max 間歇（4 分鐘 × 4-6 組）</p>
        <p>週四：上半身 B（推 + 水平拉）</p>
        <p>週五：下半身 B（硬舉 + 腿前側）</p>
        <p>週六/日：Zone 2 有氧 45-60 分鐘</p>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 冷水浴統一規定</p>
          <p className="text-red-700 font-bold">重訓日（一二四五）及 VO2 Max 日（三）嚴格禁止</p>
          <p className="text-red-700">冷水浴會抑制肌肥大信號（mTOR、IGF-1）+ 線粒體適應</p>
          <p className="text-emerald-600 font-semibold">✓ 僅週六/日（Zone 2 日）早晨 07:00-08:00 可執行</p>
          <p className="text-emerald-600">與 Zone 2 運動間隔 4hr 以上（例：07:00 冷水浴 → 11:00 Zone 2）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('午餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>午餐 + 訓練後補充品</Label>
        <p>蛋白質 35-40g（正餐食物，單餐 ≤40g 避免 BUN 飆升與腸道產氣）+ 肌酸 5g（CGN Creatine Monohydrate，iHerb）+ 十字花科蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）</p>
        <div className="space-y-0.5">
          <p>脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g（確保脂溶性維生素充分吸收）</p>
          <p>魚油 3 顆（2100mg EPA+DHA）</p>
          <p>維他命 D3 1000 IU（<span className="text-emerald-600 font-bold">1 顆，已改 1000IU 規格免切</span>，補鈣日維持攝取）<span className="text-amber-600 font-medium">⟵ 每日服用；血檢達標+晨光曝曬→可進一步減量</span></p>
          <p>K2（僅取 K2 引導鈣至骨骼，不額外疊加 D3 避免攝取過量）</p>
          <p>葉黃素 20mg</p>
          <p>膠原蛋白肽 10-15g（已含 Vit C ~160mg，晚餐再補 500mg = 每日 ~660mg。<span className="text-red-600 font-bold">🔴 補鈣日移至 18:00 服用</span>，與 14:00 鈣片間隔 4hr+）</p>
          <p>CoQ10 Ubiquinol 200mg（脂溶性，與魚油同服，軟膠囊無法拆分故統一 200mg）</p>
          <p className="text-gray-400">※ B群在 09:15 訓練前營養餐隨餐服用（非午餐）</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 若當日需補鈣：14:00 服用（午餐後 2hr）</p>
          <p className="text-red-700 font-bold">🔴 補鈣日膠原蛋白移至 18:00+：與 14:00 鈣片間隔 4hr+（VitC + 鈣 + 草酸 = 結石黃金三角）</p>
          <p className="text-amber-700">時間軸：14:00 鈣片 → 16:00 銅 → 18:00 膠原蛋白 → 19:00 晚餐最後一口鋅</p>
          <p className="text-red-700">🚫 補鈣日全天禁中高草酸蔬菜（菠菜、甜菜、羽衣甘藍、芥菜、青花菜），改用櫛瓜、大白菜、高麗菜、小白菜</p>
          <p className="text-amber-700 font-medium">⚠️ 飲食鈣優先：若當日已攝取希臘優格 300g（~300mg）+ 豆腐/蔬菜 → 可不補鈣片</p>
          <p className="text-amber-700">⚠️ 若必須補鈣：午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐），高劑量鈣 500mg 抑制非血基質鐵鋅吸收</p>
          <p className="text-emerald-700 font-medium">✅ 補鈣當日維持 D3 1000IU：總計 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
          <p className="text-amber-700">🚫 補鈣日午餐避免大量菠菜、甜菜（草酸與鈣結合 → 結石 + 降低吸收）</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">蛋白質目標：1.5-1.7g/kg（MPS 最大化 + 腎負荷平衡）</p>
          <p>午晚餐各 35-40g（單餐 ≤40g）、每日 4-5 餐均勻分配</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">每日脂肪目標：80-90g（22-25% 總熱量）</p>
          <p>午餐：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g</p>
          <p>晚餐：橄欖油 2 大匙（28g）</p>
          <p className="text-gray-500">加上魚油、蛋、肉類烹調脂肪，每日輕鬆達 80-90g</p>
        </div>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-orange-800">腸胃負荷管理</p>
          <p className="text-orange-700">十字花科蔬菜（花椰菜、西蘭花）若有脹氣或消化變慢 → 立刻替換為菠菜、櫛瓜等低 FODMAP 蔬菜，並將當餐蛋白質微調降至 30g</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('銅') && title.includes('2mg')) {
    return (
      <Detail>
        <Label>銅 2mg — 隨小點心服用（非嚴格空腹）</Label>
        <p className="font-semibold">下午 16:00 隨低鈣/低鐵小點心服用（少量水果、幾片餅乾）</p>
        <p>避免空腹服用引發噁心嘔吐（銅離子空腹刺激性高）</p>
        <p>不與鋅、鈣、鐵等礦物質補劑同服，避開午餐的魚油/D3/鈣鎂競爭</p>
        <p>14:00 鈣 → 16:00 銅（間隔 2hr）→ 18:00 膠原蛋白（補鈣日，與鈣間隔 4hr+）→ 19:00 晚餐最後一口鋅</p>
        <p className="text-amber-600 font-medium">⚠️ 牛肉日免補銅：牛肉 + 堅果已提供足夠銅，當日取消銅補劑避免逼近 UL 10mg/日</p>
        <Tip>遵從性優先：不再堅持「嚴格空腹」，搭配少量低鈣/低鐵食物可大幅改善遵從性且仍保有良好吸收率</Tip>
      </Detail>
    );
  }

  if (title.includes('晚餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>晚餐營養策略</Label>
        <p>蛋白質 35-40g（單餐 ≤40g 避免 BUN 飆升與腸道產氣）</p>
        <p className="text-gray-500">進食順序：蔬菜 → 蛋白質/脂肪 → 碳水（降低血糖波動）</p>
        <div className="space-y-0.5">
          <p>維他命 C 500mg（<span className="text-emerald-600 font-bold">1 錠，已改 500mg 規格免切</span>，<span className="text-red-600 font-bold">🔴 補鈣日全天停用</span>）— 補鈣日僅保留 18:00 膠原蛋白食物來源 160mg，不額外補充合成 VitC</p>
          <p className="text-amber-600 font-medium">鋅 15mg 在晚餐「最後一口」吞服（非隨餐混吃，最大化與 16:00 銅的時間距離）</p>
        </div>
        <p className="text-gray-500">晚餐蔬菜預設菠菜、櫛瓜等低 FODMAP（十字花科留給午餐，減少每日兩餐脹氣風險）</p>
        <Tip>橄欖油 2 大匙（28g）入菜或涼拌。脂溶性維他命皆在午餐服用，晚餐脂肪支持整體每日 80-90g 目標</Tip>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 牛肉日特別注意</p>
          <p className="text-amber-700 font-bold">草飼牛肉 150-180g ≈ 30-36g 蛋白，嚴格零蛋（36g + 1蛋 6.3g = 42.3g 超過 40g 上限）</p>
          <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150-180g，當晚無需額外補鋅</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🔴 補鈣日 VitC 統一策略</p>
          <p className="text-red-700 font-bold">補鈣日全天停用合成 VitC 補劑（晚餐 500mg 停服）</p>
          <p className="text-red-700">僅保留 18:00 膠原蛋白食物來源 160mg（與 14:00 鈣片間隔 4hr+）</p>
          <p className="text-red-700">高劑量 VitC + 鈣 + 草酸 = 結石黃金三角，三者不可同餐</p>
          <p className="text-red-700 font-bold">🚫 補鈣日全天禁中高草酸蔬菜（菠菜、甜菜、羽衣甘藍、芥菜、青花菜），改用櫛瓜、大白菜、高麗菜、小白菜</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 鋅鈣競爭：晚餐嚴禁優格</p>
          <p className="text-amber-700">希臘優格鈣 200-300mg 會抑制鋅 15mg 吸收，必須間隔 2hr+</p>
          <p className="text-amber-700">優格安排在午餐或 15:30 點心（15:30 → 19:00 鋅 = 3.5hr 間隔 ✓）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 重訓日（一二四五）晚餐零葉菜 + 零抗性澱粉</p>
          <p className="text-red-700">高碳水日嚴格執行：僅保留新鮮熱白米飯/去皮馬鈴薯/義大利麵</p>
          <p className="text-emerald-700 font-medium">✅ 保留少量煮熟去皮櫛瓜 50-100g（微量纖維緩衝血糖波動，不產氣）</p>
          <p className="text-red-700 font-bold">禁止冷卻米飯/地瓜：抗性澱粉在腸道後段發酵產氣比葉菜纖維更強</p>
          <p className="text-red-700">纖維 + 抗性澱粉 + 睡前甘胺酸鎂（高滲透壓）三重疊加 → 夜間滲透性腹脹干擾睡眠</p>
          <p className="text-emerald-700">抗性澱粉保留在午餐（冷卻再加熱米飯），晚餐以新鮮熱食為主</p>
        </div>
        <p>最後正餐在睡前 2-3 小時完成（⚠️ 優格須在 17:00 前食用，與 19:00 鋅間隔 2hr+）</p>
        <Tip>社交聚餐時允許打破 19:00 限制，零罪惡感享受當下（人際關係品質對壽命影響 &gt; 飲食與運動）</Tip>
      </Detail>
    );
  }

  if (title.includes('藍光管理')) {
    return (
      <Detail>
        <Label>藍光管理 & 數位衛生</Label>
        <div className="bg-indigo-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="text-indigo-700">白天：娛樂螢幕 &lt;2hr、社群 &lt;30min、專注時段手機勿擾</p>
          <p className="text-indigo-700">22:00 調暗燈光或戴防藍光眼鏡（琥珀色鏡片）</p>
          <p className="text-indigo-700">室溫 18-19°C · 全遮光窗簾 · 遮蓋 LED 指示燈</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('下午點心') || title.includes('15:30')) {
    return (
      <Detail>
        <Label>15:30 下午點心</Label>
        <p>Tryall 豌豆蛋白 ~20g 粉（≈16g 蛋白）— 台灣品牌，非乳製植物蛋白，中速消化</p>
        <p>下午點心時段服用，分散蛋白質攝取壓力。與 Tryall 乳清同品牌，品質一致</p>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">為何從 20:00 移至 15:30？</p>
          <p className="text-amber-700">避免 19:00 晚餐 45-50g + 20:00 再補 16g = 1.5hr 內超過 60g 蛋白質</p>
          <p className="text-amber-700">單次消化壓力過大，可能造成腹脹、消化不良</p>
        </div>
        <Tip>無調味可搭配少量蜂蜜或可可粉調味。Tryall 官網或 Costco 線上可訂</Tip>
      </Detail>
    );
  }

  if (title.includes('22:00') && title.includes('睡前') || title.includes('睡前補充品')) {
    return (
      <Detail>
        <Label>22:30 睡前補充品（洗完熱水澡後）</Label>
        <p>⏰ 嚴格 22:30 後服用（洗完熱水澡後），確保與 19:00 晚餐蛋白質間隔 3.5hr+（甘胺酸與蛋白質共用氨基酸載體，間隔不足會降低甘胺酸降溫效果），同時為腎臟保留排尿緩衝時間</p>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">⚠️ 甘胺酸 vs 熱水澡：必須先洗澡再服用</p>
          <p className="text-red-700">熱水澡短暫升高核心體溫，甘胺酸降低核心體溫 → 兩者同時進行會互相抵消</p>
          <p className="text-red-700">正確流程：21:30-22:15 洗澡 → 22:30 服用甘胺酸 → 散熱 60-90min → 00:00 入睡</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">補充品堆疊</p>
          <p>甘胺酸 3g — 降低核心體溫、促進深層睡眠</p>
          <p>蘇糖酸鎂 — 唯一可穿越血腦屏障的鎂型態，改善認知與睡眠</p>
          <p>甘胺酸鎂 100mg — 肌肉放鬆、GABA 受體調節（減半避免總鎂過高致腹瀉）</p>
          <p>Ashwagandha 450mg — 降低皮質醇（<span className="text-red-600 font-bold">嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日</span>）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 血清素藥物禁忌</p>
          <p className="text-red-700 font-semibold">若正在服用抗憂鬱劑（SSRIs/SNRIs）或任何影響血清素的藥物 → 必須立即停用 Ashwagandha</p>
          <p className="text-red-700">可能誘發血清素綜合徵（Serotonin Syndrome），症狀包括高熱、肌肉僵硬、意識混亂</p>
        </div>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-orange-800">📋 每日情緒自評（Ashwagandha 服用期間）</p>
          <p className="text-orange-700">□ 今天是否對平常喜歡的事物失去興趣？</p>
          <p className="text-orange-700">□ 是否感到情緒平淡/麻木？</p>
          <p className="text-orange-700">□ 早晨是否異常無力起床？</p>
          <p className="text-orange-700 font-bold">→ 任一「是」連續 2 天 → 立即停用 Ashwagandha（不可因 8 週未滿而繼續服用）</p>
          <p className="text-orange-600 text-[10px]">情緒冷漠為「強制停用」信號，藥源性情緒阻斷具隱蔽性，僅靠第 4/12 週抽血不足以應對</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-red-800">⚠️ Ashwagandha 監測 — 第 6 週起密切觀察</p>
          <p className="text-red-700">若 ALT/AST 異常 → 首位停用 Ashwagandha（偶有肝損傷案例）</p>
          <p className="text-red-700 font-semibold">肝功能追蹤：新品牌開始後第 4 週、第 12 週各追蹤 ALT/AST（藥源性肝損傷多發於數週內）</p>
          <p className="text-red-700">若隔日晨間感到異常昏沉 → 優先暫停甘胺酸鎂或減量</p>
        </div>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">停用期 4 週替代方案</p>
          <p className="text-blue-700">甘胺酸鎂 + Cyclic Sighing 呼吸法維持睡眠品質</p>
          <p className="text-blue-700">其餘睡前補充品（甘胺酸 3g、蘇糖酸鎂）照常服用</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('Ashwagandha') && title.includes('週期')) {
    return (
      <Detail>
        <Label>Ashwagandha 週期管理</Label>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">📋 8 週用 / 4 週停 週期</p>
          <p>第 1-5 週：正常服用 450mg/日（睡前）</p>
          <p>第 6 週起：每日自評情緒冷漠、早晨無力起床</p>
          <p>第 8 週（第 56 天）：準時進入停用期</p>
          <p>停用 4 週（28 天）：甘胺酸鎂 + Cyclic Sighing 替代</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 禁忌與停用觸發</p>
          <p className="text-red-700">服用 SSRIs/SNRIs 或血清素藥物 → 禁用（血清素綜合徵風險）</p>
          <p className="text-red-700 font-semibold">🚫 甲狀腺即時停用：若 TSH/Free T4 異常 → 立即停用並就醫（可能提升 T4，甲狀腺風暴風險）</p>
          <p className="text-red-700 font-bold">⚠️ 情緒冷漠為「強制停用」信號：即使未滿 8 週也必須立即停用，不可因週期未滿而繼續服用</p>
          <p className="text-red-700">ALT/AST 異常 → 首位停用本品（肝損傷風險）</p>
          <p className="text-red-700 font-semibold">感冒/發燒/任何急性感染 → 立即暫停，康復後再恢復</p>
        </div>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-orange-800">⚠️ 肝功能追蹤（勿枯等半年健檢）</p>
          <p className="text-orange-700">開始服用新品牌 Ashwagandha 後第 4 週及第 12 週各追蹤 ALT/AST</p>
          <p className="text-orange-700">藥源性肝損傷多發於服用後數週內，早期發現可避免惡化</p>
        </div>
        <Tip>在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。每半年健檢確認肝功能 + 甲狀腺指標（TSH、Free T4）</Tip>
      </Detail>
    );
  }

  if (title.includes('肝功能追蹤') && title.includes('第4/12週')) {
    return (
      <Detail>
        <Label>Ashwagandha 肝功能追蹤（第4/12週）</Label>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-semibold text-red-800">⚠️ 開始服用新品牌 Ashwagandha 後，務必追蹤肝功能</p>
          <p className="text-red-700 font-bold">第 4 週 + 第 12 週各安排一次 ALT/AST 抽血</p>
          <p className="text-red-700">藥源性肝損傷（DILI）多發於服用後數週內，早期發現可避免惡化</p>
        </div>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-blue-800">📋 追蹤方式</p>
          <p className="text-blue-700">自費抽血（家醫科/健檢中心，約 NT$200-400）</p>
          <p className="text-blue-700">僅需檢測 ALT + AST 兩項</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 異常處理</p>
          <p className="text-amber-700">若 ALT &gt;56 U/L 或 AST &gt;40 U/L → 立即停用 Ashwagandha</p>
          <p className="text-amber-700">停用 2 週後複檢確認回落</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 兩次追蹤均正常</p>
          <p className="text-emerald-700">後續回歸每半年健檢即可</p>
        </div>
        <Tip>在瓶身標記「第 4 週抽血日」與「第 12 週抽血日」</Tip>
      </Detail>
    );
  }

  if (title.includes('準時入睡')) {
    return (
      <Detail>
        <Label>準時入睡</Label>
        <p>理想就寢時間：00:00 入睡</p>
        <p className="font-medium">固定起床時間 &gt; 固定就寢時間（最核心的晝夜節律原則）</p>
        <p>慢性睡眠不足（&lt;6 小時）與胰島素阻抗、認知衰退、心血管疾病相關</p>
      </Detail>
    );
  }

  if (title.includes('Zone 2') && title.includes('有氧')) {
    const { zone2Low, zone2High } = getHeartRateZones();
    return (
      <Detail>
        <Label>Zone 2 有氧（週六、週日）</Label>
        <p>時間：45-60 分鐘持續運動</p>
        <p>心率：最大心率 60-70%（約 <strong>{zone2Low}-{zone2High} bpm</strong>）</p>
        <p>方式：固定式腳踏車、飛輪或划船機（避免跑步以減少對肌肥大的干擾）</p>
        <p>強度：可以說話但無法唱歌，鼻呼吸為佳</p>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-emerald-800">Zone 2 日補水策略</p>
          <p className="text-emerald-700">09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration）</p>
          <p className="text-emerald-700">訓練中持續飲用電解質水維持水合與電解質平衡</p>
        </div>
        <Tip>Zone 2 安排在非重訓日，避免與肌力訓練競爭恢復資源。週三改為 VO2 Max，避免高強度與長時間有氧疊加同一天</Tip>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">冷水浴僅限週六/日早晨</p>
          <p className="text-blue-700">07:00-08:00 執行冷水浴，與 Zone 2 運動間隔 4hr+</p>
          <p className="text-blue-700">例：07:00 冷水浴（10 分鐘）→ 11:00 Zone 2 有氧（45-60 分鐘）</p>
          <p className="text-blue-700">Zone 2 為低強度有氧，冷水浴對其影響較小（非肌肥大目標）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('肌力訓練')) {
    return (
      <Detail>
        <Label>四天課表（Upper/Lower Split）</Label>
        <div className="space-y-1 text-xs text-gray-700">
          {[
            { day: '週一', content: 'Upper A（力量）', tag: '力量', color: 'green' as const },
            { day: '週二', content: 'Lower A（力量）', tag: '力量', color: 'green' as const },
            { day: '週四', content: 'Upper B（肌肥大）', tag: '肌肥大', color: 'blue' as const },
            { day: '週五', content: 'Lower B（肌肥大）', tag: '肌肥大', color: 'blue' as const },
          ].map(({ day, content, tag, color }) => (
            <div key={day} className="flex items-center gap-2 py-1 border-b border-gray-50 last:border-0">
              <span className="font-semibold text-gray-900 w-10">{day}</span>
              <span className="flex-1">{content}</span>
              <Tag color={color}>{tag}</Tag>
            </div>
          ))}
        </div>

        <div className="space-y-3 mt-3">
          <ExerciseTable
            title="Upper A — 週一（力量）~65 分鐘"
            exercises={[
              { name: '槓鈴臥推 Bench Press', sets: '4×5-8', rest: '3-4 min' },
              { name: '槓鈴划船 Bent-Over Row', sets: '4×6-8', rest: '3 min' },
              { name: '肩推 Overhead Press', sets: '3×6-10', rest: '2-3 min' },
              { name: '負重引體向上 Weighted Chin-Up', sets: '3×6-10', rest: '2-3 min' },
              { name: '斜板彎舉 Incline DB Curl', sets: '3×8-12', rest: '90 sec' },
              { name: '過頭三頭伸展 Overhead Tricep Extension', sets: '3×10-12', rest: '90 sec' },
              { name: '面拉 Face Pull', sets: '3×15-20', rest: '60 sec' },
            ]}
          />
          <ExerciseTable
            title="Lower A — 週二（力量）~60 分鐘"
            exercises={[
              { name: '槓鈴深蹲 Back Squat', sets: '4×5-8', rest: '3-4 min' },
              { name: '羅馬尼亞硬舉 Romanian Deadlift', sets: '3×8-10', rest: '2-3 min' },
              { name: '保加利亞分腿蹲 Bulgarian Split Squat', sets: '3×8-12', rest: '90 sec' },
              { name: '坐姿腿彎舉 Seated Leg Curl', sets: '3×10-12', rest: '90 sec' },
              { name: '站姿小腿推舉 Standing Calf Raise', sets: '4×10-15', rest: '60 sec' },
            ]}
          />
          <ExerciseTable
            title="Upper B — 週四（肌肥大）~65 分鐘"
            exercises={[
              { name: '上斜啞鈴臥推 Incline DB Press', sets: '3×8-12', rest: '2-3 min' },
              { name: '纜繩飛鳥 Cable Fly', sets: '3×12-15', rest: '90 sec' },
              { name: '胸靠划船 Chest-Supported Row', sets: '4×8-12', rest: '2 min' },
              { name: '滑輪下拉 Lat Pulldown', sets: '3×10-12', rest: '2 min' },
              { name: '側平舉 Lateral Raise', sets: '4×12-15', rest: '60 sec' },
              { name: '槓鈴彎舉 Barbell Curl', sets: '3×8-12', rest: '90 sec' },
              { name: '纜繩下壓 Cable Pushdown', sets: '3×10-15', rest: '90 sec' },
            ]}
          />
          <ExerciseTable
            title="Lower B — 週五（肌肥大）~60 分鐘"
            exercises={[
              { name: '腿推 Leg Press', sets: '4×8-12', rest: '2-3 min' },
              { name: '槓鈴臀推 Barbell Hip Thrust', sets: '3×8-12', rest: '2 min' },
              { name: '走路弓步 Walking Lunge', sets: '3×10-12', rest: '90 sec' },
              { name: '俯臥腿彎舉 Lying Leg Curl', sets: '3×10-12', rest: '90 sec' },
              { name: '坐姿小腿推舉 Seated Calf Raise', sets: '4×12-15', rest: '60 sec' },
            ]}
          />
        </div>

        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-1 mt-2">
          <p className="font-medium text-gray-800">漸進式超負荷（雙重遞增法）</p>
          <p>以處方次數下限開始 → 每次多做 1-2 次 → 所有組數完成上限次數時加重量</p>
          <p>上肢 +2.5kg / 下肢 +5kg / 隔離動作 +1-2.5kg</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">RPE 週期（每 6 週 Deload）</p>
          <p>第 1 週 RPE 7 → 第 2 週 7.5-8 → 第 3 週 8-8.5 → 第 4 週 8.5-9 → 第 5 週 9-9.5 → 第 6 週 Deload</p>
          <p>減量週：訓練量 50%、RPE 5-6、Zone 2 縮短至 30 分鐘、跳過 VO2 Max</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">週計劃總覽</p>
          <p>週一 Upper A · 週二 Lower A · 週三 VO2 Max · 週四 Upper B · 週五 Lower B · 週六 Zone 2 · 週日 Zone 2</p>
          <p className="text-gray-500">每週：肌力 4 次 · Zone 2 有氧 2 次 · VO2 Max 1 次</p>
        </div>
      </Detail>
    );
  }

  // === All-day items ===

  if (title.includes('蛋白質') && (title.includes('113') || title.includes('146'))) {
    return (
      <Detail>
        <p>訓練前乳清 27g + 午餐 35-40g + 下午豌豆 16g + 晚餐 35-40g ≈ 113-123g</p>
        <p>每餐達亮氨酸門檻 2.5-3g，單餐 ≤40g 避免 BUN 飆升與腸道產氣</p>
        <p>每日 4-5 餐均勻分配，總計約 1.5-1.7g/kg（健康腎功能範圍）</p>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🔴 eGFR 檢測流程</p>
          <p className="text-red-700 font-bold">1. 抽血前必須先停用肌酸 7 天 + 暫停高強度重訓 48-72hr（肌肉修復也會升高 Creatinine）</p>
          <p className="text-red-700 font-bold">2. 取得真實 eGFR → 若仍 &lt;90 才啟動下修蛋白質</p>
          <p className="text-red-700">→ 下修至 1.6g/kg（≈ 117g/day），每餐 ≤35g，永久停止肌酸</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 牛肉日單餐蛋白質控制</p>
          <p className="text-amber-700 font-bold">草飼牛肉 150-180g ≈ 30-36g 蛋白，嚴格零蛋（36g + 1蛋 6.3g = 42.3g 超標）</p>
          <p className="text-amber-700">確保單餐 ≤40g，避免腎臟短時間代謝壓力</p>
        </div>
        <p className="text-emerald-600">牛肉日額外提供血基質鐵、B12、天然肌酸</p>
      </Detail>
    );
  }

  if (title.includes('膳食纖維')) {
    return (
      <Detail>
        <p>洋蔥、大蒜、燕麥、酪梨、冷卻米飯/地瓜（抗性澱粉）</p>
        <p>搭配發酵食物（優格、泡菜）增強腸道多樣性</p>
      </Detail>
    );
  }

  if (title.includes('站立') && title.includes('坐姿')) {
    return (
      <Detail>
        <p>維持脂蛋白脂肪酶 LPL 活性，避免久坐代謝下降</p>
      </Detail>
    );
  }

  if (title.includes('碳水循環')) {
    return (
      <Detail>
        <p>重訓日 5-6g/kg（360-430g）· 有氧日 3-4g/kg（215-290g）</p>
        <p>重訓日熱量目標 3,100-3,400 kcal</p>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-blue-800">📋 重訓日碳水分配範例（目標 ~400g）</p>
          <p className="text-blue-700">訓練前：地瓜 200g ≈ 50g 碳水</p>
          <p className="text-blue-700">午餐：白米飯 300g（乾重 120g）≈ 90g + 冷卻米飯 150g ≈ 45g = 135g</p>
          <p className="text-blue-700">下午點心：香蕉 1 根 ≈ 27g</p>
          <p className="text-blue-700">晚餐：義大利麵 120g（乾重）≈ 90g + 白米飯 200g ≈ 60g = 150g + 去皮櫛瓜 50-100g</p>
          <p className="text-blue-700">零食加餐：燕麥 40g ≈ 28g</p>
          <p className="text-blue-800 font-medium">合計 ≈ 390g ✓</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 高碳水日嚴格執行低纖維替換</p>
          <p className="text-amber-700">30-40% 碳水必須替換為低纖維來源：白米飯、義大利麵、去皮馬鈴薯</p>
          <p className="text-amber-700">目的：控制總纖維量（&lt;45g），減輕腸胃負擔</p>
        </div>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-orange-800">脹氣優先監控</p>
          <p className="text-orange-700">若出現腹脹 → 當餐立即減少十字花科蔬菜份量</p>
          <p className="text-orange-700">增加低纖維碳水佔比（白米 &gt; 地瓜，義大利麵 &gt; 燕麥）</p>
          <p className="text-orange-700">連續 2 天脹氣 → 暫停十字花科 3 天，改全低 FODMAP 蔬菜</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('鈣攝取') || title.includes('鈣') && title.includes('1000')) {
    return (
      <Detail>
        <Label>每日鈣攝取確認（目標 1000mg）</Label>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">主要鈣來源（食物優先）</p>
          <p>希臘優格 200-300g — ~200-300mg</p>
          <p>深綠蔬菜（菠菜、花椰菜）— ~100-150mg</p>
          <p>豆腐（板豆腐）100g — ~150mg</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 飲食鈣優先原則</p>
          <p className="text-emerald-700">若已攝取希臘優格 300g（~300mg）+ 豆腐/蔬菜（~200mg）≥ 500mg → 可不補鈣片</p>
          <p className="text-emerald-700">避免不必要的高劑量鈣抑制午餐鐵鋅吸收</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 確認需補鈣時：14:00 服用（午餐後 2hr）</p>
          <p className="text-amber-700">鈣片 500mg 於 14:00 服用，與午餐脂溶性維生素間隔 2hr</p>
          <p className="text-red-700 font-bold">🔴 補鈣日膠原蛋白移至 18:00+：與鈣片間隔 4hr+</p>
          <p className="text-amber-700">時間軸：14:00 鈣 → 16:00 銅 → 18:00 膠原蛋白 → 19:00 鋅（最後一口）</p>
          <p className="text-amber-700 font-medium">⚠️ 補鈣日午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐），避免紅肉/蛋</p>
          <p className="text-amber-700">高劑量鈣 500mg 明顯抑制非血基質鐵及鋅吸收</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 補鈣當日維持 D3 1000IU</p>
          <p className="text-emerald-700">總攝取 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
          <p className="text-emerald-700">25(OH)D 為長期蓄積指標，單日波動不影響血清濃度</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 草酸警示（補鈣日特別注意）</p>
          <p className="text-red-700 font-bold">補鈣日全天禁止中高草酸蔬菜（含青花菜）</p>
          <p className="text-red-700">菠菜、甜菜、羽衣甘藍、芥菜、青花菜均禁（青花菜仍含中等草酸）</p>
          <p className="text-red-700">草酸與鈣結合 → 草酸鈣結石風險 + 降低鈣吸收率</p>
          <p className="text-red-700">改用極低草酸蔬菜：櫛瓜、大白菜、高麗菜、小白菜</p>
          <p className="text-blue-700 font-medium">💧 補鈣日飲水目標 3.5L+（稀釋尿鈣，降低結石風險）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 禁止睡前服用鈣片</p>
          <p className="text-red-700">鈣與鎂競爭 DMT1 載體，同服降低兩者吸收率</p>
          <p className="text-red-700">睡前已服用蘇糖酸鎂 + 甘胺酸鎂，再加鈣片會互相干擾</p>
          <p className="text-red-700">09:05 碘鹽 → 14:00 鈣（間隔 5hr）→ 16:00 銅（牛肉日免補）→ 18:00 膠原蛋白（補鈣日，與鈣間隔 4hr+）→ 19:00 鋅（最後一口）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('飲水')) {
    return (
      <Detail>
        <p>尿液淡黃色為適當水合指標</p>
        <p className="text-amber-600">⚠️ 週六/日 Zone 2 有氧日：09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水</p>
        <p className="text-blue-600 font-medium">💧 補鈣日飲水目標 3.5L+（稀釋尿鈣，降低結石風險）</p>
      </Detail>
    );
  }

  if (title.includes('健康檢測') || title.includes('每半年')) {
    return (
      <Detail>
        <Label>每半年健康檢測 — 必檢指標</Label>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-semibold text-red-800">腎功能（高蛋白飲食 + 肌酸監測）</p>
          <p className="text-red-700 font-bold">🔴 絕對前提：抽血前 7 天停用肌酸 + 48-72hr 暫停高強度重訓</p>
          <p className="text-red-700">肌肉修復本身也會顯著升高 Creatinine，與肌酸偽陽性疊加 → eGFR 被嚴重低估</p>
          <p className="text-red-700">只有停用+休息後的數據才能反映真實腎功能</p>
          <p className="text-red-700">BUN（尿素氮）— 正常 7-20 mg/dL</p>
          <p className="text-red-700">Creatinine（肌酐）— 正常 0.7-1.3 mg/dL</p>
          <p className="text-red-700">eGFR（腎絲球過濾率）— 正常 &gt;90 mL/min</p>
        </div>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-orange-800">肝功能（補劑代謝負荷）</p>
          <p className="text-orange-700">ALT — 正常 7-56 U/L</p>
          <p className="text-orange-700">AST — 正常 10-40 U/L</p>
          <p className="text-orange-700 font-semibold">⚠️ Ashwagandha 肝功能追蹤：新品牌開始後第 4 週、第 12 週各加測 ALT/AST</p>
          <p className="text-orange-700">藥源性肝損傷多發於數週內，勿枯等半年健檢</p>
        </div>
        <div className="bg-purple-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-purple-800">甲狀腺功能（Ashwagandha 可能提升 T4）</p>
          <p className="text-purple-700">TSH — 正常 0.4-4.0 mIU/L</p>
          <p className="text-purple-700">Free T4 — 正常 0.8-1.8 ng/dL</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">其他指標</p>
          <p>維他命 D — 目標 40-60 ng/mL</p>
          <p>鋅銅比 — 目標 10-15:1</p>
          <p>荷爾蒙：睪固酮、SHBG、皮質醇</p>
          <p>代謝：空腹血糖、HbA1c、胰島素</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ ALT/AST 異常時停用順序</p>
          <p className="text-amber-700 font-bold">1. 首位停用：Ashwagandha（偶有肝損傷案例報告）</p>
          <p className="text-amber-700">2. 其次停用：CoQ10、葉黃素</p>
          <p className="text-amber-700">停用後 2 週複檢，確認指標回落</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 Ashwagandha 禁忌</p>
          <p className="text-red-700">若正在服用抗憂鬱劑（SSRIs/SNRIs）或血清素藥物 → 禁用（血清素綜合徵風險）</p>
          <p className="text-red-700">甲亢或服用甲狀腺藥物者 → 禁用（可能提升 T4，甲狀腺風暴風險）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">⚠️ 若停用肌酸後 eGFR 仍 &lt;90（確認為真實腎功能下降）</p>
          <p className="text-red-700">立即下修蛋白質至 1.6g/kg（≈ 117g/day），每餐 ≤35g</p>
          <p className="text-red-700">永久停止肌酸補充（減少腎臟代謝負擔）</p>
          <p className="text-red-700">增加飲水、降低鈉攝取、密切監測 BUN/Creatinine</p>
          <p className="text-red-700 font-semibold">必須先停用肌酸 7 天 + 暫停重訓 48-72hr → 取得真實 eGFR → 才啟動下修蛋白質</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('VO2 Max')) {
    const { vo2Low, vo2High } = getHeartRateZones();
    return (
      <Detail>
        <Label>VO2 Max 訓練（週三）</Label>
        <p>方式：Peter Attia 4×4 法 — 4 分鐘全力 + 4 分鐘恢復，重複 4 組</p>
        <p>心率：最大心率 90-95%（約 <strong>{vo2Low}-{vo2High} bpm</strong>）</p>
        <p>器材：衝刺飛輪、划船機或上坡跑</p>
        <p>總時間：含暖身和收操約 45 分鐘</p>
        <Tip>安排在週三（非重訓日），與週六日 Zone 2 分開，避免中樞神經疲勞與恢復不良</Tip>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 VO2 Max 日禁止冷水浴</p>
          <p className="text-red-700">高強度間歇訓練後冷水浴會抑制線粒體適應信號，降低 VO2 Max 訓練效果</p>
          <p className="text-red-700">比照重訓日嚴格禁止</p>
        </div>
      </Detail>
    );
  }

  return null;
}
