# Build

In order to run the frontend of CPM, follow these steps :

- [Flutter](#flutter)
- [Platform build tools](#platform-build-tools)
  - [Windows](#windows)
  - [Android](#android)
  - [Web](#web)
- [Configuration](#configuration)
  - [General](#general)
  - [Android](#android-1)
- [Run](#run)
- [Build](#build-1)

## Flutter

- Flutter SDK (stable) :
  - [Download the ZIP file](https://docs.flutter.dev/get-started/install) for your OS
  - Decompress the files somewhere
  - Add the path to `flutter\bin` to your `Path` environment variable

## Platform build tools

### Windows

- Visual Studio Build Tools :
  - [Download the Visual Studio installer](https://visualstudio.microsoft.com/fr/downloads)
  - Install the "Desktop development with C++" workload
  - Check "C++ ATL for latest version build tools" under Optional

### Android

- Android Studio :
  - [Download](https://developer.android.com/studio) and install it

### Web

- Use the already installed Microsoft
  Edge, [Google Chrome](https://www.google.com/intl/fr_fr/chrome/) or any other Chromium navigator

## Configuration

### General

- Replace the API URL in the [config.yaml](assets/config/config.yaml) file

### Android

- Signing configuration to build for release:
  - Place your `.jks` keystore file in the `android` directory (
      example: `android/my_keystore.jks`)
  - Place your `key.properties` file in the `android` directory with the following values:

  ```properties
  storePassword=<password>
  keyPassword=<password>
  keyAlias=<alias>
  storeFile=../my_keystore.jks
  ```

## Run

- Get the dependencies: `flutter pub get`
- Run the app: `flutter run`

## Build

- Run the [build command](https://docs.flutter.dev/deployment) for the platform
- Use the `--release` flag to create a release build
