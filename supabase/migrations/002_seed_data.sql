------------------------------------------------------------
-- 每日計畫項目 (23 active + 8 inactive = 31 items)
-- Matches live DB state as of 2026-02-25
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  -- === Morning (< 12:00) ===
  ('09:00 起床 & 晨光曝曬', '起床後 30 分鐘內到戶外曬太陽 10-20 分鐘（陰天久一點）。不戴太陽眼鏡。校正晝夜節律、降低皮質醇、促進維他命D合成', 'daily', '睡眠', 1, 1, true),
  ('09:05 補水 & 電解質', '起床後盡快補水。500ml 室溫水 + 碘鹽 1g（使用食品電子秤測量 0.1g 精度，約 400mg 鈉）+ 檸檬汁。可搭配晨光曝曬同時進行。⚠️ 碘攝取策略（RDA 150mcg/日）：晨間碘鹽僅 1g 以控制每日總鈉（WHO 每日 <2400mg 鈉建議），碘攝取主要仰賴食物：(1) 午晚餐烹調用碘鹽（每餐 1-2g）(2) 每週 2-3 次海帶/紫菜（富含碘 500-3000mcg/g 乾重）。⚠️ 十字花科蔬菜含硫代葡萄糖苷（Goitrogens），會競爭甲狀腺對碘的吸收 → 高十字花科攝取者碘需求更高。⚠️ 週六/日 Zone 2 有氧日：09:05 補水改用電解質粉沖泡 500ml（CGN Sport Hydration），訓練中持續補充電解質水', 'daily', '飲食', 2, 1, true),
  ('09:15 NMN + TMG（空腹）', '香蕉/地瓜 + 乳清蛋白 ~30g 粉（≈27g 蛋白）', 'daily', '補充品', 2, 1, false),
  ('09:15 訓練前營養', '⏰ 09:05 先補水（500ml 室溫水 + 碘鹽 1g 用電子秤測量 + 檸檬汁）→ 09:15 訓練前營養。地瓜（推薦）或香蕉 + 乳清蛋白 ~30g 粉（≈27g 蛋白）+ B群 1 顆（活化型態 Coenzyme B-Complex：甲鈷胺 B12 + 5-MTHF 葉酸 + P5P B6，水溶性需隨餐服用確保吸收）。⚠️ 地瓜建議前晚用電子鍋蒸好冷藏（產生抗性澱粉 RS3），隔日微波 30 秒加溫即可食用，抗性澱粉仍保留大部分。⚠️ B群勿空腹：需搭配地瓜或香蕉，食物基質減緩胃排空提升吸收。⚠️ 順序：先喝水再吃固體食物+B群，確保胃中有食物基質時 B群才進入', 'daily', '飲食', 3, 1, true),
  ('09:45 穩定性訓練暖身', 'RAMP 暖身含穩定性訓練共 15 分鐘（升溫→激活→活動度→增強）：反伸展、反旋轉、單腳 RDL、肩胛穩定、抗側屈（行李箱負重走）', 'daily', '運動', 4, 1, true),
  ('10:00 運動', '一上半身A/二下半身A/四上半身B/五下半身B。三 VO2 Max 間歇。六/日 Zone 2 有氧 45-60 分鐘。每次 60-90 分鐘。🚫 冷水浴統一規定：僅限週六、日 Zone 2 日執行（早晨 07:00-08:00），與運動間隔 4hr 以上。重訓日（一二四五）及 VO2 Max 日（三）嚴格禁止冷水浴（抑制 mTOR/IGF-1 肌肥大 + 線粒體適應）。🚫 三溫暖/熱暴露排程：三溫暖必須在重訓「之後」執行，或與重訓間隔 2 小時以上。高溫暴露後立即重訓會增加心血管負擔（心率升高 + 血壓波動 + 脫水風險）。正確順序：重訓 → 休息/補水 → 三溫暖。⚠️ 三溫暖本身不抑制 mTOR（與冷水浴不同），但時序錯誤仍有安全風險', 'daily', '運動', 5, 1, true),
  ('11:15 咖啡 + L-Theanine', '起床後 90-135 分鐘再喝（避免干擾皮質醇覺醒反應，且與 09:15 B群間隔 2hr+）。咖啡因 200-300mg（約 1-2 杯黑咖啡）+ L-Theanine 200mg（NOW Foods Double Strength 200mg，iHerb，1:1 比例 A 級 nootropic 組合，消除焦慮、增強專注）。15:00 後禁止咖啡因（半衰期 5-6 小時影響睡眠）。⚠️ B群吸收保護：咖啡因利尿作用加速水溶性 B 群（尤其 B1）排出，與 09:15 B群服用間隔至少 2 小時。⚠️ 綠茶日微調：若 13:00 飲用綠茶 2-3 杯（含天然 L-Theanine ~20-30mg/杯，合計 40-90mg），直接跳過 L-Theanine 補劑（200mg 素食膠囊無法精準減半，強行拆開肉眼估量誤差大且易受潮）', 'daily', '飲食', 6, 1, true),

  -- === Midday (12:00-15:00) ===
  ('12:00 午餐 + 訓練後補充品', '蛋白質 35-40g（正餐食物，單餐建議 ≤45g）+ 肌酸 5g（CGN Creatine Monohydrate）+ 蔬菜（切碎靜置 40 分鐘最大化蘿蔔硫素）+ 碳水 80-105g（訓練日，建議使用冷卻再加熱米飯以保留抗性澱粉 RS3）。脂肪：橄欖油 1 大匙（14g）+ 酪梨半顆（~15g）≈ 30g（確保脂溶性維生素充分吸收）。隨餐服用：魚油 3 顆、D3 1000IU（每日 1 顆，已改為 1000IU 規格免切）、K2 MK-7 100mcg、葉黃素 20mg、膠原蛋白肽 10-15g（含 Vit C ~160mg，每日隨午餐服用）、CoQ10 200mg。✅ 草酸鈣正確觀念：鈣與草酸在「腸道」同餐攝取 → 結合為不溶性草酸鈣隨糞便排出（好）。若刻意分開，游離草酸被吸收入血 → 在「腎臟」與尿鈣結合形成結石（壞）。因此高草酸蔬菜（菠菜等）搭配鈣質食物反而是保護策略。⚠️ 若當日需補鈣：鈣片 500mg 隨午餐服用（碳酸鈣需胃酸解離，空腹吸收率極低）。補鈣日午餐注意：高劑量鈣 500mg 抑制非血基質鐵及鋅吸收，若當日飲食鈣充足（如已攝取希臘優格 300g ≈ 300mg）則取消鈣片；若必須補鈣，午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐取代紅肉/蛋）', 'daily', '飲食', 7, 1, true),
  ('12:00-13:00 午餐補銅 2mg', '銅 2mg（Solgar）隨午餐服用。與鋅間隔 4+ 小時（鋅在晚餐）。鋅銅比維持 10-15:1，防止長期鋅補充導致銅缺乏。⚠️ 16:00 小點心嚴格避開含鈣食物（優格、牛奶、起司）：鈣與銅共用 DMT1 轉運蛋白，高鈣食物會顯著抑制銅吸收。點心選擇：少量水果（蘋果/香蕉片）或幾片低鈣餅乾', 'daily', '補充品', 8, 1, false),
  ('13:00 綠茶 EGCG 2-3 杯', '午餐後 1hr+ 再飲用（~13:00），避免螯合鈣、鐵、鋅。EGCG + L-theanine 天然組合促進專注。15:00 前喝完（咖啡因 cutoff）。⚠️ 若當日已服用 L-Theanine 200mg 補劑（11:15 咖啡隨服），綠茶天然 L-Theanine（~20-30mg/杯 × 2-3 杯 = 40-90mg）合計可達 240-290mg，雖無毒性但可能過度放鬆 → 建議綠茶日將 L-Theanine 補劑減半（100mg）或跳過', 'daily', '飲食', 8, 1, true),

  -- === Afternoon (15:00-18:59) ===
  ('15:00 NSDR', '使用引導式 Yoga Nidra 音檔（非單純休息）。11 分鐘有 RCT 支持，促進深度放鬆與多巴胺恢復', 'daily', '心理', 9, 1, true),
  ('16:00-17:00 銅 2mg 補充', '銅 2mg（Solaray Bisglycinate）隨低鈣/低鐵小點心服用（如少量水果、幾片餅乾），避免空腹服用引發噁心嘔吐。不與鋅、鈣、鐵等礦物質補劑同服。⚠️ 時間安排：12:00 午餐（鈣隨餐）→ 16:00 銅（間隔 4hr）→ 19:00 晚餐最後一口鋅（間隔 3hr+）。⚠️ 牛肉日免補銅：牛肉 150-180g + 堅果已提供足夠銅，當日取消銅補劑避免逼近 UL 10mg/日。遵從性優先：不再堅持「嚴格空腹」，以不引起嘔吐感為最高原則', 'daily', '補充品', 10, 1, true),
  ('15:30 下午點心', 'Tryall 豌豆蛋白 ~20g 粉（≈16g 蛋白）。非乳製植物蛋白，中速消化。下午點心時段服用，分散蛋白質攝取壓力。與 Tryall 乳清同品牌，品質一致', 'daily', '飲食', 11, 1, true),
  ('17:00 高質量社交對話', '至少與一位親友進行非公事的深度對話。每週安排 1 次面對面社交活動。戶外自然接觸 120+ 分鐘/週（可結合有氧）。哈佛研究：人際關係品質對壽命影響高於飲食與運動', 'daily', '心理', 12, 1, true),

  -- === Evening (19:00+) ===
  ('19:00 晚餐 + 低 FODMAP 蔬菜', '蛋白質 35-40g（單餐建議 ≤45g，生理上非絕對門檻）+ 低 FODMAP 蔬菜（十字花科留給午餐）。順序：纖維→蛋白→碳水。脂肪：橄欖油 2 大匙（28g）入菜或涼拌。隨餐服用：維他命 C 500mg（1 錠，已改為 500mg 規格免切，每日服用不再因補鈣日停用）。鋅 15mg 在晚餐「最後一口」吞服（非隨餐混吃，最大化與 16:00 銅離子的時間距離，銅鋅共用 DMT1/ZIP 轉運蛋白）。⚠️ 鋅吸收注意：含鋅餐避免菠菜、豆類等高植酸食物（植酸+草酸強力螯合游離鋅離子，大幅削弱 15mg 鋅吸收率）。晚餐蔬菜優先選擇低植酸品種：櫛瓜、大白菜、高麗菜、小白菜。菠菜安排在午餐（有鈣質保護 + 不影響鋅）。⚠️ 牛肉日蛋白質控制：草飼牛肉 150-180g ≈ 30-36g 蛋白，可加 1 顆蛋（~42g 仍在安全範圍內），整日總量維持 1.5-1.7g/kg 即可。⚠️ 牛肉日取消鋅補劑：牛肉富含鋅 6-9mg/150-180g，當晚無需額外補鋅，避免超過 UL 40mg/日。⚠️ 鋅鈣競爭：晚餐勿食用希臘優格（鈣 200-300mg 抑制鋅吸收），優格移至午餐或 15:30 點心（與 19:00 鋅間隔 2hr+ 以上）。⚠️ 重訓日（一二四五）晚餐零葉菜+零抗性澱粉：高碳水日嚴格執行低纖維策略，僅保留新鮮熱白米飯/去皮馬鈴薯/義大利麵 + 少量煮熟去皮櫛瓜（微量纖維緩衝血糖波動，不產氣）。禁止冷卻米飯/地瓜（抗性澱粉在腸道後段發酵產氣比葉菜纖維更強），避免纖維 + 睡前甘胺酸鎂（高滲透壓）疊加導致夜間滲透性腹脹干擾睡眠。固體食物睡前 3-4hr 結束', 'daily', '飲食', 13, 1, true),
  ('19:30 餐後散步 15 分鐘', '控制餐後血糖最有效的方法，降低胰島素峰值。輕快步行即可，不需高強度。午餐後也建議散步 10-15 分鐘。可結合戶外自然接觸（每週目標 120+ 分鐘）', 'daily', '運動', 14, 1, true),
  ('22:00 睡前補充品', '甘胺酸 3g + 蘇糖酸鎂 + 甘胺酸鎂 100mg + Ashwagandha 450mg（KSM-66 每顆 450mg，每日 1 顆。嚴格 8 週用 / 4 週停，在瓶身標記開始日與第 56 天停用日）。🚫 血清素藥物禁忌：若正在服用抗憂鬱劑（SSRIs/SNRIs）或任何影響血清素的藥物 → 必須立即停用 Ashwagandha，可能誘發血清素綜合徵（Serotonin Syndrome）。⚠️ 第 6 週起密切觀察情緒變化：若出現情緒冷漠（Anhedonia）或早晨無力起床 → 立即進入停用期（不可因 8 週未滿而繼續服用，情緒冷漠為「強制停用」信號）。📋 每日情緒自評（服用期間）：今天是否對平常喜歡的事物失去興趣？是否感到情緒平淡/麻木？早晨是否異常無力起床？→ 任一「是」連續 2 天 → 立即停用。停用期替代：甘胺酸鎂 + Cyclic Sighing 維持睡眠品質。🚨 肝毒性實體症狀監測（DILI）：不限新品牌，任何批次服用期間若出現以下任一症狀 → 立即停用並安排 ALT/AST 抽血：(1) 異常疲累加重（排除訓練/睡眠因素）(2) 食慾不振持續 2 天以上 (3) 皮膚或眼白微黃（黃疸前兆）(4) 右上腹不適/隱痛。⚠️ 藥源性肝損傷可發生在任何品牌、任何批次，不應僅依賴定期抽血排程。⏰ 嚴格 22:30 後服用（洗完熱水澡後），確保與 19:00 晚餐蛋白質間隔 3.5hr+（甘胺酸與蛋白質共用氨基酸載體，間隔不足會降低甘胺酸降溫效果），同時為腎臟保留排尿緩衝時間。⚠️ 甘胺酸必須在洗澡結束後服用：熱水澡升高核心體溫，甘胺酸降低核心體溫 → 兩者同時進行會互相抵消', 'daily', '補充品', 15, 1, true),
  ('Ashwagandha 週期管理（8 週用 / 4 週停）', '在瓶身標記「開始日」與「第 56 天停用日」，建議設定手機鬧鐘提醒停用日期。📋 週期檢查：第 1-5 週正常服用 450mg/日 / 第 6 週起每日自評情緒冷漠（Anhedonia）、早晨無力起床 → 任一症狀立即停用 / 第 8 週（56 天）準時進入停用期 / 停用 4 週（28 天）替代方案：甘胺酸鎂 + Cyclic Sighing。🚫 禁忌：服用 SSRIs/SNRIs 或血清素藥物者禁用。🚫 甲狀腺即時停用觸發：若健檢 TSH/Free T4 異常 → 立即停用 Ashwagandha 並就醫（Ashwagandha 可能提升 T4 水平，甲亢風險）。⚠️ 情緒冷漠為「強制停用」信號：若出現 Anhedonia 或早晨無力起床，即使未滿 8 週也必須立即停用，不可因週期未滿而繼續服用。⚠️ ALT/AST 異常 → 首位停用本品。⚠️ 肝功能追蹤：開始服用新品牌 Ashwagandha 後第 4 週及第 12 週各追蹤一次 ALT/AST（藥源性肝損傷多發於數週內，勿枯等半年健檢）。🚫 感冒/免疫啟動時立即停用：Ashwagandha 具有免疫調節作用，急性感染徵兆出現時 → 立即暫停，待完全康復後再恢復。每半年健檢時確認肝功能 + 甲狀腺指標（TSH、Free T4）。🚨 肝毒性實體症狀（DILI）— 不限新品牌/批次：異常疲累加重、食慾不振 ≥2 天、皮膚/眼白微黃、右上腹不適 → 任一出現即刻停用並抽血 ALT/AST。', 'daily', '補充品', 16, 1, true),
  ('Ashwagandha 肝功能追蹤（第4/12週）', '⚠️ 開始服用新品牌 Ashwagandha 後，第 4 週及第 12 週各安排一次 ALT/AST 抽血追蹤。藥源性肝損傷（DILI）多發於服用後數週內，早期發現可避免惡化。📋 追蹤方式：自費抽血（家醫科/健檢中心，約 NT$200-400），僅需檢測 ALT + AST 兩項。⚠️ 若 ALT/AST 異常（ALT >56 U/L 或 AST >40 U/L）→ 立即停用 Ashwagandha，2 週後複檢確認回落。✅ 兩次追蹤均正常 → 後續回歸每半年健檢即可。請在瓶身標記「第 4 週抽血日」與「第 12 週抽血日」。🚨 重要補充：DILI 可發生在任何品牌、任何批次，定期排程僅是基準線。若服用期間出現疲累加重、食慾不振、皮膚/眼白微黃、右上腹不適 → 不必等排程，立即安排抽血。', 'daily', '補充品', 16, 1, true),
  ('22:00 藍光管理', '調暗燈光或佩戴防藍光眼鏡（琥珀色鏡片）。白天：娛樂螢幕 <2hr、社群媒體 <30min、專注時段手機勿擾模式', 'daily', '睡眠', 17, 1, true),
  ('21:30-22:15 熱水澡', '40-42°C 10-15 分鐘。⚠️ 必須在 22:15 前結束洗澡：熱水澡短暫升高核心體溫，而 22:30 甘胺酸的作用是降低核心體溫促進入睡 — 若洗完澡立刻服用甘胺酸，體溫尚未從升高狀態回落，甘胺酸降溫效果被抵消。正確流程：21:30-22:15 洗澡結束 → 22:30 服用甘胺酸（體溫已開始自然回落）→ 散熱 60-90 分鐘 → 00:00 入睡時核心體溫降至最低點', 'daily', '睡眠', 17, 1, true),
  ('23:30 Cyclic Sighing + 專注冥想', 'Cyclic Sighing 5 分鐘（雙吸鼻、長呼口，Stanford RCT 證實最佳呼吸法）+ 專注冥想 10 分鐘（單點注意力：鼻尖呼吸）。寫下三件感恩的事', 'daily', '心理', 18, 1, true),
  ('00:00 感恩練習', '睡前或早晨寫下三件感恩的事，調節自律神經系統', 'daily', '心理', 19, 1, false),
  ('23:50 口腔衛生：刷牙 + 牙線', '早晚各一次。牙周病菌（P. gingivalis）與心血管疾病、阿茲海默症強相關。每日至少刷牙 2 次 + 牙線 1 次', 'daily', '一般', 19, 1, true),
  ('00:00 準時入睡', '目標 8-8.5 小時睡眠。全黑、低溫 18-19°C。深層睡眠啟動腦部排毒系統。週末偏差不超過 30 分鐘。不使用褪黑激素（24歲不需要）', 'daily', '睡眠', 20, 1, true),

  -- === All-day items ===
  ('全天 蛋白質 113-123g+（1.5-1.7g/kg）', '訓練前乳清 27g + 午餐 35-40g（含每週 1-2 次草飼牛肉 150-180g 替代雞胸）+ 下午豌豆 16g + 晚餐 35-40g ≈ 113-123g。每餐達亮氨酸門檻 2.5-3g，單餐建議 ≤45g（生理上非絕對門檻，42g 與 36g 對 BUN 影響差異極小）。每日 4-5 餐均勻分配，總計約 1.5-1.7g/kg（健康腎功能範圍）。⚠️ 牛肉日蛋白質彈性：牛肉 150-180g ≈ 30-36g 蛋白，可加 1 顆蛋（~42g 仍安全），不必為 2.3g 差異造成備餐壓力。牛肉日額外提供血基質鐵、B12、天然肌酸。🔴 eGFR 檢測流程：抽血前必須先停用肌酸 7 天 + 暫停高強度重訓 48-72 小時（肌肉修復也會升高 Creatinine，疊加肌酸偽陽性 → eGFR 嚴重低估）→ 取得真實 eGFR → 🔴 eGFR <90 分級處置：(1) 首次 eGFR <90 → 下修至 1.6g/kg（≈117g/day），每餐 ≤35g，永久停止肌酸，3 個月後複檢。(2) 連續兩次 eGFR <90（間隔 3 個月）→ 強制下修至 1.2g/kg（≈88g/day），每餐 ≤30g，轉介腎臟科追蹤。⚠️ 長期肌酸使用者即使停用 7 天，肌肉質量增加仍可能使 Creatinine 偏高 → eGFR 偽低估，建議搭配 Cystatin C 檢測確認', 'daily', '飲食', 21, 1, true),
  ('全天 膳食纖維 35-45g', '洋蔥、大蒜、蘆筍、燕麥、扁豆、酪梨、冷卻米飯/地瓜。供腸道菌產生丁酸，維護腸腦軸。每日至少 1 份發酵食物：希臘優格 200-300g（午餐或 15:30 點心，⚠️ 嚴禁晚餐食用：優格鈣 200-300mg 與 19:00 鋅 15mg 競爭吸收載體，必須間隔 2hr+。15:30 點心 → 19:00 鋅 = 3.5hr 間隔 ✓）+ 泡菜 50-100g（晚餐隨餐）。雙菌源增強腸道多樣性。⚠️ 菠菜安排在午餐（有鈣質食物同餐保護 + 不影響晚餐鋅吸收），晚餐蔬菜選低植酸品種（櫛瓜、大白菜、高麗菜、小白菜）', 'daily', '飲食', 22, 1, true),
  ('全天 每 45 分鐘站立/坐姿切換', '維持脂蛋白脂肪酶 LPL 活性，避免久坐代謝下降', 'daily', '運動', 23, 1, true),
  ('全天 碳水循環：訓練日 vs 休息日', '重訓日 5-6g/kg (360-430g)、有氧日 3-4g/kg (215-290g)、休息日 2-3g/kg (145-215g，僅 Deload 週或臨時休息)。支持 mTOR 肌肉修復與合成。⚠️ 高碳水日嚴格執行 30-40% 替換為低纖維來源（白米飯、義大利麵、去皮馬鈴薯）以控制總纖維量。⚠️ 重訓日（一二四五）晚餐零葉菜+零抗性澱粉，但保留少量煮熟去皮櫛瓜（微量纖維緩衝血糖波動，不產氣）：僅保留新鮮熱白米飯/去皮馬鈴薯/義大利麵 + 去皮櫛瓜 50-100g（禁止冷卻米飯/地瓜 — 抗性澱粉在腸道後段發酵產氣比葉菜纖維更強），避免纖維 + 睡前甘胺酸鎂（高滲透壓）疊加 → 夜間滲透性腹脹干擾睡眠。⚠️ 非重訓日晚餐蔬菜：選低植酸品種（櫛瓜、大白菜、高麗菜、小白菜），菠菜安排在午餐（保護鋅吸收）。📋 重訓日碳水分配範例（目標 400g）：訓練前 地瓜 200g ≈ 50g 碳水 / 午餐 白米飯 300g（乾重 120g）≈ 90g + 冷卻米飯 150g ≈ 45g = 135g / 下午點心 香蕉 1 根 ≈ 27g / 晚餐 新鮮熱白米飯 250g ≈ 75g + 義大利麵 100g（乾重）≈ 75g = 150g / 零食加餐 燕麥 40g ≈ 28g。合計 ≈ 390g。⚠️ 抗性澱粉保留在午餐（冷卻再加熱米飯），晚餐以新鮮熱食為主減少腸道發酵。優先監控脹氣反應：若出現腹脹→當餐立即減少十字花科蔬菜、增加低纖維碳水佔比。卡路里目標：重訓日 3,100-3,400 kcal', 'daily', '飲食', 24, 1, true),
  ('全天 週末睡眠一致性（±30 分鐘）', '週末起床/睡覺時間與平日偏差不超過 30 分鐘。社交時差（Social Jetlag）影響認知、情緒與代謝，A 級證據', 'daily', '睡眠', 25, 1, false),
  ('全天 數位衛生', '娛樂螢幕 <2hr、社群媒體 <30min。23:00 後無螢幕、專注時段手機勿擾模式', 'daily', '心理', 26, 1, false),
  ('全天 鈣攝取確認（目標 1000mg）', '每日確認鈣攝取是否達標 1000mg。主要來源：希臘優格 200-300g（~200-300mg）+ 深綠蔬菜 + 豆腐。⚠️ 飲食鈣優先原則：若當日已攝取希臘優格 300g（~300mg）+ 豆腐/蔬菜（~200mg）≥ 500mg，可考慮不補鈣片，避免高劑量鈣抑制午餐鐵鋅吸收。⚠️ 若確認需補鈣 → 鈣片 500mg 隨午餐服用（碳酸鈣需充足胃酸解離吸收，空腹服用吸收率極低且易脹氣便秘）。✅ 草酸鈣正確觀念：鈣與草酸在「腸道」同餐結合 → 不溶性草酸鈣隨糞便排出（保護機制）。若刻意將鈣與高草酸食物分開，游離草酸反而被大量吸收入血 → 在「腎臟」與尿鈣結合形成結石。因此：高草酸蔬菜（菠菜）搭配含鈣食物（如午餐優格或鈣片）同餐食用才是正確防結石策略。⚠️ 補鈣日午餐蛋白質改選低鐵/低鋅來源（魚肉、豆腐），避免紅肉/蛋（高劑量鈣 500mg 明顯抑制非血基質鐵及鋅吸收）。✅ 補鈣當日維持 D3 1000IU：總攝取 1150IU（鈣片 150 + 獨立 1000）安全低於 UL 4000IU/日。💧 補鈣日飲水目標 3.5L+（稀釋尿鈣）。禁止睡前服用鈣片（鈣與鎂競爭 DMT1 載體）。09:05 碘鹽 → 12:00 鈣（隨餐）→ 16:00 銅 → 19:00 鋅（最後一口），各間隔充足', 'daily', '飲食', 25, 1, true),
  ('全天 飲水 3-3.5L', '尿液淡黃色為適當水合指標。有氧日訓練中改用電解質粉。💧 補鈣日飲水目標 3.5L+（稀釋尿鈣，降低結石風險）', 'daily', '飲食', 26, 1, true);

------------------------------------------------------------
-- 每週計畫項目 (3 active + 3 semi-active/inactive)
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('Zone 2 有氧 2 次', '週六、週日各 45-60 分鐘。心率 60-70% HRmax。腳踏車/飛輪/划船機。⚠️ Zone 2 日補水策略：09:05 補水改用電解質粉沖泡（CGN Sport Hydration），訓練中持續飲用電解質水維持水合', 'weekly', '運動', 1, 2, true),
  ('肌力訓練 4 次（Upper/Lower）', '一上半身A/二下半身A/四上半身B/五下半身B。每肌群每週 12-20 組，分 2 次訓練。3 週漸進超負荷 + 第 4 週 Deload（量減 40-50%，強度維持 85%）。記錄每組重量/次數', 'weekly', '運動', 2, 4, true),
  ('VO2 Max 訓練 1 次', 'Peter Attia 4×4 法 — 4 分鐘全力（90-95% HRmax）+ 4 分鐘恢復 × 4 組。週三進行', 'weekly', '運動', 3, 1, true),
  ('學習新技能', '樂器或語言學習最佳（結構性神經可塑性證據最強）。20-30 分鐘練習後安排運動，有助記憶鞏固。NSDR 也可在學習後使用', 'weekly', '心理', 4, 3, true),
  ('鋅 25mg 補充', '每週 1-2 次服用鋅 25mg（Zinc Picolinate 半顆），建議週二、週六隨晚餐服用。與銅間隔 4hr+。降低長期高劑量風險，維持鋅銅比 10-15:1', 'weekly', '補充品', 12, 2, false),
  ('Quercetin + Fisetin 抗氧化抗發炎', '每週集中 2-3 天服用，抗氧化與抗發炎，輔助清除衰老細胞', 'weekly', '補充品', 5, 1, false),
  ('每週回顧與調整', '記錄：1.早晨精神狀態 2.下午能量水平 3.運動後恢復速度 4.體重 7 日均值（目標每月 +0.5-1kg）5.主要複合動作進步。異常時優先調整睡眠與熱量', 'weekly', '一般', 5, 1, false),
  ('【每半年】健康檢測', '每半年一次全面健康檢查。🔴 絕對前提：抽血前 7 天停用肌酸 + 48-72 小時暫停高強度重訓（肌肉修復本身也會顯著升高 Creatinine，與肌酸偽陽性疊加 → eGFR 被嚴重低估）。24 歲高強度重訓 + 高蛋白 113-123g/day，Creatinine 代謝需更長時間回到基準線，3-5 天可能不足。⚠️ 建議加測 Cystatin C：不受肌肉質量及肌酸影響，可與 Creatinine-based eGFR 交叉驗證真實腎功能。必檢指標：BUN（尿素氮）、Creatinine（肌酐）、eGFR（腎絲球過濾率）監測腎功能；ALT/AST 監測肝功能；TSH + Free T4 監測甲狀腺功能（Ashwagandha 可能提升 T4）。⚠️ Ashwagandha 肝功能追蹤：開始服用新品牌後第 4 週及第 12 週各加測 ALT/AST（藥源性肝損傷多發於數週內，勿枯等半年健檢）。🚨 DILI 不限品牌/批次：任何批次服用期間若出現疲累加重、食慾不振或皮膚/眼白微黃 → 立即停用並安排 ALT/AST 抽血（不必等排程）。⚠️ 若 ALT/AST 異常：首位停用 Ashwagandha（偶有肝損傷案例報告），其次停用 CoQ10、葉黃素。🚫 Ashwagandha 禁忌：若正在服用抗憂鬱劑或血清素藥物 → 禁用（血清素綜合徵風險）；甲亢或服用甲狀腺藥物者 → 禁用（甲狀腺風暴風險）。⚠️ 若停用肌酸後 🔴 eGFR <90 分級處置：(1) 首次 eGFR <90 → 下修至 1.6g/kg，3 個月後複檢。(2) 連續兩次 <90 → 強制下修至 1.2g/kg（≈88g/day），轉介腎臟科。其他：血液、荷爾蒙、代謝指標、維他命D、鋅銅比', 'weekly', '一般', 6, 0, true),
  ('【每季】FMD 斷食模擬飲食（5 天）', '每 3-4 月執行 5 天低蛋白/低糖/高脂飲食。清除衰老細胞、重啟免疫系統。FMD 期間停用：肌酸、魚油、NMN、白藜蘆醇', 'weekly', '飲食', 9, 1, false);

------------------------------------------------------------
-- 每日鋅補充（替代舊 weekly 項目）
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('鋅 25mg 每日補充', '每日隨晚餐服用鋅 25mg（Zinc Picolinate 半顆）。與每日銅 2mg 維持 12.5:1 鋅銅比例，防止長期銅缺乏導致貧血與神經損傷。與 16:00 銅間隔 3hr+', 'daily', '補充品', 27, 1, false),
  ('鋅 25mg 每兩天補充', '每兩天隨晚餐服用鋅 25mg（Zinc Picolinate 半顆）。平均每日鋅攝入 12.5mg + 銅 2mg/日 = 鋅銅比約 6.25:1（加上飲食鋅可達 10:1 以上）。與 16:00 銅間隔 3hr+。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 150-180g 已含鋅 6-9mg，無需額外補充', 'daily', '補充品', 27, 1, false),
  ('鋅 15mg 每日補充', '每日晚餐「最後一口」吞服鋅 15mg（Picolinate 錠劑 1 錠）。最後一口服用而非隨餐混吃，最大化與 16:00 銅離子的時間距離（銅鋅共用轉運蛋白 DMT1/ZIP）。補充品 15mg + 飲食鋅 ~10-15mg = 每日總計 25-30mg（安全低於 UL 40mg/日）。⚠️ 鋅吸收關鍵：晚餐（含鋅餐）嚴禁菠菜、未處理豆類等高植酸食物（植酸+草酸強力螯合游離鋅離子，大幅削弱吸收率）。晚餐蔬菜選擇低植酸品種：櫛瓜、大白菜、高麗菜、小白菜。菠菜安排在午餐（午餐有鈣質保護 + 不影響鋅吸收）。⚠️ 牛肉日豁免：草飼牛肉日（每週 1-2 次）當晚取消鋅補劑，牛肉 150-180g 已含鋅 6-9mg，無需額外補充。⚠️ 鋅鈣競爭：晚餐避免高鈣食物（希臘優格移至午餐/點心），高鈣 >200mg 明顯抑制鋅吸收。⚠️ 優格間隔 2hr+：優格最晚 17:00 前食用完畢（17:00 → 19:00 鋅 = 2hr 間隔），或安排在午餐/15:30 點心更佳。⚠️ 補鈣日特別處置：午餐鈣片 500mg 殘餘鈣在腸道停留數小時，與晚餐鋅競爭 DMT1。補鈣日鋅改至睡前（22:00）單獨空腹服用（與晚餐間隔 3hr+、與午餐鈣間隔 10hr），避免鈣鋅競爭。', 'daily', '補充品', 27, 1, true);

------------------------------------------------------------
-- 追蹤項目：油、鹽、藍莓 (4 items)
------------------------------------------------------------

INSERT INTO plan_items (title, description, frequency, category, sort_order, target_count, is_active) VALUES
  ('午餐 橄欖油 14g（1 大匙）',
   '特級初榨橄欖油 1 大匙（14g）入菜或涼拌。確保脂溶性維生素（D3、K2、葉黃素、CoQ10）充分吸收。橄欖油富含單元不飽和脂肪酸（MUFA），支持心血管健康與抗發炎',
   'daily', '脂肪', 18, 1, true),
  ('晚餐 橄欖油 28g（2 大匙）',
   '特級初榨橄欖油 2 大匙（28g）入菜或涼拌。支持每日脂肪目標 80-90g。晚餐較高脂肪有助於延緩胃排空、穩定血糖、增加飽足感',
   'daily', '脂肪', 28, 1, true),
  ('09:05 碘鹽 1g',
   '500ml 室溫水 + 碘鹽 1g（使用食品電子秤測量 0.1g 精度）+ 檸檬汁。碘鹽取代海鹽以確保碘攝取（甲狀腺功能必需）。⚠️ 晨間碘鹽僅 1g 以控制每日總鈉（WHO <2400mg/日），碘攝取主要由食物補足：午晚餐烹調碘鹽 + 每週 2-3 次海帶/紫菜（3-5g 乾海帶即含碘 1500-15000mcg，遠超 RDA 150mcg）。⚠️ 十字花科蔬菜高攝取者碘需求更高（硫代葡萄糖苷干擾甲狀腺碘吸收）。⚠️ Zone 2 日（週六/日）09:05 補水改用電解質粉，碘鹽併入其他餐次',
   'daily', '礦物質', 2, 1, true),
  ('藍莓 50g（抗氧化）',
   '每日 50g 新鮮或冷凍藍莓。富含花青素（Anthocyanins），A 級證據支持改善認知功能、血管健康、抗氧化。可加入燕麥碗、希臘優格、或作為下午點心（15:30）搭配豌豆蛋白',
   'daily', '食物', 20, 1, true);

------------------------------------------------------------
-- Costco 保健品 (4 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '緩釋魚油（Kirkland 新型緩釋 Omega-3）',
  '每 1200mg 魚油含 Omega-3 約 700mg（EPA 419mg + DHA 281mg）。沙丁魚、鯷魚、鯖魚來源，緩釋不打嗝。產地加拿大',
  '每日隨餐 3 顆（EPA+DHA 共 2100mg）',
  'NT$579 / 180 顆',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Kirkland-Signature-Enteric-Omega-3-Fish-Oil-180-Softgel/p/240669',
  'Costco', 'costco_supplement', 'Kirkland Signature 科克蘭', '加拿大',
  $${"ingredients":"魚油(沙丁魚、鯷魚、鯖魚)、明膠(豬來源)、甘油、水、柑橘果膠、D-山梨醇(甜味劑)","form":"軟膠囊","count":"180粒","storage":"請置於陰涼乾燥處，開瓶後請旋緊瓶蓋，並避免陽光直射。","allergens":"本產品含魚可能導致過敏症狀。不添加乳糖、人工色素及麩質。"}$$::jsonb,
  $${"per_serving":"每1200毫克濃縮魚油","omega3_total":"約700毫克","epa":"419毫克","dha":"281毫克"}$$::jsonb,
  '線上可訂（常溫配送）。每日 3 顆，180 顆可用 2 個月。開瓶後旋緊避免氧化，有腥味表示已變質。',
  1
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '鈣片備用（Nature Made Ca+D3+K2 250 錠）',
  '碳酸鈣 + 檸檬酸鈣雙鈣源。純粹作為鈣質備用品。注意：本品含 D3 150IU/錠，與獨立 D3 1000IU 疊加風險低但需留意。K2 僅 10mcg/錠（不足日需量，已改用獨立 K2 MK-7 100mcg）。鈣質食物優先策略：優先從希臘優格等原型食物攝取鈣',
  '備用品：僅在當日飲食鈣攝取確認嚴重不足時才服用 1 錠。日常 K2 已改用獨立 K2 MK-7 產品',
  'NT$759 / 250 錠',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Supplements-Digestive-Support/Nature-Made-Calcium-500-mg-with-D3-K2-250-Tablets/p/228453',
  'Costco', 'costco_supplement', 'NATURE MADE 萊萃美', '美國',
  $${"ingredients":"碳酸鈣(碳酸鈣、麥芽糊精(玉米)、阿拉伯膠)、檸檬酸鈣、微結晶纖維素、維生素K2(麥芽糊精(玉米)、納豆脂質、維生素K2(Menaquinone-7))、羥丙基甲基纖維素、二氧化鈦(著色劑)、聚糊精、硬脂酸鎂、二氧化矽、交聯羧甲基纖維素鈉、滑石粉、麥芽糊精、維生素D3(辛烯基丁二酸鈉澱粉、糖、L-抗壞血酸鈉(抗氧化劑)、二氧化矽、中鏈三酸甘油酯、生育醇(抗氧化劑)、膽鈣化醇)、脂肪酸甘油酯(乳化劑)","form":"錠劑","count":"250錠","storage":"請置於陰涼乾燥處（錠劑常溫即可穩定保存）","allergens":"不添加麩質、防腐劑、化學色素及人工香料。"}$$::jsonb,
  $${"calcium":"500mg/錠","vitamin_d3":"3.75mcg (150IU)/錠","vitamin_k2":"10mcg (MK-7型)/錠"}$$::jsonb,
  '線上可訂（常溫配送）。純鈣備用品（鈣從食物攝取為主），250 錠可用非常久。⚠️ 碳酸鈣需胃酸解離：必須隨餐服用（午餐），空腹吸收率極低且易脹氣便秘。✅ 補鈣當日注意：本品每錠含 D3 150IU，午餐獨立 D3 1000IU 仍正常服用（總計 1150IU 安全低於 UL 4000IU/日）。碳酸鈣+檸檬酸鈣錠劑常溫陰涼處即可穩定保存。',
  2
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '維他命 C（NOW Foods 500mg × 100 錠）',
  '抗氧化、膠原蛋白合成、增強鐵吸收。✅ 500mg 規格每日 1 錠免切，避免 1000mg 切半導致的氧化與劑量不準風險',
  '每日 1 錠（500mg）隨晚餐。午餐膠原蛋白已含 ~160mg，每日總計 ~660mg',
  'NT$250-350 / 100 錠',
  'https://tw.iherb.com/pr/now-foods-c-500-100-tablets/690',
  'iHerb', 'iherb_supplement', 'NOW Foods', NULL,
  $${"ingredients":"抗壞血酸(維生素C)","form":"錠劑","count":"100錠","storage":"請存放於乾燥陰涼處，開封後請旋緊瓶蓋。"}$$::jsonb,
  $${"vitamin_c":"500mg/錠"}$$::jsonb,
  'iHerb 直送。✅ 每日 1 錠（500mg），免切免切藥器。100 錠可用約 3 個月。午餐膠原蛋白已含 ~160mg Vit C，晚餐 1 錠 500mg，每日總計 ~660mg。✅ VitC 與鈣同餐不增加結石風險：鈣在腸道與草酸結合排出，VitC 代謝產生的少量草酸同理。開瓶後標記日期，6 個月內用完。',
  3
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  'Tryall 無調味分離乳清蛋白 2kg',
  '台灣品牌，無調味無添加。分離乳清蛋白（WPI），約 90% 蛋白質含量，每 30g 粉含 ~27g 蛋白、~120kcal。美國乳源，過濾大部分乳糖與脂肪，乳糖不耐者也適合',
  '訓練前 1 份（~30g 粉 ≈ 27g 蛋白）。午餐改為正餐蛋白質，不再額外沖乳清',
  '約 NT$1,899~2,199 / 2kg',
  'https://www.costco.com.tw/Health-Beauty/Supplements/Sports-Performance/Tryall-Whey-Protein-Isolate-Unflavored-2-kg/p/155648',
  'Costco', 'costco_supplement', 'TRYALL',
  NULL, NULL, NULL, '155648', '台灣（品牌）/ 美國（乳源）',
  '{"ingredients":"分離乳清蛋白（美國乳源）","form":"無調味粉末","weight":"2kg","features":"無添加糖、甜味劑、人工色素、香料"}'::jsonb,
  '{"serving_size":"30g","calories":"~120kcal","protein":"~27g","fat":"~2g","carbs":"~3g","bcaa":"~5.3g","protein_pct":"約90%"}'::jsonb,
  'Costco 線上可訂。每日 ~70g，2kg 約 28 天，每月補貨。無調味可搭配咖啡、黑芝麻粉等調味。',
  4
);

------------------------------------------------------------
-- Costco 食材 (19 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '平飼雞蛋（全佑牧場 LL 規格）',
  '高蛋白第一餐，富含亮氨酸 Leucine。冷藏平飼蛋，非籠飼。賣場限定商品',
  '每日 3-4 顆',
  '~NT$274 / 30 入',
  'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/QUAN-YOU-FARM-Cage-Free-Eggs-LL-30-Count/p/128970',
  'Costco', 'costco_food', '全佑牧場', '台灣',
  $${"count":"30入","storage":"冷藏 7°C 以下，離開冷藏時間請勿超過30分鐘，開封後請盡速使用","warehouse_only":true}$$::jsonb,
  '{}'::jsonb,
  '賣場限定，無法線上訂。每日 3-4 顆，30 入約 7-10 天。絕對不要把 30 入紙托直接塞冰箱——買一個雙層抽屜式雞蛋盒（寬約 15cm），貼齊冷藏最底層側邊，上方平面還能繼續疊放保鮮盒。',
  4
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '冷凍鮭魚排（Kirkland 1.36kg）',
  '挪威養殖大西洋鮭魚，優質蛋白 + Omega-3 來源。成分：鮭魚、水、食鹽',
  '每週 3-4 份',
  'NT$1,229 / 1.36kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/Kirkland-Signature-Frozen-Atlantic-Salmon-136-kg/p/1286092',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '挪威',
  $${"ingredients":"養殖鮭魚、水、食鹽","weight":"1.36公斤","storage":"請冷凍-18℃保存。","allergens":"本產品含有鮭魚，食物過敏者，請注意。","cooking":"烤：將烤箱預熱至200℃，將解凍後的鮭魚調味後放在烤盤上烤約10-12分，或直到中心溫度達63℃。"}$$::jsonb,
  '{}'::jsonb,
  '冷凍庫主力，每 2 週線上訂 1 包（冷凍配送）。買回立即分裝 5-6 份 zip bag（佔冷凍約 2.5L），每 2-3 天取 1 份移至冷藏解凍。冷凍庫僅 7L，鮭魚是唯一需要長期冷凍的高價值食材。',
  5
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '新鮮綠花椰菜（傳統市場/超市）',
  '十字花科蔬菜，富含蘿蔔硫素 Sulforaphane（Nrf2 激活劑）。切碎後靜置 40 分鐘可最大化黑芥子酶轉化',
  '每日一份',
  'NT$20-30 / 顆',
  'https://www.pxmart.com.tw',
  '傳統市場 / 全聯 / 頂好', 'costco_food', NULL, '台灣',
  '{"storage":"冷藏3-4天","preparation":"切碎靜置40分鐘最大化蘿蔔硫素","portion":"每次2-3顆"}'::jsonb,
  '{}'::jsonb,
  '每週補貨 2 次，每次買 3-4 顆（每顆約 300-400g，支撐午餐每日一份約 150g，每週需 ~1kg）。切成小朵後靜置 40 分鐘（最大化蘿蔔硫素），裝入有瀝水網底的長方形保鮮盒，冷藏可放 3-4 天。小冰箱用戶不建議買 Costco 冷凍版（454g×4 佔冷凍 3L 直接爆倉）',
  6
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '地瓜',
  '原型碳水來源。訓練前能量補充，晚餐助色氨酸→血清素→褪黑激素。冷卻後產生抗性澱粉（益生元）',
  '訓練前/晚餐適量',
  '~NT$135 / 2.8kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。挑外皮光滑無發芽。每週約 1 袋（2.8kg）。常溫陰涼處可放 1-2 週，勿冷藏。',
  7
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '洋蔥 / 大蒜',
  '膳食纖維與益生元（菊糖 Inulin）來源',
  '日常入菜',
  '~NT$149',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。常溫通風處可保存 2-4 週，耗量低，每月補一次即可。',
  8
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '碘鹽（統一生機 日曬海鹽加碘）',
  '西班牙日曬海鹽 + 碘化鉀。海鹽/玫瑰鹽碘含量極低，十字花科蔬菜攝取量高時需確保碘攝取',
  '日常用鹽，每日少許',
  'NT$179 / 2kg',
  'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/Uni-President-Iodized-Solar-Sea-Salt-2-kg/p/283283',
  'Costco', 'costco_food', '統一生機', '西班牙',
  $${"ingredients":"日曬海鹽、碘化鉀","weight":"2公斤","storage":"常溫","allergens":"本產品與其它含有芒果、大豆、奶類、含麩質之穀物、魚、堅果、芝麻、蕎麥及甲殼類的產品於同一工廠生產，食物過敏者請留意。","notes":"不添加抗結塊劑，若有輕微結塊，品質無虞請安心食用。"}$$::jsonb,
  '{}'::jsonb,
  '線上可訂（常溫配送）。2kg 約可用 6 個月以上（晨間僅 1g/日 + 烹調用鹽）。⚠️ 務必確認為「加碘」版本（包裝標示「碘化鉀」成分）。海鹽/玫瑰鹽碘含量極低。⚠️ 晨間碘鹽僅 1g（電子秤測量），碘攝取主力仰賴午晚餐海帶/紫菜 + 烹調碘鹽，避免晨間高鹽水引發噁心及鈉超標。',
  9
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '檸檬',
  '早晨補水，促進消化',
  '每日半顆',
  '~NT$329 / 2.2kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。選外皮鮮黃有光澤。整顆放保鮮抽屜，切半後用矽膠套包住切面冷藏。每日半顆，約可用 3-4 週。',
  10
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '綜合堅果（Kirkland 1.13kg）',
  '（可選品項）腰果、杏仁、開心果、夏威夷豆、巴西堅果。健康脂肪、鎂、鋅來源',
  '每日一把',
  'NT$599 / 1.13kg',
  'https://www.costco.com.tw/Food-Dining/Snacks/Nuts-Jerky/Kirkland-Signature-Mixed-Nuts-113-kg/p/1669722',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '越南',
  $${"ingredients":"腰果,杏仁,開心果,夏威夷果仁,巴西堅果,花生油,海鹽","weight":"1.13公斤","storage":"未開封時請存放於陰涼乾燥處,開封後請冷藏並請儘速食用完畢","allergens":"本產品含有花生及堅果類製品，食物過敏者請留意","notes":"可能含有堅果碎殼，食用時請小心"}$$::jsonb,
  '{}'::jsonb,
  '（可選）線上可訂（常溫配送）。每日 30g，1.13kg 約 5-6 週。⚠️ 含花生油，過敏者注意',
  11
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '希臘優格（Kirkland 零脂 907g×2）',
  '5 種活菌（保加利亞乳桿菌、嗜熱鏈球菌、嗜酸乳桿菌、雙歧桿菌、乾酪乳桿菌）。零脂，每 100g 含 9.4g 蛋白質。賣場限定商品',
  '每日 200-300g',
  'NT$479 / 907g×2',
  'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/Kirkland-Signature-Chilled-Nonfat-Greek-Yogurt-907-g-X-2-Count/p/599369',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '美國',
  $${"ingredients":"巴氏殺菌發酵脫脂牛奶(巴氏殺菌脫脂牛奶,乳酸菌), 乳酸菌(Lactobacillus bulgaricus, Streptococcus thermophilus, Lactobacillus acidophilus, Bifidobacterium lactis, Lactobacillus casei)","weight":"907公克 X 2入","storage":"冷藏 4°C 以下，開封後請盡速食用完畢","allergens":"本產品含牛奶，食物過敏者請留意","warehouse_only":true,"notes":"無防腐劑、無色素、無麩質、無人工香料、無添加糖"}$$::jsonb,
  $${"protein_per_100g":"9.4g"}$$::jsonb,
  '賣場限定，無法線上訂。每日 200-300g，907g×2 約 6-9 天，每週補貨。兩罐圓筒無法改形狀，緊靠冷藏室最上層深處放置（最低溫區），前方空間留給泡菜疊放。',
  12
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '泡菜（宗家府 冷藏切塊泡菜 120g×6）',
  '韓國產冷藏泡菜，活性乳酸菌來源。成分含白菜、蘿蔔、辣椒、大蒜、韭菜、蝦醬、鯷魚醬。賣場限定商品',
  '每日 50-100g 隨餐',
  '~NT$259 / 120g×6',
  'https://www.costco.com.tw/Warehouse-Only/Food-Beverages/Chilled/JONGGA-Sliced-Kimchi-120-g-X-6-Pack/p/137728',
  'Costco', 'costco_food', '宗家府', '韓國',
  $${"ingredients":"白菜,蘿蔔,米澱粉,辣椒,大蒜,韭菜,果糖,昆布萃取物,鹽,大蔥,鰹魚萃取物,梨,鯷魚醬(鯷魚,鹽),蝦醬(蝦,鹽,鯷魚,玉米糖膠),甜味劑(D-山梨醇,麥芽糖醇),L-麩酸鈉","weight":"720公克","count":"120公克 X 6入","storage":"0°C-7°C","allergens":"本產品含有魚,蝦類及其製品,不適合其過敏體質者食用.","warehouse_only":true}$$::jsonb,
  '{}'::jsonb,
  '賣場限定，無法線上訂。每日 50-100g，120g×6 約 7-14 天，每 1-2 週補貨。小圓罐適合見縫插針：兩兩疊放在優格罐前方，或利用層板間的零碎高度。',
  13
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '酪梨',
  '修復鉀缺口（每顆 ~700mg 鉀）+ 健康單元不飽和脂肪 + 膳食纖維 7g',
  '每日半顆至一顆',
  '~NT$329 / 1.3kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。輕捏微軟代表已熟。未熟室溫放 2-3 天催熟。1.3kg 約 4-5 顆，4-7 天用完。',
  14
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '新鮮菠菜（傳統市場/超市）',
  '低 FODMAP 蔬菜，鉀、鎂、鐵、葉酸來源。搭配維他命C增強鐵吸收',
  '每日 100-150g 入菜',
  'NT$30-50 / 300-400g',
  'https://www.pxmart.com.tw',
  '傳統市場 / 全聯 / 頂好', 'costco_food', NULL, '台灣',
  '{"storage":"冷藏3-5天","preparation":"墊廚房紙巾吸濕","portion":"每週300-400g"}'::jsonb,
  '{}'::jsonb,
  '每週補貨 2 次，每次買 400-500g（支撐每日 100-150g 入菜量，每週需 700-1050g）。放入大保鮮袋、裡面墊一張廚房紙巾吸濕，平放於保鮮抽屜底部，3-5 天內用完。小冰箱用戶不建議買 Costco 冷凍版（500g×6 佔冷凍室 70%）',
  15
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '櫛瓜（美國/加拿大）',
  '低FODMAP蔬菜，腸胃溫和。富含鉀、維他命C、膳食纖維。替代綠花椰菜避免脹氣',
  '每日 100-150g 入菜（晚餐優先）',
  '~NT$100-150 / 300-500g',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, '美國/加拿大',
  '{"storage":"冷藏 5-7 天，不要水洗後再冷藏","preparation":"切片或切丁入菜、涼拌皆可","portion":"每次 100-150g"}'::jsonb,
  '{"per_100g":"17kcal, 蛋白質 1.2g, 碳水 3.1g, 纖維 1.0g, 鉀 261mg"}'::jsonb,
  '每週補貨 1-2 次，每次買 500-700g（支撐晚餐每日 100-150g 入菜，每週需 700-1050g）。選外表光滑無軟爛。裝入大保鮮袋平放保鮮抽屜，5-7 天內用完。低FODMAP首選，腸胃敏感者必備。',
  16
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '大白菜 / 高麗菜 / 小白菜',
  '低草酸、低植酸葉菜，晚餐首選（不干擾鋅吸收）。富含維他命 C、K、鉀、膳食纖維。大白菜草酸僅 ~20mg/100g（菠菜 ~750mg/100g 的 1/37）',
  '晚餐蔬菜首選（搭配鋅服用日），午餐可搭配高草酸蔬菜（有鈣保護）',
  'NT$20-50 / 顆或把',
  'https://www.pxmart.com.tw',
  '傳統市場 / 全聯 / 頂好', 'costco_food', NULL, '台灣',
  '{"storage":"冷藏 3-5 天","varieties":"大白菜（整顆較大，切半使用）、高麗菜（耐儲存 5-7 天）、小白菜（保存期短 2-3 天）"}'::jsonb,
  '{"per_100g":"大白菜 13kcal, 蛋白質 1.1g, 鉀 176mg, 草酸 ~20mg；高麗菜 25kcal, 蛋白質 1.3g；小白菜 13kcal, 蛋白質 1.5g, 鈣 105mg"}'::jsonb,
  '每週補貨 1-2 次。高麗菜最耐儲存（5-7 天），大白菜次之（3-5 天切半保鮮膜包），小白菜最短（2-3 天墊廚房紙巾）。晚餐蔬菜首選：低草酸+低植酸，不干擾鋅吸收。菠菜留給午餐（有鈣質同餐保護 + 不影響鋅）。',
  16
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '乾海帶（昆布）/ 紫菜',
  '天然碘最佳來源，每 3-5g 乾海帶含碘 1500-15000mcg（遠超 RDA 150mcg/日）。同時提供鈣、鐵、膳食纖維。替代高劑量碘鹽以降低鈉攝取',
  '每週 2-3 次午餐加入：海帶味噌湯（3-5g 乾昆布）或涼拌紫菜（1-2 片）',
  'NT$50-150 / 包',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/c/90901',
  '全聯 / 傳統市場 / Costco', 'convenience_daily', NULL, '日本/韓國/台灣',
  '{"storage":"常溫密封保存 6-12 個月","varieties":"昆布（煮湯用）、海帶芽（涼拌用）、紫菜/海苔（直接食用或入湯）","portion":"每次 3-5g 乾重"}'::jsonb,
  '{"per_5g_dry":"碘 1500-15000mcg, 鈣 ~35mg, 鐵 ~0.5mg, 膳食纖維 ~1.5g"}'::jsonb,
  '每月購買 1-2 包即可（乾貨耐儲存）。碘來源首選：3-5g 乾海帶已大幅超過 RDA 150mcg。⚠️ 甲狀腺疾病患者應諮詢醫師後再食用（碘攝取過量亦有風險）。常溫密封保存，開封後放密封袋/罐。',
  17
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '板豆腐（傳統硬豆腐）',
  '優質植物蛋白 + 鈣質來源。100g 板豆腐含鈣 ~150mg + 蛋白質 ~8g。補鈣日低鐵/低鋅蛋白質替代選擇',
  '每週 3-4 次午餐入菜（100-150g），補鈣日優先選用',
  'NT$15-30 / 塊',
  'https://www.pxmart.com.tw',
  '全聯 / 傳統市場 / 便利商店', 'convenience_daily', NULL, '台灣',
  '{"storage":"冷藏 3-5 天，開封後浸水每日換水","varieties":"板豆腐（硬，適合煎炒）、嫩豆腐（軟，適合湯品）","portion":"每次 100-150g"}'::jsonb,
  '{"per_100g":"76kcal, 蛋白質 8.1g, 鈣 150mg, 鐵 1.5mg, 脂肪 4.8g"}'::jsonb,
  '每週補貨 2-3 次（保質期短）。板豆腐鈣含量高（~150mg/100g），是補鈣日的理想蛋白質來源（低鐵低鋅，不受高劑量鈣 500mg 的吸收抑制影響）。建議午餐搭配：板豆腐 150g（~12g 蛋白 + ~225mg 鈣）+ 蔬菜 + 碳水。',
  18
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '牙線（Oral-B / GUM / 3M）',
  '口腔衛生必需品。牙周病菌（P. gingivalis）與心血管疾病、阿茲海默症強相關。牙刷僅清潔 60% 牙面，牙線覆蓋剩餘 40% 齒縫',
  '每日至少 1 次（睡前刷牙後）',
  'NT$50-150 / 盒',
  'https://www.costco.com.tw/Health-Beauty/Oral-Care/Dental-Floss/c/90401',
  'Costco / 全聯 / 便利商店', 'personal_care',
  '每 2-3 個月購買 1 盒。Costco 有大包裝（3 入組更划算）。建議選含蠟牙線（滑順不易卡牙縫）。每日睡前刷牙後使用。',
  42
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '蜂蜜 / 無糖可可粉',
  '豌豆蛋白調味用。無調味豌豆蛋白口感較澀，少量蜂蜜或可可粉可大幅提升適口性與遵從性',
  '15:30 下午點心搭配豌豆蛋白使用',
  'NT$100-300',
  'https://www.costco.com.tw/Food-Dining/Pantry/Honey-Sweeteners/c/90301',
  'Costco / 全聯', 'convenience_daily', NULL, NULL,
  '{"蜂蜜":"每次 5-10g（~15-30kcal），選台灣產龍眼蜜或百花蜜","可可粉":"每次 5g，選無糖純可可粉（如 Hersheys Unsweetened）"}'::jsonb,
  '{"蜂蜜_per_10g":"30kcal, 碳水 8g","可可粉_per_5g":"10kcal, 膳食纖維 1.7g, 鎂 25mg"}'::jsonb,
  '蜂蜜常溫保存（永不過期）；可可粉開封後密封保存 6 個月。每日用量極少（5-10g），一罐可用數月。可可粉額外提供鎂 25mg/5g 及黃酮類抗氧化物。',
  19
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '有機燕麥（桂格有機大燕麥片 935g×2）',
  '澳洲有機燕麥，已完全煮熟。β-葡聚醣降膽固醇，優質碳水 + 膳食纖維 8g/份（GI~55，中升糖）',
  '每日 1 份（80g），訓練後或早餐',
  'NT$439 / 935g×2',
  'https://www.costco.com.tw/Food-Dining/Drinks/Powdered-Drink-Mix-Cereal-Oats/Quaker-Organic-Whole-Oats-935-g-X-2-Count/p/116958',
  'Costco', 'costco_food', 'QUAKER 桂格', '澳洲（原料）/ 台灣（製造）',
  $${"ingredients":"有機燕麥(澳洲)。","weight":"935公克 X 2入","storage":"開封前請置於乾燥陰涼處，開封後請盡速食用完畢。","allergens":"本產品含有含穀蛋白之穀物(燕麥)。","cooking":"直接將本產品置於250c.c.熱開水中三分鐘，均勻攪拌即可。"}$$::jsonb,
  $${"fiber":"8g/份","gi":"約55（中升糖）"}$$::jsonb,
  '線上可訂（常溫配送）。每日 80g，935g×2 約 23 天，每月補一次。開封後密封避免受潮。',
  17
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '香蕉',
  '訓練前後快速碳水，富含鉀。青香蕉含抗性澱粉（益生元）',
  '每日 1-2 根（訓練前後）',
  '~NT$99 / 1.4kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場蔬果區散裝。選微青帶黃放 2-3 天自然熟成。1.4kg 約 7-8 根，4-7 天用完。',
  18
);

-- 雞胸肉大包裝已移除（方案 B：改用冷藏小包，見 convenience_daily 區塊）

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '有機糙米（銀川有機一等糙米 3kg）',
  '花蓮產有機糙米。基礎碳水來源，冷卻後產生抗性澱粉（益生元）。提供膳食纖維與鎂',
  '每日適量，訓練日增加碳水攝取',
  'NT$359 / 3kg',
  'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Greenme-Organic-Brown-Rice-3-kg/p/124095',
  'Costco', 'costco_food', '銀川', '台灣（花蓮）',
  $${"ingredients":"有機糙米","weight":"3公斤"}$$::jsonb,
  '{}'::jsonb,
  '線上可訂（常溫配送）。3kg 約 3-6 週。有機花蓮產。開封後密封避免蟲害，夏天建議冷藏。',
  20
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '咖啡豆 / 研磨咖啡',
  '起床 60-90 分鐘後飲用，咖啡因 200-300mg。多酚抗氧化、增強專注力',
  '每日 1-2 杯，10:30-15:00 之間',
  '~NT$399 / 1.13kg',
  'https://www.costco.com.tw/Coffee-Beans/c/hero_coffeebean',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  '賣場咖啡專區。Kirkland 深焙豆 1.13kg 約 $399 最經濟，可用 1-2 個月。開封後密封或冷凍保存。⚠️ 搭配 L-Theanine 200mg（iHerb NOW Foods）一起服用，構成 A 級 nootropic 組合。',
  21
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '特級初榨橄欖油（Kirkland 2L）',
  '單元不飽和脂肪酸（MUFA）來源，支持脂溶性維他命吸收。抗發炎多酚。產地西班牙',
  '午餐 1 大匙（14g）+ 晚餐 2 大匙（28g）= 每日共 42g',
  'NT$459 / 2L',
  'https://www.costco.com.tw/Food-Dining/Groceries/Cooking-Oil-Sauces/c/90903',
  'Costco', 'costco_food', 'Kirkland Signature 科克蘭', '西班牙',
  $${"ingredients":"100% 特級初榨橄欖油","volume":"2公升","storage":"陰涼避光處，開封後 3-6 個月內用完"}$$::jsonb,
  $${"fat_per_15ml":"14g","mufa":"約10g","calories":"約126kcal"}$$::jsonb,
  '線上可訂（常溫配送）。每日 42g（午餐 14g + 晚餐 28g），2L（≈1840g）約 1.5 個月用完。⚠️ 建議每 1.5 個月補貨，或趁 Costco 促銷時一次購入 2 瓶（3 個月份）。避免高溫油炸（發煙點 ~190°C），涼拌或中低溫烹調最佳。開封後陰涼避光處保存，3-6 個月內用完。',
  22
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '冷凍草飼牛肉片（澳洲）',
  '紅肉提供血基質鐵（吸收率 15-35%）、維他命 B12、天然肌酸。草飼牛肉 Omega-3 較高',
  '每週 1-2 次晚餐（150-180g/次），替代雞胸肉',
  'NT$600-800 / 1kg',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Frozen-Seafood-Meat/c/90701',
  'Costco', 'costco_food', NULL, '澳洲',
  '{"cut":"薄片火鍋肉片或牛排","fat":"選擇瘦部位（如菲力、後腿）","storage":"冷凍 -18°C"}'::jsonb,
  '{"protein_per_100g":"20-25g","iron":"2-3mg（血基質鐵）","b12":"豐富","creatine":"天然含有"}'::jsonb,
  '每週 1-2 次作為紅肉來源，替代 1-2 餐雞胸肉（150-180g/次 ≈ 30-36g 蛋白）。⚠️ 牛肉日可加 1 顆蛋（~42g 仍在安全範圍內），不必為 2.3g 差異造成備餐壓力。⚠️ 牛肉日取消鋅補劑（牛肉 150-180g 已含鋅 6-9mg）。補充血基質鐵（植物鐵吸收率僅 2-20%）與 B12。草飼優於穀飼。瘦部位脂肪 <10g/100g。',
  23
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '綠茶（茶葉/茶包）',
  'EGCG + L-theanine 天然組合，促進專注。多酚抗氧化',
  '每日午餐後 2-3 杯（13:00-15:00）',
  '~NT$200-400',
  'https://www.costco.com.tw/Food-Dining/Drinks/Tea/c/90811',
  'Costco', 'costco_food', NULL, NULL,
  '{}'::jsonb, '{}'::jsonb,
  'Costco 茶飲區或超市購買。散裝綠茶葉 CP 值最高。午餐後 1hr+ 再飲用避免螯合鈣鐵鋅，15:00 前喝完（咖啡因 cutoff）。',
  23
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES (
  '藍莓 / 冷凍莓果',
  '抗氧化花青素含量最高的水果之一。搭配燕麥碗、希臘優格食用。改善認知功能與心血管健康',
  '每日 50-100g（燕麥碗或優格搭配）',
  '新鮮 ~NT$399/510g 或 冷凍 ~NT$329/600g',
  'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
  'Costco', 'costco_food', NULL, '美國/加拿大/智利',
  '{"storage":"新鮮冷藏3-5天，冷凍版-18°C長期保存"}'::jsonb,
  '{"anthocyanins":"花青素豐富","fiber":"約2.4g/100g","vitamin_c":"約10mg/100g"}'::jsonb,
  '新鮮藍莓在 Costco 蔬果區（季節性）。小冰箱建議買新鮮版每週 1 盒（510g），放保鮮抽屜 3-5 天用完。若買冷凍版（Nature''s Touch 600g），僅佔冷凍約 0.5L 可接受。每日取 50-100g 加入燕麥碗或優格。',
  24
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('有機白米（銀川一等白米 3kg）',
   '花蓮產有機白米。低纖維碳水，訓練日30-40%替代糙米以減輕腸胃負擔。易消化，GI較高適合訓練後補充',
   '訓練日適量（目標總碳水30-40%來自低纖維）',
   'NT$320-380 / 3kg',
   'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/c/hero_rice',
   'Costco', 'costco_food', '銀川', '台灣（花蓮）',
   '{"ingredients":"有機白米","weight":"3公斤"}'::jsonb,
   '{"fiber":"低纖維（<1g/100g）","gi":"中高GI（約73）"}'::jsonb,
   '線上可訂（常溫配送）。與糙米混合購買：糙米為基礎，白米作為訓練日高碳日補充。3kg約3-6週（取決於訓練頻率）。開封後密封避免蟲害，夏天建議冷藏。',
   25),

  ('義大利麵（Garofalo 500g×6）',
   '義大利進口杜蘭小麥義大利麵。低纖維碳水，訓練日30-40%替代全麥麵食。煮熟後冷卻可產生抗性澱粉',
   '訓練日適量（作為低纖維碳水選項）',
   'NT$459 / 500g×6',
   'https://www.costco.com.tw/Food-Dining/Groceries/Rice-Noodles/Garofalo-Penne-Rigate-Pasta-500-g-X-6-Pack/p/117346',
   'Costco', 'costco_food', 'Garofalo', '義大利',
   '{"ingredients":"杜蘭小麥粉","weight":"3公斤","count":"500g × 6包","storage":"常溫陰涼乾燥處"}'::jsonb,
   '{"fiber":"低纖維（約2-3g/100g乾麵）","protein":"約12g/100g","gi":"中GI（約55-65，視煮熟度）"}'::jsonb,
   '線上可訂（常溫配送）。500g×6共3kg，每週訓練日1-2餐使用，可用1-2個月。開封後每包密封防潮。常溫存放不佔冰箱空間。Costco另有其他品牌（Barilla, De Cecco）可替換。',
   26),

  ('馬鈴薯（美國/加拿大）',
   '去皮後低纖維碳水，訓練日30-40%替代地瓜。富含鉀（每顆~800mg），冷卻後產生抗性澱粉。選擇黃皮或紅皮較甜',
   '訓練日適量（去皮烹調）',
   '~NT$199 / 3kg',
   'https://www.costco.com.tw/Food-Dining/Frozen-Fresh-Food/Chilled-Fresh-Food/c/90901',
   'Costco', 'costco_food', NULL, '美國/加拿大',
   '{"storage":"陰涼通風處，勿冷藏（會轉甜並影響質地）","notes":"發芽或變綠的馬鈴薯含有毒素（龍葵鹼），務必丟棄"}'::jsonb,
   '{"potassium":"約800mg/顆","fiber":"去皮後低纖維（約1g/100g）","gi":"中高GI（約85-90，視烹調法）"}'::jsonb,
   '賣場蔬果區散裝，約NT$199/3kg（6-8顆）。選外皮光滑無發芽。常溫通風處可放2-3週，勿冷藏。去皮後煮、蒸或烤，冷卻後作為訓練日碳水。每週補1次約可用7-10天。',
   27);

------------------------------------------------------------
-- iHerb 專業補充品 (15 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '肌酸 Creatine Monohydrate（CGN 454g）',
  '養肌肉 + 養腦，改善認知與工作記憶',
  '每日 5g',
  'NT$420 / 454g',
  'https://tw.iherb.com/pr/california-gold-nutrition-sport-creatine-monohydrate-unflavored-1-lb-454-g/71026',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01059/g/144.jpg',
  4.8, 29306, 'CGN-01059',
  $${"ingredients":"一水肌酸","form":"無調味粉末","weight":"454g"}$$::jsonb,
  $${"serving_size":"5g","creatine_monohydrate":"5g"}$$::jsonb,
  'iHerb 直送。每日 5g，454g 可用 90 天（3 個月）。⚠️ 建議設定每 3 個月定期補貨提醒，避免斷供影響肌力維持。🔴 抽血絕對前提：健檢前 7 天必須停用肌酸 + 48-72 小時暫停高強度重訓（肌肉修復也會升高 Creatinine，與肌酸偽陽性疊加 → eGFR 嚴重低估），否則可能誤判腎功能異常。只有停用+休息後的 eGFR 才能反映真實腎功能。CGN 自有品牌常有額外折扣。搭配其他 iHerb 品項湊免運。',
  22
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '甘胺酸鎂 Mg Glycinate（NOW Foods 100mg × 180 錠）',
  '甘胺酸是抑制性神經傳導物質，降低核心體溫助眠。高吸收率',
  '睡前 1 錠（100mg）',
  'NT$399 / 180 錠',
  'https://tw.iherb.com/pr/now-foods-magnesium-glycinate-180-tablets-100-mg-per-tablet/88819',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now01289/g/41.jpg',
  4.8, 30061, 'NOW-01289',
  $${"form":"錠劑","count":"180錠","chelate_type":"TRAACS™ 甘氨酸鎂"}$$::jsonb,
  $${"serving_size":"2錠","magnesium":"200mg（提取自2000mg甘氨酸鎂）"}$$::jsonb,
  'iHerb 直送。每日睡前 1 錠（100mg），180 錠可用 6 個月。⚠️ 產品標示 serving size 為 2 錠 200mg，但本計畫僅用 1 錠（減半策略，避免總鎂過高致腹瀉）。',
  23
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '葉黃素 + 玉米黃素（CGN 20mg × 120 顆）',
  '沉積於視網膜黃斑部，保護眼睛抵禦藍光與氧化傷害',
  '每日 1 顆隨餐（需搭配油脂吸收）',
  'NT$914 / 120 顆',
  'https://tw.iherb.com/pr/california-gold-nutrition-lutein-with-zeaxanthin-from-marigold-extract-120-veggie-softgels/94824',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01403/g/126.jpg',
  4.7, 45894, 'CGN-01403',
  $${"ingredients":"葉黃素（來自萬壽菊提取物）（花）、玉米黃質（來自萬壽菊提取物）（花）","form":"素食軟膠囊","count":"120顆","source":"mGold™ 萬壽菊花提取物"}$$::jsonb,
  $${"serving_size":"1顆","lutein":"20mg","zeaxanthin":"含玉米黃質"}$$::jsonb,
  'iHerb 直送。每日 1 顆，120 顆可用 4 個月。CGN 自有品牌 CP 值高。需隨含油脂餐食服用。',
  24
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '鋅 Zinc Picolinate（NOW Foods 15mg × 120 錠）',
  '免疫與睪固酮合成必需。每日 15mg 錠劑，含飲食鋅（雞蛋 ~5mg + 肉類 ~5-12mg + 堅果 ~2-3mg）總計不超過 UL 40mg/日。Picolinate 形式吸收率優於其他形式。錠劑可精確控量（膠囊粉末無法掰半）',
  '每日隨晚餐服用 1 錠（15mg），與銅 2mg 維持平衡',
  'NT$250-350 / 120 錠',
  'https://tw.iherb.com/pr/now-foods-zinc-picolinate-30-mg-100-veg-capsules/733',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now01552/g/57.jpg',
  4.8, 46833, 'NOW-01552',
  $${"form":"錠劑","count":"120錠","chelate_type":"吡啶甲酸鋅"}$$::jsonb,
  $${"serving_size":"1錠","zinc":"15mg"}$$::jsonb,
  'iHerb 直送。✅ 15mg 錠劑（非 50mg 膠囊），可精確控量。每日 1 錠，120 錠可用 4 個月。含飲食鋅（蛋 ~5mg + 肉 ~5-12mg）每日總鋅攝取 25-32mg，安全低於 UL 40mg。⚠️ 晚餐「最後一口」吞服：非隨餐混吃，最大化與 16:00 銅的時間距離。⚠️ 鋅吸收關鍵：晚餐（含鋅餐）嚴禁菠菜等高植酸蔬菜（螯合鋅離子），改用櫛瓜、大白菜等低植酸品種。⚠️ 牛肉日豁免：牛肉 150-180g 已含鋅 6-9mg，當晚不服鋅補劑',
  25
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '銅 Copper Bisglycinate（Solaray 2mg × 100 顆）',
  '長期補鋅必須搭配銅。甘胺酸銅吸收率優於檸檬酸銅。隨低鈣/低鐵小點心服用，避免空腹噁心。不與鋅、鈣、鐵等礦物質競爭。鋅銅比維持 10-15:1，防止銅缺乏導致貧血與神經損傷',
  '非紅肉日每日 1 顆，下午 16:00 隨低鈣/低鐵小點心服用（少量水果或餅乾，避免空腹噁心）。⚠️ 牛肉日免補銅。⚠️ 嚴格避開優格/牛奶等含鈣食物，鈣與銅共用 DMT1 競爭吸收',
  'NT$217 / 100 顆',
  'https://tw.iherb.com/pr/solaray-copper-2-mg-100-vegcaps/70102',
  'iHerb', 'iherb_supplement', 'Solaray',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/sor/sor45931/g/37.jpg',
  4.7, 17219, 'SOR-45931',
  $${"form":"素食膠囊","count":"100顆","chelate_type":"銅氨基酸螯合物"}$$::jsonb,
  $${"serving_size":"1顆","copper":"2mg"}$$::jsonb,
  'iHerb 直送。非紅肉日每日 1 顆，100 顆可用 4 個月+（因牛肉日免補）。⚠️ 16:00 隨小點心服用（非嚴格空腹）：銅離子空腹刺激性高，易引發噁心嘔吐。⚠️ 嚴格避開優格/牛奶等含鈣食物，鈣與銅共用 DMT1 競爭吸收。⚠️ 牛肉日免補銅：牛肉 150-180g 含銅 ~0.1-0.2mg + 堅果一把含銅 ~0.3-0.5mg + 飲食其他來源，當日銅攝取已足夠，額外補 2mg 可能逼近 UL 10mg/日。與晚餐鋅間隔 3hr+',
  26
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '維他命 D3 1000IU（NOW Foods 180 顆）',
  '每日服用 1 顆（1000 IU）。目標血清 25(OH)D 40-60 ng/mL。血檢達標+每日晨光曝曬→可進一步減量。✅ 1000IU 軟凝膠，每日 1 顆免切',
  '每日 1 顆（1000 IU）隨訓練後餐（需搭配油脂吸收）',
  'NT$300-400 / 180 顆',
  'https://tw.iherb.com/pr/now-foods-vitamin-d-3-high-potency-1-000-iu-180-softgels/10421',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  NULL,
  4.8, NULL, 'NOW-00375',
  $${"form":"軟凝膠","count":"180顆"}$$::jsonb,
  $${"serving_size":"1顆","vitamin_d3":"25微克（1000IU）"}$$::jsonb,
  'iHerb 直送。✅ 每日 1 顆（1000IU），無需切割。180 顆可用 6 個月。脂溶性，務必隨含油脂午餐服用。',
  27
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '維他命 K2 MK-7（NOW Foods 100mcg × 120 顆）',
  '獨立 K2 MK-7（納豆來源），引導鈣質沉積至骨骼而非血管壁。與 D3 協同作用，防止動脈鈣化。取代鈣片複方中不足量的 K2',
  '每日 1 顆隨午餐（與 D3、魚油同服，脂溶性需油脂）',
  'NT$887 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-mk-7-vitamin-k-2-100-mcg-120-veg-capsules/78992',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00993/g/86.jpg', 4.8, NULL, 'NOW-00993',
  $${"form":"素食膠囊","count":"120顆","source":"MK-7（納豆來源）"}$$::jsonb,
  $${"serving_size":"1顆","vitamin_k2":"100mcg（MK-7型）"}$$::jsonb,
  'iHerb 直送。每日 1 顆，120 顆可用 4 個月。MK-7 型半衰期長（~72hr），每日 1 顆即可維持穩定血中濃度。取代 Nature Made 鈣片複方中僅 10mcg 的不足 K2。',
  28
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'L-Theanine（NOW Foods Double Strength 200mg × 120 顆）',
  '搭配咖啡的最強 nootropic 組合（A 級證據）。促進專注 + 放鬆，消除咖啡因焦慮感。120 顆大包裝更划算',
  '每日 1 顆（200mg）隨咖啡。綠茶日直接跳過（膠囊無法減半）',
  'NT$399 / 120 顆',
  'https://tw.iherb.com/pr/now-foods-double-strength-l-theanine-200-mg-120-veg-capsules/54096',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00148/g/32.jpg',
  4.7, 16952, 'NOW-00148',
  $${"form":"素食膠囊","count":"120顆"}$$::jsonb,
  $${"serving_size":"1顆","l_theanine":"200mg"}$$::jsonb,
  'iHerb 直送。Double Strength 200mg 素食膠囊。每日 1 顆隨 11:15 咖啡服用。⚠️ 綠茶日直接跳過整顆（200mg 膠囊無法精準減半，拆開估量誤差大且粉末易受潮），不需執著於減半。60 顆約可用 2 個月。搭配其他 iHerb 品項湊免運。',
  29
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '膠原蛋白肽 CollagenUP（CGN 206g）',
  '水解海洋膠原蛋白肽 + 玻尿酸 + 維他命 C（每 6.5g 含 80mg Vit C）。午餐服用 10-15g 已提供 ~120-160mg Vit C，與晚餐 500mg 合計每日 ~660mg，無需額外疊加。每日隨午餐服用（含鈣食物同餐攝取可在腸道結合草酸，無需錯開）',
  '每日 10-15g 隨午餐（已含 Vit C ~160mg）',
  'NT$1,279 / 206g',
  'https://tw.iherb.com/pr/california-gold-nutrition-collagenup-marine-hydrolyzed-collagen-hyaluronic-acid-vitamin-c-unflavored-7-26-oz-206-g/64903',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01033/g/255.jpg', 4.7, NULL, 'CGN-01033',
  $${"ingredients":"水解海洋膠原蛋白肽、玻尿酸、維他命C","form":"無調味粉末","weight":"206g"}$$::jsonb,
  $${"serving_size":"6.5g","collagen_peptides":"5.1g","hyaluronic_acid":"18mg","vitamin_c":"80mg"}$$::jsonb,
  'iHerb 直送。每日 10-15g，206g 約可用 2-3 週。已內含維他命 C（~160mg/份），與晚餐 500mg Vit C 合計每日 ~660mg（充足且不過量）。✅ 草酸鈣正確觀念：VitC 與鈣同餐攝取不會增加結石風險（腸道結合排出），因此膠原蛋白無需與鈣片錯開時間。搭配其他 iHerb 品項湊免運。',
  30
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'CoQ10 Ubiquinol 200mg（NOW Foods 60 顆）',
  '還原型輔酶 Q10（Ubiquinol），生物利用率高於 Ubiquinone。支持細胞能量產生與心血管健康。脂溶性，與魚油同服提升吸收',
  '每日 1 顆隨午餐（搭配魚油）',
  'NT$1,109 / 60 顆',
  'https://tw.iherb.com/pr/now-foods-ubiquinol-200-mg-60-softgels/23657',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now03144/g/38.jpg', 4.8, NULL, 'NOW-03144',
  $${"form":"軟膠囊","count":"60顆"}$$::jsonb,
  $${"serving_size":"1顆","ubiquinol":"200mg"}$$::jsonb,
  'iHerb 直送。每日 1 顆，60 顆可用 2 個月。脂溶性，務必隨含油脂餐食服用。',
  31
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'B群 活化型態（NOW Foods B-50 Coenzyme 60 顆）',
  '✓ iHerb 必買。活化型態 B 群複方：甲鈷胺（Methylcobalamin B12）、5-MTHF 葉酸（非合成 Folic Acid）、P5P（活化 B6）。應對 MTHFR 基因變異風險，確保 B 群被有效利用。水溶性，需隨餐服用以利能量代謝、神經系統與紅血球生成',
  '每日 1 顆隨早餐（訓練前營養餐，需搭配地瓜或香蕉）',
  'NT$450-550 / 60 顆',
  'https://tw.iherb.com/pr/now-foods-coenzyme-b-complex-60-veg-capsules/14804',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00420/g/74.jpg', 4.7, NULL, 'NOW-00427',
  $${"form":"素食膠囊","count":"60顆","type":"Coenzyme（活化型態）"}$$::jsonb,
  $${"serving_size":"1顆","b12":"甲鈷胺 Methylcobalamin","folate":"5-MTHF（非 Folic Acid）","b6":"P5P（活化型態）"}$$::jsonb,
  'iHerb 必買品項。✅ 活化型態（Coenzyme）優於普通合成 B-50：甲鈷胺 B12（非氰鈷胺）、5-MTHF 葉酸（非 Folic Acid，應對 MTHFR 基因變異）、P5P B6。每日 1 顆隨 09:15 早餐，60 顆可用 2 個月。水溶性需隨餐服用（地瓜推薦，或香蕉），尿液變黃為正常現象（B2 代謝）',
  32
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '豌豆蛋白 Pea Protein（Tryall 1kg）',
  '台灣品牌 Tryall，非乳製植物蛋白，中速消化。下午點心時段服用，分散每日蛋白質攝取至 4-5 餐。無大豆、無乳製品、無麩質。與 Tryall 乳清同品牌，品質一致',
  '下午點心 ~20g 粉（≈16g 蛋白），約 15:30',
  '約 NT$800-1,000 / 1kg',
  'https://www.tryall.com.tw',
  'Costco', 'iherb_supplement', 'TRYALL',
  NULL, NULL, NULL, NULL,
  $${"ingredients":"豌豆蛋白分離物","form":"無調味粉末","weight":"1kg","brand":"Tryall"}$$::jsonb,
  $${"serving_size":"33g","protein":"~24g","fat":"~2g","carbs":"~1g"}$$::jsonb,
  'Tryall 官網或 Costco 線上可訂。每日 ~20g，1kg 可用約 50 天。無調味可搭配少量蜂蜜或可可粉。下午 15:30 服用，分散蛋白質攝取。與 Tryall 乳清同品牌，統一採購更方便',
  33
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '甘胺酸 Glycine Pure Powder（NOW Foods 454g）',
  '抑制性神經傳導物質，降低核心體溫促進深層睡眠。參與膠原蛋白合成與肌酸生成',
  '睡前 3g（約半茶匙）',
  'NT$710 / 454g',
  'https://tw.iherb.com/pr/now-foods-glycine-pure-powder-1-lb-454-g/615',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now00225/g/32.jpg', 4.8, NULL, 'NOW-00225',
  $${"ingredients":"甘胺酸","form":"純粉末","weight":"454g"}$$::jsonb,
  $${"serving_size":"3g","glycine":"3g"}$$::jsonb,
  'iHerb 直送。每日 3g，454g 可用 5 個月。微甜味，可直接加入豌豆蛋白一起沖泡。',
  34
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '蘇糖酸鎂 Magtein（NOW Foods 90 顆）',
  '唯一可穿越血腦屏障的鎂型態（鎂 L-蘇糖酸鹽）。改善認知功能與睡眠品質',
  '睡前 3 顆（元素鎂 ~144mg）',
  'NT$874 / 90 顆',
  'https://tw.iherb.com/pr/now-foods-magtein-magnesium-l-threonate-90-veg-capsules/57577',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now02390/g/50.jpg', 4.8, NULL, 'NOW-02390',
  $${"form":"素食膠囊","count":"90顆"}$$::jsonb,
  $${"serving_size":"3顆","magnesium_l_threonate":"2000mg","elemental_magnesium":"144mg"}$$::jsonb,
  'iHerb 直送。每日 3 顆，90 顆僅可用 30 天（⚠️ 每月必須補貨）。建議與甘胺酸鎂（180 錠/3 個月）合併訂購以節省運費：每 3 個月訂 3 罐蘇糖酸鎂 + 1 罐甘胺酸鎂。與甘胺酸鎂搭配使用，注意總鎂量。',
  35
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  'Ashwagandha KSM-66（NOW Foods 90 顆）',
  'KSM-66 全譜根部萃取，降低皮質醇、改善壓力與睡眠品質。RCT 支持的適應原草藥',
  '睡前 1 顆（450mg）。8 週用 / 4 週停',
  'NT$288 / 90 顆',
  'https://tw.iherb.com/pr/now-foods-ashwagandha-standardized-extract-450-mg-90-veg-capsules/310',
  'iHerb', 'iherb_supplement', 'NOW Foods',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/now/now04603/g/83.jpg', 4.7, NULL, 'NOW-04603',
  $${"form":"素食膠囊","count":"90顆","extract":"KSM-66 全譜根部萃取"}$$::jsonb,
  $${"serving_size":"1顆","ashwagandha_extract":"450mg"}$$::jsonb,
  'iHerb 直送。⚠️ 8 週用期（56 天）每日 1 顆，每瓶 90 顆可完成 1 個完整週期（56 顆用 + 剩 34 顆留下一輪）。建議在瓶身標記「開始日」與「第 56 天停用日」，並設定手機鬧鐘提醒。停用期 4 週替代：甘胺酸鎂 + Cyclic Sighing。⚠️ 情緒冷漠為「強制停用」信號：即使未滿 8 週也必須立即停用，不可因週期未滿而繼續服用。⚠️ 第 6 週起留意情緒冷漠 → 立即停用。若 ALT/AST 異常 → 首位停用本品。⚠️ 肝功能追蹤：新品牌開始後第 4 週、第 12 週各追蹤 ALT/AST（藥源性肝損傷多發於數週內）。🚫 甲狀腺即時停用：若 TSH/Free T4 異常 → 立即停用並就醫。🚫 血清素藥物禁忌（SSRIs/SNRIs）→ 禁用。🚫 感冒/免疫啟動時立即暫停，待康復後再恢復。🚨 肝毒性實體症狀（不限品牌/批次）：異常疲累、食慾不振 ≥2天、皮膚/眼白微黃、右上腹不適 → 任一出現即刻停用並抽血 ALT/AST。',
  36
);

INSERT INTO products (name, description, usage, price, url, store, category, brand, image_url, rating, review_count, sku, specs, nutrition, purchase_note, sort_order) VALUES (
  '電解質粉 Sport Hydration（CGN 20 包）',
  '鈉、鉀、鎂、鈣電解質補充。有氧訓練日維持水合與電解質平衡',
  '有氧日訓練中 1 包沖 500ml 水',
  'NT$600 / 20 包',
  'https://tw.iherb.com/pr/california-gold-nutrition-hydrationup-electrolyte-drink-mix-variety-pack-20-packets-0-14-oz-0-17-oz-4-g-4-8-g-each/94823',
  'iHerb', 'iherb_supplement', 'California Gold Nutrition',
  'https://cloudinary.images-iherb.com/image/upload/f_auto,q_auto:eco/images/cgn/cgn01402/g/75.jpg', 4.5, NULL, 'CGN-01402',
  $${"form":"沖泡粉末","count":"20包"}$$::jsonb,
  $${"serving_size":"1包","sodium":"250mg","potassium":"150mg"}$$::jsonb,
  'iHerb 直送。有氧日每次 1 包，每週 2 次（週六/日），20 包約 10 週。每年需約 5-6 盒。💡 建議一次購入 3 盒（半年份），匹配每半年一次的體檢與補劑調整週期，避免有氧日斷貨。CGN 自有品牌有折扣，3 盒同購可湊 iHerb 免運門檻。',
  37
);

------------------------------------------------------------
-- 設備 (3 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '防藍光眼鏡（琥珀色鏡片）',
  '阻擋 400-550nm 藍光，保護褪黑激素分泌',
  '22:00 後佩戴',
  'NT$500~1,500',
  'https://www.amazon.com/amber-blue-light-blocking-glasses/s?k=amber+blue+light+blocking+glasses',
  'Amazon', 'equipment',
  '一次性購買，Amazon 或蝦皮。選琥珀色鏡片才有效阻擋藍光。$500-1,500 即可。',
  37
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '食品電子秤',
  '精準測量蛋白粉、食材重量、每日碘鹽（0.1g 精度）。確保每日蛋白質及碘攝取達標',
  '每餐使用，精度 0.1g',
  'NT$300~800',
  'https://www.amazon.com/digital-kitchen-food-scale/s?k=digital+kitchen+food+scale',
  'Amazon', 'equipment',
  '一次性購買，Amazon 或蝦皮。精度 0.1g，最大秤量至少 5kg。$300-800 即可。⚠️ 碘鹽每日用量 1g 需精確測量（1/4 茶匙量勺 ≈ 1.4g 誤差過大），電子秤為唯一可靠工具。',
  38
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '全遮光窗簾',
  '確保臥室全黑環境，維持褪黑激素正常分泌。配合 00:00 入睡方案',
  '安裝於臥室窗戶',
  'NT$1,000~3,000',
  'https://www.amazon.com/100-percent-blackout-curtains/s?k=100+percent+blackout+curtains',
  'Amazon', 'equipment',
  '一次性購買。量好窗戶尺寸，選「100% blackout」標示。邊緣可用魔鬼氈輔助密封。',
  39
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '電子鍋（多功能）',
  '⚡ 優先採購（若尚未持有）。煮飯、蒸地瓜/馬鈴薯、燉雞胸肉、煮燕麥粥。一鍋多用是小廚房核心設備。選 3-6 人份（1.0-1.8L 內鍋）適合一人備餐',
  '每日使用（煮飯、蒸菜、燉肉）',
  'NT$1,500-4,000',
  'https://www.costco.com.tw/TVs-Electronics/Home-Appliances/Rice-Cookers/c/90118',
  'Costco/momo/蝦皮', 'equipment',
  '⚡ 若尚未持有請優先購入。一次性購買。推薦：象印微電腦電子鍋 3 人份（~$2,500-4,000，煮飯品質佳，有預約定時功能可前晚設定早上煮好）或大同電子鍋 6 人份（~$1,800，經典耐用）。Costco 線上有多款可比較。',
  40
);

INSERT INTO products (name, description, usage, price, url, store, category, purchase_note, sort_order) VALUES (
  '1/4 茶匙不鏽鋼量勺',
  '（非必要品）其他調味料粗略量測用途。⚠️ 不適合碘鹽精確測量：1/4 茶匙實測約 1.4g（非 1g），誤差 40%。碘鹽精確測量請使用食品電子秤（0.1g 精度）',
  '（備用）其他調味料或烘焙粗略量測，非碘鹽使用',
  'NT$50-150',
  'https://www.amazon.com/measuring-spoons-stainless-steel/s?k=measuring+spoons+stainless+steel',
  'Amazon', 'equipment',
  '（可選）若已有食品電子秤則無需購買。⚠️ 碘鹽（每日 1g）必須使用食品電子秤測量（精度 0.1g），量勺誤差過大不可用於碘鹽。量勺僅適合調味料/烘焙等不需精確的場合。',
  41
);

------------------------------------------------------------
-- 個人保養 Personal Care (4 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('防曬乳（Neutrogena/La Roche-Posay SPF 50+）',
   '廣譜 UVA/UVB 防護，SPF 50+ PA++++。物理+化學防曬，質地清爽不油膩。防曬是#1抗皮膚老化措施',
   '每日早上外出前，全臉頸部（約1/4茶匙）',
   'NT$350-600 / 50-100ml',
   'https://www.watsons.com.tw/sunscreen',
   '屈臣氏/康是美/iHerb', 'personal_care', 'Neutrogena / La Roche-Posay / Biore', '美國/法國/日本',
   '{"spf":"SPF 50+ PA++++","volume":"50-100ml","features":"廣譜防曬,防水配方"}'::jsonb,
   '{}'::jsonb,
   '屈臣氏/康是美實體購買可試質地。Neutrogena Ultra Sheer約$400/88ml（CP值高），La Roche-Posay Anthelios約$600/50ml（敏感肌），Biore Aqua Rich約$350/50ml（清爽款）。每日使用，50ml約1個月。',
   40),

  ('洗面乳（CeraVe Hydrating Cleanser 236ml）',
   '胺基酸溫和潔面，含神經醯胺+玻尿酸，不破壞皮膚屏障。pH平衡配方適合每日早晚使用',
   '早晚各一次，溫水洗臉',
   'NT$420 / 236ml',
   'https://tw.iherb.com/pr/cerave-hydrating-facial-cleanser-8-fl-oz-236-ml/69325',
   'iHerb/屈臣氏/康是美', 'personal_care', 'CeraVe', '美國',
   '{"volume":"236ml","ph":"pH 5.5-6 (接近皮膚自然pH)","features":"無香料,無皂鹼,低敏配方"}'::jsonb,
   '{}'::jsonb,
   'iHerb 直送 NT$420/236ml（最划算）。屈臣氏/康是美也有販售但容量較小。每日2次，236ml約3個月。CeraVe 是皮膚科醫師推薦品牌，含神經醯胺修復皮膚屏障。替代品：Cetaphil 溫和潔膚乳（約$400/200ml）。',
   41),

  ('保濕乳液（CeraVe Moisturizing Cream 340g）',
   '含玻尿酸+神經醯胺+甘油，MVE 緩釋技術24小時保濕。無香料低敏配方，洗臉後立即使用鎖水',
   '早晚洗臉後立即使用（臉頸部）',
   'NT$566 / 340g',
   'https://tw.iherb.com/pr/cerave-moisturizing-cream-12-oz-340-g/69326',
   'iHerb/屈臣氏/康是美', 'personal_care', 'CeraVe', '美國',
   '{"volume":"340g","features":"MVE緩釋技術,24小時保濕,無香料,無油配方"}'::jsonb,
   '{}'::jsonb,
   'iHerb 直送 NT$566/340g（大包裝划算）。每日2次，340g約3-4個月。同品牌與洗面乳搭配使用效果佳。替代品：Cetaphil 長效潤膚乳（約$550/350ml）或平價選項如Neutrogena水活保濕凝露（約$300/100g）。',
   42),

  ('A醇精華 0.5% + Vit C 精華（The Ordinary）',
   'A醇（晚）：0.5%濃度適合進階使用，促進細胞更新與膠原蛋白生成。Vit C（早）：抗氧化+促進膠原蛋白，防曬前使用增強防護',
   'A醇每週2-3次晚上（保濕後），Vit C每日早上（洗臉後）',
   'A醇 NT$440/30ml + Vit C NT$550/30ml',
   'https://tw.iherb.com/pr/the-ordinary-retinol-0-5-in-squalane-1-fl-oz-30-ml/90058',
   'iHerb/屈臣氏', 'personal_care', 'The Ordinary / Timeless', '加拿大',
   '{"a醇":"0.5% in Squalane基底,30ml","vit_c":"20% L-Ascorbic Acid + Vit E + Ferulic Acid,30ml","storage":"避光陰涼處,Vit C開封後冷藏"}'::jsonb,
   '{}'::jsonb,
   'iHerb 購買最划算。A醇：從0.2%開始適應→0.5%→1%漸進提升。初期每週1次，無刺激後增至2-3次。若出現脫皮紅癢→暫停數日。Vit C：選L-Ascorbic Acid形式（效果最佳但需冷藏）。開封後3個月內用完避免氧化。兩者不可同時使用（A醇晚，Vit C早）。',
   43);

------------------------------------------------------------
-- 便利超商日購 Convenience Store Daily (7 items)
------------------------------------------------------------

INSERT INTO products (name, description, usage, price, url, store, category, brand, origin, specs, nutrition, purchase_note, sort_order) VALUES
  ('香蕉（單顆，已熟）',
   '便利超商每日新鮮香蕉，已達最佳熟度。訓練前快速碳水，富含鉀（每根 ~400mg）',
   '訓練前 1-2 根，或每日點心',
   'NT$10-12 / 根',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店', 'convenience_daily', NULL, '台灣 / 菲律賓',
   '{"ripeness":"已熟即食","storage":"常溫1-2天或冷藏3-4天"}'::jsonb,
   '{"potassium":"約400mg/根","carbs":"約27g/根","calories":"約105kcal/根"}'::jsonb,
   '每 2-3 天買 1-2 根。優點：零熟度追蹤、即買即食。比 Costco 散裝 1.4kg 每根貴 NT$2-4，但省冰箱空間 + 保證熟度。訓練日建議每日採購。',
   50),

  ('茶葉蛋',
   '便利超商現煮茶葉蛋，架穩定蛋白質來源。每顆 ~6.3g 蛋白，適合緊急補充或午餐搭配',
   '每日 1-2 顆作為蛋白質補充',
   'NT$8-12 / 顆',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店 / OK便利店', 'convenience_daily', NULL, '台灣',
   '{"shelf_life":"冷藏櫃24-48小時","protein":"約6.3g/顆"}'::jsonb,
   '{"protein":"6.3g/顆","fat":"5g/顆","sodium":"約200-300mg（鹹味）"}'::jsonb,
   '每 2-3 天買 1-2 顆。優點：熟食即食、不佔冷藏（架穩定）、補充 Costco 生蛋不足。注意鹽分較高，每日 1-2 顆為限。每月約 20 顆（NT$160-240）+ Costco 生蛋 20 顆/月，總成本約 Costco 30 顆價格，但省蛋盒空間。',
   51),

  ('新鮮雞胸肉（冷藏小包）',
   '超市/全聯冷藏鮮雞胸，300-500g 小包裝。當天購買當天烹調，零冷凍空間佔用',
   '每週 2-3 次購買，每次 300-500g',
   'NT$120-150 / 300g',
   'https://www.pxmart.com.tw',
   '全聯 / 頂好 / 家樂福', 'convenience_daily', NULL, '台灣',
   '{"packaging":"冷藏真空包","shelf_life":"冷藏3-5天","cooking":"當天購買建議當天烹調"}'::jsonb,
   '{"protein":"約31g/100g","fat":"約3g/100g","calories":"約165kcal/100g"}'::jsonb,
   '✅ 唯一雞胸方案（方案 B）：每週 2-3 次購買 300-500g（每次約 NT$120-150）。優點：釋放 Costco 5kg 冷凍佔用的 2-3L 冷凍空間、保證新鮮度、不需「當天全煮 5kg→分裝」流程。每月成本約 NT$1,200-1,500。冷凍庫空間留給鮭魚與其他高價值食材。',
   52),

  ('酪梨（單顆，已熟）',
   '便利超商/全聯單顆酪梨，已達最佳熟度（輕捏微軟）。健康脂肪 + 鉀（~700mg/顆）',
   '每 2-3 天 1 顆，午餐或晚餐',
   'NT$25-30 / 顆',
   'https://www.7-11.com.tw',
   '7-Eleven / 全聯', 'convenience_daily', NULL, '台灣 / 紐西蘭',
   '{"ripeness":"已熟即食","storage":"冷藏1-2天"}'::jsonb,
   '{"fat":"約15g/半顆","potassium":"約700mg/顆","fiber":"約7g/顆"}'::jsonb,
   '每 2-3 天買 1 顆（每週 3-4 顆）。優點：零氧化浪費（不需矽膠套保鮮）、熟度保證。比 Costco 1.3kg（4-5 顆）週購貴約 NT$20-40/顆，但省冷藏空間 + 切半保鮮負擔。每月約 12-16 顆（NT$300-480）。',
   53),

  ('新鮮藍莓（小盒）',
   '便利超商小盒藍莓 150-200g，花青素豐富。搭配燕麥碗、希臘優格',
   '每週 2-3 次，每次 50-100g',
   'NT$99-129 / 150-200g',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店', 'convenience_daily', NULL, '美國 / 智利',
   '{"packaging":"透明盒裝","shelf_life":"冷藏3-5天"}'::jsonb,
   '{"anthocyanins":"花青素豐富","fiber":"約2.4g/100g","vitamin_c":"約10mg/100g"}'::jsonb,
   '每週 2-3 次買 1 小盒（每週 300-450g）。優點：不需週購 Costco 510g 大盒（3-5 天吃完壓力）、小量新鮮。成本約 Costco ±0，但省冷藏抽屜空間。',
   54),

  ('新鮮菠菜（沙拉包）',
   '便利超商預洗菠菜沙拉包 100-150g。低 FODMAP 蔬菜，鉀、鎂、鐵來源',
   '每週 2-3 次，每次 100-150g',
   'NT$30-50 / 100-150g',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店', 'convenience_daily', NULL, '台灣',
   '{"packaging":"預洗沙拉包","shelf_life":"冷藏2-3天"}'::jsonb,
   '{"iron":"約2.7mg/100g","magnesium":"約79mg/100g","potassium":"約558mg/100g"}'::jsonb,
   '每週 2-3 次買 1 包（每週 300-400g）。優點：預洗即食、省傳統市場週購。比市場散裝貴 50-100%，但便利性高。可與傳統市場混搭：50% 便利超商 + 50% 市場散裝。',
   55),

  ('鮪魚罐頭（水煮）',
   '架穩定蛋白質備用來源。每罐 ~25g 蛋白，適合緊急午餐或晚餐補充',
   '備用（每月 2-4 罐）',
   'NT$50-80 / 罐（約 180g）',
   'https://www.7-11.com.tw',
   '7-Eleven / 全家便利店 / 全聯', 'convenience_daily', NULL, '泰國 / 台灣',
   '{"type":"水煮鮪魚（低鈉）","shelf_life":"未開封2-3年","storage":"常溫"}'::jsonb,
   '{"protein":"約25g/罐","fat":"約1g/罐","sodium":"約200-400mg（視品牌）"}'::jsonb,
   '備用品。當無法採購新鮮蛋白質時（雞胸、鮭魚、蛋缺貨），2 罐鮪魚 = 50g 蛋白可替代一餐。建議常備 2-4 罐（常溫不佔冰箱）。',
   56);
