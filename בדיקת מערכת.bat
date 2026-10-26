@echo off
rem ASCII-only on purpose - see scripts\start.js for why.
chcp 65001 >nul
title Makolet - system check
cd /d "%~dp0"

set "NODE="
where node >nul 2>&1 && set "NODE=node"
if not defined NODE if exist "%ProgramFiles%\nodejs\node.exe" set "NODE=%ProgramFiles%\nodejs\node.exe"
if not defined NODE if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "NODE=%ProgramFiles(x86)%\nodejs\node.exe"
if not defined NODE if exist "%LOCALAPPDATA%\Programs\nodejs\node.exe" set "NODE=%LOCALAPPDATA%\Programs\nodejs\node.exe"

if not defined NODE (
  echo.
  echo   Node.js is NOT installed on this computer.
  echo.
  echo   This is the first thing you need. Install it from:
  echo       https://nodejs.org
  echo   Choose the big green LTS button, run the installer,
  echo   click Next until it finishes, then run this file again.
  echo.
  pause
  exit /b 1
)

"%NODE%" "scripts\doctor.js"
pause
