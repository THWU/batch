# batch
常用批次檔

## mssql-scripter/ScriptExport.bat
透過提示輸入，可便於使用 mssql-scripter 產生指定 SQL Server 資料庫的 
* Data Definition Language (DDL)
* Data Manipulation Language (DML) T-SQL 檔案

即 Table, View, Stored Procedure, Function 等物件的 **建立(CREATE)** 語法檔案

### 使用要求
需先安裝 mssql-scripter https://github.com/microsoft/mssql-scripter

### 使用方法
1. 將 ScriptExport.bat 存放在欲匯出檔案的目錄中後，執行 ScriptExport.bat。
2. 依提示輸入資料庫連結資訊
    - 資料庫伺服器名稱 (IP, Hostname)
    - 資料庫名稱
    - 登入帳號 (僅支援 SQL Server 驗證模式)
    - 登入密碼
3. 開始匯出檔案

### 匯出資料夾結構
    -- /ScriptExport.bat  
    -- /StoredProcedures/  
    -- /Tables/  
    -- /UserDefinedFunctions/  
    -- /Views/  

### 注意事項
- 執行後，**會刪除所有位於 ScriptExport.bat 目錄下 資料夾內所有檔案**
    - StoredProcedures
    - Tables
    - UserDefinedFunctions
    - Views
- 若執行時沒有以上資料夾，則會自動建立。

### 其他
    使用 mssql-scripter 參數如下
    --file-per-object     By default script to a single file. If supplied and
                          given a directory for --file-path, script a file per
                          object to that directory.
    --script-create       Script object CREATE statements.
    --include-types       Database objects of this type to include in script.
    --exclude-headers     Exclude descriptive headers for each object scripted.
