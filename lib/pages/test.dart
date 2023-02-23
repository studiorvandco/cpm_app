import 'package:flutter/material.dart';
import '../widgets/icon_label.dart';
import '../widgets/info_header.dart';

import '../widgets/tabbed_info_sheet.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          InfoHeader(
            title: 'Test',
            description:
                'This is a project, and this is a very long description that takes multiples lines, this project is a very good project that will be awesome',
            dateRange: DateTimeRange(start: DateTime(2023, 9, 19), end: DateTime(2023, 9, 24)),
            leftLabel: const IconLabel(text: 'Bastien', icon: Icons.movie_outlined),
            rightLabel: const IconLabel(text: 'Maxence', icon: Icons.description_outlined),
            image: Image.asset('assets/en-sursis.png'),
            progress: 0.3,
            cornerButton: IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
          ),
          TextButton(
              onPressed: () {
                showModalBottomSheet(
                    context: context,
                    builder: (BuildContext context) {
                      return const TabbedInfoSheet();
                    });
              },
              child: const Text('Bottom sheet')),
        ],
      ),
    );
  }
}
