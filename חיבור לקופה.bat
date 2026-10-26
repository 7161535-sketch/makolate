@echo off
rem ASCII-only on purpose - see scripts\start.js for why.
chcp 65001 >nul
title Makolet - POS link
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

rem First time: run the setup wizard. After that: run the agent.
if not exist "agent\agent-config.json" (
  "%NODE%" "scripts\setup-pos.js"
  pause
  exit /b 0
)

"%NODE%" "agent\pos-agent.js"
pause
