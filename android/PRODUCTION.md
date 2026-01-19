# Production Release Quick Start

## For Google Play Store Upload

### Step 1: Build Production AAB

```bash
cd android
./build-release.sh
```

Select option 1 (Android App Bundle)

**Output:** `app/build/outputs/bundle/release/app-release.aab`

### Step 2: Upload to Play Console

1. Go to: https://play.google.com/console
2. Select your app (or create new app)
3. Navigate to: **Release > Production**
4. Click **"Create new release"**
5. Upload `app-release.aab`
6. Add release notes
7. Click **"Review release"**
8. Click **"Start rollout to Production"**

### Step 3: First-Time Setup (if new app)

Complete these sections in Play Console:

**Required:**
- [ ] Store listing (name, description, screenshots, icon)
- [ ] Content rating questionnaire
- [ ] Target audience
- [ ] News app declaration (select "No")
- [ ] Privacy policy (if collecting data)
- [ ] App access (all features accessible)
- [ ] Ads declaration (select "No" if no ads)

**Recommended:**
- [ ] Set up pricing & distribution
- [ ] Configure in-app products (if any)
- [ ] Add developer contact information
- [ ] Upload feature graphic
- [ ] Add promotional text

## App Signing

### Recommended: Play App Signing

Let Google manage your signing keys (easiest and most secure):

1. Upload your AAB (unsigned or signed with upload key)
2. Google signs the final APK for distribution
3. No need to manage production keystore

### Alternative: Manual Signing

If you prefer to manage your own keys:

1. Generate keystore:
   ```bash
   keytool -genkey -v -keystore quantum-collision-lab.jks \
     -keyalg RSA -keysize 2048 -validity 10000 \
     -alias quantum-collision-lab
   ```

2. Create `keystore.properties`:
   ```bash
   cp keystore.properties.template keystore.properties
   # Edit with your values
   ```

3. Uncomment signing config in `app/build.gradle`

4. Build signed AAB:
   ```bash
   ./gradlew bundleRelease
   ```

## Version Management

Before each release, update in `app/build.gradle`:

```gradle
versionCode 2        // Increment (must be higher than previous)
versionName "1.0.1"  // User-facing version (semantic versioning)
```

## Required Assets

See `ASSETS.md` for details on creating:

- [ ] App icon (512x512 PNG)
- [ ] Feature graphic (1024x500 PNG)
- [ ] Screenshots (2-8 phone screenshots)
- [ ] Short description (80 chars max)
- [ ] Full description (4000 chars max)

**Use existing screenshots:**
- https://github.com/user-attachments/assets/63123fca-f1e6-4ef0-8ec2-27f23f573b2b
- https://github.com/user-attachments/assets/fcd519e7-a6ed-416b-8189-31a99eab191c

## Pre-Launch Checklist

- [ ] Tested on physical devices (Android 7.0+)
- [ ] Verified WebGL2 works on target devices
- [ ] Checked for crashes and ANRs
- [ ] Updated versionCode and versionName
- [ ] Prepared all store listing assets
- [ ] Completed content rating
- [ ] Set up privacy policy (if needed)
- [ ] Reviewed ProGuard rules
- [ ] Tested release build thoroughly

## Build Commands Reference

```bash
# Production AAB (for Play Store)
./build-release.sh
# or
./gradlew bundleRelease

# Production APK (for direct distribution)
./gradlew assembleRelease

# Clean build
./gradlew clean

# Debug build (for testing)
./gradlew assembleDebug
```

## Troubleshooting

### Build fails
```bash
./gradlew clean
./gradlew bundleRelease --stacktrace
```

### Signing issues
- Check `keystore.properties` exists and has correct values
- Verify keystore file path is correct
- Ensure passwords are correct

### Play Console rejects upload
- Check minSdk is 24 or higher
- Verify targetSdk is recent (34)
- Ensure versionCode is higher than previous
- Review ProGuard/R8 configuration

## Support Documentation

- **Complete guide:** `PLAYSTORE.md`
- **Asset creation:** `ASSETS.md`
- **Build setup:** `README.md`
- **Architecture:** `ARCHITECTURE.md`

## Quick Links

- **Play Console:** https://play.google.com/console
- **Developer Docs:** https://developer.android.com/studio/publish
- **App Signing:** https://support.google.com/googleplay/android-developer/answer/9842756

---

**Ready for production!** 🚀

For detailed instructions, see `PLAYSTORE.md`
