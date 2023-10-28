import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/projects/project_header.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/pages/episodes/episode_card.dart';
import 'package:cpm/pages/episodes/episode_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({super.key});

  @override
  ConsumerState<EpisodesPage> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<EpisodesPage> {
  Future<void> _add() async {
    if (!ref.read(currentProjectProvider).hasValue || !ref.read(episodesProvider).hasValue) {
      return;
    }

    final int project = ref.read(currentProjectProvider).value!.id;
    final newEpisode = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return EpisodeDialog(
          project: project,
          index: ref.read(episodesProvider).value!.getNextIndex<Episode>(),
        );
      },
    );
    if (newEpisode is Episode) {
      final added = await ref.read(episodesProvider.notifier).add(newEpisode);
      SnackBarManager().show(
        added
            ? getInfoSnackBar(
                localizations.snack_bar_add_success_item(localizations.item_episode, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_add_fail_item(localizations.item_episode, Gender.male.name),
              ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(episodesProvider).when(
        data: (List<Episode> episodes) {
          final project = ref.watch(currentProjectProvider).unwrapPrevious().valueOrNull;

          final header = ProjectHeader.project(
            title: project?.title,
            description: project?.description,
            startDate: project?.startDate,
            endDate: project?.endDate,
            director: project?.director,
            writer: project?.writer,
            links: project?.links,
          );

          final body = LayoutBuilder(
            builder: (context, constraints) {
              return AlignedGridView.count(
                crossAxisCount: getColumnsCount(constraints),
                itemCount: episodes.length,
                itemBuilder: (context, index) {
                  return EpisodeCard(episode: episodes[index]);
                },
                padding: Paddings.withFab(Paddings.padding8.all),
              );
            },
          );

          return PlatformManager().isMobile
              ? NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: header,
                      ),
                    ];
                  },
                  body: body,
                )
              : Column(
                  children: [
                    header,
                    Expanded(child: body),
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
    );
  }
}
