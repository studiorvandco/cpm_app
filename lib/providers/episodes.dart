import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../services/episode.dart';
import 'projects.dart';

part 'episodes.g.dart';

@riverpod
class Episodes extends _$Episodes {
  @override
  FutureOr<List<Episode>> build() {
    return <Episode>[];
  }

  Future<Map<String, dynamic>> add(String projectID, Episode newEpisode) async {
    final List<dynamic> result = await EpisodeService().addEpisode(projectID, newEpisode);
    state = AsyncData<List<Episode>>(<Episode>[...state.value ?? <Episode>[], newEpisode]);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Episode editedEpisode) async {
    final List<dynamic> result = await EpisodeService().editEpisode(editedEpisode);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != editedEpisode.id) episode else editedEpisode,
    ]);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String projectID, String episodeID) async {
    final List<dynamic> result = await EpisodeService().deleteEpisode(projectID, episodeID);
    state = AsyncData<List<Episode>>(<Episode>[
      for (final Episode episode in state.value ?? <Episode>[])
        if (episode.id != episodeID) episode,
    ]);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}

@riverpod
class CurrentEpisodes extends _$CurrentEpisodes {
  @override
  FutureOr<List<Episode>> build() {
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      final List<dynamic> result = await EpisodeService().getEpisodes(project.id);
      return result[1] as List<Episode>;
    }, error: (Object error, StackTrace stackTrace) {
      return <Episode>[];
    }, loading: () {
      return <Episode>[];
    });
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Episode>>();
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      final List<dynamic> result = await EpisodeService().getEpisodes(project.id);
      state = AsyncData<List<Episode>>(result[1] as List<Episode>);
      return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
    }, error: (Object error, StackTrace stackTrace) {
      return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
    }, loading: () {
      return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
    });
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
