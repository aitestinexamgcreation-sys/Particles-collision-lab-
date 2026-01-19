# Android APK Build Instructions

This directory contains an Android WebView wrapper for the Quantum Collision Lab particle simulation.

## Architecture Decision

**Chosen Approach: WebView Wrapper (WebGL2)**
- Maintains the existing WebGL2 implementation
- Provides Android APK without complete rewrite
- Enables hardware-accelerated WebGL on Android
- Faster to deploy and maintain

**Alternative (Not Implemented): Native Vulkan**
- Would require complete C++ rewrite
- SPIR-V shaders instead of GLSL
- Complex Vulkan rendering pipeline
- Significant development effort

## Prerequisites

1. **Android Studio** (Arctic Fox or later)
2. **Java JDK** 8 or later
3. **Android SDK** with:
   - SDK Platform 34 (Android 14)
   - Build Tools 34.0.0+
   - NDK (optional, for future Vulkan port)

## Building the APK

### Method 1: Using Android Studio (Recommended)

1. Open Android Studio
2. Select "Open an Existing Project"
3. Navigate to the `android` directory
4. Wait for Gradle sync to complete
5. Build APK:
   - **Debug APK**: Build > Build Bundle(s) / APK(s) > Build APK(s)
   - **Release APK**: Build > Generate Signed Bundle / APK

The APK will be generated at:
```
android/app/build/outputs/apk/debug/app-debug.apk
```

### Method 2: Using Command Line (Gradle)

From the `android` directory:

```bash
# Build debug APK
./gradlew assembleDebug

# Build release APK (requires signing configuration)
./gradlew assembleRelease

# Install on connected device
./gradlew installDebug
```

### Method 3: Using Gradle Wrapper (if gradlew not present)

```bash
# Download Gradle wrapper first
gradle wrapper --gradle-version 8.1

# Then build
./gradlew assembleDebug
```

## APK Output Location

After building, the APK will be located at:
- **Debug**: `android/app/build/outputs/apk/debug/app-debug.apk`
- **Release**: `android/app/build/outputs/apk/release/app-release.apk`

## Installing the APK

### On Physical Device
1. Enable "Unknown Sources" in device settings
2. Transfer APK to device
3. Open APK file to install

### Using ADB
```bash
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

## WebGL Support on Android

The app requires:
- **Android 7.0 (API 24)** or later
- **OpenGL ES 3.0** support
- Hardware acceleration enabled

Most modern Android devices (2016+) support these requirements.

## Features

The Android app includes:
- ✅ Full WebGL2 particle simulation (65,536 particles)
- ✅ Hardware-accelerated rendering
- ✅ Touch input support (already implemented via pointer events)
- ✅ Landscape mode optimized
- ✅ Immersive fullscreen
- ✅ Screen always on during simulation

## Performance Notes

**WebView vs Native Vulkan Performance:**
- WebView: 30-60 FPS on modern devices
- Native Vulkan: Could achieve 90-120 FPS but requires complete rewrite

For most use cases, WebView performance is acceptable. For production apps requiring maximum performance, consider the native Vulkan rewrite.

## Troubleshooting

### WebGL not working
- Check device supports OpenGL ES 3.0
- Ensure hardware acceleration is enabled in manifest
- Check Chrome WebView version (should be recent)

### Black screen on launch
- Check logcat for errors: `adb logcat | grep chromium`
- Verify index.html is in assets folder
- Check WebView permissions in manifest

### Build errors
- Ensure Android SDK is up to date
- Check Gradle version compatibility
- Clean build: `./gradlew clean`

## Future Enhancements

### Potential Native Vulkan Port
If maximum performance is required, consider:
1. Create native C++ library with NDK
2. Implement Vulkan rendering pipeline
3. Port GLSL shaders to SPIR-V
4. Use Vulkan compute for particle physics
5. Integrate with Android activity via JNI

Estimated effort: 2-4 weeks of development for full native port.

## File Structure

```
android/
├── app/
│   ├── src/main/
│   │   ├── java/com/particles/collisionlab/
│   │   │   └── MainActivity.java          # WebView host activity
│   │   ├── res/                           # Android resources
│   │   │   ├── values/
│   │   │   │   ├── strings.xml
│   │   │   │   ├── styles.xml
│   │   │   │   └── colors.xml
│   │   │   └── mipmap-*/                  # Launcher icons
│   │   ├── assets/
│   │   │   └── index.html                 # WebGL2 particle simulation
│   │   └── AndroidManifest.xml
│   ├── build.gradle                       # App-level build config
│   └── proguard-rules.pro
├── build.gradle                           # Project-level build config
├── settings.gradle
└── gradle.properties
```

## License

Same as parent project.
