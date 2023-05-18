import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cpm.dart';
import 'services/config.dart';
import 'utils/constants_globals.dart';

void main() async {
  Future<void> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString(Preferences.token.name) ?? '';
  }

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Config.init();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [LevelMessages.error, LevelMessages.warning];
  await getToken();
  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[Locale('en', 'US'), Locale('fr', 'FR')],
      path: 'assets/translations',
      child: const ProviderScope(child: CPM()),
    ),
  );
}
