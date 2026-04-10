@echo off
REM CLIPS Execution Script for Diabetes Expert System (Windows)
REM Pure CLIPS implementation (no C++ wrapper)
REM
REM Instructions:
REM 1. Make sure CLIPS is installed and in your PATH
REM 2. Run this batch file: clips_run.bat
REM 3. Or run manually: clips < clips_commands.txt
REM
REM For interactive mode:
REM 1. Open Command Prompt
REM 2. Navigate to the project directory
REM 3. Type: clips
REM 4. Copy and paste the commands from below

setlocal enabledelayedexpansion

echo.
echo ========================================
echo  DIABETES EXPERT SYSTEM - CLIPS LOADER
echo  Windows Batch Execution Script
echo ========================================
echo.

REM Check if CLIPS is available
where clips >nul 2>nul
if errorlevel 1 (
    echo ERROR: CLIPS not found in PATH
    echo Please install CLIPS or add it to your PATH environment variable
    echo.
    echo For manual execution:
    echo 1. Open Command Prompt
    echo 2. Change to this directory
    echo 3. Type: clips
    echo 4. In CLIPS console, type the commands from clips_commands.txt
    echo.
    pause
    exit /b 1
)

echo Starting CLIPS and loading knowledge base...
echo.

REM Create a temporary CLIPS script file
(
    echo (batch knowledge_base/00_templates.clp^)
    echo (batch knowledge_base/01_validation.clp^)
    echo (batch knowledge_base/02_abstraction.clp^)
    echo (batch knowledge_base/03_diagnostic.clp^)
    echo (batch knowledge_base/04_cli.clp^)
    echo (reset^)
    echo (run^)
) > temp_clips_script.txt

REM Run CLIPS with the script
clips < temp_clips_script.txt

REM Clean up temporary file
del temp_clips_script.txt

echo.
echo ========================================
echo  Execution Complete
echo ========================================
pause
