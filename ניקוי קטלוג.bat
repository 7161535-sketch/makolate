@echo off
rem ASCII-only on purpose - see scripts\start.js for why.
chcp 65001 >nul
title Makolet - prune catalog
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

rem Drag a sales-report CSV onto this file to use it as the keep-list.
if "%~1"=="" (
  "%NODE%" "scripts\prune-catalog.js" --months 18
) else (
  "%NODE%" "scripts\prune-catalog.js" --keep "%~1" --months 18
)

echo.
pause
