@echo off
echo Building Flutter Web App...
flutter clean
flutter pub get
flutter build web --release

if exist "build\web" (
    echo.
    echo ✅ Build successful!
    echo.
    echo Starting local web server...
    echo Open http://localhost:8080 in your browser
    echo Press Ctrl+C to stop the server
    echo.
    cd build\web
    python -m http.server 8080
) else (
    echo ❌ Build failed!
    pause
)
