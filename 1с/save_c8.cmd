Set file=C:\base_list.txt
For /F %%i In (%file%) Do ("C:\Program Files\1cv8\8.3.17.1851\bin\1cv8.exe" ENTERPRISE /S"1csrv01\%%i" /N"Администратор" /P"30" /DisableStartupMessages /C"ЗавершитьРаботуПользователей"
"C:\Program Files\1cv8\8.3.17.1851\bin\1cv8.exe" DESIGNER /S"1csrv01\%%i" /N"Администратор" /P"30" /DumpIB"E:\Data\Backup\%%i_%date%.dt" /UC"КодРазрешения")