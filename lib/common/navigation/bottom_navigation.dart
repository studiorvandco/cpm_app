import 'dart:io';

import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation();

  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onDestinationSelected(int? index) {
    if (index != null) {
      setState(() {
        _selectedIndex = index;
      });

      switch (index) {
        case 0:
          context.goNamed(RouterRoute.home.name);
        case 1:
          context.goNamed(RouterRoute.settings.name);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid
        ? NavigationBar(
            surfaceTintColor: Theme.of(context).colorScheme.primary,
            destinations: [
              NavigationDestination(
                icon: const Icon(Icons.home_outlined),
                selectedIcon: const Icon(Icons.home),
                label: localizations.navigation_home,
              ),
              NavigationDestination(
                icon: const Icon(Icons.settings_outlined),
                selectedIcon: const Icon(Icons.settings),
                label: localizations.navigation_settings,
              ),
            ],
            selectedIndex: _selectedIndex,
            onDestinationSelected: _onDestinationSelected,
          )
        : CupertinoTabBar(
            items: [
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.house),
                activeIcon: const Icon(CupertinoIcons.house_fill),
                label: localizations.navigation_home,
              ),
              BottomNavigationBarItem(
                icon: const Icon(CupertinoIcons.settings),
                activeIcon: const Icon(CupertinoIcons.settings_solid),
                label: localizations.navigation_settings,
              ),
            ],
            currentIndex: _selectedIndex,
            onTap: _onDestinationSelected,
          );
  }
}
