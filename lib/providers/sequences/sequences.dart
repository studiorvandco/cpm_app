import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../models/episode/episode.dart';
import '../../models/sequence/sequence.dart';
import '../../services/config/supabase_table.dart';
import '../base_provider.dart';
import '../episodes/episodes.dart';

part 'sequences.g.dart';

@riverpod
class Sequences extends _$Sequences with BaseProvider {
  SupabaseTable table = SupabaseTable.sequence;

  @override
  FutureOr<List<Sequence>> build() {
    return ref.watch(currentEpisodeProvider).when(
      data: (Episode episode) async {
        return await selectSequenceService.selectSequences(episode.id);
      },
      error: (Object error, StackTrace stackTrace) {
        return <Sequence>[];
      },
      loading: () {
        return <Sequence>[];
      },
    );
  }

  Future<void> get() {
    state = const AsyncLoading<List<Sequence>>();

    return ref.watch(currentEpisodeProvider).when(
      data: (Episode episode) async {
        List<Sequence> sequences = await selectSequenceService.selectSequences(episode.id);
        state = AsyncData<List<Sequence>>(sequences);
      },
      error: (Object error, StackTrace stackTrace) {
        return Future.value();
      },
      loading: () {
        return Future.value();
      },
    );
  }

  Future<void> add(Sequence newSequence) async {
    await insertService.insert(table, newSequence);
    await get();
  }

  Future<void> edit(Sequence editedSequence) async {
    await updateService.update(table, editedSequence);
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence episode in state.value ?? <Sequence>[])
        if (episode.id != editedSequence.id) episode else editedSequence,
    ]);
  }

  Future<void> delete(int? id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Sequence>>(<Sequence>[
      for (final Sequence episode in state.value ?? <Sequence>[])
        if (episode.id != id) episode,
    ]);
  }
}

@Riverpod(keepAlive: true)
class CurrentSequence extends _$CurrentSequence {
  @override
  FutureOr<Sequence> build() {
    return Future.value(null);
  }

  void set(Sequence sequence) {
    state = AsyncData<Sequence>(sequence);
  }
}
