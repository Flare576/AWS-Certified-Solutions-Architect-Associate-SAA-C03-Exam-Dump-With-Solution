@echo off
rem Windows: map aws.certification.edu to this machine, then serve the viewer on localhost only.
setlocal
set "HOST=aws.certification.edu"
if "%PORT%"=="" set "PORT=80"
set "HOSTS=%SystemRoot%\System32\drivers\etc\hosts"
set "URL=http://%HOST%/"
if not "%PORT%"=="80" set "URL=http://%HOST%:%PORT%/"

cd /d "%~dp0"

findstr /i /c:"%HOST%" "%HOSTS%" >nul 2>&1
if errorlevel 1 (
  echo Adding %HOST% to the hosts file - approve the administrator prompt...
  powershell -NoProfile -Command "Start-Process powershell -Verb RunAs -Wait -ArgumentList '-NoProfile -Command Add-Content -Path ''%HOSTS%'' -Value ''127.0.0.1 %HOST%'''"
)

start "" /b powershell -NoProfile -Command "Start-Sleep 1; Start-Process '%URL%'"

echo Serving %URL% (Ctrl+C to stop)
where py >nul 2>&1
if %errorlevel%==0 (
  py -3 serve.py %PORT%
) else (
  python serve.py %PORT%
)
