import React from 'react';

interface AshwagandhaWarningsProps {
  variant: 'full' | 'sleep' | 'cycle' | 'liver-tracking' | 'health-check';
  className?: string;
}

/** Serotonin syndrome warning (SSRIs/SNRIs) */
function SerotoninWarning() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-bold text-red-800">🚫 血清素藥物禁忌</p>
      <p className="text-red-700 font-semibold">若正在服用抗憂鬱劑（SSRIs/SNRIs）或任何影響血清素的藥物 → 必須立即停用 Ashwagandha</p>
      <p className="text-red-700">可能誘發血清素綜合徵（Serotonin Syndrome），症狀包括高熱、肌肉僵硬、意識混亂</p>
    </div>
  );
}

/** Autoimmune disease complete prohibition */
function AutoimmuneProhibition() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1 border border-red-300">
      <p className="font-bold text-red-800">🚫 自體免疫疾病完全禁用</p>
      <p className="text-red-700 font-semibold">橋本氏甲狀腺炎、類風濕性關節炎、紅斑性狼瘡等自體免疫疾病患者 → 完全禁用 Ashwagandha</p>
      <p className="text-red-700">免疫調節作用可能加劇自體免疫反應，甲狀腺風暴風險</p>
    </div>
  );
}

/** Daily mood apathy self-assessment checklist */
function MoodApathyChecklist() {
  return (
    <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-bold text-orange-800">📋 每日情緒自評（Ashwagandha 服用期間）</p>
      <p className="text-orange-700">□ 今天是否對平常喜歡的事物失去興趣？</p>
      <p className="text-orange-700">□ 是否感到情緒平淡/麻木？</p>
      <p className="text-orange-700">□ 早晨是否異常無力起床？</p>
      <p className="text-orange-700 font-bold">→ 任一「是」連續 2 天 → 立即停用 Ashwagandha（不可因 8 週未滿而繼續服用）</p>
      <p className="text-orange-600 text-[10px]">情緒冷漠為「強制停用」信號，藥源性情緒阻斷具隱蔽性，僅靠第 4/12 週抽血不足以應對</p>
    </div>
  );
}

/** DILI liver symptom monitoring */
function DiliSymptoms() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1 border border-red-200">
      <p className="font-bold text-red-800">🚨 肝毒性實體症狀監測（DILI）— 不限品牌/批次</p>
      <p className="text-red-700">服用期間出現以下任一症狀 → 立即停用並安排 ALT/AST 抽血：</p>
      <p className="text-red-700 font-semibold">1. 異常疲累加重（排除訓練/睡眠因素）</p>
      <p className="text-red-700 font-semibold">2. 食慾不振持續 2 天以上</p>
      <p className="text-red-700 font-semibold">3. 皮膚或眼白微黃（黃疸前兆）</p>
      <p className="text-red-700 font-semibold">4. 右上腹不適/隱痛</p>
      <p className="text-red-700">⚠️ DILI 可發生在任何品牌、任何批次，不應僅依賴定期抽血排程</p>
    </div>
  );
}

/** ALT/AST tracking schedule (Week 4 & Week 12) */
function AltAstTracking() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-medium text-red-800">⚠️ Ashwagandha 監測 — 第 6 週起密切觀察</p>
      <p className="text-red-700">若 ALT/AST 異常 → 首位停用 Ashwagandha（偶有肝損傷案例）</p>
      <p className="text-red-700 font-semibold">肝功能追蹤：新品牌開始後第 4 週、第 12 週各追蹤 ALT/AST（藥源性肝損傷多發於數週內）</p>
      <p className="text-red-700">若隔日晨間感到異常昏沉 → 優先暫停甘胺酸鎂或減量</p>
    </div>
  );
}

/** 8-week-on / 4-week-off cycle management */
function CycleManagement() {
  return (
    <div className="bg-gray-50 rounded-lg px-3 py-2 space-y-0.5">
      <p className="font-medium text-gray-800">📋 8 週用 / 4 週停 週期</p>
      <p>第 1-5 週：正常服用 450mg/日（睡前）</p>
      <p>第 6 週起：每日自評情緒冷漠、早晨無力起床</p>
      <p>第 8 週（第 56 天）：準時進入停用期</p>
      <p>停用 4 週（28 天）：甘胺酸鎂 + Cyclic Sighing 替代</p>
    </div>
  );
}

/** Cycle prohibitions and stop triggers */
function CycleProhibitions() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-bold text-red-800">🚫 禁忌與停用觸發</p>
      <p className="text-red-700">服用 SSRIs/SNRIs 或血清素藥物 → 禁用（血清素綜合徵風險）</p>
      <p className="text-red-700 font-semibold">🚫 自體免疫疾病完全禁用：橋本氏甲狀腺炎、類風濕性關節炎、紅斑性狼瘡等（加劇自體免疫反應）</p>
      <p className="text-red-700 font-semibold">🚫 甲狀腺即時停用：若 TSH/Free T4 異常 → 立即停用並就醫（可能提升 T4，甲狀腺風暴風險）</p>
      <p className="text-red-700 font-bold">⚠️ 情緒冷漠為「強制停用」信號：即使未滿 8 週也必須立即停用，不可因週期未滿而繼續服用</p>
      <p className="text-red-700">ALT/AST 異常 → 首位停用本品（肝損傷風險）</p>
      <p className="text-red-700 font-semibold">感冒/發燒/任何急性感染 → 立即暫停，康復後再恢復</p>
    </div>
  );
}

/** Cycle liver function tracking */
function CycleLiverTracking() {
  return (
    <div className="bg-orange-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-semibold text-orange-800">⚠️ 肝功能追蹤（勿枯等半年健檢）</p>
      <p className="text-orange-700">開始服用新品牌 Ashwagandha 後第 4 週及第 12 週各追蹤 ALT/AST</p>
      <p className="text-orange-700">藥源性肝損傷多發於服用後數週內，早期發現可避免惡化</p>
    </div>
  );
}

/** Cycle DILI symptoms (compact version) */
function CycleDiliCompact() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1 border border-red-200">
      <p className="font-bold text-red-800">🚨 肝毒性實體症狀（DILI）— 不限品牌/批次</p>
      <p className="text-red-700 font-semibold">異常疲累、食慾不振 ≥2天、皮膚/眼白微黃、右上腹不適</p>
      <p className="text-red-700 font-bold">→ 任一出現即刻停用並抽血 ALT/AST（不必等排程）</p>
    </div>
  );
}

/** Off-cycle alternatives */
function OffCycleAlternatives() {
  return (
    <div className="bg-blue-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-medium text-blue-800">停用期 4 週替代方案</p>
      <p className="text-blue-700">甘胺酸鎂 + Cyclic Sighing 呼吸法維持睡眠品質</p>
      <p className="text-blue-700">其餘睡前補充品（甘胺酸 3g、蘇糖酸鎂）照常服用</p>
    </div>
  );
}

/** Liver tracking detail (standalone section) */
function LiverTrackingDetail() {
  return (
    <>
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
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1 border border-red-200">
        <p className="font-bold text-red-800">🚨 重要：DILI 不限品牌/批次</p>
        <p className="text-red-700">定期排程僅是基準線。服用期間出現疲累加重、食慾不振、皮膚/眼白微黃、右上腹不適</p>
        <p className="text-red-700 font-bold">→ 不必等排程，立即安排抽血</p>
      </div>
    </>
  );
}

/** Health check summary: prohibitions + monitoring */
function HealthCheckSummary() {
  return (
    <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
      <p className="font-bold text-red-800">🚫 Ashwagandha 禁忌</p>
      <p className="text-red-700">若正在服用抗憂鬱劑（SSRIs/SNRIs）或血清素藥物 → 禁用（血清素綜合徵風險）</p>
      <p className="text-red-700">甲亢或服用甲狀腺藥物者 → 禁用（可能提升 T4，甲狀腺風暴風險）</p>
      <p className="text-red-700 font-semibold">自體免疫疾病（橋本氏甲狀腺炎、類風濕性關節炎、紅斑性狼瘡等）→ 完全禁用</p>
    </div>
  );
}

export function AshwagandhaWarnings({ variant, className }: AshwagandhaWarningsProps) {
  return (
    <div className={className}>
      {variant === 'full' && (
        <>
          <SerotoninWarning />
          <AutoimmuneProhibition />
          <MoodApathyChecklist />
          <AltAstTracking />
          <DiliSymptoms />
          <OffCycleAlternatives />
        </>
      )}
      {variant === 'sleep' && (
        <>
          <SerotoninWarning />
          <AutoimmuneProhibition />
          <MoodApathyChecklist />
          <AltAstTracking />
          <DiliSymptoms />
          <OffCycleAlternatives />
        </>
      )}
      {variant === 'cycle' && (
        <>
          <CycleManagement />
          <CycleProhibitions />
          <CycleLiverTracking />
          <CycleDiliCompact />
        </>
      )}
      {variant === 'liver-tracking' && (
        <LiverTrackingDetail />
      )}
      {variant === 'health-check' && (
        <HealthCheckSummary />
      )}
    </div>
  );
}
