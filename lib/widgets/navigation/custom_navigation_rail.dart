import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/authentication.dart';

class CustomNavigationRail extends ConsumerStatefulWidget {
  const CustomNavigationRail({super.key, required this.navigate});

  final void Function(int) navigate;

  @override
  ConsumerState<CustomNavigationRail> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends ConsumerState<CustomNavigationRail> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
            leading: Builder(builder: (BuildContext context) {
              if (Theme.of(context).brightness == Brightness.light) {
                return Image.asset(
                  'assets/images/logo-cpm-alpha.png',
                  width: 50,
                  filterQuality: FilterQuality.high,
                );
              } else {
                return Image.asset(
                  'assets/images/logo-cpm-white-alpha.png',
                  width: 50,
                  filterQuality: FilterQuality.high,
                );
              }
            }),
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(icon: const Icon(Icons.home_outlined), label: Text('home'.tr())),
              NavigationRailDestination(
                  icon: const Icon(Icons.people_outline), label: Text('members.member.upper'.plural(2))),
              NavigationRailDestination(icon: const Icon(Icons.map), label: Text('locations.location.upper'.plural(2))),
              NavigationRailDestination(icon: const Icon(Icons.settings), label: Text('settings.settings'.tr())),
              NavigationRailDestination(icon: const Icon(Icons.info), label: Text('about.about'.tr())),
              // const NavigationRailDestination(icon: Icon(Icons.quiz), label: Text('Test')),
            ],
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(icon: const Icon(Icons.logout), onPressed: logout),
                ),
              ),
            ),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
                widget.navigate(_selectedIndex);
              });
            },
          ),
        ),
      ),
    );
  }

  void logout() {
    ref.read(authenticationProvider.notifier).logout();
  }
}
