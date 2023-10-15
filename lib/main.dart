import 'package:cpm/app.dart';
import 'package:cpm/pages/projects/favorites.dart';
import 'package:cpm/utils/config/config.dart';
import 'package:cpm/utils/config/config_key.dart';
import 'package:cpm/utils/package_info_manager.dart';
import 'package:cpm/utils/preferences/preferences_manager.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  await PreferencesManager().init();
  await PackageInfoManager().init();

  await Config().init();
  await Favorites().init();

  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
    url: Config().get<String>(ConfigKey.supabaseUrl),
    anonKey: Config().get<String>(ConfigKey.supabaseAnonKey),
  );

  FlutterNativeSplash.remove();

  runApp(
    ProviderScope(
      child: EasyLocalization(
        supportedLocales: const <Locale>[
          Locale('en', 'US'),
          Locale('fr', 'FR'),
        ],
        path: 'assets/translations',
        child: App(),
      ),
    ),
  );
}
