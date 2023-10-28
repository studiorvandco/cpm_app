import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/projects/project_card.dart';
import 'package:cpm/common/widgets/projects/project_header.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/sequences/sequence_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
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

class SequencesPage extends ConsumerStatefulWidget {
  const SequencesPage({super.key});

  @override
  ConsumerState<SequencesPage> createState() => _SequencesState();
}

class _SequencesState extends ConsumerState<SequencesPage> {
  Future<void> _open(Sequence sequence) async {
    ref.read(currentSequenceProvider.notifier).set(sequence);
    if (context.mounted) {
      context.pushNamed(RouterRoute.shots.name);
    }
  }

  Future<void> _deleteProject(Project? project) async {
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

  Future<void> _deleteEpisode(Episode? episode) async {
    if (episode != null) {
      showConfirmationDialog(context, episode.getTitle).then((bool? result) async {
        if (result ?? false) {
          final deleted = await ref.read(projectsProvider.notifier).delete(episode.id);
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
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(sequencesProvider).when(
        data: (List<Sequence> sequences) {
          final project = ref.watch(currentProjectProvider).unwrapPrevious().valueOrNull;
          final episode = ref.watch(currentEpisodeProvider).unwrapPrevious().valueOrNull;

          Widget header;
          if (project != null && project.isMovie) {
            header = ProjectHeader.project(
              delete: () => _deleteProject(project),
              title: project.title,
              description: project.description,
              startDate: project.startDate,
              endDate: project.endDate,
            );
          } else {
            header = ProjectHeader.episode(
              delete: () => _deleteEpisode(episode),
              title: episode?.title,
              description: episode?.description,
            );
          }

          final body = LayoutBuilder(
            builder: (context, constraints) {
              return AlignedGridView.count(
                crossAxisCount: getColumnsCount(constraints),
                itemCount: sequences.length,
                itemBuilder: (context, index) {
                  final episode = sequences[index];

                  return ProjectCard.sequence(
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

  Future<void> add() async {
    if (!ref.read(currentProjectProvider).hasValue ||
        !ref.read(currentEpisodeProvider).hasValue ||
        !ref.read(sequencesProvider).hasValue) {
      return;
    }

    final int episode = ref.read(currentEpisodeProvider).value!.id;
    final result = await showDialog<(Sequence, int?)>(
      context: context,
      builder: (BuildContext context) {
        return SequenceDialog(
          episode: episode,
          index: ref.read(sequencesProvider).value!.getNextIndex<Sequence>(),
        );
      },
    );
    final newSequence = result?.$1;
    final locationId = result?.$2;

    if (newSequence != null) {
      final added = await ref.read(sequencesProvider.notifier).add(newSequence, locationId);
      SnackBarManager().show(
        added
            ? getInfoSnackBar(
                localizations.snack_bar_add_success_item(localizations.item_sequence, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_add_fail_item(localizations.item_sequence, Gender.male.name),
              ),
      );
    }
  }
}
