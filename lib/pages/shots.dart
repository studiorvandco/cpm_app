import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/episode/episode.dart';
import '../models/project/project.dart';
import '../models/sequence/sequence.dart';
import '../models/shot/shot.dart';
import '../providers/episodes.dart';
import '../providers/navigation.dart';
import '../providers/projects.dart';
import '../providers/sequences.dart';
import '../providers/shots.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/shot_card.dart';
import '../widgets/custom_snack_bars.dart';
import '../widgets/dialogs/shot_dialog.dart';
import '../widgets/info_headers/sequence_info_header.dart';

class Shots extends ConsumerStatefulWidget {
  const Shots({super.key});

  @override
  ConsumerState<Shots> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<Shots> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Expanded(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () => add(), child: const Icon(Icons.add)),
          body: ref.watch(shotsProvider).when(
            data: (List<Shot> shots) {
              return Column(
                children: <Widget>[
                  const SequenceInfoHeader(),
                  LayoutBuilder(
                    builder: (BuildContext context, BoxConstraints constraints) {
                      return MasonryGridView.count(
                        itemCount: shots.length,
                        padding:
                            const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                        itemBuilder: (BuildContext context, int index) {
                          return ShotCard(
                            shot: shots[index],
                            onPressed: () {
                              // TODO
                            },
                          );
                        },
                        crossAxisCount: getColumnsCount(constraints),
                        mainAxisSpacing: 2,
                        crossAxisSpacing: 2,
                      );
                    },
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
          ),
        ),
      ),
    );
  }

  Future<bool> handleBackButton() {
    ref.read(navigationProvider.notifier).set(HomePage.sequences);

    return Future<bool>(() => false);
  }

  Future<void> add() async {
    var currentProjectReader = ref.read(currentProjectProvider);
    var currentEpisodeReader = ref.read(currentEpisodeProvider);
    var currentSequenceReader = ref.read(currentSequenceProvider);

    if (!currentProjectReader.hasValue || !currentEpisodeReader.hasValue || !currentSequenceReader.hasValue) {
      return;
    }

    final shot = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const ShotDialog();
      },
    );
    if (shot is Shot) {
      final Project project = currentProjectReader.value!;
      final Episode episode = currentEpisodeReader.value!;
      final Sequence sequence = currentSequenceReader.value!;
      final Map<String, dynamic> result =
          await ref.read(shotsProvider.notifier).add(project.id, episode.id, sequence.id, shot);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.shot.added'.tr() : 'snack_bars.shot.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }
}
