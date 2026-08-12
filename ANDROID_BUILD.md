# Android Build Instructions

## Prerequisites

- Flutter SDK 3.22.0+
- Android SDK 21+
- Java JDK 11+
- Android Studio (recommended)

## Setup

### 1. Configure Android SDK

```bash
flutter doctor -v
```

### 2. Create Signing Key

```bash
keytool -genkey -v -keystore key.jks -keyalg RSA -keysize 2048 -validity 10000 -alias android
```

Then copy `key.jks` to `android/` directory.

### 3. Configure Signing

Create `android/key.properties`:

```properties
storeFile=../key.jks
storePassword=<your_password>
keyAlias=android
keyPassword=<your_password>
```

## Building

### Development Build

```bash
flutter run
```

### Release APK

```bash
flutter build apk --release
```

Output: `build/app/outputs/flutter-apk/app-release.apk`

### Release App Bundle (for Google Play)

```bash
flutter build appbundle --release
```

Output: `build/app/outputs/bundle/release/app-release.aab`

## Automated Scripts

### Build Configuration

```bash
bash scripts/build.sh
```

### Build APK

```bash
bash scripts/build_apk.sh
```

### Build AAB

```bash
bash scripts/build_aab.sh
```
