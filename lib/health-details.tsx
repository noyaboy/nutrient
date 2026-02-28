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
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-blue-800">⏰ 正確順序</p>
          <p className="text-blue-700">09:05 補水：500ml 室溫水 + 碘鹽 1g（食品電子秤測量，~400mg 鈉）+ 檸檬汁</p>
          <p className="text-blue-700">09:15 進食：香蕉（首選）或地瓜 + 乳清蛋白</p>
          <p className="text-blue-700">先喝水再吃固體食物，確保胃中有適當水合狀態</p>
          <p className="text-emerald-600 font-medium">✅ B群在 12:00 午餐隨餐服用（正餐完整食物基質 + 油脂最佳化吸收，避免訓練前少量流質狀態下服用引發噁心）</p>
          <p className="text-red-600 font-medium">⚠️ 下肢日（深蹲/硬舉/腿推）：45 分鐘消化固體地瓜極度不足，高強度訓練時血液集中於骨骼肌導致消化停滯，易引發胃脹、胃酸逆流甚至嘔吐。建議改用香蕉（消化快）或將地瓜提前至 08:00 食用（間隔 2hr）</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">⚠️ 碘攝取策略（RDA 150mcg/日）</p>
          <p className="text-amber-700">全日碘鹽（~2.5g）提供 ~50-82mcg 碘，輔助補足：每週 2-3 次紫菜/海苔（每次 1-2g 乾重，每片 ~12-43mcg 碘），穩定縮小與 RDA 150mcg 的缺口。⚠️ 碘在高溫烹調易昇華流失，碘鹽應於起鍋後撒上或隨湯汁完整攝入。🚫 不以海帶/昆布作為補碘來源：碘含量極高且變異大（1-2g 乾重 = 300-6000mcg，輕易超過 UL 1100mcg），有甲狀腺毒性風險</p>
          <p className="text-amber-700">不用 3-5g：5g/500ml 高於生理食鹽水 0.9%，空腹易噁心；5g = 2000mg 鈉加烹調鹽超 WHO 上限</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">⚠️ 地瓜 RS3 準備</p>
          <p className="text-amber-700">推薦地瓜（前晚蒸好冷藏 → RS3），隔日可放心微波加熱至好入口的熱度（中火 1-1.5 分鐘）。RS3 晶體結構熔解溫度高達 100-120°C 以上，日常微波加熱（70-80°C）不會破壞已形成的抗性澱粉</p>
          <p className="text-amber-700">替代：香蕉（快速碳水 + 鉀）</p>
        </div>
        <Tip>下肢大重量日（週二/週五）：地瓜需提前至訓練前 1.5-2 小時食用；若僅有 45 分鐘空檔，改用香蕉 + 乳清蛋白即可</Tip>
      </Detail>
    );
  }

  if (title.includes('咖啡') && title.includes('Theanine')) {
    return (
      <Detail>
        <p className="text-amber-600">⚠️ 最早 11:15 飲用（訓練後 1hr+，讓身體自然回歸副交感狀態再攝入咖啡因）</p>
        <p className="text-emerald-600">✅ 無論當天是否飲用綠茶，只要喝咖啡就必須同步服用 L-Theanine 200mg（確保咖啡因即時得到緩衝）</p>
        <p className="text-gray-500">下午綠茶另含天然 L-Theanine 40-90mg，總計 ~300mg 仍安全無虞</p>
      </Detail>
    );
  }

  if (title.includes('10:00') && title.includes('運動')) {
    return (
      <Detail>
        <ColdBathRules context="exercise" />
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 三溫暖排程</p>
          <p className="text-amber-700">必須在重訓後或間隔 2hr+（重訓 → 補水 → 三溫暖）。不抑制 mTOR，時序正確即安全</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('午餐') && !title.includes('銅')) {
    return (
      <Detail>
        <div className="space-y-0.5">
          <p>脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g（確保脂溶性維生素充分吸收）</p>
          <p>魚油 3 顆（2100mg EPA+DHA）</p>
          <p>維他命 D3 1000 IU（<span className="text-emerald-600 font-bold">1 顆，已改 1000IU 規格免切</span>）<span className="text-amber-600 font-medium">⟵ 每日服用；血檢達標+晨光曝曬→可進一步減量</span></p>
          <p>K2（僅取 K2 引導鈣至骨骼，不額外疊加 D3 避免攝取過量）</p>
          <p>葉黃素 20mg</p>
          <p>膠原蛋白肽 10-15g（已含 Vit C ~160mg，為每日主要 Vit C 來源，搭配檸檬汁與蔬菜已遠超 RDA 100mg）</p>
          <p>CoQ10 Ubiquinol 200mg（脂溶性，與魚油同服，軟膠囊無法拆分故統一 200mg）</p>
          <p className="text-emerald-600">✅ B群 1 顆隨午餐服用（活化型態，搭配正餐油脂+蛋白質完整食物基質，吸收率最佳）</p>
        </div>
        <CalciumOxalateEducation />
        <p className="text-amber-600 font-medium mt-1">⚠️ 若當日需補鈣：鈣片隨午餐服用（完整規則詳見「鈣攝取」項目）</p>
        <p className="text-gray-500 mt-1">每日脂肪 80-90g：午餐橄欖油 1 匙 + 酪梨 ≈ 30g，晚餐橄欖油 2 匙 28g，加魚油/蛋/肉脂肪</p>
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-orange-800">腸胃負荷管理</p>
          <p className="text-orange-700">十字花科蔬菜（花椰菜、西蘭花）若有脹氣或消化變慢 → 午餐可替換為菠菜或櫛瓜；晚餐可替換為菠菜（草酸對鋅影響弱）、去皮櫛瓜或大白菜。並將當餐蛋白質微調降至 30g</p>
        </div>
      </Detail>
    );
  }

  // 銅 2mg 已停用 — 15mg 鋅不會觸發金屬硫蛋白阻斷銅吸收，銅由堅果/可可粉/全穀類天然提供

  if (title.includes('晚餐') && !title.includes('銅')) {
    return (
      <Detail>
        <div className="space-y-0.5">
          <p className="text-emerald-600 font-medium">✅ 維他命 C 已停用補劑 — 每日由午餐膠原蛋白肽（~160mg）+ 晨間檸檬汁 + 蔬菜天然攝取，遠超 RDA 100mg</p>
          <p className="text-amber-600 font-medium">鋅 15mg 在晚餐「最後一口」吞服（每日固定，含補鈣日 — 午餐鈣至 19:00 已間隔 7hr，礦物質早已離開小腸吸收段，不存在 DMT1 競爭）</p>
        </div>
        <p className="text-gray-500">晚餐蔬菜避開全穀類（糙米、燕麥含植酸干擾鋅吸收）。菠菜主要含草酸（非植酸），對鋅影響較弱，晚餐可適量食用。優格安排在午餐或點心（鈣抑制鋅吸收，與鋅間隔 2hr+）</p>
        <p className="text-amber-600 font-medium">⚠️ 晚餐碳水避開全穀類（糙米、燕麥）：糠皮含大量植酸，干擾 19:00 鋅吸收。改用白米、義大利麵或去皮馬鈴薯</p>
        <Tip>橄欖油 2 大匙入菜。脂溶性維他命皆在午餐服用</Tip>
        <BeefDayAdjustments context="egg" />
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 重訓日晚餐：零高纖/高FODMAP蔬菜 + 零抗性澱粉</p>
          <p className="text-red-700">蔬菜僅限去皮櫛瓜、大白菜或高麗菜（50-100g）+ 熱白米飯/去皮馬鈴薯/義大利麵</p>
          <p className="text-red-700">禁冷卻米飯/地瓜：RS 發酵 + 纖維 + 睡前甘胺酸鎂三重疊加 → 夜間腹脹（詳見「碳水循環」）</p>
        </div>
        <p>最後正餐在睡前 2-3 小時完成（⚠️ 優格須在 17:00 前食用，與 19:00 鋅間隔 2hr+）</p>
        <Tip>社交聚餐時允許打破 19:00 限制，零罪惡感享受當下（人際關係品質對壽命影響 &gt; 飲食與運動）</Tip>
      </Detail>
    );
  }

  if (title.includes('藍光管理')) {
    return (
      <Detail>
        <div className="bg-indigo-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="text-indigo-700">睡眠環境：室溫 18-19°C · 全遮光窗簾 · 遮蓋 LED 指示燈</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('下午點心') || title.includes('15:30')) {
    return (
      <Detail>
        <p className="text-amber-600">安排在 15:30 而非 20:00：避免晚餐 45g + 再補 16g = 1.5hr 內超 60g 蛋白致消化壓力</p>
        <Tip>無調味可搭配蜂蜜或可可粉。Tryall 官網或 Costco 線上可訂</Tip>
      </Detail>
    );
  }

  if (title.includes('22:30') && title.includes('睡前') || title.includes('睡前補充品')) {
    return (
      <Detail>
        <p>與 19:00 晚餐蛋白質間隔 3.5hr+（甘胺酸與蛋白質共用氨基酸載體，間隔不足會降低甘胺酸降溫效果），同時為腎臟保留排尿緩衝時間。洗完熱水澡後立即服用效果最佳 — 熱水澡促進周邊血管擴張散熱，與甘胺酸降溫機制協同</p>
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
        <AshwagandhaWarnings variant="cycle" />
        <Tip>在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。每半年健檢確認肝功能 + 甲狀腺指標（TSH、Free T4）</Tip>
      </Detail>
    );
  }

  if (title.includes('肝功能追蹤') && title.includes('第4/12週')) {
    return (
      <Detail>
        <AshwagandhaWarnings variant="liver-tracking" />
        <Tip>在瓶身標記「第 4 週抽血日」與「第 12 週抽血日」</Tip>
      </Detail>
    );
  }

  if (title.includes('準時入睡')) {
    return (
      <Detail>
        <p className="font-medium">固定起床時間 &gt; 固定就寢時間（最核心的晝夜節律原則）</p>
        <p>慢性睡眠不足（&lt;6 小時）與胰島素阻抗、認知衰退、心血管疾病相關</p>
      </Detail>
    );
  }

  if (title.includes('Zone 2') && title.includes('有氧')) {
    const { zone2Low, zone2High } = getHeartRateZones();
    return (
      <Detail>
        <p>心率目標：約 <strong>{zone2Low}-{zone2High} bpm</strong>（可以說話但無法唱歌，鼻呼吸為佳）</p>
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

  if (title.includes('蛋白質') && (title.includes('122') || title.includes('146'))) {
    return (
      <Detail>
        <p>每餐達亮氨酸門檻 2.5-3g（健康腎功能範圍）</p>
        <EgfrProtocol context="protein-section" />
        <BeefDayAdjustments context="protein" />
        <p className="text-emerald-600">牛肉日額外提供血基質鐵、B12、天然肌酸</p>
      </Detail>
    );
  }

  if (title.includes('膳食纖維')) {
    return (
      <Detail>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">菠菜安排策略</p>
          <p className="text-blue-700">菠菜主要含草酸（Oxalate），非植酸（Phytate）。草酸主要螯合鈣與鐵，對鋅的干擾相對較弱</p>
          <p className="text-blue-700">午餐食用最佳（有鈣質食物保護：鈣+草酸在腸道結合排出，減少草酸吸收）</p>
          <p className="text-blue-700">晚餐可適量食用菠菜（草酸對鋅影響有限）；真正干擾鋅吸收的植酸來自全穀類（糙米、燕麥），晚餐碳水已改用白米/義大利麵</p>
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
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5">
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
          <p className="text-orange-700">連續 2 天脹氣 → 暫停十字花科 3 天，午餐改菠菜或櫛瓜；晚餐可用菠菜、去皮櫛瓜或大白菜（全穀類才是植酸主要來源，已於晚餐碳水避開）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('鈣攝取') || title.includes('鈣') && title.includes('1000')) {
    return (
      <Detail>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">主要鈣來源（食物優先）</p>
          <p>希臘優格 200-300g — ~200-300mg</p>
          <p>低草酸深綠蔬菜（花椰菜、小白菜、高麗菜）— ~100-150mg</p>
          <p className="text-red-600">⚠️ 菠菜草酸極高（~750mg/100g），鈣生物利用率僅 ~5%，不計入每日鈣質總和。菠菜視為膳食纖維、鉀、葉酸來源</p>
          <p>豆腐（板豆腐）100g — ~150mg</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 飲食鈣優先原則</p>
          <p className="text-emerald-700">若已攝取希臘優格 300g（~300mg）+ 豆腐/低草酸蔬菜（~200mg）≥ 500mg → 可不補鈣片</p>
          <p className="text-emerald-700">避免不必要的高劑量鈣抑制午餐鐵鋅吸收</p>
        </div>
        <CalciumOxalateEducation />
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 確認需補鈣時：隨午餐服用</p>
          <p className="text-amber-700">碳酸鈣需充足胃酸解離吸收，空腹服用吸收率極低且易脹氣便秘</p>
          <MineralTimingGuidance minerals={['calcium', 'zinc']} />
          <p className="text-amber-700 font-medium">⚠️ 補鈣日午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐），避免紅肉/蛋</p>
          <p className="text-amber-700">高劑量鈣 500mg 明顯抑制非血基質鐵及鋅吸收</p>
          <p className="text-emerald-600 font-medium">✅ 補鈣日仍正常補鋅：12:00 午餐鈣至 19:00 晚餐鋅已間隔 7 小時，午餐鈣質早已通過小腸吸收段（胃排空 2-4hr + 小腸轉運 3-5hr），不會與晚餐鋅競爭 DMT1/ZIP 載體</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-emerald-800">✅ 補鈣當日維持 D3 1000IU</p>
          <p className="text-emerald-700">總攝取 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日</p>
          <p className="text-emerald-700">25(OH)D 為長期蓄積指標，單日波動不影響血清濃度</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-red-800">🚫 禁止睡前服用鈣片</p>
          <p className="text-red-700">高劑量鈣鎂同服時經細胞旁路徑（paracellular pathway）產生吸收干擾（鎂走 TRPM6/7、鈣走 TRPV5/6，非 DMT1 競爭）</p>
          <p className="text-red-700">睡前已服用蘇糖酸鎂 + 甘胺酸鎂，再加鈣片會互相干擾</p>
          <p className="text-red-700">09:05 碘鹽 → 12:00 午餐（鈣隨餐）→ 19:00 鋅（最後一口）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('飲水')) {
    return (
      <Detail>
        <p className="text-amber-600">⚠️ 週六/日 Zone 2 有氧日：09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水</p>
      </Detail>
    );
  }

  if (title.includes('健康檢測') || title.includes('每半年')) {
    return (
      <Detail>
        <EgfrProtocol context="health-check" />
        <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-orange-800">肝功能（補劑代謝負荷）</p>
          <p className="text-orange-700">ALT — 正常 7-56 U/L</p>
          <p className="text-orange-700">AST — 正常 10-40 U/L</p>
          <p className="text-orange-700 font-semibold">⚠️ Ashwagandha 肝功能追蹤：新品牌開始後第 4 週、第 12 週各加測 ALT/AST</p>
          <p className="text-orange-700">藥源性肝損傷多發於數週內，勿枯等半年健檢</p>
          <p className="text-orange-700 font-bold">🚨 不限品牌/批次：疲累加重、食慾不振、皮膚微黃、右上腹不適（肝臟位置） → 立即停用並抽血</p>
        </div>
        <div className="bg-purple-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-purple-800">甲狀腺功能（Ashwagandha 可能提升 T4）</p>
          <p className="text-purple-700">TSH — 正常 0.4-4.0 mIU/L</p>
          <p className="text-purple-700">Free T4 — 正常 0.8-1.8 ng/dL</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">其他指標</p>
          <p>維他命 D — 目標 40-60 ng/mL</p>
          <p>鋅銅比 — 目標 10-15:1（銅由天然食物提供，不額外補劑）</p>
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
