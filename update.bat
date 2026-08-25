@echo off
REM Double-click to push local website changes to GitHub.

cd /d "%~dp0"

echo ============================================
echo  Updating diopapadakis.github.io
echo ============================================
echo.

echo [1/4] Checking for local changes...
git add -A
git diff --cached --quiet
if %errorlevel%==0 (
    echo No local changes to commit. Syncing with GitHub anyway...
    echo.
    git pull --rebase --autostash origin main
    if errorlevel 1 (
        echo.
        echo *** Pull failed. Resolve the issue above, then re-run. ***
        pause
        exit /b 1
    )
    git push origin main
    echo.
    echo You are up to date.
    echo.
    pause
    exit /b 0
)

git status --short
echo.

echo [2/4] Committing...
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

echo [3/4] Pulling latest from GitHub...
git pull --rebase --autostash origin main
if errorlevel 1 (
    echo.
    echo *** Pull failed - you may have a merge conflict. ***
    echo *** Fix the conflict, then run: git rebase --continue ***
    echo *** Or to abort and start over:  git rebase --abort ***
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
