# Install

In order to run the frontend of CPM, follow these steps :

1. [Install Flutter](#Flutter)
2. [Install the build tools](#platform-build-tools) for the platforms you need
3. [Configure](#configuration) the app
4. [Run](#run) the app

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

- Use the already installed Microsoft Edge, [Google Chrome](https://www.google.com/intl/fr_fr/chrome/) or any other Chromium navigator

## Configuration

- Replace the API URL in the [config.yaml](assets/config/config.yaml) file

## Run

- Get the dependencies: `flutter pub get`
- Run the app: `flutter run`
