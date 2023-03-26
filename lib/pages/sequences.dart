import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                    child: LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return MasonryGridView.count(
                          itemCount: sequences.length,
                          padding: const EdgeInsets.only(
                              bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return SequenceCard(sequence: sequences[index]);
                          },
                          crossAxisCount: getColumnsCount(constraints),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        );
                      },
                    ),
                  ),
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
