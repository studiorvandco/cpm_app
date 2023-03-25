import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project.dart';
import '../../providers/projects.dart';
import '../icon_label.dart';
import '../request_placeholder.dart';

class DetailsPaneProject extends ConsumerStatefulWidget {
  const DetailsPaneProject({super.key});

  @override
  ConsumerState<DetailsPaneProject> createState() => _DetailsPaneProjectState();
}

class _DetailsPaneProjectState extends ConsumerState<DetailsPaneProject>
    with AutomaticKeepAliveClientMixin<DetailsPaneProject> {
  late DateTime start;
  late DateTime end;
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return ref.watch(currentProjectProvider).when(data: (Project project) {
      start = project.startDate;
      end = project.endDate;
      titleController.text = project.title;
      descriptionController.text = project.description;

      return Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Focus(
              onFocusChange: (bool hasFocus) {
                if (!hasFocus && titleController.text != project.title) {
                  edit(project);
                }
              },
              child: TextField(
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration.collapsed(hintText: 'attributes.title.upper'.tr()),
                controller: titleController,
                maxLength: 64,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            Focus(
              onFocusChange: (bool hasFocus) {
                if (!hasFocus && descriptionController.text != project.description) {
                  edit(project);
                }
              },
              child: TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                decoration: InputDecoration.collapsed(hintText: 'attributes.description.upper'.tr()),
                controller: descriptionController,
                keyboardType: TextInputType.multiline,
                minLines: 1,
                maxLines: null,
                maxLength: 280,
              ),
            ),
            const Padding(padding: EdgeInsets.only(bottom: 16)),
            GestureDetector(
              onTap: () => editDate(project),
              behavior: HitTestBehavior.translucent,
              child: IconLabel(
                text: getDateText(),
                icon: Icons.event_outlined,
                textStyle: TextStyle(color: Theme.of(context).colorScheme.primary),
              ),
            ),
          ],
        ),
      );
    }, error: (Object error, StackTrace stackTrace) {
      return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
    }, loading: () {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    });
  }

  String getDateText() {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(start);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(end);
    return '$firstText - $lastText';
  }

  Future<void> editDate(Project project) async {
    final DateTimeRange? newDates = await showDateRangePicker(
        context: context,
        initialDateRange: DateTimeRange(start: start, end: end),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101));
    if (newDates != null) {
      setState(() {
        start = newDates.start;
        end = newDates.end;
      });
    }
    edit(project);
  }

  Future<void> edit(Project project) async {
    project.title = titleController.text;
    project.description = descriptionController.text;
    project.startDate = start;
    project.endDate = end;

    ref.read(projectsProvider.notifier).edit(project);
    ref.read(currentProjectProvider.notifier).set(project);
  }
}
