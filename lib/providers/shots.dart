import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../models/shot.dart';
import '../services/sequence.dart';
import '../services/shot.dart';
import 'episodes.dart';
import 'projects.dart';
import 'sequences.dart';

part 'shots.g.dart';

@riverpod
class CurrentShots extends _$CurrentShots {
  @override
  FutureOr<List<Shot>> build() {
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      return ref.watch(currentEpisodeProvider).when(data: (Episode episode) async {
        return ref.watch(currentSequenceProvider).when(data: (Sequence sequence) async {
          final List<dynamic> result = await ShotService().getShots(project.id, episode.id, sequence.id);
          return result[1] as List<Shot>;
        }, error: (Object error, StackTrace stackTrace) {
          return <Shot>[];
        }, loading: () {
          return <Shot>[];
        });
      }, error: (Object error, StackTrace stackTrace) {
        return <Shot>[];
      }, loading: () {
        return <Shot>[];
      });
    }, error: (Object error, StackTrace stackTrace) {
      return <Shot>[];
    }, loading: () {
      return <Shot>[];
    });
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Shot>>();
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      return ref.watch(currentEpisodeProvider).when(data: (Episode episode) async {
        final List<dynamic> result = await SequenceService().getSequences(project.id, episode.id);
        state = AsyncData<List<Shot>>(result[1] as List<Shot>);
        return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
      }, error: (Object error, StackTrace stackTrace) {
        return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
      }, loading: () {
        return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
      });
    }, error: (Object error, StackTrace stackTrace) {
      return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
    }, loading: () {
      return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
    });
  }
}
