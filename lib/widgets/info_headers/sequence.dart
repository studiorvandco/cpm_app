import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/sequence.dart';
import '../../providers/sequences.dart';
import '../icon_label.dart';
import '../info_sheets/sequence.dart';
import '../request_placeholder.dart';

class InfoHeaderSequence extends ConsumerStatefulWidget {
  const InfoHeaderSequence({super.key});

  @override
  ConsumerState<InfoHeaderSequence> createState() => _InfoHeaderSequenceState();
}

class _InfoHeaderSequenceState extends ConsumerState<InfoHeaderSequence> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentSequenceProvider).when(data: (Sequence sequence) {
      return FilledButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(sequence.title,
                          style: Theme.of(context).textTheme.titleLarge, maxLines: 1, overflow: TextOverflow.ellipsis)),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(sequence.description ?? '', maxLines: 2, overflow: TextOverflow.ellipsis)),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  IconLabel(text: _getDateText(context, sequence), icon: Icons.event),
                  Row(children: <Widget>[
                    if (sequence.location != null) ...<Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      const Flexible(child: Icon(Icons.map))
                    ]
                  ])
                ],
              ),
            ),
            //_getCardContent(context),
          ],
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const InfoSheetSequence();
              });
        },
      );
    }, error: (Object error, StackTrace stackTrace) {
      return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
    }, loading: () {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    });
  }

  String _getDateText(BuildContext context, Sequence sequence) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(sequence.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(sequence.endDate);
    return '$firstText - $lastText';
  }
}
