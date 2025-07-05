@echo off
echo 🧪 Testing GitHub Pages Build Locally...
echo.

REM Build with the exact same settings as GitHub Pages
echo 🔨 Building with GitHub Pages settings...
flutter build web --release --base-href /My_Portfolio/

if exist "build\web" (
    echo.
    echo ✅ Build successful!
    echo.
    echo 🌐 Starting local server to test GitHub Pages build...
    echo    Your portfolio will open at: http://localhost:8080
    echo    This simulates how it will look on GitHub Pages
    echo.
    echo 💡 Press Ctrl+C to stop the server
    echo.
    cd build\web
    start http://localhost:8080
    python -m http.server 8080
) else (
    echo ❌ Build failed! Check the errors above.
    pause
)
