#!/bin/bash
# Quick build script for Quantum Collision Lab Android APK

set -e

echo "================================================"
echo "  Quantum Collision Lab - Android APK Builder"
echo "================================================"
echo ""

# Check if we're in the android directory
if [ ! -f "build.gradle" ]; then
    echo "Error: Please run this script from the android directory"
    echo "Usage: cd android && ./build.sh"
    exit 1
fi

# Check for Java
if ! command -v java &> /dev/null; then
    echo "Error: Java is not installed"
    echo "Please install Java JDK 8 or later"
    exit 1
fi

echo "✓ Java found: $(java -version 2>&1 | head -n 1)"
echo ""

# Download Gradle wrapper if needed
if [ ! -f "gradlew" ]; then
    echo "Downloading Gradle wrapper..."
    gradle wrapper --gradle-version 8.1 || {
        echo "Error: Failed to download Gradle wrapper"
        echo "Please install Gradle manually: https://gradle.org/install/"
        exit 1
    }
fi

# Make gradlew executable
chmod +x gradlew

echo "Building debug APK..."
echo ""

# Build debug APK
./gradlew assembleDebug

if [ $? -eq 0 ]; then
    echo ""
    echo "================================================"
    echo "  BUILD SUCCESSFUL!"
    echo "================================================"
    echo ""
    echo "APK Location:"
    echo "  $(pwd)/app/build/outputs/apk/debug/app-debug.apk"
    echo ""
    echo "Install on device:"
    echo "  adb install app/build/outputs/apk/debug/app-debug.apk"
    echo ""
    echo "Or transfer the APK to your Android device and install manually"
    echo ""
else
    echo ""
    echo "Build failed. Check errors above."
    exit 1
fi
