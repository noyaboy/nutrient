import React from 'react';
import { AshwagandhaWarnings } from '@/lib/health-warnings/AshwagandhaWarnings';
import { EgfrProtocol } from '@/lib/health-warnings/EgfrProtocol';
import { ColdBathRules } from '@/lib/health-warnings/ColdBathRules';
import { CalciumOxalateEducation } from '@/lib/health-warnings/CalciumOxalateEducation';
import { MineralTimingGuidance } from '@/lib/health-warnings/MineralTimingGuidance';
import { BeefDayAdjustments } from '@/lib/health-warnings/BeefDayAdjustments';

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
          <p className="text-blue-700">09:05 補水：500ml 室溫水 + 碘鹽 1g（食品電子秤測量，~400mg 鈉）+ 檸檬汁</p>
          <p className="text-blue-700">09:15 進食：地瓜/香蕉 + 乳清蛋白 + B群</p>
          <p className="text-blue-700">先喝水再吃固體食物+B群，確保胃中有食物基質時 B群才進入</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">⚠️ 碘攝取策略（RDA 150mcg/日）</p>
          <p className="text-amber-700">晨間碘鹽僅 1g（~20-33mcg 碘），碘攝取主力仰賴食物：</p>
          <p className="text-amber-700">• 午晚餐烹調碘鹽（每餐 1-2g）</p>
          <p className="text-amber-700">• 每週 2-3 次海帶味噌湯 / 涼拌紫菜（3-5g 乾海帶即超過 RDA）</p>
          <p className="text-amber-700">⚠️ 為何不用 3-5g？5g 鹽 / 500ml = 1%（高於生理食鹽水 0.9%），空腹易噁心/腹瀉；且 5g = 2000mg 鈉，加烹調鹽必超 WHO 上限</p>
          <p className="text-amber-700">使用食品電子秤（精度 0.1g）精確測量</p>
        </div>
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
          <p className="font-medium text-blue-800">⚠️ 綠茶日規定</p>
          <p className="text-blue-700">凡飲用綠茶之日，一律停用 L-Theanine 補劑</p>
          <p className="text-blue-700">綠茶 2-3 杯已提供天然 L-Theanine 40-90mg，200mg 膠囊無法精準減半</p>
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
        <ColdBathRules context="exercise" />
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-bold text-amber-800">⚠️ 三溫暖/熱暴露排程</p>
          <p className="text-amber-700 font-semibold">三溫暖必須在重訓「之後」執行，或與重訓間隔 2 小時以上</p>
          <p className="text-amber-700">高溫暴露後立即重訓 → 心率升高 + 血壓波動 + 脫水風險，增加心血管負擔</p>
          <p className="text-amber-700">正確順序：重訓 → 休息/補水 → 三溫暖</p>
          <p className="text-emerald-600">三溫暖本身不抑制 mTOR（與冷水浴不同），時序正確即安全</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('午餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>午餐 + 訓練後補充品</Label>
        <p>蛋白質 35-40g（正餐食物，單餐 ≤40g 避免 BUN 飆升與腸道產氣）+ 肌酸 5g（CGN Creatine Monohydrate，iHerb）+ 蔬菜（建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）</p>
        <div className="space-y-0.5">
          <p>脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g（確保脂溶性維生素充分吸收）</p>
          <p>魚油 3 顆（2100mg EPA+DHA）</p>
          <p>維他命 D3 1000 IU（<span className="text-emerald-600 font-bold">1 顆，已改 1000IU 規格免切</span>）<span className="text-amber-600 font-medium">⟵ 每日服用；血檢達標+晨光曝曬→可進一步減量</span></p>
          <p>K2（僅取 K2 引導鈣至骨骼，不額外疊加 D3 避免攝取過量）</p>
          <p>葉黃素 20mg</p>
          <p>膠原蛋白肽 10-15g（已含 Vit C ~160mg，晚餐再補 500mg = 每日 ~660mg，每日隨午餐服用）</p>
          <p>CoQ10 Ubiquinol 200mg（脂溶性，與魚油同服，軟膠囊無法拆分故統一 200mg）</p>
          <p className="text-gray-400">※ B群在 09:15 訓練前營養餐隨餐服用（非午餐）</p>
        </div>
        <CalciumOxalateEducation />
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 若當日需補鈣：鈣片隨午餐服用</p>
          <p className="text-amber-700">碳酸鈣需充足胃酸解離吸收，空腹服用吸收率極低且易脹氣便秘</p>
          <MineralTimingGuidance minerals={['calcium', 'copper', 'zinc']} />
          <p className="text-amber-700 font-medium">⚠️ 飲食鈣優先：若當日已攝取希臘優格 300g（~300mg）+ 豆腐/蔬菜 → 可不補鈣片</p>
          <p className="text-amber-700">⚠️ 若必須補鈣：午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐），高劑量鈣 500mg 抑制非血基質鐵鋅吸收</p>
          <p className="text-red-600 font-medium">🚫 補鈣日當晚放棄補鋅：鈣殘餘競爭 DMT1 + 睡前鋅與 22:30 甘胺酸鎂（Mg²⁺）僅隔 30 分鐘競爭同一二價陽離子載體。單日不補鋅不影響整體鋅營養狀態</p>
          <p className="text-emerald-700 font-medium">✅ 補鈣當日維持 D3 1000IU：總計 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
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
        <p className="font-semibold">下午 14:00-15:00 隨低鈣/低鐵小點心服用（少量水果、幾片餅乾）</p>
        <p>避免空腹服用引發噁心嘔吐（銅離子空腹刺激性高）</p>
        <p>不與鋅、鈣、鐵等礦物質補劑同服，避開午餐的魚油/D3/鈣鎂競爭</p>
        <p>12:00 午餐（鈣隨餐）→ 14:00-15:00 銅（間隔 2-3hr）→ 19:00 晚餐最後一口鋅（間隔 4-5hr）</p>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 14:00-15:00 小點心嚴格避開含鈣食物</p>
          <p className="text-red-700">優格、牛奶、起司等含鈣食物會顯著抑制銅吸收（鈣銅共用 DMT1 轉運蛋白）</p>
          <p className="text-red-700">正確選擇：少量水果（蘋果/香蕉片）或幾片低鈣餅乾</p>
        </div>
        <BeefDayAdjustments context="copper" />
        <Tip>遵從性優先：不再堅持「嚴格空腹」，搭配少量低鈣/低鐵食物可大幅改善遵從性且仍保有良好吸收率</Tip>
      </Detail>
    );
  }

  if (title.includes('晚餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>晚餐營養策略</Label>
        <p>蛋白質 35-40g（單餐建議 ≤45g，生理上非絕對門檻）</p>
        <p className="text-gray-500">進食順序：蔬菜 → 蛋白質/脂肪 → 碳水（降低血糖波動）</p>
        <div className="space-y-0.5">
          <p>維他命 C 500mg（<span className="text-emerald-600 font-bold">1 錠，已改 500mg 規格免切，每日服用</span>）</p>
          <p className="text-amber-600 font-medium">鋅 15mg 在晚餐「最後一口」吞服（非隨餐混吃，最大化與 14:00-15:00 銅的時間距離 4-5hr）</p>
          <p className="text-red-600 font-medium">🚫 補鈣日當晚放棄補鋅：鈣殘餘競爭 DMT1 + 若改睡前 22:00 與 22:30 甘胺酸鎂（Mg²⁺）僅隔 30 分鐘競爭二價陽離子載體 → 兩者皆降。單日不補鋅不影響整體鋅營養狀態</p>
        </div>
        <p className="text-gray-500">晚餐蔬菜選低植酸品種：櫛瓜、大白菜、高麗菜、小白菜（菠菜安排在午餐，有鈣質保護且不影響鋅）</p>
        <Tip>橄欖油 2 大匙（28g）入菜或涼拌。脂溶性維他命皆在午餐服用，晚餐脂肪支持整體每日 80-90g 目標</Tip>
        <BeefDayAdjustments context="egg" />
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 鋅吸收注意：晚餐避免高植酸食物</p>
          <p className="text-amber-700">菠菜、豆類等高植酸食物的植酸+草酸強力螯合游離鋅離子，大幅削弱 15mg 鋅吸收率</p>
          <p className="text-amber-700">晚餐蔬菜優先：櫛瓜、大白菜、高麗菜、小白菜（低植酸）</p>
          <p className="text-amber-700">菠菜安排在午餐（有鈣質保護 + 不影響鋅吸收）</p>
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
        <AshwagandhaWarnings variant="sleep" />
      </Detail>
    );
  }

  if (title.includes('Ashwagandha') && title.includes('週期')) {
    return (
      <Detail>
        <Label>Ashwagandha 週期管理</Label>
        <AshwagandhaWarnings variant="cycle" />
        <Tip>在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。每半年健檢確認肝功能 + 甲狀腺指標（TSH、Free T4）</Tip>
      </Detail>
    );
  }

  if (title.includes('肝功能追蹤') && title.includes('第4/12週')) {
    return (
      <Detail>
        <Label>Ashwagandha 肝功能追蹤（第4/12週）</Label>
        <AshwagandhaWarnings variant="liver-tracking" />
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
        <ColdBathRules context="zone2" />
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
        <p>每餐達亮氨酸門檻 2.5-3g，單餐建議 ≤45g（生理上非絕對門檻）</p>
        <p>每日 4-5 餐均勻分配，總計約 1.5-1.7g/kg（健康腎功能範圍）</p>
        <EgfrProtocol context="protein-section" />
        <BeefDayAdjustments context="protein" />
        <p className="text-emerald-600">牛肉日額外提供血基質鐵、B12、天然肌酸</p>
      </Detail>
    );
  }

  if (title.includes('膳食纖維')) {
    return (
      <Detail>
        <p>洋蔥、大蒜、燕麥、酪梨、冷卻米飯/地瓜（抗性澱粉）</p>
        <p>搭配發酵食物（優格、泡菜）增強腸道多樣性</p>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">菠菜安排策略</p>
          <p className="text-blue-700">菠菜在午餐食用（有鈣質食物保護：鈣+草酸在腸道結合排出）</p>
          <p className="text-blue-700">晚餐避免菠菜（植酸螯合鋅離子，削弱 19:00 鋅吸收）</p>
          <p className="text-blue-700">晚餐選低植酸蔬菜：櫛瓜、大白菜、高麗菜、小白菜</p>
        </div>
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
          <p className="text-blue-700">晚餐：義大利麵 120g（乾重）≈ 90g + 白米飯 200g ≈ 60g = 150g + 去皮櫛瓜/大白菜/高麗菜 50-100g</p>
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
        <CalciumOxalateEducation />
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 確認需補鈣時：隨午餐服用</p>
          <p className="text-amber-700">碳酸鈣需充足胃酸解離吸收，空腹服用吸收率極低且易脹氣便秘</p>
          <MineralTimingGuidance minerals={['calcium', 'copper', 'zinc']} />
          <p className="text-amber-700 font-medium">⚠️ 補鈣日午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐），避免紅肉/蛋</p>
          <p className="text-amber-700">高劑量鈣 500mg 明顯抑制非血基質鐵及鋅吸收</p>
          <p className="text-red-600 font-medium">🚫 補鈣日當晚放棄補鋅：鈣殘餘競爭 DMT1 + 睡前鋅與甘胺酸鎂競爭二價陽離子載體。單日不補鋅不影響整體鋅營養狀態</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 補鈣當日維持 D3 1000IU</p>
          <p className="text-emerald-700">總攝取 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
          <p className="text-emerald-700">25(OH)D 為長期蓄積指標，單日波動不影響血清濃度</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 禁止睡前服用鈣片</p>
          <p className="text-red-700">鈣與鎂競爭 DMT1 載體，同服降低兩者吸收率</p>
          <p className="text-red-700">睡前已服用蘇糖酸鎂 + 甘胺酸鎂，再加鈣片會互相干擾</p>
          <p className="text-red-700">09:05 碘鹽 → 12:00 午餐（鈣隨餐）→ 14:00-15:00 銅（牛肉日免補）→ 19:00 鋅（最後一口）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('飲水')) {
    return (
      <Detail>
        <p>尿液淡黃色為適當水合指標</p>
        <p className="text-amber-600">⚠️ 週六/日 Zone 2 有氧日：09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水</p>
        <p className="text-blue-600 font-medium">💧 補鈣日飲水建議 3L+（維持良好水合，支持腎臟代謝）</p>
      </Detail>
    );
  }

  if (title.includes('健康檢測') || title.includes('每半年')) {
    return (
      <Detail>
        <Label>每半年健康檢測 — 必檢指標</Label>
        <EgfrProtocol context="health-check" />
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-orange-800">肝功能（補劑代謝負荷）</p>
          <p className="text-orange-700">ALT — 正常 7-56 U/L</p>
          <p className="text-orange-700">AST — 正常 10-40 U/L</p>
          <p className="text-orange-700 font-semibold">⚠️ Ashwagandha 肝功能追蹤：新品牌開始後第 4 週、第 12 週各加測 ALT/AST</p>
          <p className="text-orange-700">藥源性肝損傷多發於數週內，勿枯等半年健檢</p>
          <p className="text-orange-700 font-bold">🚨 不限品牌/批次：疲累加重、食慾不振、皮膚微黃、右上腹不適 → 立即停用並抽血</p>
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
        <AshwagandhaWarnings variant="health-check" />
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
        <ColdBathRules context="vo2max" />
      </Detail>
    );
  }

  return null;
}
