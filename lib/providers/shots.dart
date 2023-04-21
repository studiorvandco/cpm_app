import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../models/shot.dart';
import '../services/sequence_service.dart';
import '../services/shot_service.dart';
import 'episodes.dart';
import 'projects.dart';
import 'sequences.dart';

part 'shots.g.dart';

@riverpod
class Shots extends _$Shots {
  @override
  FutureOr<List<Shot>> build() {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        return ref.watch(currentEpisodeProvider).when(
          data: (Episode episode) async {
            return ref.watch(currentSequenceProvider).when(
              data: (Sequence sequence) async {
                final List result = await ShotService().getAll(project.id, episode.id, sequence.id);

                return result[1] as List<Shot>;
              },
              error: (Object error, StackTrace stackTrace) {
                return <Shot>[];
              },
              loading: () {
                return <Shot>[];
              },
            );
          },
          error: (Object error, StackTrace stackTrace) {
            return <Shot>[];
          },
          loading: () {
            return <Shot>[];
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return <Shot>[];
      },
      loading: () {
        return <Shot>[];
      },
    );
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Shot>>();

    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        return ref.watch(currentEpisodeProvider).when(
          data: (Episode episode) async {
            final List result = await SequenceService().getAll(project.id, episode.id);
            state = AsyncData<List<Shot>>(result[1] as List<Shot>);

            return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
          },
          error: (Object error, StackTrace stackTrace) {
            return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
          },
          loading: () {
            return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
      },
      loading: () {
        return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
      },
    );
  }

  Future<Map<String, dynamic>> add(String projectID, String episodeID, String sequenceID, Shot newShot) async {
    final List result = await ShotService().add(projectID, episodeID, sequenceID, newShot);
    await get(); // Get the shots in order to get the new shot's ID

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(String projectID, String episodeID, String sequenceID, Shot editedShot) async {
    final List result = await ShotService().edit(projectID, episodeID, sequenceID, editedShot);
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot episode in state.value ?? <Shot>[])
        if (episode.id != editedShot.id) episode else editedShot,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String projectID, String episodeID, String sequenceID, String shotID) async {
    final List result = await ShotService().delete(projectID, episodeID, sequenceID, shotID);
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot episode in state.value ?? <Shot>[])
        if (episode.id != episodeID) episode,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
