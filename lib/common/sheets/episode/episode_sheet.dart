import 'package:cpm/common/sheets/episode/episode_details_tab.dart';
import 'package:flutter/material.dart';

class EpisodeSheet extends StatefulWidget {
  const EpisodeSheet({super.key});

  @override
  State<EpisodeSheet> createState() => _EpisodeSheetState();
}

class _EpisodeSheetState extends State<EpisodeSheet> with SingleTickerProviderStateMixin {
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
                EpisodeDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
