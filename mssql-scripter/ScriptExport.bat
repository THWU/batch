REM =========================
REM Bat File 本身若是 UTF8 語系, 為了讓 Bat 檔裡的中文字正常顯示與讀取
REM 必須利用 chcp 變更 Command Line 語系為 UTF8 (代碼為 65001)
REM 否則中文字會是亂碼, 甚至造成 Java Application 執行錯誤
REM =========================
chcp 65001

@echo OFF

::設定自訂變數
SET /P ServerName=DB Server Name:
SET /P DatabaseName=DB Name:
SET /P user=Account:
SET /p password=Password:

echo -------------匯出開始-------------
::判斷 Tables 資料夾是否建立
echo 判斷 Tables 資料夾是否建立
IF NOT EXIST %CD%\Tables\ (
md Tables
echo 建立 Tables 資料夾完成
) ELSE (
echo Tables 資料夾已存在，刪除裡面所有檔案
del %CD%\Tables\*.sql
)
echo 匯出 Tables 結構
start "Export Tables schema" /B mssql-scripter -S %ServerName% -d %DatabaseName% -U %user% -P %password% -f %CD%\Tables\ --file-per-object --script-create --include-types Table --exclude-headers
GOTO _CreateTable

:_CreateTable
::判斷 Views 資料夾是否建立
echo 判斷 Views 資料夾是否建立
IF NOT EXIST %CD%\Views\ (
md Views
echo 建立 Views 資料夾完成
) ELSE (
echo Views 資料夾已存在，刪除裡面所有檔案
del %CD%\Views\*.sql
)
echo 匯出 Views 結構
start "Export Views schema" /B mssql-scripter -S %ServerName% -d %DatabaseName% -U %user% -P %password% -f %CD%\Views\ --file-per-object --script-create --include-types View --exclude-headers
GOTO _CreateStoredProcedures

:_CreateStoredProcedures
::判斷 StoredProcedures 資料夾是否建立
echo 判斷 StoredProcedures 資料夾是否建立
IF NOT EXIST "%CD%\StoredProcedures\" (
md StoredProcedures
echo 建立 StoredProcedures 資料夾完成
) ELSE (
echo StoredProcedures 資料夾已存在，刪除裡面所有檔案
del %CD%\StoredProcedures\*.sql
)
echo 匯出 StoredProcedures 結構
start "Export Stored Procedures schema" /B mssql-scripter -S %ServerName% -d %DatabaseName% -U %user% -P %password% -f %CD%\StoredProcedures\ --file-per-object --script-create --include-types StoredProcedure --exclude-headers

:_CreateUserDefinedFunction
::判斷 UserDefinedFunctions 資料夾是否建立
echo 判斷 UserDefinedFunctions 資料夾是否建立
IF NOT EXIST "%CD%\UserDefinedFunctions\" (
md UserDefinedFunctions
echo 建立 UserDefinedFunctions 資料夾完成
) ELSE (
echo UserDefinedFunctions 資料夾已存在，刪除裡面所有檔案
del %CD%\UserDefinedFunctions\*.sql
)
echo 匯出 UserDefinedFunctions 結構
start "Export Stored Procedures schema" /B mssql-scripter -S %ServerName% -d %DatabaseName% -U %user% -P %password% -f %CD%\UserDefinedFunctions\ --file-per-object --script-create --include-types UserDefinedFunction --exclude-headers

echo -------------匯出結束-------------