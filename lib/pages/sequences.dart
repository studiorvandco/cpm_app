import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/project.dart';
import '../models/sequence.dart';
import '../providers/navigation.dart';
import '../providers/projects.dart';
import '../providers/sequences.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/sequence.dart';
import '../widgets/info_headers/episode.dart';
import '../widgets/info_headers/project.dart';

class Sequences extends ConsumerStatefulWidget {
  const Sequences({super.key});

  @override
  ConsumerState<Sequences> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<Sequences> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Expanded(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: add,
            child: const Icon(Icons.add),
          ),
          body: ref.watch(currentProjectProvider).when(data: (Project project) {
            return ref.watch(sequencesProvider).when(data: (List<Sequence> sequences) {
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
                          );
                        })
                      ]))
                ],
              );
            }, error: (Object error, StackTrace stackTrace) {
              return requestPlaceholderError;
            }, loading: () {
              return requestPlaceholderLoading;
            });
          }, error: (Object error, StackTrace stackTrace) {
            return requestPlaceholderError;
          }, loading: () {
            return requestPlaceholderLoading;
          }),
        ),
      ),
    );
  }

  Future<bool> handleBackButton() {
    ref.watch(currentProjectProvider).whenData((Project project) {
      ref.read(homePageNavigationProvider.notifier).set(project.isMovie() ? HomePage.projects : HomePage.episodes);
    });
    return Future<bool>(() => false);
  }

  void add() {
    print('TODO');
  }
}
