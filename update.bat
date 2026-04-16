@echo off
REM Double-click to push local website changes to GitHub.

cd /d "%~dp0"

echo ============================================
echo  Updating diopapadakis.github.io
echo ============================================
echo.

echo [1/4] Pulling latest from GitHub...
git pull --rebase origin main
if errorlevel 1 (
    echo.
    echo *** Pull failed. Resolve the issue above, then re-run. ***
    pause
    exit /b 1
)
echo.

echo [2/4] Staging all changes...
git add -A
echo.

echo [3/4] Checking for changes...
git diff --cached --quiet
if %errorlevel%==0 (
    echo No local changes to commit. You are already up to date.
    echo.
    pause
    exit /b 0
)

git status --short
echo.
set /p MSG="Commit message (press Enter for 'Update site'): "
if "%MSG%"=="" set MSG=Update site

git commit -m "%MSG%"
if errorlevel 1 (
    echo.
    echo *** Commit failed. ***
    pause
    exit /b 1
)
echo.

echo [4/4] Pushing to GitHub...
git push origin main
if errorlevel 1 (
    echo.
    echo *** Push failed. ***
    pause
    exit /b 1
)

echo.
echo ============================================
echo  Done. Site will update in 1-2 minutes.
echo  https://diopapadakis.github.io
echo ============================================
echo.
pause
