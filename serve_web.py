#!/usr/bin/env python3
"""
Simple HTTP Server for Flutter Web App
Run this script to serve the built web app locally
"""

import http.server
import socketserver
import os
import sys

def serve_web_app():
    # Change to the web build directory
    web_dir = os.path.join(os.path.dirname(__file__), 'build', 'web')
    
    if not os.path.exists(web_dir):
        print("❌ Web build directory not found!")
        print("Please run 'flutter build web' first.")
        return
    
    os.chdir(web_dir)
    
    # Set up the server
    PORT = 8080
    Handler = http.server.SimpleHTTPRequestHandler
    
    with socketserver.TCPServer(("", PORT), Handler) as httpd:
        print(f"🚀 Serving Flutter web app at http://localhost:{PORT}")
        print("Press Ctrl+C to stop the server")
        try:
            httpd.serve_forever()
        except KeyboardInterrupt:
            print("\n👋 Server stopped")

if __name__ == "__main__":
    serve_web_app()
