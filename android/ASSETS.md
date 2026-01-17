# Google Play Store Assets

This directory contains templates and guidelines for creating Play Store assets.

## Required Assets

### 1. App Icon (512x512)
**File:** `ic_launcher-playstore.png`
**Size:** 512x512 pixels
**Format:** 32-bit PNG with alpha
**Shape:** Full square (no rounded corners, Google adds them)

**Design Guidelines:**
- Use app theme colors (cyan #00f2ff and purple #7000ff)
- Particle burst or collision symbol
- Simple and recognizable
- No text (app name shown separately)

**Create using:**
- Android Studio: File > New > Image Asset
- Online: https://romannurik.github.io/AndroidAssetStudio/
- Design tools: Figma, Adobe Illustrator, Inkscape

**Suggested design:**
```
Gradient background (purple to cyan)
Stylized particle collision burst in center
Glowing effect matching app aesthetic
```

### 2. Feature Graphic (1024x500)
**File:** `feature-graphic.png`
**Size:** 1024x500 pixels
**Format:** PNG or JPEG
**Required:** Yes

**Content:**
- App name: "Quantum Collision Lab"
- Tagline: "65K Particles. Infinite Possibilities."
- Background: Particle simulation screenshot with overlay
- Theme: Match app's dark glass-morphism style

**Design template:**
```
[Left side: Particle burst visual]
[Right side: Text]
  QUANTUM
  COLLISION LAB
  
  65,536 GPU-Accelerated Particles
  Interactive Physics Simulation
```

### 3. Screenshots
**Phone Screenshots (Required: 2-8)**
**Size:** Minimum 320px, Maximum 3840px on longest side
**Format:** PNG or JPEG

**Required screenshots:**
1. Main simulation view with particles
2. UI panel showing controls
3. Different color mode (heat-map or speed-based)
4. Particle interaction (touch spawning)

**Available from PR:**
- Screenshot 1: https://github.com/user-attachments/assets/63123fca-f1e6-4ef0-8ec2-27f23f573b2b
- Screenshot 2: https://github.com/user-attachments/assets/fcd519e7-a6ed-416b-8189-31a99eab191c

**Prepare screenshots:**
1. Take screenshots on Android device
2. Resize to fit Play Store requirements (1080x1920 or 1080x2340)
3. Optionally add frame or border
4. Number them: screenshot-1.png, screenshot-2.png, etc.

### 4. Promotional Graphics (Optional but Recommended)

**Promo Graphic (180x120)**
- Used in various Play Store promotions
- Similar to feature graphic but smaller

**TV Banner (1280x720)**
- Only if supporting Android TV
- Not required for this app

## Content Guidelines

### Short Description (80 characters max)
```
GPU-accelerated particle simulation with 65K particles and stunning effects
```

### Full Description (4000 characters max)
See PLAYSTORE.md for complete description template

### App Category
**Primary:** Simulation
**Secondary:** Entertainment

### Tags (up to 5)
1. physics
2. particles
3. simulation
4. art
5. interactive

## Creating Assets Locally

### Using Android Studio

1. **App Icon:**
   ```
   Right-click res/
   New > Image Asset
   Icon Type: Launcher Icons (Adaptive and Legacy)
   Configure foreground/background layers
   Generate all densities
   ```

2. **Export screenshots:**
   ```
   Run app on device/emulator
   Press Ctrl+S (Windows/Linux) or Cmd+S (Mac)
   Or use adb:
   adb shell screencap -p /sdcard/screenshot.png
   adb pull /sdcard/screenshot.png
   ```

### Using Online Tools

**Icon Generator:**
- https://romannurik.github.io/AndroidAssetStudio/icons-launcher.html
- Upload or design icon
- Download all densities

**Screenshot Framer:**
- https://www.appmockup.com/
- https://screenshots.pro/
- Add device frames to screenshots

### Using Design Software

**Figma (Free):**
1. Create 512x512 artboard for icon
2. Create 1024x500 artboard for feature graphic
3. Design with brand colors
4. Export as PNG

**Inkscape (Free):**
1. New document
2. Set dimensions
3. Design vector graphics
4. Export as PNG at required size

## File Structure

```
play-store-assets/
├── icon/
│   └── ic_launcher-playstore.png        (512x512)
├── feature-graphic/
│   └── feature-graphic.png              (1024x500)
├── screenshots/
│   ├── phone/
│   │   ├── screenshot-1.png
│   │   ├── screenshot-2.png
│   │   ├── screenshot-3.png
│   │   └── screenshot-4.png
│   └── tablet/ (optional)
└── promo/ (optional)
    └── promo-graphic.png                (180x120)
```

## Quick Asset Checklist

Before uploading to Play Console:

- [ ] App icon (512x512 PNG)
- [ ] Feature graphic (1024x500 PNG/JPG)
- [ ] At least 2 phone screenshots
- [ ] Short description (80 chars)
- [ ] Full description (max 4000 chars)
- [ ] App category selected
- [ ] Content rating completed
- [ ] Privacy policy URL (if applicable)
- [ ] Contact email

## Design Tips

### Color Palette
Use app theme colors:
- Primary: #00f2ff (Cyan)
- Secondary: #7000ff (Purple)
- Background: #020205 (Dark)
- Accent: Gradient between primary and secondary

### Typography
- Clean, modern sans-serif
- High contrast for readability
- Consider: Roboto, Inter, Space Grotesk

### Visual Style
- Dark theme with neon accents
- Glass-morphism effects
- Particle/glowing elements
- High contrast

## Resources

**Icon Design:**
- Material Design Icons: https://material.io/design/iconography
- Icon guidelines: https://developer.android.com/google-play/resources/icon-design-specifications

**Screenshots:**
- Screenshot guidelines: https://support.google.com/googleplay/android-developer/answer/9866151

**Feature Graphic:**
- Asset guidelines: https://support.google.com/googleplay/android-developer/answer/9866151

**Tools:**
- Android Asset Studio: https://romannurik.github.io/AndroidAssetStudio/
- Figma: https://www.figma.com/
- Inkscape: https://inkscape.org/

## Next Steps

1. Create app icon (512x512)
2. Design feature graphic (1024x500)
3. Capture screenshots (2-8)
4. Write store listing copy
5. Upload to Play Console
6. Complete all required fields
7. Submit for review

---

**Need help?**
- Check Play Console help center
- Review design guidelines
- Test different designs with users
- A/B test if possible after launch
