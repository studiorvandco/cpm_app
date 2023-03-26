import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../dialogs/new_shot.dart';
import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../models/shot.dart';
import '../providers/episodes.dart';
import '../providers/navigation.dart';
import '../providers/projects.dart';
import '../providers/sequences.dart';
import '../providers/shots.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/shot.dart';
import '../widgets/info_headers/sequence.dart';
import '../widgets/snack_bars.dart';

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
              floatingActionButton: FloatingActionButton(onPressed: add, child: const Icon(Icons.add)),
              body: ref.watch(shotsProvider).when(data: (List<Shot> shots) {
                return Column(
                  children: <Widget>[
                    const InfoHeaderSequence(),
                    LayoutBuilder(
                      builder: (BuildContext context, BoxConstraints constraints) {
                        return MasonryGridView.count(
                          itemCount: shots.length,
                          padding: const EdgeInsets.only(
                              bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                          itemBuilder: (BuildContext context, int index) {
                            return ShotCard(shot: shots[index], onPressed: () {});
                          },
                          crossAxisCount: getColumnsCount(constraints),
                          mainAxisSpacing: 2,
                          crossAxisSpacing: 2,
                        );
                      },
                    ),
                  ],
                );
              }, error: (Object error, StackTrace stackTrace) {
                return requestPlaceholderError;
              }, loading: () {
                return requestPlaceholderLoading;
              }))),
    );
  }

  Future<bool> handleBackButton() {
    ref.read(homePageNavigationProvider.notifier).set(HomePage.sequences);
    return Future<bool>(() => false);
  }

  Future<void> add() async {
    if (!ref.read(currentProjectProvider).hasValue ||
        !ref.read(currentEpisodeProvider).hasValue ||
        !ref.read(currentSequenceProvider).hasValue) {
      return;
    }

    final dynamic shot = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NewShotDialog();
        });
    if (shot is Shot) {
      final Project project = ref.read(currentProjectProvider).value!;
      final Episode episode = ref.read(currentEpisodeProvider).value!;
      final Sequence sequence = ref.read(currentSequenceProvider).value!;
      final Map<String, dynamic> result =
          await ref.read(shotsProvider.notifier).add(project.id, episode.id, sequence.id, shot);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.shot.added'.tr() : 'snack_bars.shot.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }
}
