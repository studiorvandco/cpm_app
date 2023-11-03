import 'package:cpm/common/sheets/shot/shot_details_tab.dart';
import 'package:flutter/material.dart';

class ShotSheet extends StatefulWidget {
  const ShotSheet({super.key});

  @override
  State<ShotSheet> createState() => _ShotSheetState();
}

class _ShotSheetState extends State<ShotSheet> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 3,
            child: const TabBarView(
              children: [
                ShotDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
