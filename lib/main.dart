import 'package:easy_localization/easy_localization.dart';
import 'package:easy_logger/easy_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'cpm.dart';
import 'services/config.dart';

void main() async {
  await Supabase.initialize(
    url: 'https://aktiwmbfdcbjyetnippp.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImFrdGl3bWJmZGNianlldG5pcHBwIiwicm9sZSI6ImFub24iLCJpYXQiOjE2ODgzOTE1NTgsImV4cCI6MjAwMzk2NzU1OH0.ot6QLTuGMWs6Rc0nDeyFWUGDx2biZYpKtONcqrLlSZ8',
  );

  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await Config.init();
  await EasyLocalization.ensureInitialized();

  EasyLocalization.logger.enableLevels = [LevelMessages.error, LevelMessages.warning];

  runApp(
    EasyLocalization(
      supportedLocales: const <Locale>[Locale('en', 'US'), Locale('fr', 'FR')],
      path: 'assets/translations',
      child: const ProviderScope(child: CPM()),
    ),
  );
}
