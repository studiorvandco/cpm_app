import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../services/episode_service.dart';
import 'projects.dart';

part 'episodes.g.dart';

@riverpod
class Episodes extends _$Episodes {
  @override
  FutureOr<List<Episode>> build() {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        final List result = await EpisodeService().getAll(project.id);

        return result[1] as List<Episode>;
      },
      error: (Object error, StackTrace stackTrace) {
        return <Episode>[];
      },
      loading: () {
        return <Episode>[];
      },
    );
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Episode>>();

    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        final List result = await EpisodeService().getAll(project.id);
        state = AsyncData<List<Episode>>(result[1] as List<Episode>);

        return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
      },
      error: (Object error, StackTrace stackTrace) {
        return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
      },
      loading: () {
        return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
      },
    );
  }

  Future<Map<String, dynamic>> add(String projectID, Episode newEpisode) async {
    final List result = await EpisodeService().add(projectID, newEpisode);
    await get(); // Get the episodes in order to get the new episode's ID

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(String projectID, Episode editedEpisode) async {
    final List result = await EpisodeService().edit(projectID, editedEpisode);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != editedEpisode.id) episode else editedEpisode,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String projectID, String episodeID) async {
    final List result = await EpisodeService().delete(projectID, episodeID);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != episodeID) episode,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}

@Riverpod(keepAlive: true)
class CurrentEpisode extends _$CurrentEpisode {
  @override
  FutureOr<Episode> build() {
    return Episode(id: '', number: -1, title: '', description: '', sequences: <Sequence>[]);
  }

  void set(Episode episode) {
    state = AsyncData<Episode>(episode);
  }
}
