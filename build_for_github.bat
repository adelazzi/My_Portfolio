@echo off
echo 🚀 Building Flutter Portfolio for GitHub Pages...
echo.

REM Clean previous builds
echo 🧹 Cleaning previous builds...
flutter clean

REM Get dependencies
echo 📦 Getting dependencies...
flutter pub get

REM Build for web with GitHub Pages base href
echo 🔨 Building web app for GitHub Pages...
flutter build web --release --base-href /My_Portfolio/

if exist "build\web" (
    echo.
    echo ✅ Build successful!
    echo.
    echo 📁 Web files are ready in: build\web\
    echo.
    echo 📋 Next steps:
    echo 1. Commit and push your changes to GitHub
    echo 2. Enable GitHub Pages in your repository settings
    echo 3. Your portfolio will be available at: https://yourusername.github.io/My_Portfolio/
    echo.
    echo 🌐 To test locally, run: python -m http.server 8080
    echo    Then open: http://localhost:8080
    echo.
    pause
) else (
    echo ❌ Build failed! Check the errors above.
    pause
)
