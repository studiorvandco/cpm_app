import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'models/event.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'providers/authentication.dart';
import 'providers/theme.dart';
import 'services/config.dart';
import 'utils/constants_globals.dart';
import 'utils/themes.dart';

void main() async {
  Future<void> getToken() async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    token = preferences.getString(Preferences.token.name) ?? '';
  }

  WidgetsFlutterBinding.ensureInitialized();
  await Config.init();
  await EasyLocalization.ensureInitialized();
  await getToken();
  runApp(
    EasyLocalization(
        supportedLocales: const <Locale>[Locale('en', 'US'), Locale('fr', 'FR')],
        path: 'assets/translations',
        child: const ProviderScope(child: CPM())),
  );
}

class CPM extends ConsumerStatefulWidget {
  const CPM({super.key});

  @override
  ConsumerState<CPM> createState() => _CPMState();
}

class _CPMState extends ConsumerState<CPM> {
  @override
  Widget build(BuildContext context) {
    return CalendarControllerProvider<Event>(
      controller: EventController<Event>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: ref.watch(authenticationProvider).when(data: (bool authenticated) {
          if (authenticated) {
            return const Home();
          } else {
            return const Login();
          }
        }, error: (Object error, StackTrace stackTrace) {
          return const Login();
        }, loading: () {
          return const Login();
        }),
        title: 'Cinema Project Manager',
        theme: Themes().light,
        darkTheme: Themes().dark,
        themeMode: ref.watch(themeProvider),
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
      ),
    );
  }
}
