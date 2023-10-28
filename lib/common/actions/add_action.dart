import 'package:cpm/common/dialogs/add/add_project.dart';
import 'package:cpm/common/model_generic.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/pages/episodes/episode_dialog.dart';
import 'package:cpm/pages/locations/location_dialog.dart';
import 'package:cpm/pages/members/member_dialog.dart';
import 'package:cpm/pages/sequences/sequence_dialog.dart';
import 'package:cpm/pages/shots/shot_dialog.dart';
import 'package:cpm/providers/episodes/episodes.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/members/members.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AddAction<T> extends ModelGeneric<T> {
  AddAction() {
    if (T == dynamic) throw TypeError();
  }

  Future<void> add(
    BuildContext context,
    WidgetRef ref, {
    int? parentId,
    int? index,
  }) async {
    await showAdaptiveDialog(
      context: context,
      builder: (BuildContext context) {
        switch (T) {
          case const (Project):
            return const AddProject();
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
          case const (Member):
            return const MemberDialog();
          case const (Location):
            return const LocationDialog();
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
          final sequence = (element as (Sequence, int?)).$1;
          final locationId = element.$2;
          added = await ref.read(sequencesProvider.notifier).add(sequence, locationId);
        case const (Shot):
          added = await ref.read(shotsProvider.notifier).add(element as Shot);
        case const (Member):
          added = await ref.read(membersProvider.notifier).add(element as Member);
        case const (Location):
          added = await ref.read(locationsProvider.notifier).add(element as Location);
      }

      SnackBarManager().show(
        added
            ? getInfoSnackBar(localizations.snack_bar_add_success_item(item, gender.name))
            : getErrorSnackBar(localizations.snack_bar_add_fail_item(item, gender.name)),
      );
    });
  }
}
