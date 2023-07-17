import 'dart:async';

import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/episode/episode.dart';
import '../../models/project/project.dart';
import '../projects/projects.dart';

part 'episodes.g.dart';

@riverpod
class Episodes extends _$Episodes with BaseProvider {
  SupabaseTable table = SupabaseTable.episode;

  @override
  FutureOr<List<Episode>> build() {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        final List<Episode> episodes = await selectEpisodeService.selectEpisodes(project.id);

        if (project.isMovie) {
          ref.read(currentEpisodeProvider.notifier).set(episodes.first);
        }

        return episodes;
      },
      error: (Object error, StackTrace stackTrace) {
        return <Episode>[];
      },
      loading: () {
        return <Episode>[];
      },
    );
  }

  Future<void> get() {
    state = const AsyncLoading<List<Episode>>();

    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        final List<Episode> episodes = await selectEpisodeService.selectEpisodes(project.id);
        state = AsyncData<List<Episode>>(episodes);

        if (project.isMovie) {
          ref.read(currentEpisodeProvider.notifier).set(episodes.first);
        }
      },
      error: (Object error, StackTrace stackTrace) {
        return Future.value();
      },
      loading: () {
        return Future.value();
      },
    );
  }

  Future<void> add(Episode newEpisode) async {
    await insertService.insert(table, newEpisode);
    await get(); // Get the episodes in order to get the new episode's ID
  }

  Future<void> edit(Episode editedEpisode) async {
    await updateService.update(table, editedEpisode);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != editedEpisode.id) episode else editedEpisode,
    ]);
  }

  Future<void> delete(int? id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != id) episode,
    ]);
  }
}

@Riverpod(keepAlive: true)
class CurrentEpisode extends _$CurrentEpisode {
  @override
  FutureOr<Episode> build() {
    return Future.value(null);
  }

  void set(Episode episode) {
    state = AsyncData<Episode>(episode);
  }
}
