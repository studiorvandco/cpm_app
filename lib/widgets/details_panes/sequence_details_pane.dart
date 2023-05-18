import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/episode.dart';
import '../../models/project/project.dart';
import '../../models/sequence.dart';
import '../../providers/episodes.dart';
import '../../providers/projects.dart';
import '../../providers/sequences.dart';
import '../../utils/constants_globals.dart';
import '../icon_label.dart';

class SequenceDetailsPane extends ConsumerStatefulWidget {
  const SequenceDetailsPane({super.key});

  @override
  ConsumerState<SequenceDetailsPane> createState() => _DetailsPaneSequenceState();
}

class _DetailsPaneSequenceState extends ConsumerState<SequenceDetailsPane>
    with AutomaticKeepAliveClientMixin<SequenceDetailsPane> {
  late DateTime start;
  late DateTime end;
  TextEditingController titleController = TextEditingController();
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
                start = sequence.startDate;
                end = sequence.endDate;
                titleController.text = sequence.title;
                descriptionController.text = sequence.description ?? '';
                titleController.selection = TextSelection.collapsed(offset: titleController.text.length);
                descriptionController.selection = TextSelection.collapsed(offset: descriptionController.text.length);

                return Padding(
                  padding:
                      EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Focus(
                        onFocusChange: (bool hasFocus) {
                          if (!hasFocus && titleController.text != project.title) {
                            edit(project.id, episode.id, sequence);
                          }
                        },
                        child: TextField(
                          style: Theme.of(context).textTheme.titleMedium,
                          decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                          controller: titleController,
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 16)),
                      Focus(
                        onFocusChange: (bool hasFocus) {
                          if (!hasFocus && descriptionController.text != project.description) {
                            edit(project.id, episode.id, sequence);
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
                      const Padding(padding: EdgeInsets.only(bottom: 16)),
                      GestureDetector(
                        onTap: () => editDate(project.id, episode.id, sequence),
                        behavior: HitTestBehavior.translucent,
                        child: IconLabel(
                          text: getDateText(),
                          icon: Icons.event,
                          textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
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
  }

  String getDateText() {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(start);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(end);

    return '$firstText - $lastText';
  }

  Future<void> editDate(String projectID, String episodeID, Sequence sequence) async {
    final DateTimeRange? newDates = await showDateRangePicker(
      context: context,
      initialDateRange: DateTimeRange(start: start, end: end),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (newDates != null) {
      setState(() {
        start = newDates.start;
        end = newDates.end;
      });
    }
    edit(projectID, episodeID, sequence);
  }

  void edit(String projectID, String episodeID, Sequence sequence) {
    sequence.title = titleController.text;
    sequence.description = descriptionController.text;
    sequence.startDate = start;
    sequence.endDate = end;

    ref.read(sequencesProvider.notifier).edit(projectID, episodeID, sequence);
    ref.read(currentSequenceProvider.notifier).set(sequence);
  }
}
