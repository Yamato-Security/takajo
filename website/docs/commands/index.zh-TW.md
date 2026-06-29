# 指令清單

## 自動化指令
* `automagic`: 自動執行盡可能多的指令，並將結果輸出到新資料夾

## 擷取指令
* `extract-scriptblocks`: 擷取並重組 PowerShell EID 4104 指令碼區塊記錄

## HTML 指令
* `html-report`: 建立靜態 HTML 摘要報告
* `html-server`: 建立動態網頁伺服器以檢視 HTML 摘要報告

## 清單指令
* `list-domains`: 建立可搭配 `vt-domain-lookup` 使用的唯一網域清單
* `list-hashes`: 建立可搭配 `vt-hash-lookup` 使用的處理程序雜湊清單
* `list-ip-addresses`: 建立可搭配 `vt-ip-lookup` 使用的唯一目標與/或來源 IP 位址清單
* `list-undetected-evtx`: 建立未偵測到的 evtx 檔案清單
* `list-unused-rules`: 建立未使用的偵測規則清單

## 分割指令
* `split-csv-timeline`: 依電腦名稱將大型 CSV 時間軸分割為較小的時間軸
* `split-json-timeline`: 依電腦名稱將大型 JSONL 時間軸分割為較小的時間軸

## 堆疊指令
* `stack-cmdlines`: 堆疊已執行的命令列
* `stack-computers`: 堆疊電腦
* `stack-dns`: 堆疊 DNS 查詢與回應
* `stack-ip-addresses`: 堆疊目標 IP 位址（`TgtIP` 欄位）或來源 IP 位址（`SrcIP` 欄位）
* `stack-logons`: 依目標使用者、目標電腦、來源 IP 位址與來源電腦堆疊登入事件
* `stack-processes`: 堆疊已執行的處理程序
* `stack-services`: 堆疊來自 `System 7040` 與 `Security 4697` 事件的服務名稱與路徑
* `stack-tasks`: 堆疊來自 `Security 4698` 事件的新排程工作並解析出 XML 工作內容
* `stack-users`: 堆疊目標使用者（`TgtUser` 欄位）或來源使用者（`SrcUser` 欄位）

## Sysmon 指令
* `sysmon-process-tree`: 輸出特定處理程序的處理程序樹

## 時間軸指令
* `timeline-logon`: 建立登入事件的 CSV 時間軸
* `timeline-partition-diagnostic`: 建立磁碟分割診斷事件的 CSV 時間軸
* `timeline-suspicious-processes`: 建立可疑處理程序的 CSV 時間軸
* `timeline-tasks`: 建立排程工作的 CSV 時間軸

## TTP 指令
* `ttp-summary`: 彙整在每台電腦中發現的戰術與技術
* `ttp-visualize`: 擷取 TTP 並建立 JSON 檔案，以便在 MITRE ATT&CK Navigator 中視覺化
* `ttp-visualize-sigma`: 從 Sigma 規則擷取 TTP 並建立 JSON 檔案，以便在 MITRE ATT&CK Navigator 中視覺化

## VirusTotal 指令
* `vt-domain-lookup`: 在 VirusTotal 上查詢網域清單並回報惡意網域
* `vt-hash-lookup`: 在 VirusTotal 上查詢雜湊清單並回報惡意雜湊
* `vt-ip-lookup`: 在 VirusTotal 上查詢 IP 位址清單並回報惡意 IP 位址
