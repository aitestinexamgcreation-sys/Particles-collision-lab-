# Add project specific ProGuard rules here
# For more details, see http://developer.android.com/guide/developing/tools/proguard.html

# Keep WebView JavaScript interface
-keepattributes *Annotation*
-keepattributes JavascriptInterface
-keep class android.webkit.JavascriptInterface { *; }
-keepclassmembers class * {
    @android.webkit.JavascriptInterface <methods>;
}

# Keep WebView classes
-keep class android.webkit.** { *; }
-keep class androidx.webkit.** { *; }

# Keep application classes
-keep class com.particles.collisionlab.** { *; }

# Don't warn about missing platform classes
-dontwarn android.webkit.**
-dontwarn androidx.webkit.**

# Optimize for performance
-optimizationpasses 5
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-dontpreverify
-verbose

# Keep crash reporting info
-keepattributes SourceFile,LineNumberTable
-renamesourcefileattribute SourceFile
