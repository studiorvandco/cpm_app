import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../services/sequence.dart';
import 'episodes.dart';
import 'projects.dart';

part 'sequences.g.dart';

@riverpod
class CurrentSequences extends _$CurrentSequences {
  @override
  FutureOr<List<Sequence>> build() {
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      return ref.watch(currentEpisodeProvider).when(data: (Episode episode) async {
        final List<dynamic> result = await SequenceService().getSequences(project.id, episode.id);
        return result[1] as List<Sequence>;
      }, error: (Object error, StackTrace stackTrace) {
        return <Sequence>[];
      }, loading: () {
        return <Sequence>[];
      });
    }, error: (Object error, StackTrace stackTrace) {
      return <Sequence>[];
    }, loading: () {
      return <Sequence>[];
    });
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Sequence>>();
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      return ref.watch(currentEpisodeProvider).when(data: (Episode episode) async {
        final List<dynamic> result = await SequenceService().getSequences(project.id, episode.id);
        state = AsyncData<List<Sequence>>(result[1] as List<Sequence>);
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
