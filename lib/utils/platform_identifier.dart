import 'dart:io' show Platform;

import 'package:flutter/foundation.dart' show kIsWeb;

class PlatformIdentifier {
  static final PlatformIdentifier _instance = PlatformIdentifier._internal();

  factory PlatformIdentifier() {
    return _instance;
  }

  PlatformIdentifier._internal();

  /// Whether the platform is a mobile device (only native app).
  bool isMobile() {
    if (kIsWeb) {
      return false;
    }

    return Platform.isAndroid || Platform.isIOS;
  }

  /// Whether the platform is a desktop device.
  ///
  /// Only desktop app.
  bool isDesktop() {
    if (kIsWeb) {
      return true;
    }

    return Platform.isWindows || Platform.isLinux || Platform.isMacOS;
  }

  /// Whether the app runs in a web browser.
  ///
  /// Independently from the platform.
  bool isWeb() {
    return kIsWeb;
  }

  // TODO detect, when running in a web browser, if the platform is desktop or mobile
  /// Whether the platform is a computer
  ///
  /// Desktop app or running in a desktop web browser.
  bool isComputer() {
    return isWeb() || isDesktop();
  }

  // TODO detect, when running in a web browser, if the platform is desktop or mobile
  /// Whether the platform is not a computer.
  ///
  /// Native mobile app or running in a mobile web browser.
  bool isNotComputer() {
    return !isComputer();
  }
}
