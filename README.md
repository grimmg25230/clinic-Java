# 診所管理 CLI 專案（clinic1101）

此專案為一個 **Java Console** 程式，透過 JDBC 連線 MySQL，提供診所預約與看診流程的基本操作：病人與醫師管理、預約建立與狀態更新、病例新增、帳單產生與付款狀態更新。

---

## 專案特色

- Java Console 互動式選單
- JDBC + MySQL 資料庫操作
- 預約／看診／帳單流程串接
- 報表檢視（使用 DB View）
- 中文輸入支援（Scanner 使用 BIG5）

---

## 環境需求

- Java 8+（建議 11 或以上）
- MySQL 8+
- MySQL JDBC Driver（`mysql-connector-j`）

---

## 資料庫連線設定

程式內建連線設定（`src/clinic1101.java`）：

```java
private static final String URL = "jdbc:mysql://localhost:3306/1141029_clinic";
private static final String USER = "root";
private static final String PASSWORD = "84447521";
```

> 建議：請改為環境變數或外部設定檔，避免將密碼寫入程式碼。

---

## 主要功能（選單對應）

啟動後會顯示操作選單：

```
0 - 退出
1 - 預約看診日期
2 - 新增醫師
3 - 查看醫師
4 - 查看病人
5 - 查看預約狀況
6 - 更改預約狀況
7 - 新增病例
8 - 查看付款明細及狀況
9 - 更改付款狀況
```

### 1. 預約看診日期
- 以身分證查詢病人
- 若不存在可直接新增病人資料
- 建立預約（appointments）

### 2. 新增醫師
- 新增 doctors 資料

### 3. 查看醫師
- 列出 doctors 所有醫師資料

### 4. 查看病人
- 列出 patients 所有病人資料

### 5. 查看預約狀況
- 讀取 view `report01` 顯示預約狀況

### 6. 更改預約狀況
- 依身分證與日期找到預約
- 更新 appointments.status

### 7. 新增病例
- 依身分證與日期找到預約
- 新增 medical_records
- 自動更新預約狀態為「已看診」
- 依疫苗費用建立 billing 帳單

### 8. 查看付款明細及狀況
- 讀取 view `report07` 列出帳單與付款狀態（paid 轉換為已付款/未付款）

### 9. 更改付款狀況
- 透過 view `report06` 找出未付款帳單
- 更新 billing.paid

---

## 需要的資料表 / View

程式會操作下列資料表與 View（請先在 DB 建立）：

- `patients`
- `doctors`
- `appointments`
- `medical_records`
- `vaccines`
- `billing`
- `report01`（View：預約狀況）
- `report06`（View：付款資訊）
- `report07`（View：帳單明細與付款狀態）

---

## 執行方式

在專案根目錄下：

```bash
javac -cp ".;lib/mysql-connector-j.jar" src/clinic1101.java
java -cp ".;lib/mysql-connector-j.jar;src" clinic1101
```

> 若使用 IDE，可直接執行 `clinic1101.java`。

---

## 注意事項

- Scanner 使用 BIG5 編碼：若環境為 UTF-8，可能需調整輸入編碼。
- 使用 `scanner.nextInt()` 後，若需要讀取字串請留意換行殘留問題。
- SQL View 欄位名稱與程式查詢需一致（如 `report06` 的 `patient_nid`, `paid` 等欄位）。

---

## 下一步建議

- 將 DB 帳密移出程式碼（環境變數或設定檔）
- 增加輸入格式驗證與錯誤處理
- 增加單元測試或資料庫整合測試
