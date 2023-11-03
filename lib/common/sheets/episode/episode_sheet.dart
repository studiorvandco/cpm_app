import 'package:cpm/common/sheets/sequence/sequence_details_tab.dart';
import 'package:flutter/material.dart';

class SequenceSheet extends StatefulWidget {
  const SequenceSheet({super.key});

  @override
  State<SequenceSheet> createState() => _SequenceSheetState();
}

class _SequenceSheetState extends State<SequenceSheet> with SingleTickerProviderStateMixin {
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
                SequenceDetailsTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
