import 'package:cpm/common/model_generic.dart';
import 'package:cpm/models/base_model.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ReorderAction<T extends BaseModel> extends ModelGeneric<T> {
  ReorderAction() {
    if (T == dynamic) throw TypeError();
  }

  Future<void> reorder(
    BuildContext context,
    WidgetRef ref, {
    required int oldIndex,
    required int newIndex,
    required List<T> models,
  }) async {
    if (T == dynamic) throw TypeError();

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

    final model = models[oldIndex];
    models.removeAt(oldIndex);
    models.insert(newIndex > oldIndex ? newIndex - 1 : newIndex, model);

    final sublist = models.sublist(sublistStart, sublistEnd);
    for (final model in sublist) {
      switch (T) {
        case const (Episode):
          (model as Episode).index = sublistStart + sublist.indexOf(model);
          model.number = sublistStart + sublist.indexOf(model) + 1;
          await ref.read(episodesProvider.notifier).edit(model, reordering: true);
        case const (Sequence):
          (model as Sequence).index = sublistStart + sublist.indexOf(model);
          model.number = sublistStart + sublist.indexOf(model) + 1;
          await ref.read(sequencesProvider.notifier).edit(model, reordering: true);
        case const (Shot):
          (model as Shot).index = sublistStart + sublist.indexOf(model);
          model.number = sublistStart + sublist.indexOf(model) + 1;
          await ref.read(shotsProvider.notifier).edit(model, reordering: true);
        default:
          throw TypeError();
      }
    }
  }
}
