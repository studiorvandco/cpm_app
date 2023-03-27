import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode.dart';
import '../../models/project.dart';
import '../../providers/episodes.dart';
import '../../providers/navigation.dart';
import '../../providers/projects.dart';
import '../../utils/constants_globals.dart';
import '../dialogs/confirm_dialog.dart';
import '../info_sheets/episode.dart';
import '../snack_bars.dart';

class InfoHeaderEpisode extends ConsumerStatefulWidget {
  const InfoHeaderEpisode({super.key});

  @override
  ConsumerState<InfoHeaderEpisode> createState() => _InfoHeaderEpisodeState();
}

class _InfoHeaderEpisodeState extends ConsumerState<InfoHeaderEpisode> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentEpisodeProvider).when(data: (Episode episode) {
      return FilledButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(children: <Widget>[
                    Expanded(
                      child: Text(
                        episode.title,
                        style: Theme.of(context).textTheme.titleLarge,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    IconButton(
                      onPressed: () => delete(episode),
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                    )
                  ]),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        episode.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      )),
                  Row(children: <Widget>[
                    if (episode.director != null) ...<Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      const Flexible(child: Icon(Icons.movie_outlined))
                    ],
                    if (episode.writer != null) ...<Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      const Flexible(child: Icon(Icons.description_outlined))
                    ]
                  ])
                ],
              ),
            ),
          ],
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return const InfoSheetEpisode();
              });
        },
      );
    }, error: (Object error, StackTrace stackTrace) {
      return requestPlaceholderError;
    }, loading: () {
      return requestPlaceholderLoading;
    });
  }

  Future<void> delete(Episode episode) async {
    if (!ref.read(currentProjectProvider).hasValue) {
      return;
    }

    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final Project project = ref.read(currentProjectProvider).value!;
        final Map<String, dynamic> result = await ref.read(episodesProvider.notifier).delete(project.id, episode.id);
        if (context.mounted) {
          final bool succeeded = result['succeeded'] as bool;
          final int code = result['code'] as int;
          final String message = succeeded ? 'snack_bars.episode.deleted'.tr() : 'snack_bars.episode.not_deleted'.tr();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
        }
        ref.read(homePageNavigationProvider.notifier).set(HomePage.episodes);
      }
    });
  }
}
