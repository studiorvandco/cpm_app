import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialogs/new_episode.dart';
import '../models/episode.dart';
import '../models/project.dart';
import '../providers/episodes.dart';
import '../providers/projects.dart';
import '../widgets/cards/episode.dart';
import '../widgets/info_headers/project.dart';
import '../widgets/request_placeholder.dart';
import '../widgets/snack_bars.dart';

class Episodes extends ConsumerStatefulWidget {
  const Episodes({required Key key}) : super(key: key);

  @override
  ConsumerState<Episodes> createState() => EpisodesState();
}

class EpisodesState extends ConsumerState<Episodes> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add(),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(episodesProvider).when(data: (List<Episode> episodes) {
        return Column(
          children: <Widget>[
            const InfoHeaderProject(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
                children: <EpisodeCard>[
                  ...episodes.map(
                    (Episode episode) {
                      return EpisodeCard(episode: episode);
                    },
                  )
                ],
              ),
            )
          ],
        );
      }, error: (Object error, StackTrace stackTrace) {
        return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
      }, loading: () {
        return const RequestPlaceholder(placeholder: CircularProgressIndicator());
      }),
    ));
  }

  Future<void> add() async {
    if (!ref.read(currentProjectProvider).hasValue || !ref.read(episodesProvider).hasValue) {
      return;
    }

    final int number = ref.read(episodesProvider).value!.length + 1;
    final dynamic episode = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return NewEpisodeDialog(number: number);
        });
    if (episode is Episode) {
      final Project project = ref.read(currentProjectProvider).value!;
      final Map<String, dynamic> result = await ref.read(episodesProvider.notifier).add(project.id, episode);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.episode.added'.tr() : 'snack_bars.episode.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
    ref.read(episodesProvider.notifier).get();
  }
}
