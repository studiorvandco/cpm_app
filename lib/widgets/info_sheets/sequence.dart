import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../details_panes/sequence.dart';

class InfoSheetSequence extends StatelessWidget {
  const InfoSheetSequence({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: Column(
          children: <Widget>[
            TabBar(tabs: <Tab>[
              Tab(text: 'details.upper'.plural(2)),
              Tab(text: 'members.member.upper'.plural(2)),
              Tab(text: 'locations.location.upper'.plural(2))
            ]),
            const Expanded(
                child: TabBarView(
              children: <Widget>[
                DetailsPaneSequence(),
                Center(child: Text('Coming soon!')),
                Center(child: Text('Coming soon!'))
              ],
            ))
          ],
        ));
  }
}
