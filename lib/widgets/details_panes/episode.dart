import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode.dart';
import '../../models/project.dart';
import '../../providers/episodes.dart';
import '../../providers/projects.dart';
import '../../utils/constants_globals.dart';

class DetailsPaneEpisode extends ConsumerStatefulWidget {
  const DetailsPaneEpisode({super.key});

  @override
  ConsumerState<DetailsPaneEpisode> createState() => _DetailsPaneEpisodeState();
}

class _DetailsPaneEpisodeState extends ConsumerState<DetailsPaneEpisode>
    with AutomaticKeepAliveClientMixin<DetailsPaneEpisode> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ref.watch(currentProjectProvider).when(data: (Project project) {
      return ref.watch(currentEpisodeProvider).when(data: (Episode episode) {
        titleController.text = episode.title;
        descriptionController.text = episode.description;
        titleController.selection = TextSelection.collapsed(offset: titleController.text.length);
        descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

        return Padding(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Focus(
                  onFocusChange: (bool hasFocus) {
                    if (!hasFocus && titleController.text != project.title) {
                      edit(project.id, episode);
                    }
                  },
                  child: TextField(
                      style: Theme.of(context).textTheme.titleMedium,
                      decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                      controller: titleController,
                      maxLength: 64),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 16)),
                Focus(
                  onFocusChange: (bool hasFocus) {
                    if (!hasFocus && descriptionController.text != project.description) {
                      edit(project.id, episode);
                    }
                  },
                  child: TextField(
                    style: Theme.of(context).textTheme.bodyMedium,
                    decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                    controller: descriptionController,
                    keyboardType: TextInputType.multiline,
                    minLines: 3,
                    maxLines: null,
                    maxLength: 280,
                  ),
                ),
              ],
            ));
      }, error: (Object error, StackTrace stackTrace) {
        return requestPlaceholderError;
      }, loading: () {
        return requestPlaceholderLoading;
      });
    }, error: (Object error, StackTrace stackTrace) {
      return requestPlaceholderError;
    }, loading: () {
      return requestPlaceholderLoading;
    });
  }

  Future<void> edit(String projectID, Episode episode) async {
    episode.title = titleController.text;
    episode.description = descriptionController.text;

    ref.read(episodesProvider.notifier).edit(projectID, episode);
    ref.read(currentEpisodeProvider.notifier).set(episode);
  }
}
