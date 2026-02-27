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
        <p>香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（iHerb NOW Foods B-50，水溶性隨餐）</p>
        <p>500ml 室溫水 + 少許碘鹽 + 檸檬汁（補水）</p>
        <p className="text-amber-600">⚠️ 確認碘鹽為「加碘」版本（統一生機日曬海鹽加碘，包裝標示「碘化鉀」）</p>
        <Tip>下肢大重量日（深蹲/硬舉）若腸胃不適，可提前至訓練前 60-90 分鐘進食或減量</Tip>
      </Detail>
    );
  }

  if (title.includes('咖啡') && title.includes('Theanine')) {
    return (
      <Detail>
        <Label>咖啡因 + L-Theanine</Label>
        <p>起床後 60-90 分鐘再喝（避免干擾皮質醇覺醒反應）</p>
        <p>標準比例：咖啡因 200-300mg + L-Theanine 200mg（iHerb NOW Foods，偏好更平靜可調 1:2）</p>
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
          <p className="font-bold text-red-800">🚫 冷水浴嚴格限制</p>
          <p className="text-red-700 font-bold">重訓日（一二四五）絕對禁止冷水浴</p>
          <p className="text-red-700">冷水浴會降低核心體溫，抑制肌肥大關鍵信號（mTOR、IGF-1），顯著減少肌肉蛋白質合成</p>
          <p className="text-emerald-600 font-semibold">週六/日（Zone 2 日）：可在早晨執行冷水浴</p>
          <p className="text-emerald-600">與 Zone 2 運動間隔 4hr 以上（例：07:00 冷水浴 → 11:00 Zone 2）</p>
          <p className="text-gray-500">週三（VO2 Max 日）：建議避免，若執行需間隔 4hr+</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('午餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>午餐 + 訓練後補充品</Label>
        <p>蛋白質 45-50g（正餐食物）+ 肌酸 5g（CGN Creatine Monohydrate，iHerb）+ 十字花科蔬菜</p>
        <div className="space-y-0.5">
          <p>魚油 3 顆（2100mg EPA+DHA）</p>
          <p>維他命 D3 2000 IU <span className="text-amber-600 font-medium">⟵ 週一至五，週末休息；血檢達標+晨光曝曬→減半或改兩天一次</span></p>
          <p>K2（僅取 K2 引導鈣至骨骼，不額外疊加 D3 避免攝取過量）</p>
          <p>葉黃素 20mg</p>
          <p>膠原蛋白肽 10-15g（已含 Vit C ~160mg，晚餐再補 500mg = 每日 ~660mg）</p>
          <p>CoQ10 Ubiquinol 100-200mg（脂溶性，與魚油同服）</p>
          <p className="text-gray-400">※ B群在 09:15 訓練前營養餐隨餐服用（非午餐）</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">蛋白質目標：1.6-2.0g/kg（MPS 最大化 + 腎負荷平衡）</p>
          <p>午晚餐各 45-50g、每日 4-5 餐均勻分配。不再額外沖乳清蛋白（正餐蛋白質已足夠）</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">每日脂肪目標：80-90g（22-25% 總熱量）</p>
          <p>午餐：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g</p>
          <p>晚餐：橄欖油 1 大匙（14g）+ 堅果 30g（~15g）≈ 25g</p>
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
        <Label>銅 2mg — 嚴格空腹單獨服用</Label>
        <p className="font-semibold">下午 15:00-16:00 嚴格單獨空腹服用，不與任何礦物質補劑同服</p>
        <p>最大化吸收率：避開午餐的魚油、D3、鈣鎂等礦物質競爭</p>
        <p>若空腹不適 → 搭配少量水果（非含鈣/鐵食物）</p>
        <p>15:00 銅 → 19:00 鋅（僅週二、六）= 間隔 4hr+（避免競爭吸收）</p>
      </Detail>
    );
  }

  if (title.includes('晚餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>晚餐營養策略</Label>
        <p>蛋白質 45-50g，進食順序：蔬菜 → 蛋白質/脂肪 → 碳水（降低血糖波動）</p>
        <div className="space-y-0.5">
          <p>維他命 C 500mg（1 錠）— 午餐膠原蛋白已含 ~160mg，每日合計 ~660mg 已足夠</p>
          <p className="text-amber-600">鋅 25mg 僅週二、六隨晚餐服用（每週 1-2 次，降低長期風險）</p>
        </div>
        <p className="text-gray-500">晚餐蔬菜預設菠菜、櫛瓜等低 FODMAP（十字花科留給午餐，減少每日兩餐脹氣風險）</p>
        <Tip>橄欖油 1 大匙（14g）入菜或涼拌 + 堅果 30g（~15g 脂肪）≈ 25g。脂溶性維他命皆在午餐服用，晚餐脂肪支持整體每日 80-90g 目標</Tip>
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

  if (title.includes('晚餐後點心') || title.includes('20:00')) {
    return (
      <Detail>
        <Label>20:00-20:30 晚餐後點心</Label>
        <p>豌豆蛋白 ~20g 粉（≈16g 蛋白）— 非乳製植物蛋白，中速消化</p>
        <p>晚餐後 1-1.5 小時服用，補充當日蛋白質目標</p>
        <p>避免睡前過飽影響睡眠品質</p>
        <Tip>無調味可搭配少量蜂蜜或可可粉調味</Tip>
      </Detail>
    );
  }

  if (title.includes('21:30') || title.includes('睡前補充品')) {
    return (
      <Detail>
        <Label>21:30-22:00 睡前補充品</Label>
        <p>提前至 21:30-22:00 服用，為腎臟保留排尿緩衝時間，避免半夜起床</p>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">補充品堆疊</p>
          <p>甘胺酸 3g — 降低核心體溫、促進深層睡眠</p>
          <p>蘇糖酸鎂 — 唯一可穿越血腦屏障的鎂型態，改善認知與睡眠</p>
          <p>甘胺酸鎂 100mg — 肌肉放鬆、GABA 受體調節（減半避免總鎂過高致腹瀉）</p>
          <p>Ashwagandha 600mg — 降低皮質醇（<span className="text-red-600 font-bold">嚴格 8 週用 / 4 週停</span>，停用期留白讓受體完全重置）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-red-800">⚠️ Ashwagandha 監測 — 第 6 週起密切觀察</p>
          <p className="text-red-700 font-semibold">第 6 週開始每日自評：是否出現情緒冷漠（Anhedonia）、對平常喜歡的事物失去興趣、早晨無力起床</p>
          <p className="text-red-700">任一症狀出現 → 立即停用，進入 4 週停用期</p>
          <p className="text-red-700">若隔日晨間感到異常昏沉 → 優先暫停甘胺酸鎂或減量</p>
        </div>
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
        <Tip>Zone 2 安排在非重訓日，避免與肌力訓練競爭恢復資源。週三改為 VO2 Max，避免高強度與長時間有氧疊加同一天</Tip>
        <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-blue-800">冷水浴可在週六/日早晨執行</p>
          <p className="text-blue-700">與 Zone 2 運動間隔 4hr 以上（例：07:00 冷水浴 → 11:00 Zone 2）</p>
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

  if (title.includes('蛋白質') && title.includes('146')) {
    return (
      <Detail>
        <p>訓練前乳清 27g + 午晚餐各 45-50g + 睡前豌豆 16g ≈ 143g</p>
        <p>每餐達亮氨酸門檻 2.5-3g 才能啟動 MPS</p>
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
          <p>牛奶 250ml — ~300mg</p>
          <p>深綠蔬菜（菠菜、花椰菜）— ~100-150mg</p>
          <p>豆腐（板豆腐）100g — ~150mg</p>
          <p>起司 30g — ~200mg</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-semibold text-amber-800">⚠️ 不足時睡前補鈣</p>
          <p className="text-amber-700">若當日飲食鈣攝取明顯不足（&lt;600mg）→ 睡前補 1 錠鈣片 500mg</p>
          <p className="text-amber-700">使用 Nature Made Ca+D3+K2（Costco 備用品）</p>
          <p className="text-amber-700">鈣片僅為安全網，不應取代食物來源</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('飲水')) {
    return (
      <Detail>
        <p>尿液淡黃色為適當水合指標。有氧日訓練中改用電解質粉</p>
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
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">其他指標</p>
          <p>維他命 D — 目標 40-60 ng/mL</p>
          <p>鋅銅比 — 目標 10-15:1</p>
          <p>荷爾蒙：睪固酮、SHBG、皮質醇</p>
          <p>代謝：空腹血糖、HbA1c、胰島素</p>
        </div>
        <Tip>⚠️ 任一腎肝指標超出參考範圍 → 立即停用非必要合成補劑（優先停：Ashwagandha、CoQ10、葉黃素），2 週後複檢</Tip>
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
      </Detail>
    );
  }

  return null;
}
