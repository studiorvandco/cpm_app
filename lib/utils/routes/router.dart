import 'package:cpm/common/navigation/bottom_navigation.dart';
import 'package:cpm/common/navigation/top_navigation.dart';
import 'package:cpm/pages/home/home_page.dart';
import 'package:cpm/pages/settings/settings_page.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: RouterRoute.home.path,
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return Scaffold(
          appBar: const TopNavigation(),
          body: child,
          bottomNavigationBar: const BottomNavigation(),
        );
      },
      routes: [
        GoRoute(
          name: RouterRoute.home.name,
          path: RouterRoute.home.path,
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          name: RouterRoute.settings.name,
          path: RouterRoute.settings.path,
          builder: (context, state) => const SettingsPage(),
        ),
      ],
    ),
  ],
);
