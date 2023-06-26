import 'package:cpm/providers/navigation.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../models/episode/episode.dart';
import '../models/project/project.dart';
import '../providers/episodes.dart';
import '../providers/projects.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/episode_card.dart';
import '../widgets/custom_snack_bars.dart';
import '../widgets/dialogs/episode_dialog.dart';
import '../widgets/info_headers/project_info_header.dart';

class Episodes extends ConsumerStatefulWidget {
  const Episodes({required Key key}) : super(key: key);

  @override
  ConsumerState<Episodes> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<Episodes> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: handleBackButton,
      child: Expanded(
        child: Scaffold(
          floatingActionButton: FloatingActionButton(onPressed: () => add(), child: const Icon(Icons.add)),
          body: ref.watch(episodesProvider).when(
            data: (List<Episode> episodes) {
              return Column(children: <Widget>[
                const ProjectInfoHeader(),
                Expanded(child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                  return MasonryGridView.count(
                    itemCount: episodes.length,
                    padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return EpisodeCard(episode: episodes[index]);
                    },
                    crossAxisCount: getColumnsCount(constraints),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  );
                })),
              ]);
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
    ref.read(navigationProvider.notifier).set(HomePage.projects);

    return Future<bool>(() => false);
  }

  Future<void> add() async {
    if (!ref.read(currentProjectProvider).hasValue || !ref.read(episodesProvider).hasValue) {
      return;
    }

    final int number = ref.read(episodesProvider).value!.length + 1;
    final episode = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EpisodeDialog(number: number);
      },
    );
    if (episode is Episode) {
      final Project project = ref.read(currentProjectProvider).value!;
      final Map<String, dynamic> result = await ref.read(episodesProvider.notifier).add(project.id, episode);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.episode.added'.tr() : 'snack_bars.episode.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }
}
