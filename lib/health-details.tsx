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
        <p>香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）</p>
        <p>500ml 室溫水 + 少許碘鹽 + 檸檬汁（補水）</p>
        <Tip>下肢大重量日（深蹲/硬舉）若腸胃不適，可提前至訓練前 60-90 分鐘進食或減量</Tip>
      </Detail>
    );
  }

  if (title.includes('咖啡') && title.includes('Theanine')) {
    return (
      <Detail>
        <Label>咖啡因 + L-Theanine</Label>
        <p>起床後 60-90 分鐘再喝（避免干擾皮質醇覺醒反應）</p>
        <p>標準比例：咖啡因 200-300mg + L-Theanine 200mg</p>
        <div className="bg-blue-50 rounded-lg px-3 py-2">
          <p className="text-blue-700">偏好更平靜專注可調為 1:2 比例（如 100mg 咖啡因 + 200mg L-Theanine）</p>
        </div>
        <p>L-Theanine 緩衝咖啡因焦慮，達到平靜專注狀態</p>
        <p className="text-red-600 font-medium">15:00 前為咖啡因截止時間（保護睡眠品質）</p>
      </Detail>
    );
  }

  if (title.includes('午餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>午餐 + 訓練後補充品</Label>
        <p>蛋白質 30-40g（正餐食物）+ 肌酸 5g + 十字花科蔬菜</p>
        <div className="space-y-0.5">
          <p>魚油 3 顆（2100mg EPA+DHA）</p>
          <p>維他命 D3 2000 IU <span className="text-amber-600 font-medium">⟵ 週一至五，週末休息；血檢達標+晨光曝曬→減半或改兩天一次</span></p>
          <p>K2（僅取 K2 引導鈣至骨骼，不額外疊加 D3 避免攝取過量）</p>
          <p>維他命 C 500-1000mg（水溶性，每日服用）</p>
          <p>葉黃素 20mg</p>
          <p>膠原蛋白肽 10-15g（與 Vit C 協同促進膠原蛋白合成）</p>
          <p>CoQ10 Ubiquinol 100-200mg（脂溶性，與魚油同服）</p>
          <p>B群 1 顆（水溶性，白天能量代謝）</p>
        </div>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-gray-800">蛋白質目標：1.6-2.0g/kg（MPS 最大化 + 腎負荷平衡）</p>
          <p>每餐 30-40g、每日 4-5 餐均勻分配。不再額外沖乳清蛋白（正餐蛋白質已足夠）</p>
        </div>
        <div className="bg-amber-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-amber-800">補充品假期 5+2</p>
          <p className="text-amber-700">脂溶性（D3）與微量礦物質（鋅、銅）：週一至五服用，週末休息</p>
          <p className="text-amber-700">防止脂肪組織或肝臟過度蓄積；水溶性（Vit C）可每日服用</p>
        </div>
        <div className="bg-emerald-50 rounded-lg px-3 py-2 space-y-1 mt-1">
          <p className="font-medium text-emerald-800">搭配原理</p>
          <div className="flex items-start gap-2">
            <Tag color="green">D3 + K2</Tag>
            <span className="flex-1 text-emerald-700">D3 增加鈣吸收，K2 引導鈣至骨骼而非動脈（僅取 K2，不疊加 D3）</span>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="green">Vit C + 魚油</Tag>
            <span className="flex-1 text-emerald-700">維他命 C 抗氧化保護 Omega-3 免受氧化降解</span>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="green">膠原蛋白 + Vit C</Tag>
            <span className="flex-1 text-emerald-700">Vit C 是膠原蛋白合成的必要輔因子，同服最大化效果</span>
          </div>
          <div className="flex items-start gap-2">
            <Tag color="green">CoQ10 + 魚油</Tag>
            <span className="flex-1 text-emerald-700">CoQ10 為脂溶性，魚油中的脂肪大幅提升吸收率</span>
          </div>
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
        <Label>銅 2mg</Label>
        <p>與鋅間隔 4 小時以上（銅和鋅在腸道吸收時互相競爭）</p>
        <p>15:00 服用銅 → 19:00 隨晚餐服用鋅 = 完美間隔</p>
      </Detail>
    );
  }

  if (title.includes('晚餐') && !title.includes('銅')) {
    return (
      <Detail>
        <Label>晚餐營養策略</Label>
        <p>鋅隨餐服用避免噁心，進食順序：蔬菜 → 蛋白質/脂肪 → 碳水（降低血糖波動）</p>
        <p className="text-gray-500">晚餐蔬菜預設菠菜、櫛瓜等低 FODMAP（十字花科留給午餐，減少每日兩餐脹氣風險）</p>
        <Tip>適量橄欖油入菜或涼拌，確保每日脂肪攝取達 20-30% 總熱量。脂溶性維他命（D3、K2、葉黃素）與 CoQ10 皆需油脂輔助吸收</Tip>
        <p>最後正餐在睡前 2-3 小時完成（睡前小份優格不影響）</p>
        <div className="bg-purple-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-purple-800">社交豁免權 80/20</p>
          <p className="text-purple-700">高質量社交聚餐時，允許打破 19:00 晚餐結束的限制。將社交帶來的多巴胺與催產素視為當日最佳的抗老補劑，零罪惡感享受當下</p>
          <p className="text-purple-700">人際關係品質對壽命影響高於飲食與運動</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('藍光管理')) {
    return (
      <Detail>
        <Label>藍光管理 & 睡眠衛生</Label>
        <div className="bg-indigo-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-indigo-800">睡眠衛生清單</p>
          <p className="text-indigo-700">睡前 60 分鐘關閉螢幕（或戴防藍光眼鏡）</p>
          <p className="text-indigo-700">室溫 18-19°C（涼爽環境增加深層睡眠和生長激素分泌）</p>
          <p className="text-indigo-700">完全遮光（全遮光窗簾 + 遮蓋 LED 指示燈）</p>
        </div>
      </Detail>
    );
  }

  if (title.includes('睡前')) {
    return (
      <Detail>
        <Label>睡前營養</Label>
        <p>熱水澡 40-42°C，10-15 分鐘（睡前 60-90 分鐘）</p>
        <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
          <p className="font-medium text-gray-800">補充品堆疊</p>
          <p>豌豆蛋白 ~20g 粉（≈16g 蛋白）— 降低粉末蛋白佔比，減輕腎過濾負荷</p>
          <p>甘胺酸 3g — 降低核心體溫、促進深層睡眠</p>
          <p>蘇糖酸鎂 — 唯一可穿越血腦屏障的鎂型態，改善認知與睡眠</p>
          <p>甘胺酸鎂 100mg — 肌肉放鬆、GABA 受體調節（減半避免總鎂過高致腹瀉）</p>
          <p>Ashwagandha 600mg — 降低皮質醇（<span className="text-amber-600 font-medium">8 週用 / 4 週停</span>，停用期改紅景天 500mg）</p>
        </div>
        <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
          <p className="font-medium text-red-800">監測指標</p>
          <p className="text-red-700">若隔日晨間感到異常昏沉 → 優先暫停甘胺酸鎂或減量</p>
          <p className="text-red-700">若夜間腸胃蠕動過快 → 豌豆蛋白減半或改為較少量的希臘優格</p>
          <p className="text-red-700">Ashwagandha 使用第 6-8 週留意情緒冷漠（Anhedonia）或早晨無力起床 → 出現則提前進入停用期</p>
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
