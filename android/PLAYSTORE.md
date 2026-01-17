# Google Play Store Release Guide

This guide covers building and publishing the Quantum Collision Lab to Google Play Store.

## Prerequisites

### 1. Google Play Console Account
- Sign up at https://play.google.com/console
- Pay one-time $25 registration fee
- Complete developer profile

### 2. App Signing
Google Play requires app signing. Two options:

**Option A: Play App Signing (Recommended)**
- Google manages your signing keys
- Easier and more secure
- Automatic key rotation
- No local keystore needed

**Option B: Manual Signing**
- You manage your own keystore
- More control but more responsibility
- Keep backups of your keystore!

## Building Release APK/AAB

### Method 1: Android App Bundle (AAB) - Recommended for Play Store

Android App Bundle is the recommended format for Google Play:

```bash
cd android

# Build release AAB
./gradlew bundleRelease

# Output location:
# app/build/outputs/bundle/release/app-release.aab
```

**Why AAB?**
- Smaller download sizes (up to 35% smaller)
- Dynamic delivery
- Google manages APK generation
- Required for apps >150MB

### Method 2: Universal APK

If you need a standalone APK:

```bash
cd android

# Build release APK
./gradlew assembleRelease

# Output location:
# app/build/outputs/apk/release/app-release.apk
```

## App Signing Setup

### Option A: Play App Signing (Recommended)

1. **Build unsigned AAB**
   ```bash
   ./gradlew bundleRelease
   ```

2. **Upload to Play Console**
   - Go to Release > Setup > App integrity
   - Enroll in Play App Signing
   - Upload your AAB
   - Google will sign it for you

3. **Done!** Google manages keys from now on.

### Option B: Manual Signing

1. **Create keystore** (one-time setup)
   ```bash
   # Generate signing key
   keytool -genkey -v -keystore quantum-collision-lab.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias quantum-collision-lab
   
   # Enter strong passwords and keep them safe!
   ```

2. **Create keystore.properties**
   ```bash
   cd android
   nano keystore.properties
   ```
   
   Add (replace with your values):
   ```properties
   storeFile=../quantum-collision-lab.jks
   storePassword=YOUR_STORE_PASSWORD
   keyAlias=quantum-collision-lab
   keyPassword=YOUR_KEY_PASSWORD
   ```

3. **Update build.gradle**
   
   Uncomment signing config in `app/build.gradle`:
   ```gradle
   signingConfigs {
       release {
           def keystorePropertiesFile = rootProject.file("keystore.properties")
           if (keystorePropertiesFile.exists()) {
               def keystoreProperties = new Properties()
               keystoreProperties.load(new FileInputStream(keystorePropertiesFile))
               
               storeFile file(keystoreProperties['storeFile'])
               storePassword keystoreProperties['storePassword']
               keyAlias keystoreProperties['keyAlias']
               keyPassword keystoreProperties['keyPassword']
           }
       }
   }
   
   buildTypes {
       release {
           signingConfig signingConfigs.release
           // ... rest of config
       }
   }
   ```

4. **Build signed release**
   ```bash
   ./gradlew bundleRelease
   # or
   ./gradlew assembleRelease
   ```

5. **IMPORTANT: Backup your keystore!**
   - Store keystore file securely (encrypted cloud storage)
   - Store passwords in password manager
   - **If lost, you can never update your app again!**

## Version Management

Update version before each release in `app/build.gradle`:

```gradle
defaultConfig {
    versionCode 2        // Increment for each release (integer)
    versionName "1.0.1"  // Human-readable version
}
```

**Version Code Rules:**
- Must be higher than previous release
- Integer only
- Never reuse a version code

**Version Name:**
- User-facing version
- Semantic versioning recommended (MAJOR.MINOR.PATCH)

## Google Play Console Setup

### 1. Create App

1. Go to https://play.google.com/console
2. Click "Create app"
3. Fill in:
   - App name: "Quantum Collision Lab"
   - Default language: English (US)
   - App or game: Game
   - Free or paid: Free
   - Accept declarations

### 2. Store Listing

**App Details:**
- **App name:** Quantum Collision Lab
- **Short description (80 chars):**
  ```
  GPU-accelerated particle simulation with 65K particles and stunning effects
  ```
- **Full description (4000 chars):**
  ```
  Experience the mesmerizing world of particle physics with Quantum Collision Lab!
  
  🌟 FEATURES
  • 65,536 particles rendered in real-time on your GPU
  • Multiple lifecycle modes: Respawn, Heat-map, and Energy-preserving
  • Three stunning color systems: Hue rotation, Temporal drift, and Speed-based
  • Advanced physics: gravity, collision detection, and interactive forces
  • Touch to spawn and interact with particles
  • Dynamic Level-of-Detail for smooth performance
  • Minimalist glass-morphism UI
  
  🎮 INTERACTIVE PHYSICS
  Touch and drag to create particle bursts. Watch as they interact with gravity,
  bounce off boundaries, and respond to your touch with realistic physics.
  
  🎨 CUSTOMIZATION
  • Adjust repulsion power for different collision behaviors
  • Control gravity from reverse to intense
  • Change particle colors with hue rotation
  • Set decay rates for different visual effects
  • Adjust simulation speed from slow-motion to hyper-speed
  
  ⚡ PERFORMANCE
  Built with WebGL2 and GPU compute shaders for maximum performance. Dynamic
  LOD ensures smooth 60 FPS even on mid-range devices.
  
  Perfect for:
  • Stress relief through mesmerizing visuals
  • Learning about particle physics
  • Creative expression and art
  • Device performance testing
  
  No ads, no in-app purchases, just pure particle physics simulation!
  ```

**Graphics:**
- **App icon:** 512x512 PNG (create using ICON_README.txt guidance)
- **Feature graphic:** 1024x500 PNG
- **Screenshots:** At least 2, max 8
  - Phone: 320-3840px wide
  - Use screenshots from PR (resize if needed)
  
**Categorization:**
- **App category:** Simulation
- **Tags:** physics, particles, simulation, art, visualization

**Contact details:**
- Email: your-email@example.com
- Privacy policy URL: (if collecting data)
- Website: GitHub repo URL

### 3. Content Rating

Complete questionnaire at Play Console > Content rating

**Sample answers for this app:**
- No violence
- No sexual content
- No controlled substances
- No user-generated content
- No data collection
- Rating: Everyone

### 4. Target Audience

- Primary: 13+
- Secondary: All ages

### 5. Privacy Policy

If NOT collecting any user data:
```
Privacy Policy for Quantum Collision Lab

This application does not collect, store, or share any personal data.
All processing happens locally on your device.

No analytics, no tracking, no data collection of any kind.

Contact: [your-email]
Last updated: [date]
```

Host this on GitHub Pages or your website.

### 6. App Content

- **Ads:** No ads
- **In-app purchases:** None
- **Target audience:** Everyone
- **Content declarations:** None (no sensitive content)

## Pre-Launch Checklist

- [ ] Update versionCode and versionName
- [ ] Test on multiple Android versions (7.0+)
- [ ] Test on different screen sizes
- [ ] Verify WebGL2 works on various devices
- [ ] Check battery usage
- [ ] Test touch interactions
- [ ] Verify full-screen mode
- [ ] Check for crashes (use Firebase Crashlytics)
- [ ] Review ProGuard/R8 obfuscation
- [ ] Test release build thoroughly
- [ ] Prepare store listing assets
- [ ] Screenshot various states
- [ ] Create feature graphic
- [ ] Design app icon
- [ ] Write descriptions
- [ ] Set up privacy policy
- [ ] Complete content rating

## Building for Production

### Final Build Commands

**For Play Store (AAB - Recommended):**
```bash
cd android

# Clean previous builds
./gradlew clean

# Build release bundle
./gradlew bundleRelease

# Verify output
ls -lh app/build/outputs/bundle/release/

# Output: app-release.aab
```

**For Direct Distribution (APK):**
```bash
cd android

# Clean previous builds
./gradlew clean

# Build release APK
./gradlew assembleRelease

# Verify output
ls -lh app/build/outputs/apk/release/

# Output: app-release.apk
```

### Verify Build

```bash
# Check AAB contents
bundletool build-apks --bundle=app/build/outputs/bundle/release/app-release.aab \
  --output=/tmp/my_app.apks

# Install on device for testing
bundletool install-apks --apks=/tmp/my_app.apks
```

## Upload to Play Console

1. **Go to Production Track**
   - Play Console > Your app > Release > Production
   - Click "Create new release"

2. **Upload AAB**
   - Drop `app-release.aab` or click to browse
   - Wait for upload and processing

3. **Release Notes**
   ```
   Version 1.0.0 - Initial Release
   
   🎉 Welcome to Quantum Collision Lab!
   
   Features:
   • 65,536 GPU-accelerated particles
   • Interactive physics simulation
   • Multiple visual modes
   • Touch to create and manipulate particles
   • Dynamic performance optimization
   
   Enjoy the mesmerizing particle effects!
   ```

4. **Review and Roll Out**
   - Review all details
   - Click "Review release"
   - Fix any warnings
   - Click "Start rollout to Production"

## Post-Launch

### Monitoring
- **Play Console Dashboard:** Track installs, ratings, crashes
- **User Reviews:** Respond to feedback
- **Crash Reports:** Fix issues in updates
- **Performance Metrics:** Monitor ANRs, crashes, battery

### Updates

For each update:
1. Increment versionCode
2. Update versionName (semantic versioning)
3. Build new AAB/APK
4. Upload to Play Console
5. Add release notes
6. Roll out (staged rollout recommended)

### Staged Rollout

Start with small percentage:
1. 10% rollout first day
2. Monitor for crashes/issues
3. Increase to 25%, 50%, 100% gradually
4. Halt and fix if issues found

## Troubleshooting

### Build Errors

**ProGuard issues:**
```bash
# Disable temporarily to test
./gradlew assembleRelease -Pandroid.enableR8=false
```

**Signing errors:**
- Check keystore.properties path
- Verify passwords
- Ensure keystore file exists

### Play Console Errors

**App not supported on any devices:**
- Check minSdk (should be 24)
- Review uses-feature declarations
- Check permissions

**Content policy violation:**
- Review content rating
- Check for prohibited content
- Verify privacy policy

## Best Practices

1. **Always use Play App Signing** (let Google manage keys)
2. **Test release builds** before uploading
3. **Use staged rollouts** for safety
4. **Monitor crash reports** closely
5. **Respond to user reviews** promptly
6. **Keep keystore secure** (if self-signing)
7. **Version properly** (never skip version codes)
8. **Document changes** in release notes

## Quick Command Reference

```bash
# Build release AAB (for Play Store)
./gradlew bundleRelease

# Build release APK (for direct distribution)
./gradlew assembleRelease

# Clean builds
./gradlew clean

# Check for lint issues
./gradlew lint

# Run tests
./gradlew test

# Install release on device
adb install app/build/outputs/apk/release/app-release.apk
```

## Resources

- **Play Console:** https://play.google.com/console
- **Android Publishing Guide:** https://developer.android.com/studio/publish
- **App Signing:** https://support.google.com/googleplay/android-developer/answer/9842756
- **Content Policy:** https://support.google.com/googleplay/android-developer/topic/9858052

## Support

For issues:
1. Check Play Console help center
2. Review Android developer documentation
3. Test on physical devices
4. Use Play Console pre-launch reports

---

**Version:** 1.0.0  
**Last Updated:** 2026-01-17  
**Status:** Production Ready
