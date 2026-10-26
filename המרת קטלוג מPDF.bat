@echo off
rem ASCII-only on purpose - see scripts\start.js for why.
chcp 65001 >nul
title Makolet - PDF catalog to CSV
cd /d "%~dp0"

set "NODE="
where node >nul 2>&1 && set "NODE=node"
if not defined NODE if exist "%ProgramFiles%\nodejs\node.exe" set "NODE=%ProgramFiles%\nodejs\node.exe"
if not defined NODE if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "NODE=%ProgramFiles(x86)%\nodejs\node.exe"
if not defined NODE if exist "%LOCALAPPDATA%\Programs\nodejs\node.exe" set "NODE=%LOCALAPPDATA%\Programs\nodejs\node.exe"

if not defined NODE (
  echo Node.js is not installed. Get it from https://nodejs.org
  pause
  exit /b 1
)

if "%~1"=="" (
  echo.
  echo   Drag the PDF file onto this .bat file, or run:
  echo       "%~nx0" "C:\path\to\report.pdf"
  echo.
  pause
  exit /b 1
)

if not exist "node_modules\pdfjs-dist" (
  echo Installing the PDF reader, one time only...
  call npm install pdfjs-dist --no-audit --no-fund
)

"%NODE%" "scripts\pdf-to-csv.js" "%~1" "%~dpn1.csv"
echo.
pause
