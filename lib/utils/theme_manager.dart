import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/preferences/preference_key.dart';
import 'package:cpm/utils/preferences/preferences_manager.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:flutter/material.dart';

const _customPrimaryColor = Color(0xFF8189c6);

class ThemeManager {
  static final ThemeManager _singleton = ThemeManager._internal();

  factory ThemeManager() {
    return _singleton;
  }

  ThemeManager._internal();

  late final bool isDynamicThemingAvailable;

  Future<void> init() async {
    isDynamicThemingAvailable = await DynamicColorPlugin.getAccentColor() != null;
  }

  final _customLightColorScheme = ColorScheme.fromSeed(
    seedColor: _customPrimaryColor,
  );

  final _customDarkColorScheme = ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: _customPrimaryColor,
  );

  bool get isLight {
    return Theme.of(navigatorKey.currentContext!).brightness == Brightness.light;
  }

  bool get useDynamicTheming {
    return PreferencesManager().get<bool>(PreferenceKey.dynamicTheming) ??
        PreferenceKey.dynamicTheming.defaultValue! as bool;
  }

  ThemeMode get themeMode {
    final themeModePreference = PreferencesManager().get<int>(PreferenceKey.theme);

    if (themeModePreference != null) {
      switch (themeModePreference) {
        case 0:
          return ThemeMode.system;
        case 1:
          return ThemeMode.light;
        case 2:
          return ThemeMode.dark;
      }
    }

    return ThemeMode.system;
  }

  String get themeModeName {
    final themeModePreference = PreferencesManager().get<int>(PreferenceKey.theme);

    if (themeModePreference != null) {
      switch (themeModePreference) {
        case 0:
          return localizations.settings_theme_system;
        case 1:
          return localizations.settings_theme_light;
        case 2:
          return localizations.settings_theme_dark;
      }
    }

    return localizations.settings_theme_system;
  }

  void setThemeMode(ThemeMode? themeMode) {
    if (themeMode == null) {
      return;
    }

    int value;
    switch (themeMode) {
      case ThemeMode.system:
        value = 0;
      case ThemeMode.light:
        value = 1;
      case ThemeMode.dark:
        value = 2;
    }
    PreferencesManager().set<int>(PreferenceKey.theme.name, value);

    themeModeNotifier.value = themeMode;
  }

  ThemeData getLightDynamicTheme([ColorScheme? lightDynamicColorScheme]) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: lightDynamicColorScheme != null ? lightDynamicColorScheme.harmonized() : _customLightColorScheme,
    );
  }

  ThemeData getDarkDynamicTheme([ColorScheme? darkDynamicColorScheme]) {
    return ThemeData(
      useMaterial3: true,
      colorScheme: darkDynamicColorScheme != null ? darkDynamicColorScheme.harmonized() : _customDarkColorScheme,
    );
  }

  ThemeData get getLightCustomTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _customLightColorScheme,
    );
  }

  ThemeData get getDarkCustomTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _customDarkColorScheme,
    );
  }
}
