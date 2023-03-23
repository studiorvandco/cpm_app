import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project.dart';
import '../models/sequence.dart';
import '../providers/projects.dart';
import '../providers/sequences.dart';
import '../widgets/cards/sequence.dart';
import '../widgets/info_headers/episode.dart';
import '../widgets/info_headers/project.dart';
import '../widgets/request_placeholder.dart';

class Sequences extends ConsumerStatefulWidget {
  const Sequences({super.key, required this.openSequence});

  final void Function(Sequence sequence) openSequence;

  @override
  ConsumerState<Sequences> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<Sequences> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: const Icon(Icons.add),
        ),
        body: ref.watch(currentProjectProvider).when(data: (Project project) {
          return ref.watch(currentSequencesProvider).when(data: (List<Sequence> sequences) {
            return Column(
              children: <Widget>[
                if (project.isMovie()) const InfoHeaderProject() else const InfoHeaderEpisode(),
                Expanded(
                    child: ListView(
                        padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
                        children: <SequenceCard>[
                      ...sequences.map((Sequence sequence) {
                        return SequenceCard(
                          sequence: sequence,
                          openShots: () {
                            widget.openSequence(sequence);
                          },
                        );
                      })
                    ]))
              ],
            );
          }, error: (Object error, StackTrace stackTrace) {
            return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
          }, loading: () {
            return const RequestPlaceholder(placeholder: CircularProgressIndicator());
          });
        }, error: (Object error, StackTrace stackTrace) {
          return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
        }, loading: () {
          return const RequestPlaceholder(placeholder: CircularProgressIndicator());
        }),
      ),
    );
  }

  void add() {
    print('TODO');
  }
}
