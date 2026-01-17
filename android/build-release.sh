#!/bin/bash
# Production build script for Google Play Store release

set -e

echo "========================================================"
echo "  Quantum Collision Lab - Production Build for Play Store"
echo "========================================================"
echo ""

# Check if we're in the android directory
if [ ! -f "build.gradle" ]; then
    echo "❌ Error: Please run this script from the android directory"
    echo "Usage: cd android && ./build-release.sh"
    exit 1
fi

# Check for Java
if ! command -v java &> /dev/null; then
    echo "❌ Error: Java is not installed"
    echo "Please install Java JDK 8 or later"
    exit 1
fi

echo "✓ Java found: $(java -version 2>&1 | head -n 1)"
echo ""

# Download Gradle wrapper if needed
if [ ! -f "gradlew" ]; then
    echo "📦 Downloading Gradle wrapper..."
    gradle wrapper --gradle-version 8.1 || {
        echo "❌ Error: Failed to download Gradle wrapper"
        echo "Please install Gradle manually: https://gradle.org/install/"
        exit 1
    }
fi

# Make gradlew executable
chmod +x gradlew

echo "🧹 Cleaning previous builds..."
./gradlew clean

echo ""
echo "========================================================"
echo "  Select build type:"
echo "========================================================"
echo "1) Android App Bundle (AAB) - Recommended for Play Store"
echo "2) APK - For direct distribution"
echo ""
read -p "Enter choice [1-2]: " choice

case $choice in
    1)
        echo ""
        echo "🏗️  Building Android App Bundle (AAB)..."
        echo ""
        ./gradlew bundleRelease
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "========================================================"
            echo "  ✅ BUILD SUCCESSFUL!"
            echo "========================================================"
            echo ""
            echo "📦 Android App Bundle (AAB) Location:"
            echo "  $(pwd)/app/build/outputs/bundle/release/app-release.aab"
            echo ""
            echo "📊 File Size:"
            ls -lh app/build/outputs/bundle/release/app-release.aab | awk '{print "  " $5}'
            echo ""
            echo "📋 Next Steps:"
            echo "  1. Go to Google Play Console: https://play.google.com/console"
            echo "  2. Navigate to: Your App > Release > Production"
            echo "  3. Click 'Create new release'"
            echo "  4. Upload: app-release.aab"
            echo "  5. Add release notes and roll out"
            echo ""
            echo "📖 For detailed instructions, see:"
            echo "  android/PLAYSTORE.md"
            echo ""
        else
            echo ""
            echo "❌ Build failed. Check errors above."
            exit 1
        fi
        ;;
    2)
        echo ""
        echo "🏗️  Building Release APK..."
        echo ""
        ./gradlew assembleRelease
        
        if [ $? -eq 0 ]; then
            echo ""
            echo "========================================================"
            echo "  ✅ BUILD SUCCESSFUL!"
            echo "========================================================"
            echo ""
            echo "📦 Release APK Location:"
            echo "  $(pwd)/app/build/outputs/apk/release/app-release.apk"
            echo ""
            echo "📊 File Size:"
            ls -lh app/build/outputs/apk/release/app-release.apk | awk '{print "  " $5}'
            echo ""
            echo "📋 Next Steps:"
            echo "  For Play Store:"
            echo "    Upload APK to Google Play Console"
            echo ""
            echo "  For Direct Distribution:"
            echo "    Transfer APK to device and install"
            echo "    or use: adb install app/build/outputs/apk/release/app-release.apk"
            echo ""
            echo "⚠️  Note: AAB is recommended for Play Store (smaller downloads)"
            echo ""
        else
            echo ""
            echo "❌ Build failed. Check errors above."
            exit 1
        fi
        ;;
    *)
        echo "❌ Invalid choice"
        exit 1
        ;;
esac

# Display signing information
echo "🔐 Signing Information:"
if grep -q "signingConfig signingConfigs.release" app/build.gradle; then
    echo "  ✓ Release signing configured (using keystore)"
else
    echo "  ⚠️  No release signing configured"
    echo ""
    echo "  For production, you should either:"
    echo "  1. Use Play App Signing (recommended - upload unsigned AAB)"
    echo "  2. Configure manual signing (see PLAYSTORE.md)"
    echo ""
fi

echo ""
echo "📋 Pre-launch Checklist:"
echo "  [ ] Updated versionCode and versionName in build.gradle"
echo "  [ ] Tested on multiple devices/Android versions"
echo "  [ ] Prepared store listing (icon, screenshots, descriptions)"
echo "  [ ] Set up privacy policy (if needed)"
echo "  [ ] Completed content rating questionnaire"
echo "  [ ] Reviewed ProGuard rules"
echo ""
echo "✨ Ready for Play Store upload!"
echo ""
