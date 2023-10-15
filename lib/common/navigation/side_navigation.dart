import 'package:cpm/common/dialogs/logout_dialog.dart';
import 'package:cpm/providers/authentication/authentication.dart';
import 'package:cpm/utils/asset.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SideNavigation extends ConsumerStatefulWidget {
  const SideNavigation({super.key});

  @override
  ConsumerState<SideNavigation> createState() => _CustomNavigationRailState();
}

class _CustomNavigationRailState extends ConsumerState<SideNavigation> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ConstrainedBox(
        constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
        child: IntrinsicHeight(
          child: NavigationRail(
            leading: Builder(
              builder: (BuildContext context) {
                return Image.asset(Asset.cpm.path, width: 50, filterQuality: FilterQuality.medium);
              },
            ),
            labelType: NavigationRailLabelType.all,
            destinations: <NavigationRailDestination>[
              NavigationRailDestination(icon: const Icon(Icons.movie), label: Text('projects.project.upper'.plural(2))),
              NavigationRailDestination(icon: const Icon(Icons.people), label: Text('members.member.upper'.plural(2))),
              NavigationRailDestination(icon: const Icon(Icons.map), label: Text('locations.location.upper'.plural(2))),
              NavigationRailDestination(icon: const Icon(Icons.settings), label: Text('settings.settings'.tr())),
              NavigationRailDestination(icon: const Icon(Icons.info), label: Text('about.about'.tr())),
            ],
            trailing: Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: IconButton(icon: const Icon(Icons.logout), onPressed: () => logout()),
                ),
              ),
            ),
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              setState(() {
                _selectedIndex = index;
              });
            },
          ),
        ),
      ),
    );
  }

  Future<void> logout() async {
    if (await LogoutDialog().confirm()) {
      ref.read(authenticationProvider.notifier).logout();
    }
  }
}
