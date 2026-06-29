# VirusTotal 指令

## `vt-domain-lookup` 指令

在 VirusTotal 上查詢網域清單

* 輸入：文字檔
* Profile：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何 Profile
* 輸出：CSV

必要選項：

- `-a, --apiKey <API-KEY>`：您的 VirusTotal API 金鑰。
- `-d, --domainList <TXT-FILE>`：網域清單的文字檔。
- `-o, --output <CSV-FILE>`：將結果儲存至 CSV 檔。

選項：

- `-j, --jsonOutput <JSON-FILE>`：將 VirusTotal 的所有 JSON 回應輸出至 JSON 檔。
- `-r, --rateLimit <NUMBER>`：每分鐘送出請求的速率。（預設值：`4`）
- `-q, --quiet`：不顯示 logo。（預設值：`false`）

### `vt-domain-lookup` 指令範例

首先使用 `list-domains` 指令建立網域清單。
接著以下列方式查詢這些網域：

```
takajo.exe vt-domain-lookup -a <API-KEY> -d domains.txt -o vt-domain-lookup.csv -r 1000 -j vt-domain-lookup.json
```

## `vt-hash-lookup` 指令

在 VirusTotal 上查詢雜湊值清單。

* 輸入：文字檔
* Profile：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何 Profile
* 輸出：CSV

必要選項：

- `-a, --apiKey <API-KEY>`：您的 VirusTotal API 金鑰。
- `-H, --hashList <HASH-LIST>`：雜湊值的文字檔。
- `-o, --output <CSV-FILE>`：將結果儲存至 CSV 檔。

選項：

- `-j, --jsonOutput <JSON-FILE>`：將 VirusTotal 的所有 JSON 回應輸出至 JSON 檔。
- `-r, --rateLimit <NUMBER>`：每分鐘送出請求的速率。（預設值：`4`）
- `-q, --quiet`：不顯示 logo。（預設值：`false`）

### `vt-hash-lookup` 指令範例

```
takajo.exe vt-hash-lookup -a <API-KEY> -H MD5-hashes.txt -o vt-hash-lookup.csv -r 1000 -j vt-hash-lookup.json
```

## `vt-ip-lookup` 指令

在 VirusTotal 上查詢 IP 位址清單。

* 輸入：文字檔
* Profile：除了 `all-field-info` 與 `all-field-info-verbose` 以外的任何 Profile
* 輸出：CSV

必要選項：

- `-a, --apiKey <API-KEY>`：您的 VirusTotal API 金鑰。
- `-i, --ipList <IP-ADDRESS-LIST>`：IP 位址的文字檔。
- `-o, --output <CSV-FILE>`：將結果儲存至 CSV 檔。

選項：

- `-j, --jsonOutput <JSON-FILE>`：將 VirusTotal 的所有 JSON 回應輸出至 JSON 檔。
- `-r, --rateLimit <NUMBER>`：每分鐘送出請求的速率。（預設值：`4`）
- `-q, --quiet`：不顯示 logo。（預設值：`false`）

### `vt-ip-lookup` 指令範例

```
takajo.exe vt-ip-lookup -a <API-KEY> -i ipAddresses.txt -o vt-ip-lookup.csv -r 1000 -j vt-ip-lookup.json
```
