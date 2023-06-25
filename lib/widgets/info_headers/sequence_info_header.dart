import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode.dart';
import '../../models/project/project.dart';
import '../../models/sequence.dart';
import '../../providers/episodes.dart';
import '../../providers/navigation.dart';
import '../../providers/projects.dart';
import '../../providers/sequences.dart';
import '../../utils/constants_globals.dart';
import '../custom_snack_bars.dart';
import '../dialogs/confirm_dialog.dart';
import '../icon_label.dart';
import '../info_sheets/sequence_info_sheet.dart';

class SequenceInfoHeader extends ConsumerStatefulWidget {
  const SequenceInfoHeader({super.key});

  @override
  ConsumerState<SequenceInfoHeader> createState() => _InfoHeaderSequenceState();
}

class _InfoHeaderSequenceState extends ConsumerState<SequenceInfoHeader> {
  String _getDateText(BuildContext context, Sequence sequence) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(sequence.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(sequence.endDate);

    return '$firstText - $lastText';
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentSequenceProvider).when(
      data: (Sequence sequence) {
        return FilledButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          sequence.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => delete(sequence),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        sequence.description ?? '',
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    IconLabel(text: _getDateText(context, sequence), icon: Icons.event),
                    Row(children: <Widget>[
                      if (sequence.location != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.map)),
                      ],
                    ]),
                  ],
                ),
              ),
              //_getCardContent(context),
            ],
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const SequenceInfoSheet();
              },
            );
          },
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return requestPlaceholderError;
      },
      loading: () {
        return requestPlaceholderLoading;
      },
    );
  }

  Future<void> delete(Sequence sequence) async {
    if (!ref.read(currentProjectProvider).hasValue || !ref.read(currentEpisodeProvider).hasValue) {
      return;
    }

    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final Project project = ref.read(currentProjectProvider).value!;
        final Episode episode = ref.read(currentEpisodeProvider).value!;
        final Map<String, dynamic> result =
            await ref.read(sequencesProvider.notifier).delete(project.id, episode.id, sequence.id);
        if (context.mounted) {
          final bool succeeded = result['succeeded'] as bool;
          final int code = result['code'] as int;
          final String message =
              succeeded ? 'snack_bars.sequence.deleted'.tr() : 'snack_bars.sequence.not_deleted'.tr();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
        }
        ref.read(navigationProvider.notifier).set(HomePage.episodes);
      }
    });
  }
}
