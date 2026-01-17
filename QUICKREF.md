# Quick Reference Card

## 🌐 Web Version

**Start:**
```bash
python3 -m http.server 8000
# Visit http://localhost:8000
```

**Or:**
- Just open `index.html` in browser

**Requirements:**
- Modern browser with WebGL2
- Chrome 56+, Firefox 51+, Edge 79+

---

## 📱 Android APK

**Build:**
```bash
cd android
./build.sh
```

**Output:**
```
android/app/build/outputs/apk/debug/app-debug.apk
```

**Install:**
```bash
adb install app/build/outputs/apk/debug/app-debug.apk
```

**Requirements:**
- Android 7.0+ (API 24)
- OpenGL ES 3.0 support
- Java JDK 8+

---

## 🎮 Controls

### Spawn Particles
- Click/tap and drag on canvas
- Particles attracted to pointer

### UI Controls
- **Lifecycle**: Respawn | Heat-map | Energy
- **Color**: Hue Rotate | Temporal | Speed
- **Physics**: Repulsion, Radius, Gravity, etc.
- **Minimize**: Click arrow in top-left

### Reset
- Click "PURGE SYSTEM" button

---

## 📚 Documentation

| File | Description |
|------|-------------|
| `README.md` | Project overview |
| `SETUP.md` | Complete setup guide |
| `android/README.md` | Android build guide |
| `android/ARCHITECTURE.md` | WebView vs Vulkan decision |

---

## 🔧 Troubleshooting

### Web: WebGL not working
```bash
# Check browser support
# Update to latest version
# Enable hardware acceleration
```

### Android: Build fails
```bash
cd android
./gradlew clean
gradle wrapper --gradle-version 8.1
./gradlew assembleDebug
```

### Android: Black screen
```bash
# Check logcat
adb logcat | grep chromium

# Update WebView
# Settings > Apps > Android System WebView > Update
```

---

## ⚡ Performance

| Platform | FPS | Notes |
|----------|-----|-------|
| Web (Desktop) | 60 | Modern GPU |
| Web (Laptop) | 30-45 | Integrated graphics |
| Android (Flagship) | 40-60 | 2020+ devices |
| Android (Mid-range) | 25-40 | Dynamic LOD helps |

**Tip:** Enable "Dynamic LOD" for better performance

---

## 📦 File Structure

```
Particles-collision-lab-/
├── index.html              # WebGL2 simulation
├── README.md               # Overview
├── SETUP.md                # Setup guide
└── android/                # Android APK
    ├── README.md           # Build instructions
    ├── ARCHITECTURE.md     # Design decisions
    ├── build.sh            # Quick build script
    ├── app/
    │   └── src/main/
    │       ├── java/       # Java code
    │       ├── res/        # Android resources
    │       └── assets/     # index.html copy
    └── build.gradle        # Build config
```

---

## 🚀 Quick Commands

**Web:**
```bash
python3 -m http.server 8000
```

**Android:**
```bash
cd android && ./build.sh
```

**Install:**
```bash
adb install android/app/build/outputs/apk/debug/app-debug.apk
```

**View logs:**
```bash
adb logcat | grep chromium
```

---

## 💡 Tips

1. **Web**: Use Chrome for best WebGL2 support
2. **Android**: Update Chrome WebView for best performance
3. **Performance**: Enable Dynamic LOD if FPS is low
4. **Troubleshooting**: Check browser/logcat console
5. **Customization**: Edit `index.html` for both platforms

---

## 🔗 Links

- GitHub: [aitestinexamgcreation-sys/Particles-collision-lab-](https://github.com/aitestinexamgcreation-sys/Particles-collision-lab-)
- WebGL2 Spec: https://www.khronos.org/webgl/
- Android Docs: https://developer.android.com/

---

**Version:** 6.2  
**Last Updated:** 2026-01-17  
**Platform:** Web + Android (WebView)
