# Launcher Icon Placeholder

Due to limitations, actual PNG icons cannot be generated in this environment.

To add proper launcher icons:

1. Use Android Studio's Image Asset tool:
   - Right-click res folder
   - New > Image Asset
   - Choose icon type: Launcher Icons
   - Configure foreground/background
   - Generate all densities

2. Or use online tools:
   - https://romannurik.github.io/AndroidAssetStudio/
   - Upload your icon design
   - Download generated icon set
   - Copy to res/mipmap-* folders

3. Default icon files needed:
   - res/mipmap-hdpi/ic_launcher.png (72x72)
   - res/mipmap-mdpi/ic_launcher.png (48x48)
   - res/mipmap-xhdpi/ic_launcher.png (96x96)
   - res/mipmap-xxhdpi/ic_launcher.png (144x144)
   - res/mipmap-xxxhdpi/ic_launcher.png (192x192)

Recommended icon design:
- Cyan/purple gradient background matching app theme
- Particle burst or collision symbol
- Text: "QCL" or collision icon
