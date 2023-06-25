import 'dart:io';

import 'package:cpm/utils/secure_storage/secure_storage.dart';
import 'package:cpm/utils/secure_storage/secure_storage_key.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'cpm.dart';
import 'services/config.dart';
import 'utils/constants_globals.dart';

// TODO remove for release
class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  Future<void> getToken() async {
    token = await SecureStorage().read(SecureStorageKey.apiToken) ?? '';
  }

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Config.init();
  await EasyLocalization.ensureInitialized();
  EasyLocalization.logger.enableLevels = [LevelMessages.error, LevelMessages.warning];
  await getToken();
  HttpOverrides.global = MyHttpOverrides();
  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[Locale('en', 'US'), Locale('fr', 'FR')],
      path: 'assets/translations',
      child: const ProviderScope(child: CPM()),
    ),
  );
}
