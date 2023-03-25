import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../details_panes/project.dart';

class InfoSheetProject extends StatefulWidget {
  const InfoSheetProject({super.key});

  @override
  State<InfoSheetProject> createState() => _InfoSheetProjectState();
}

class _InfoSheetProjectState extends State<InfoSheetProject> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          TabBar(
              controller: _tabController,
              onTap: (int index) {
                setState(() {
                  _selectedTab = index;
                });
              },
              tabs: [
                Tab(text: 'details.upper'.plural(2)),
                Tab(text: 'members.member.upper'.plural(2)),
                Tab(text: 'locations.location.upper'.plural(2))
              ]),
          Builder(builder: (BuildContext builder) {
            if (_selectedTab == 0) {
              return const DetailsPaneProject(); //1st custom tabBarView
            } else if (_selectedTab == 1) {
              return const Center(child: Text('Coming soon!')); //2nd tabView
            } else if (_selectedTab == 2) {
              return const Center(child: Text('Coming soon!')); //3rd tabView
            } else {
              return const Center();
            }
          })
        ],
      ),
    );
  }
}
