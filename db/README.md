# Database Setup（MySQL）

本資料夾提供診所管理系統的資料庫 SQL 檔案，包含建表結構與假資料，
可用於面試 Demo 與快速還原環境。

---

## Files

- `01clinic_schema.sql`
  - 建立資料表結構（CREATE TABLE / Foreign Key / View）
- `02clinic_seed_data.sql`
  - 匯入假資料（INSERT INTO ...）

注意：本專案資料皆為假資料，用於作品展示。

---

## Import by MySQL Workbench（推薦）

1. 開啟 MySQL Workbench
2. 建立資料庫（Schema），例如：`clinic`
3. 點選：File → Run SQL Script...
4. 依序匯入：
   1. `01clinic_schema.sql`
   2. `02clinic_seed_data.sql`

---

## Import by Command Line（可選）

請先確認你已建立資料庫 `clinic`：

```sql
CREATE DATABASE clinic DEFAULT CHARSET utf8mb4;
USE clinic;
```

接著依序匯入：

```bash
mysql -u root -p clinic < db/01clinic_schema.sql
mysql -u root -p clinic < db/02clinic_seed_data.sql
```

---

## 備註

- SQL 檔案為 MySQL 8.x 版本匯出，編碼使用 `utf8mb4`。
- 內含 View：`report01`、`report02`、`report04`、`report05`、`report06`、`report07`。
- 若你在程式中使用不同的資料庫名稱（如 `1141029_clinic`），請把 `clinic` 改成實際名稱。