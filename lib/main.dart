import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:provider/provider.dart' as provider;

import 'models/event.dart';
import 'pages/home.dart';
import 'pages/login.dart';
import 'providers/authentication.dart';
import 'services/config.dart';
import 'settings.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Config.init();
  await EasyLocalization.ensureInitialized();
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
    return provider.ChangeNotifierProvider<ModelTheme>(
        create: (_) => ModelTheme(),
        child: provider.Consumer<ModelTheme>(builder: (BuildContext context, ModelTheme themeNotifier, Widget? child) {
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
              theme: CPMThemeLight().theme,
              darkTheme: CPMThemeDark().theme,
              themeMode: themeNotifier.themeMode,
              localizationsDelegates: context.localizationDelegates,
              supportedLocales: context.supportedLocales,
              locale: context.locale,
            ),
          );
        }));
  }
}
