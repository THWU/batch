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

echo -------------export開始-------------
::check if the Tables folder exists
echo check if the Tables folder exists
if NOT EXIST %CD%\Tables\ (
md Tables
echo create Tables folder complete
) else (
echo Tables folder exists, delete whole files
del %CD%\Tables\*.sql
)
echo export Tables schema
start "Export Tables schema" /B mssql-scripter -S "%ServerName%" -d "%DatabaseName%" -U %user% -P %password% -f %CD%\Tables\ --file-per-object --script-create --include-types Table --exclude-headers
GOTO _CreateView

:_CreateView
::check if the Views folder exists
echo check if the Views folder exists
if NOT EXIST %CD%\Views\ (
md Views
echo create Views folder complete
) else (
echo Views folder exists, delete whole files
del %CD%\Views\*.sql
)
echo export Views schema
start "Export Views schema" /B mssql-scripter -S "%ServerName%" -d "%DatabaseName%" -U %user% -P %password% -f %CD%\Views\ --file-per-object --script-create --include-types View --exclude-headers
GOTO _CreateStoredProcedures

:_CreateStoredProcedures
::check if the StoredProcedures folder exists
echo check if the StoredProcedures folder exists
if NOT EXIST "%CD%\StoredProcedures\" (
md StoredProcedures
echo create StoredProcedures folder complete
) else (
echo StoredProcedures folder exists, delete whole files
del %CD%\StoredProcedures\*.sql
)
echo export StoredProcedures schema
start "Export Stored Procedures schema" /B mssql-scripter -S "%ServerName%" -d "%DatabaseName%" -U %user% -P %password% -f %CD%\StoredProcedures\ --file-per-object --script-create --include-types StoredProcedure --exclude-headers

:_CreateUserDefinedFunction
::check if the UserDefinedFunctions folder exists
echo check if the UserDefinedFunctions folder exists
if NOT EXIST "%CD%\UserDefinedFunctions\" (
md UserDefinedFunctions
echo create UserDefinedFunctions folder complete
) else (
echo UserDefinedFunctions folder exists, delete whole files
del %CD%\UserDefinedFunctions\*.sql
)
echo export UserDefinedFunctions schema
start "Export Stored Procedures schema" /B mssql-scripter -S "%ServerName%" -d "%DatabaseName%" -U %user% -P %password% -f %CD%\UserDefinedFunctions\ --file-per-object --script-create --include-types UserDefinedFunction --exclude-headers

echo -------------export結束-------------