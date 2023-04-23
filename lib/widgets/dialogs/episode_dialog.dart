import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/episode.dart';
import '../../models/sequence.dart';

class EpisodeDialog extends StatefulWidget {
  const EpisodeDialog({
    super.key,
    required this.number,
  });

  final int number;

  @override
  State<StatefulWidget> createState() => _EpisodeDialogState();
}

class _EpisodeDialogState extends State<EpisodeDialog> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  DateTimeRange dates = DateTimeRange(start: DateTime.now(), end: DateTime.now().add(const Duration(days: 2)));
  String dateText = '';

  void updateDateText() {
    String res;
    final String firstText = DateFormat.yMd(context.locale.toString()).format(dates.start);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(dates.end);
    res = '$firstText - $lastText';
    setState(() {
      dateText = res;
    });
  }

  @override
  Widget build(BuildContext context) {
    updateDateText();

    return SimpleDialog(
      title: SizedBox(
        width: 300,
        child: Padding(
          padding: const EdgeInsets.all(6.8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Text>[
                  Text('${'new.masc.el.upper'.tr()} ${'episodes.episode.lower'.plural(1)}'),
                  Text(
                    '${'add.upper'.tr()} ${'articles.a.masc.lower'.tr()} ${'new.masc.el.lower'.tr()} ${'episodes.episode.lower'.plural(1)}.',
                    style: const TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextField(
                    maxLength: 64,
                    controller: titleController,
                    decoration: InputDecoration(
                      labelText: 'attributes.title.upper'.tr(),
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                    autofocus: true,
                    onEditingComplete: submit,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: TextField(
                    maxLength: 280,
                    maxLines: 4,
                    controller: descriptionController,
                    decoration: InputDecoration(
                      labelText: 'attributes.description.upper'.tr(),
                      border: const OutlineInputBorder(),
                      isDense: true,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 330,
                  child: OutlinedButton.icon(
                    onPressed: () => changeDate(),
                    icon: const Icon(Icons.calendar_month),
                    label: Text(dateText),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('cancel.upper'.tr()),
                  ),
                  TextButton(onPressed: submit, child: Text('confirm.upper'.tr())),
                ],
              ),
            ]),
          ),
        ),
      ],
    );
  }

  Future<void> changeDate() async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(3000),
      initialDateRange: dates,
    );
    if (picked != null) {
      dates = DateTimeRange(start: picked.start, end: picked.end);
      updateDateText();
    }
  }

  void submit() {
    final Episode newEpisode = Episode(
      id: '',
      number: widget.number,
      title: titleController.text,
      description: descriptionController.text,
      sequences: <Sequence>[],
    );
    Navigator.pop(context, newEpisode);
  }
}