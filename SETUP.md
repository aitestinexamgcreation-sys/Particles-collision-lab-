# Quantum Collision Lab - Complete Setup Guide

This guide covers setup for both the web version and Android APK.

## Table of Contents
1. [Web Version Setup](#web-version-setup)
2. [Android APK Setup](#android-apk-setup)
3. [Development Setup](#development-setup)
4. [Troubleshooting](#troubleshooting)

---

## Web Version Setup

### Prerequisites
- Modern web browser with WebGL2 support:
  - Chrome 56+ (recommended)
  - Firefox 51+
  - Edge 79+
  - Safari 15+

### Running Locally

#### Option 1: Direct File Open
Simply open `index.html` in your browser. This works for most browsers.

#### Option 2: Local Server (Recommended)
Some browsers require a local server for full WebGL support.

**Using Python:**
```bash
python3 -m http.server 8000
# Visit http://localhost:8000
```

**Using Node.js:**
```bash
npx serve
# Visit http://localhost:3000
```

**Using PHP:**
```bash
php -S localhost:8000
# Visit http://localhost:8000
```

### Verification
1. Open the page
2. Click anywhere on the canvas to spawn particles
3. Check FPS counter in bottom-right
4. Verify UI controls work

---

## Android APK Setup

### Prerequisites

#### 1. Install Java JDK
```bash
# Ubuntu/Debian
sudo apt install openjdk-11-jdk

# macOS
brew install openjdk@11

# Windows
# Download from: https://www.oracle.com/java/technologies/downloads/
```

Verify installation:
```bash
java -version
# Should show version 8 or later
```

#### 2. Install Android Studio (Optional but Recommended)
Download from: https://developer.android.com/studio

Android Studio includes:
- Android SDK
- Build tools
- Emulator
- Visual IDE

#### 3. Install Android SDK (If not using Android Studio)
```bash
# Using command-line tools
# Download from: https://developer.android.com/studio#command-tools

# Set environment variables
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools
```

### Building the APK

#### Method 1: Quick Build Script (Easiest)
```bash
cd android
./build.sh
```

The script will:
1. Check Java installation
2. Download Gradle wrapper if needed
3. Build debug APK
4. Show APK location

#### Method 2: Using Gradle Directly
```bash
cd android

# First time: Download Gradle wrapper
gradle wrapper --gradle-version 8.1

# Build debug APK
./gradlew assembleDebug

# Build release APK (requires signing)
./gradlew assembleRelease
```

#### Method 3: Using Android Studio
1. Open Android Studio
2. File > Open > Select `android` folder
3. Wait for Gradle sync
4. Build > Build Bundle(s) / APK(s) > Build APK(s)
5. Click "locate" in the notification to find APK

### APK Output Location
```
android/app/build/outputs/apk/debug/app-debug.apk
```

### Installing the APK

#### On Emulator
```bash
# Start emulator
emulator -avd Pixel_6_API_33

# Install APK
adb install app/build/outputs/apk/debug/app-debug.apk
```

#### On Physical Device
1. Enable "Unknown Sources" in device settings:
   - Settings > Security > Unknown Sources
   - Or Settings > Apps > Special Access > Install Unknown Apps

2. Transfer APK to device:
   ```bash
   # Via ADB
   adb install app/build/outputs/apk/debug/app-debug.apk
   
   # Or copy file to device and install manually
   ```

3. Open APK file on device to install

### Device Requirements
- Android 7.0 (API 24) or later
- OpenGL ES 3.0 support
- ~50 MB storage space
- Hardware acceleration enabled

---

## Development Setup

### Modifying the Simulation

The main simulation code is in `index.html`. Key sections:

**Particle Count:**
```javascript
const PARTICLE_COUNT = 65536; // Modify here
```

**Physics Shaders:**
```glsl
// Update shader (lines ~250-350)
// Modify gravity, collision, etc.
```

**Rendering:**
```glsl
// Fragment shader (lines ~400-500)
// Modify colors, glow effects
```

### Making Changes

#### For Web Version:
1. Edit `index.html`
2. Refresh browser to see changes
3. Check browser console for errors

#### For Android Version:
1. Edit `index.html`
2. Copy to Android assets:
   ```bash
   cp index.html android/app/src/main/assets/
   ```
3. Rebuild APK:
   ```bash
   cd android
   ./gradlew assembleDebug
   ```
4. Install updated APK

### Testing

**Web:**
```bash
# Start local server
python3 -m http.server 8000

# Open in browser
# Check console for WebGL errors
# Monitor FPS counter
```

**Android:**
```bash
# View logs
adb logcat | grep chromium

# Check WebView version
adb shell dumpsys webviewupdate

# Monitor performance
adb shell dumpsys gfxinfo com.particles.collisionlab
```

---

## Troubleshooting

### Web Version Issues

#### WebGL Not Available
**Problem:** "WebGL2 is not supported" error

**Solution:**
- Update browser to latest version
- Enable hardware acceleration in browser settings
- Try different browser (Chrome recommended)
- Check GPU drivers are up to date

#### Poor Performance
**Problem:** Low FPS, laggy simulation

**Solution:**
- Enable Dynamic LOD in UI
- Reduce particle count in code
- Close other browser tabs
- Update GPU drivers
- Try in different browser

#### Blank/Black Screen
**Problem:** Page loads but nothing appears

**Solution:**
- Check browser console for errors
- Verify WebGL2 support
- Try different browser
- Clear browser cache
- Check if JavaScript is enabled

### Android Issues

#### Build Fails
**Problem:** Gradle build errors

**Solution:**
```bash
# Clean build
cd android
./gradlew clean

# Update Gradle wrapper
gradle wrapper --gradle-version 8.1

# Check Java version
java -version  # Should be 8+

# Ensure ANDROID_HOME is set
echo $ANDROID_HOME
```

#### APK Won't Install
**Problem:** Installation blocked on device

**Solution:**
- Enable "Unknown Sources" in settings
- Check device has enough storage
- Ensure Android version is 7.0+
- Try uninstalling old version first

#### WebGL Not Working on Device
**Problem:** Blank screen or poor performance

**Solution:**
- Check device supports OpenGL ES 3.0
- Update Chrome WebView:
  - Settings > Apps > Android System WebView > Update
- Check in logcat:
  ```bash
  adb logcat | grep -i webgl
  ```
- Verify hardware acceleration in manifest

#### Touch Input Not Working
**Problem:** Can't interact with simulation

**Solution:**
- Check pointer events in code
- Verify WebView touch events enabled
- Test with Chrome browser first
- Check logcat for JavaScript errors

### Performance Issues

#### Low FPS on Web
**Solutions:**
1. Enable Dynamic LOD
2. Reduce particle count
3. Disable browser extensions
4. Update GPU drivers
5. Close background applications

#### Low FPS on Android
**Solutions:**
1. Enable Dynamic LOD
2. Close background apps
3. Ensure device isn't in power-saving mode
4. Update Chrome WebView
5. Check device temperature (throttling)

### Common Error Messages

#### "GL_INVALID_OPERATION"
**Cause:** Transform feedback buffer conflict
**Solution:** This is expected in some environments, simulation still works

#### "Failed to load resource"
**Cause:** Google Fonts blocked
**Solution:** Ignore, fonts are optional and have fallbacks

#### "WebGL context lost"
**Cause:** GPU crash or too much memory usage
**Solution:** 
- Reload page
- Reduce particle count
- Update GPU drivers

---

## Additional Resources

### WebGL2 Documentation
- https://www.khronos.org/webgl/
- https://developer.mozilla.org/en-US/docs/Web/API/WebGL_API

### Android Development
- https://developer.android.com/docs
- https://developer.android.com/guide/webapps/webview

### Performance Profiling
- Chrome DevTools > Performance
- Android Studio > Profiler
- `adb shell dumpsys gfxinfo`

---

## Support

For issues or questions:
1. Check this troubleshooting guide
2. Review browser/Android logs
3. Open an issue on GitHub with:
   - Platform (Web/Android)
   - Browser/Device info
   - Error messages
   - Steps to reproduce

---

## Next Steps

After successful setup:
1. ✅ Verify web version works
2. ✅ Build and install Android APK
3. ✅ Explore different modes and controls
4. ✅ Experiment with parameters
5. ✅ Modify code for custom effects

Enjoy the particle simulation! 🎆
