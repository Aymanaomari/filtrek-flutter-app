# Keep Google Play Services
-keep class com.google.android.gms.** { *; }
-dontwarn com.google.android.gms.**

# Suppress Flogger warnings
-dontwarn com.google.common.flogger.**
-keep class com.google.common.flogger.** { *; }

# Keep Google Maps
-keep class com.google.android.libraries.maps.** { *; }
-dontwarn com.google.android.libraries.maps.**
