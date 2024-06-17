@echo off
setlocal

rem Define variables
set DB_NAME="AirlineDB"
set DB_USER="postgres"
set DB_PASSWORD=
set OUTPUT_FILE=backupSQL.sql
set LOG_FILE=backupSQL.log

rem Log start time
echo Starting database dump at %date% %time% > %LOG_FILE%

rem Set the PGPASSWORD environment variable
set PGPASSWORD=%DB_PASSWORD%

rem Run pg_dump and log the output
echo Running pg_dump... >> %LOG_FILE%
(
   echo START TIME: %time%
   pg_dump --dbname=%DB_NAME% --username=%DB_USER% --clean --inserts --file=%OUTPUT_FILE%
   echo END TIME: %time%
) 2>> %LOG_FILE%

rem Log end time
echo Finished database dump at %date% %time% >> %LOG_FILE%

rem Log the size of the output file
echo Size of the output file: >> %LOG_FILE%
for %%f in (%OUTPUT_FILE%) do echo %%~zf bytes >> %LOG_FILE%

rem Clear the PGPASSWORD environment variable
set PGPASSWORD=

endlocal
