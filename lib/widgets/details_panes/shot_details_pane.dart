import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode/episode.dart';
import '../../models/project/project.dart';
import '../../models/sequence/sequence.dart';
import '../../providers/episodes/episodes.dart';
import '../../providers/projects/projects.dart';
import '../../providers/sequences/sequences.dart';
import '../../utils/constants_globals.dart';

class ShotDetailsPane extends ConsumerStatefulWidget {
  const ShotDetailsPane({super.key});

  @override
  ConsumerState<ShotDetailsPane> createState() => _ShotDetailsPaneState();
}

class _ShotDetailsPaneState extends ConsumerState<ShotDetailsPane> with AutomaticKeepAliveClientMixin<ShotDetailsPane> {
  TextEditingController descriptionController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        return ref.watch(currentEpisodeProvider).when(
          data: (Episode episode) {
            return ref.watch(currentSequenceProvider).when(
              data: (Sequence sequence) {
                return ref.watch(currentShotProvider).when(
                  data: (Shot shot) {
                    descriptionController.text = shot.description ?? '';
                    descriptionController.selection =
                        TextSelection.collapsed(offset: descriptionController.text.length);

                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom + 8,
                        top: 8,
                        left: 8,
                        right: 8,
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Focus(
                            onFocusChange: (bool hasFocus) {
                              if (!hasFocus && descriptionController.text != project.description) {
                                edit(shot);
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
                      ),
                    );
                  },
                  error: (Object error, StackTrace stackTrace) {
                    return requestPlaceholderError;
                  },
                  loading: () {
                    return requestPlaceholderLoading;
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
          },
          error: (Object error, StackTrace stackTrace) {
            return requestPlaceholderError;
          },
          loading: () {
            return requestPlaceholderLoading;
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

  void edit(Shot shot) {
    shot.description = descriptionController.text;

    ref.read(shotsProvider.notifier).edit(shot);
    ref.read(currentShotProvider.notifier).set(shot);
  }
}
