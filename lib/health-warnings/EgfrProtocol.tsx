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
            <p className="text-red-700 font-bold">1. 抽血前必須先停用肌酸 7 天 + 暫停高強度重訓 48-72hr（肌肉修復也會升高 Creatinine）</p>
            <p className="text-red-700 font-bold">2. 建議加測 Cystatin C（不受肌肉量/肌酸影響，交叉驗證真實腎功能）</p>
          </>
        )}
        <p className="text-red-700 font-bold">3. eGFR &lt;90 分級處置：</p>
        <p className="text-red-700">首次 &lt;90 → 下修至 1.6g/kg（≈117g/day），每餐 ≤35g，永久停止肌酸，3 個月後複檢</p>
        <p className="text-red-700 font-semibold">連續兩次 &lt;90（間隔 3 個月）→ 強制下修至 1.2g/kg（≈88g/day），每餐 ≤30g，轉介腎臟科</p>
      </div>
    );
  }

  // health-check context: full kidney function section + eGFR protocol
  return (
    <>
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5">
        <p className="font-semibold text-red-800">腎功能（高蛋白飲食 + 肌酸監測）</p>
        <p className="text-red-700 font-bold">🔴 絕對前提：抽血前 7 天停用肌酸 + 48-72hr 暫停高強度重訓</p>
        <p className="text-red-700">肌肉修復本身也會顯著升高 Creatinine，與肌酸偽陽性疊加 → eGFR 被嚴重低估</p>
        <p className="text-red-700">只有停用+休息後的數據才能反映真實腎功能</p>
        <p className="text-red-700">BUN（尿素氮）— 正常 7-20 mg/dL</p>
        <p className="text-red-700">Creatinine（肌酐）— 正常 0.7-1.3 mg/dL</p>
        <p className="text-red-700">eGFR（腎絲球過濾率）— 正常 &gt;90 mL/min</p>
        <p className="text-red-700 font-semibold">建議加測 Cystatin C：不受肌肉量/肌酸影響，交叉驗證真實 eGFR</p>
      </div>
      <div className="bg-red-50 rounded-lg px-3 py-2 space-y-0.5 mt-1">
        <p className="font-bold text-red-800">⚠️ eGFR &lt;90 分級處置（確認為真實腎功能下降後）</p>
        <p className="text-red-700 font-bold">首次 &lt;90：下修至 1.6g/kg（≈117g/day），每餐 ≤35g，永久停止肌酸，3 個月後複檢</p>
        <p className="text-red-700 font-bold">連續兩次 &lt;90（間隔 3 個月）：強制下修至 1.2g/kg（≈88g/day），每餐 ≤30g，轉介腎臟科追蹤</p>
        <p className="text-red-700">增加飲水、降低鈉攝取、密切監測 BUN/Creatinine</p>
        <p className="text-red-700">建議搭配 Cystatin C 檢測（不受肌肉量/肌酸影響），交叉驗證 eGFR</p>
        <p className="text-red-700 font-semibold">必須先停用肌酸 7 天 + 暫停重訓 48-72hr → 取得真實 eGFR → 才啟動處置</p>
      </div>
    </>
  );
}
