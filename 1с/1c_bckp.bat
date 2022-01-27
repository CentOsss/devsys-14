tskill *1cv8* /a /v
SET PBACKUP=E:\backup\hrm\hrm
SET PATH_BCKP=E:\backup\hrm
SET SOURCE=E:\1CDBs\HRM
SET USER=Admin
SET PASSWD=12348765
if exist %PBACKUP%.dt copy %PBACKUP%.dt %PBACKUP%_%date%.dt
"C:\Program Files (x86)\1cv8\common\1cestart.exe" config /f %SOURCE% /N %USER% /P %PASSWD% /OUT"E:\backup\hrm\hrm.log" /DumpIB %PBACKUP%.dt
forfiles /p %PATH_BCKP% /m *.dt /d -10 /c "cmd /c del @file"

REM СОЗДАНИЯ РЕЗЕРВНОЙ КОПИИ БАЗЫ ДАННЫХ POSTGRESQL
CLS
ECHO OFF
CHCP 1251
REM Установка переменных окружения
SET PGBIN=C:\Program Files\PostgreSQL\11.7-7.1C\bin
SET PGHOST=localhost
SET PGPORT=5432
SET PGUSER=postgres
SET PGPASSWORD=Lbvtnhf7373
REM Смена диска и переход в папку из которой запущен bat-файл
%~d0
CD %~dp0
REM Формирование имени файла резервной копии и файла-отчета
SET DATETIME=%DATE:~6,4%-%DATE:~3,2%-%DATE:~0,2% %TIME:~0,2%-%TIME:~3,2%-%TIME:~6,2%
SET DUMPFILE=%PGDATABASE% %DATETIME%.backup
SET LOGFILE=%PGDATABASE% %DATETIME%.log
SET DUMPPATH="Backup\%DUMPFILE%"
SET LOGPATH="Backup\%LOGFILE%"
REM Создание резервной копии
IF NOT EXIST Backup MD Backup
CALL "%PGBIN%\pg_dumpall.exe" --verbose --file=%DUMPPATH% 2>%LOGPATH%
REM Анализ кода завершения
IF NOT %ERRORLEVEL%==0 GOTO Error
GOTO Successfull
REM В случае ошибки удаляется поврежденная резервная копия и делается соответствующая запись в журнале
:Error
DEL %DUMPPATH%
MSG * "Ошибка при создании резервной копии базы данных. Смотрите backup.log."
ECHO %DATETIME% Ошибки при создании резервной копии базы данных %DUMPFILE%. Смотрите отчет %LOGFILE%. >> backup.log
GOTO End
REM В случае удачного резервного копирования просто делается запись в журнал
:Successfull
ECHO %DATETIME% Успешное создание резервной копии %DUMPFILE% >> backup.log
GOTO End
:End