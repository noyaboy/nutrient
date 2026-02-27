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
        <p>地瓜（推薦）或香蕉+堅果醬 1 茶匙 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（活化型態 Coenzyme B-Complex：甲鈷胺 B12 + 5-MTHF 葉酸 + P5P B6，水溶性需隨餐）</p>
        <p>500ml 室溫水 + 少許碘鹽 + 檸檬汁（補水）</p>
        <p className="text-amber-600">⚠️ 確認碘鹽為「加碘」版本（統一生機日曬海鹽加碘，包裝標示「碘化鉀」）</p>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">⚠️ B群需隨餐服用</p>
          <p className="text-amber-700">水溶性維生素需食物基質減緩胃排空以提升吸收</p>
          <p className="text-amber-700">推薦：地瓜（前晚蒸好冷藏產生抗性澱粉 RS3）</p>
          <p className="text-amber-700">替代：香蕉 + 堅果醬 1 茶匙（~5g脂肪）</p>
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
        <Label>咖啡因 + L-Theanine</Label>
        <p>起床後 60-90 分鐘再喝（避免干擾皮質醇覺醒反應）</p>
        <p>1:1 比例：咖啡因 200-300mg + L-Theanine 200mg（iHerb NOW Foods），A 級 nootropic 組合，消除焦慮、增強專注</p>
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
          <p>維他命 D3 1000 IU（半顆，補鈣日維持攝取）<span className="text-amber-600 font-medium">⟵ 每日服用；血檢達標+晨光曝曬→可進一步減量</span></p>
          <p>K2（僅取 K2 引導鈣至骨骼，不額外疊加 D3 避免攝取過量）</p>
          <p>葉黃素 20mg</p>
          <p>膠原蛋白肽 10-15g（已含 Vit C ~160mg，晚餐再補 500mg = 每日 ~660mg）</p>
          <p>CoQ10 Ubiquinol 200mg（脂溶性，與魚油同服，軟膠囊無法拆分故統一 200mg）</p>
          <p className="text-gray-400">※ B群在 09:15 訓練前營養餐隨餐服用（非午餐）</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 若當日需補鈣：午餐後 1hr（13:00）服用</p>
          <p className="text-amber-700">鈣片應於午餐後 1hr（13:00）服用，與脂溶性維生素（魚油/D3/K2/葉黃素）間隔，避免競爭吸收</p>
          <p className="text-emerald-700 font-medium">✅ 補鈣當日維持 D3 1000IU：總計 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
          <p className="text-amber-700">🚫 補鈣日午餐避免大量菠菜（草酸與鈣結合 → 結石 + 降低吸收）</p>
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
        <p>13:00 鈣（午餐後 1hr）→ 16:00 銅（間隔 3hr）→ 19:00 鋅（間隔 3hr），三者充分拉開</p>
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
          <p>維他命 C 500mg（半錠）— 午餐膠原蛋白已含 ~160mg，每日合計 ~660mg 已足夠</p>
          <p className="text-amber-600">鋅 15mg 每日隨晚餐服用（1 錠，與 16:00 銅間隔 3hr+）</p>
        </div>
        <p className="text-gray-500">晚餐蔬菜預設菠菜、櫛瓜等低 FODMAP（十字花科留給午餐，減少每日兩餐脹氣風險）</p>
        <Tip>橄欖油 2 大匙（28g）入菜或涼拌。脂溶性維他命皆在午餐服用，晚餐脂肪支持整體每日 80-90g 目標</Tip>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 牛肉日特別注意</p>
          <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白，務必減蛋（不加蛋或僅加 1 顆），確保單餐 ≤40g</p>
          <p className="text-amber-700">牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150-180g，當晚無需額外補鋅</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 補鈣日晚餐避免菠菜</p>
          <p className="text-red-700">晚餐維他命 C 500mg 增強草酸吸收，與鈣片併用 → 草酸鈣結石風險</p>
          <p className="text-red-700">補鈣日菠菜移至非補鈣日，或選擇其他低草酸蔬菜（櫛瓜、小白菜）</p>
        </div>
        <p>最後正餐在睡前 2-3 小時完成（睡前小份優格不影響）</p>
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
        <Label>22:30 睡前補充品</Label>
        <p>⏰ 嚴格 22:30 後服用，確保與 19:00 晚餐蛋白質間隔 3.5hr+（甘胺酸與蛋白質共用氨基酸載體，間隔不足會降低甘胺酸降溫效果），同時為腎臟保留排尿緩衝時間</p>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">補充品堆疊</p>
          <p>甘胺酸 3g — 降低核心體溫、促進深層睡眠</p>
          <p>蘇糖酸鎂 — 唯一可穿越血腦屏障的鎂型態，改善認知與睡眠</p>
          <p>甘胺酸鎂 100mg — 肌肉放鬆、GABA 受體調節（減半避免總鎂過高致腹瀉）</p>
          <p>Ashwagandha 600mg — 降低皮質醇（<span className="text-red-600 font-bold">嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日</span>）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 血清素藥物禁忌</p>
          <p className="text-red-700 font-semibold">若正在服用抗憂鬱劑（SSRIs/SNRIs）或任何影響血清素的藥物 → 必須立即停用 Ashwagandha</p>
          <p className="text-red-700">可能誘發血清素綜合徵（Serotonin Syndrome），症狀包括高熱、肌肉僵硬、意識混亂</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-red-800">⚠️ Ashwagandha 監測 — 第 6 週起密切觀察</p>
          <p className="text-red-700 font-semibold">第 6 週開始每日自評：是否出現情緒冷漠（Anhedonia）、對平常喜歡的事物失去興趣、早晨無力起床</p>
          <p className="text-red-700">任一症狀出現 → 立即停用，進入 4 週停用期</p>
          <p className="text-red-700">若 ALT/AST 異常 → 首位停用 Ashwagandha（偶有肝損傷案例）</p>
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
          <p>第 1-5 週：正常服用 600mg/日（睡前）</p>
          <p>第 6 週起：每日自評情緒冷漠、早晨無力起床</p>
          <p>第 8 週（第 56 天）：準時進入停用期</p>
          <p>停用 4 週（28 天）：甘胺酸鎂 + Cyclic Sighing 替代</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-red-800">🚫 禁忌與停用觸發</p>
          <p className="text-red-700">服用 SSRIs/SNRIs 或血清素藥物 → 禁用（血清素綜合徵風險）</p>
          <p className="text-red-700 font-semibold">甲亢或正服用甲狀腺藥物 → 禁用（可能提升 T4，甲狀腺風暴風險）</p>
          <p className="text-red-700">情緒冷漠（Anhedonia）→ 立即停用</p>
          <p className="text-red-700">ALT/AST 異常 → 首位停用本品（肝損傷風險）</p>
          <p className="text-red-700 font-semibold">感冒/發燒/任何急性感染 → 立即暫停，康復後再恢復</p>
        </div>
        <Tip>在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。每半年健檢確認肝功能 + 甲狀腺指標（TSH、Free T4）</Tip>
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
          <p className="font-bold text-red-800">🚫 eGFR &lt;90 警示</p>
          <p className="text-red-700">若腎絲球過濾率低於 90 → 立即下修總蛋白至 1.6g/kg（≈ 117g/day）</p>
          <p className="text-red-700">每餐 ≤35g，密切監測 BUN/Creatinine 變化</p>
          <p className="text-red-700">健康檢查結果若 eGFR &lt;90 → 優先調整蛋白質攝取，保護腎功能</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 牛肉日單餐蛋白質控制</p>
          <p className="text-amber-700">草飼牛肉 150-180g ≈ 30-36g 蛋白，務必減蛋（不加蛋或僅加 1 顆）</p>
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
          <p className="text-blue-700">晚餐：義大利麵 120g（乾重）≈ 90g + 白米飯 200g ≈ 60g = 150g</p>
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
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 不足時午餐後 1hr 補鈣（13:00）</p>
          <p className="text-amber-700">若當日飲食鈣攝取明顯不足（&lt;600mg）→ 午餐後 1hr（13:00）補 1 錠鈣片 500mg</p>
          <p className="text-amber-700">與午餐脂溶性維生素（魚油/D3/K2/葉黃素）間隔 1hr+，避免競爭吸收</p>
          <p className="text-amber-700">使用 Nature Made Ca+D3+K2（Costco 備用品）</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 補鈣當日維持 D3 1000IU</p>
          <p className="text-emerald-700">總攝取 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
          <p className="text-emerald-700">25(OH)D 為長期蓄積指標，單日波動不影響血清濃度</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 草酸警示（補鈣日特別注意）</p>
          <p className="text-red-700 font-bold">補鈣日午餐+晚餐都避免大量菠菜</p>
          <p className="text-red-700">午餐膠原蛋白 ~160mg Vit C + 晚餐 500mg Vit C → 維他命 C 增強草酸吸收</p>
          <p className="text-red-700">草酸與鈣結合 → 草酸鈣結石風險 + 降低鈣吸收率</p>
          <p className="text-red-700">菠菜移至非補鈣日食用，或選擇低草酸蔬菜（櫛瓜、小白菜、大白菜）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 禁止睡前服用鈣片</p>
          <p className="text-red-700">鈣與鎂競爭 DMT1 載體，同服降低兩者吸收率</p>
          <p className="text-red-700">睡前已服用蘇糖酸鎂 + 甘胺酸鎂，再加鈣片會互相干擾</p>
          <p className="text-red-700">09:05 碘鹽 → 13:00 鈣（間隔 4hr）→ 16:00 銅 → 19:00 鋅，各間隔 3hr+</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('飲水')) {
    return (
      <Detail>
        <p>尿液淡黃色為適當水合指標</p>
        <p className="text-amber-600">⚠️ 週六/日 Zone 2 有氧日：09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水</p>
      </Detail>
    );
  }

  if (title.includes('健康檢測') || title.includes('每半年')) {
    return (
      <Detail>
        <Label>每半年健康檢測 — 必檢指標</Label>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-semibold text-red-800">腎功能（高蛋白飲食 + 肌酸監測）</p>
          <p className="text-red-700">BUN（尿素氮）— 正常 7-20 mg/dL</p>
          <p className="text-red-700">Creatinine（肌酐）— 正常 0.7-1.3 mg/dL</p>
          <p className="text-red-700">eGFR（腎絲球過濾率）— 正常 &gt;90 mL/min</p>
        </div>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-orange-800">肝功能（補劑代謝負荷）</p>
          <p className="text-orange-700">ALT — 正常 7-56 U/L</p>
          <p className="text-orange-700">AST — 正常 10-40 U/L</p>
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
          <p className="font-bold text-red-800">⚠️ 腎功能異常（eGFR &lt;90）</p>
          <p className="text-red-700">立即下修蛋白質至 1.6g/kg（≈ 117g/day），每餐 ≤35g</p>
          <p className="text-red-700">停止肌酸補充（減少腎臟代謝負擔）</p>
          <p className="text-red-700">增加飲水、降低鈉攝取、密切監測 BUN/Creatinine</p>
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
