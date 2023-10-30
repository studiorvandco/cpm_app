import 'package:cpm/common/sheets/project/project_details_tab.dart';
import 'package:flutter/material.dart';

class ProjectSheet extends StatefulWidget {
  const ProjectSheet({super.key});

  @override
  State<ProjectSheet> createState() => _ProjectSheetState();
}

class _ProjectSheetState extends State<ProjectSheet> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.info)),
              Tab(icon: Icon(Icons.link)),
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 2 / 3,
            child: TabBarView(
              children: [
                const ProjectDetailsTab(),
                SingleChildScrollView(child: Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
