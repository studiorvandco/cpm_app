import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/placeholders/custom_placeholder.dart';
import 'package:cpm/common/placeholders/empty_placeholder.dart';
import 'package:cpm/common/widgets/project_card.dart';
import 'package:cpm/common/widgets/project_header.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/pages.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class EpisodesPage extends ConsumerStatefulWidget {
  const EpisodesPage({super.key});

  @override
  ConsumerState<EpisodesPage> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<EpisodesPage> {
  Future<void> _refresh() async {
    await ref.read(episodesProvider.notifier).get(refreshing: true);
  }

  Future<void> _open(Episode episode) async {
    ref.read(currentEpisodeProvider.notifier).set(episode);
    if (context.mounted) {
      context.pushNamed(RouterRoute.sequences.name);
    }
  }

  Future<void> _reorder(int oldIndex, int newIndex, List<Episode> episodes) async {
    late int sublistStart;
    late int sublistEnd;
    if (newIndex > oldIndex) {
      sublistStart = oldIndex;
      sublistEnd = newIndex;
    } else {
      {
        sublistStart = newIndex;
        sublistEnd = oldIndex + 1;
      }
    }

    final episode = episodes[oldIndex];
    episodes.removeAt(oldIndex);
    episodes.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, episode);

    final sublist = episodes.sublist(sublistStart, sublistEnd);
    for (final episode in sublist) {
      episode.index = sublistStart + sublist.indexOf(episode);
      episode.number = sublistStart + sublist.indexOf(episode) + 1;
      await ref.read(episodesProvider.notifier).edit(episode, reordering: true);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Episode>().add(
          context,
          ref,
          parentId: ref.read(currentProjectProvider).value!.id,
          index: ref.read(episodesProvider).value!.getNextIndex<Episode>(),
        ),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: _refresh,
        notificationPredicate: (notification) {
          return notification.depth == 0 || notification.depth == 1;
        },
        child: ref.watch(episodesProvider).when(
          data: (episodes) {
            final project = ref.watch(currentProjectProvider).unwrapPrevious().valueOrNull;

            final header = ProjectHeader.project(
              delete: () => DeleteAction<Project>().delete(context, ref, id: project?.id),
              title: project?.title,
              description: project?.description,
              dateText: project?.dateText,
              director: project?.director?.fullName,
              writer: project?.writer?.fullName,
              links: project?.links,
            );

            final body = episodes.isEmpty
                ? CustomPlaceholder.empty(EmptyPlaceholder.episodes)
                : ScrollConfiguration(
                    behavior: scrollBehavior,
                    child: ReorderableListView.builder(
                      padding: Paddings.withFab(Paddings.padding8.all),
                      itemCount: episodes.length,
                      proxyDecorator: proxyDecorator,
                      itemBuilder: (context, index) {
                        final episode = episodes[index];

                        return ProjectCard.episode(
                          key: Key('$index'),
                          open: () => _open(episode),
                          number: episode.getNumber,
                          title: episode.title,
                          description: episode.description,
                          progress: episode.progress,
                          progressText: episode.progressText,
                        );
                      },
                      onReorder: (oldIndex, newIndex) => _reorder(oldIndex, newIndex, episodes),
                    ),
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
            return CustomPlaceholder.error();
          },
          loading: () {
            return CustomPlaceholder.loading();
          },
        ),
      ),
    );
  }
}
