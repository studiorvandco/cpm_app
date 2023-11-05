import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/base_provider.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/services/config/supabase_table.dart';
import 'package:cpm/utils/cache/cache_key.dart';
import 'package:cpm/utils/cache/cache_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'shots.g.dart';

@riverpod
class Shots extends _$Shots with BaseProvider {
  final _table = SupabaseTable.shot;

  @override
  FutureOr<List<Shot>> build() {
    return ref.watch(currentSequenceProvider).when(
      data: (sequence) async {
        return selectShotService.selectShots(sequence.id);
      },
      error: (Object error, StackTrace stackTrace) {
        return <Shot>[];
      },
      loading: () {
        return <Shot>[];
      },
    );
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Shot>>();

    if (await CacheManager().contains(CacheKey.shots)) {
      state = AsyncData<List<Shot>>(
        await CacheManager().get<Shot>(CacheKey.shots, Shot.fromJson),
      );
    }

    return ref.watch(currentSequenceProvider).when(
      data: (sequence) async {
        final List<Shot> shots = await selectShotService.selectShots(sequence.id);
        CacheManager().set(CacheKey.shots, shots);
        state = AsyncData<List<Shot>>(shots);
      },
      error: (Object error, StackTrace stackTrace) {
        return Future.value();
      },
      loading: () {
        return Future.value();
      },
    );
  }

  Future<bool> add(Shot newShot) async {
    try {
      await insertService.insert(_table, newShot);
    } catch (_) {
      return false;
    }
    await get();

    return true;
  }

  Future<bool> edit(Shot editedShot) async {
    try {
      await updateService.update(_table, editedShot);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot shot in state.value ?? <Shot>[])
        if (shot.id != editedShot.id) shot else editedShot,
    ]);

    return true;
  }

  Future<bool> toggleCompletion(Shot toToggleShot) async {
    toToggleShot.completed = !toToggleShot.completed;
    try {
      await updateService.update(_table, toToggleShot);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot shot in state.value ?? <Shot>[])
        if (shot.id != toToggleShot.id) shot else toToggleShot,
    ]);

    return true;
  }

  Future<bool> delete(int id) async {
    try {
      await deleteService.delete(_table, id);
    } catch (_) {
      return false;
    }
    state = AsyncData<List<Shot>>(<Shot>[
      for (final Shot shot in state.value ?? <Shot>[])
        if (shot.id != id) shot,
    ]);

    return true;
  }
}

@Riverpod(keepAlive: true)
class CurrentShot extends _$CurrentShot {
  @override
  FutureOr<Shot> build() {
    return Future.value(); // ignore: null_argument_to_non_null_type
  }

  void set(Shot shot) {
    state = AsyncData<Shot>(shot);
  }
}
