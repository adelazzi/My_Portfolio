@echo off
echo 🔍 Running Pre-Deployment Checks...
echo.

echo 📊 Step 1: Running Flutter Analyze...
flutter analyze
if %errorlevel% neq 0 (
    echo ❌ Analyzer found issues! Please fix them before deploying.
    echo.
    pause
    exit /b 1
)

echo ✅ Analysis passed!
echo.

echo 🔨 Step 2: Building for GitHub Pages...
flutter build web --release --base-href /My_Portfolio/
if %errorlevel% neq 0 (
    echo ❌ Build failed! Check the errors above.
    echo.
    pause
    exit /b 1
)

echo ✅ Build successful!
echo.

echo 🎉 All checks passed! Your portfolio is ready for deployment.
echo.
echo 📋 Next steps:
echo 1. Commit and push your changes to GitHub
echo 2. Your GitHub Action will automatically deploy the portfolio
echo 3. Check https://yourusername.github.io/My_Portfolio/ in a few minutes
echo.

echo 🌐 Want to test locally? Run: test_github_pages.bat
echo.
pause
