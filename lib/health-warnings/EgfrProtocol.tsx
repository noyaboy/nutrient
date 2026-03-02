import React from 'react';

interface EgfrProtocolProps {
  context: 'protein-section' | 'health-check';
  showCreatineWashout?: boolean;
}

export function EgfrProtocol({ context, showCreatineWashout = true }: EgfrProtocolProps) {
  if (context === 'protein-section') {
    return (
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-bold text-red-800">🔴 eGFR 檢測流程</p>
        {showCreatineWashout && (
          <>
            <p className="text-red-700 font-bold">1. 抽血前暫停高強度重訓 48-72hr（肌肉修復會升高 Creatinine）</p>
            <p className="text-red-700 font-bold">2. 必測 Cystatin C（不受肌肉量/肌酸影響，為真實腎功能金標準指標）— 肌酸無需停用（完全洗出需 4-6 週，嚴重干擾訓練週期，Cystatin C 可完全繞過此問題）</p>
          </>
        )}
        <p className="text-red-700 font-bold">3. eGFR &lt;90 分級處置（以 Cystatin C eGFR 為準）：</p>
        <p className="text-red-700">首次 &lt;90 → 停止肌酸、下修至 1.6g/kg（≈117g/day），每餐 ≤35g，3 個月後複檢</p>
        <p className="text-red-700 font-semibold">連續兩次 &lt;90（間隔 3 個月）→ 強制下修至 1.2g/kg（≈88g/day），每餐 ≤30g，轉介腎臟科</p>
        <p className="text-red-700 text-[10px]">⚠️ 單次異常不宜貿然定義為「永久」— 3 個月複檢確認趨勢後再決定長期策略</p>
      </div>
    );
  }

  // health-check context: full kidney function section + eGFR protocol
  return (
    <>
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5">
        <p className="font-semibold text-red-800">腎功能（高蛋白飲食 + 肌酸監測）</p>
        <p className="text-red-700 font-bold">🔴 絕對前提：抽血前 48-72hr 暫停高強度重訓（肌肉修復會升高 Creatinine）</p>
        <p className="text-red-700 font-bold">🔴 必測 Cystatin C — 不受肌肉量/肌酸/運動影響，為真實腎功能金標準</p>
        <p className="text-red-700">肌酸無需停用：完全洗出需 4-6 週（肌肉飽和濃度回落至基準值），7 天停用幾乎無效。Cystatin C 完全繞過此問題，不必犧牲訓練週期</p>
        <p className="text-red-700">BUN（尿素氮）— 正常 7-20 mg/dL</p>
        <p className="text-red-700">Creatinine（肌酐）— 正常 0.7-1.3 mg/dL（僅供參考，受肌酸影響）</p>
        <p className="text-red-700">eGFR（腎絲球過濾率）— 正常 &gt;90 mL/min（以 Cystatin C eGFR 為準）</p>
      </div>
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-bold text-red-800">⚠️ eGFR &lt;90 分級處置（以 Cystatin C eGFR 為判斷依據）</p>
        <p className="text-red-700 font-bold">首次 &lt;90：停止肌酸、下修至 1.6g/kg（≈117g/day），每餐 ≤35g，3 個月後複檢確認趨勢</p>
        <p className="text-red-700 font-bold">連續兩次 &lt;90（間隔 3 個月）：強制下修至 1.2g/kg（≈88g/day），每餐 ≤30g，轉介腎臟科追蹤</p>
        <p className="text-red-700">增加飲水、降低鈉攝取、密切監測 Cystatin C + BUN/Creatinine</p>
        <p className="text-red-700 text-[10px]">⚠️ 單次異常不宜貿然定義為「永久」— 3 個月複檢確認趨勢後再決定長期策略</p>
      </div>
    </>
  );
}
