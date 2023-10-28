import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/pages/episodes/episode_dialog.dart';
import 'package:cpm/pages/projects/project_dialog.dart';
import 'package:cpm/pages/sequences/sequence_dialog.dart';
import 'package:cpm/pages/shots/shot_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

Future<void> add<T>(
  BuildContext context,
  WidgetRef ref, {
  int? parentId,
  int? index,
}) async {
  if (T == dynamic) throw ArgumentError('Type is required');

  await showAdaptiveDialog<T>(
    context: context,
    builder: (BuildContext context) {
      switch (T) {
        case const (Project):
          return const ProjectDialog();
        case const (Episode):
          if (parentId == null) throw ArgumentError('Project parent ID is required');
          if (index == null) throw ArgumentError('Index is required');

          return EpisodeDialog(projectId: parentId, index: index);
        case const (Sequence):
          if (parentId == null) throw ArgumentError('Episode parent ID is required');
          if (index == null) throw ArgumentError('Index is required');

          return SequenceDialog(episodeId: parentId, index: index);
        case const (Shot):
          if (parentId == null) throw ArgumentError('Sequence parent ID is required');
          if (index == null) throw ArgumentError('Index is required');

          return ShotDialog(sequenceId: parentId, index: index);
        default:
          throw ArgumentError('Invalid type: $T');
      }
    },
  ).then((element) async {
    if (element == null) return;

    bool added = false;
    switch (T) {
      case const (Project):
        added = await ref.read(projectsProvider.notifier).add(element as Project);
      case const (Episode):
        added = await ref.read(episodesProvider.notifier).add(element as Episode);
      case const (Sequence):
        added = await ref.read(sequencesProvider.notifier).add(element as Sequence);
      case const (Shot):
        added = await ref.read(shotsProvider.notifier).add(element as Shot);
    }

    late String item;
    late Gender gender;
    switch (T) {
      case const (Project):
        item = localizations.item_project;
        gender = Gender.male;
      case const (Episode):
        item = localizations.item_episode;
        gender = Gender.male;
      case const (Sequence):
        item = localizations.item_sequence;
        gender = Gender.female;
      case const (Shot):
        item = localizations.item_shot;
        gender = Gender.male;
    }

    SnackBarManager().show(
      added
          ? getInfoSnackBar(localizations.snack_bar_add_success_item(item, gender.name))
          : getErrorSnackBar(localizations.snack_bar_add_fail_item(item, gender.name)),
    );
  });
}
