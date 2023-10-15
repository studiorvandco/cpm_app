import 'package:cpm/extensions/list_helpers.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/project/project.dart';
import '../models/sequence/sequence.dart';
import '../providers/episodes/episodes.dart';
import '../providers/navigation/navigation.dart';
import '../providers/projects/projects.dart';
import '../providers/sequences/sequences.dart';
import '../utils/constants_globals.dart';
import '../utils/snack_bar_manager/custom_snack_bar.dart';
import '../utils/snack_bar_manager/snack_bar_manager.dart';
import '../widgets/cards/sequence_card.dart';
import '../widgets/dialogs/sequence_dialog.dart';
import '../widgets/info_headers/episode_info_header.dart';
import '../widgets/info_headers/project_info_header.dart';

class SequencesPage extends ConsumerStatefulWidget {
  const SequencesPage({super.key});

  @override
  ConsumerState<SequencesPage> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<SequencesPage> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Expanded(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () => add(),
            child: const Icon(Icons.add),
          ),
          body: ref.watch(currentProjectProvider).when(
            data: (Project project) {
              return ref.watch(sequencesProvider).when(
                data: (List<Sequence> sequences) {
                  return Column(
                    children: <Widget>[
                      if (project.isMovie) const ProjectInfoHeader() else const EpisodeInfoHeader(),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (BuildContext context, BoxConstraints constraints) {
                            return MasonryGridView.count(
                              itemCount: sequences.length,
                              padding: const EdgeInsets.only(
                                bottom: kFloatingActionButtonMargin + 64,
                                top: 4,
                                left: 4,
                                right: 4,
                              ),
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
                },
                error: (Object error, StackTrace stackTrace) {
                  return requestPlaceholderError;
                },
                loading: () {
                  return requestPlaceholderLoading;
                },
              );
            },
            error: (Object error, StackTrace stackTrace) {
              return requestPlaceholderError;
            },
            loading: () {
              return requestPlaceholderLoading;
            },
          ),
        ),
      ),
    );
  }

  Future<bool> handleBackButton() {
    ref.watch(currentProjectProvider).whenData((Project project) {
      ref.read(navigationProvider.notifier).set(project.isMovie ? HomePage.projects : HomePage.episodes);
    });

    return Future<bool>(() => false);
  }

  Future<void> add() async {
    if (!ref.read(currentProjectProvider).hasValue ||
        !ref.read(currentEpisodeProvider).hasValue ||
        !ref.read(sequencesProvider).hasValue) {
      return;
    }

    final int episode = ref.read(currentEpisodeProvider).value!.id;
    final (Sequence? newSequence, int? locationId) = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return SequenceDialog(
          episode: episode,
          index: ref.read(sequencesProvider).value!.getNextIndex<Sequence>(),
        );
      },
    );

    if (newSequence != null) {
      final added = await ref.read(sequencesProvider.notifier).add(newSequence, locationId);
      SnackBarManager().show(added
          ? CustomSnackBar.getInfoSnackBar('snack_bars.sequence.added'.tr())
          : CustomSnackBar.getErrorSnackBar('snack_bars.sequence.not_added'.tr()));
    }
  }
}
