@echo off
rem Keep this file ASCII-only. Windows cmd mis-parses Hebrew inside batch files,
rem so every Hebrew message lives in scripts\start.js instead.
chcp 65001 >nul
title Makolet
cd /d "%~dp0"

set "NODE="
where node >nul 2>&1 && set "NODE=node"
if not defined NODE if exist "%ProgramFiles%\nodejs\node.exe" set "NODE=%ProgramFiles%\nodejs\node.exe"
if not defined NODE if exist "%ProgramFiles(x86)%\nodejs\node.exe" set "NODE=%ProgramFiles(x86)%\nodejs\node.exe"
if not defined NODE if exist "%LOCALAPPDATA%\Programs\nodejs\node.exe" set "NODE=%LOCALAPPDATA%\Programs\nodejs\node.exe"

if not defined NODE (
  echo.
  echo   Node.js is not installed on this computer.
  echo   Install it from https://nodejs.org  ^(choose the LTS version^),
  echo   then run this file again.
  echo.
  pause
  exit /b 1
)

"%NODE%" "scripts\start.js"

echo.
pause
