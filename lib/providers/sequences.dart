import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project/project.dart';
import '../models/sequence.dart';
import '../models/shot.dart';
import '../services/sequence_service.dart';
import 'episodes.dart';
import 'projects.dart';

part 'sequences.g.dart';

@riverpod
class Sequences extends _$Sequences {
  @override
  FutureOr<List<Sequence>> build() {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        return ref.watch(currentEpisodeProvider).when(
          data: (Episode episode) async {
            final List result = await SequenceService().getAll(project.id, episode.id);

            return result[1] as List<Sequence>;
          },
          error: (Object error, StackTrace stackTrace) {
            return <Sequence>[];
          },
          loading: () {
            return <Sequence>[];
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return <Sequence>[];
      },
      loading: () {
        return <Sequence>[];
      },
    );
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Sequence>>();

    return ref.watch(currentProjectProvider).when(
      data: (Project project) async {
        return ref.watch(currentEpisodeProvider).when(
          data: (Episode episode) async {
            final List result = await SequenceService().getAll(project.id, episode.id);
            state = AsyncData<List<Sequence>>(result[1] as List<Sequence>);

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

  Future<Map<String, dynamic>> add(String projectID, String episodeID, Sequence newSequence) async {
    final List result = await SequenceService().add(projectID, episodeID, newSequence);
    await get(); // Get the sequences in order to get the new sequence's ID

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(String projectID, String episodeID, Sequence editedSequence) async {
    final List result = await SequenceService().edit(projectID, episodeID, editedSequence);
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence episode in state.value ?? <Sequence>[])
        if (episode.id != editedSequence.id) episode else editedSequence,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String projectID, String episodeID, String sequenceID) async {
    final List result = await SequenceService().delete(projectID, episodeID, sequenceID);
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence episode in state.value ?? <Sequence>[])
        if (episode.id != episodeID) episode,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}

@Riverpod(keepAlive: true)
class CurrentSequence extends _$CurrentSequence {
  @override
  FutureOr<Sequence> build() {
    return Sequence(id: '', number: -1, title: '', startDate: DateTime.now(), endDate: DateTime.now(), shots: <Shot>[]);
  }

  void set(Sequence sequence) {
    state = AsyncData<Sequence>(sequence);
  }
}
