import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/projects/project_card.dart';
import 'package:cpm/common/widgets/projects/project_header.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/pages/episodes/episode_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({super.key});

  @override
  ConsumerState<EpisodesPage> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<EpisodesPage> {
  Future<void> _open(Episode episode) async {
    ref.read(currentEpisodeProvider.notifier).set(episode);
    if (context.mounted) {
      context.pushNamed(RouterRoute.sequences.name);
    }
  }

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

  Future<void> _delete(Project? project) async {
    if (project != null) {
      showConfirmationDialog(context, project.getTitle).then((bool? result) async {
        if (result ?? false) {
          final deleted = await ref.read(projectsProvider.notifier).delete(project.id);
          SnackBarManager().show(
            deleted
                ? getInfoSnackBar(
                    localizations.snack_bar_delete_success_item(localizations.item_project, Gender.male.name),
                  )
                : getErrorSnackBar(
                    localizations.snack_bar_delete_fail_item(localizations.item_project, Gender.male.name),
                  ),
          );
          if (context.mounted) {
            context.pushNamed(RouterRoute.projects.name);
          }
        }
      });
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
            delete: () => _delete(project),
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
                  final episode = episodes[index];

                  return ProjectCard.episode(
                    key: UniqueKey(),
                    open: () => _open(episode),
                    number: episode.getNumber,
                    title: episode.title,
                    description: episode.description,
                    progress: 0,
                    progressText: '',
                  );
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
