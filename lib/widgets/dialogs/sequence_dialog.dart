import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../models/sequence/sequence.dart';

class SequenceDialog extends StatefulWidget {
  const SequenceDialog({super.key, required this.episode, required this.locations, required this.number});

  final int episode;
  final int number;
  final List<String> locations;

  @override
  State<StatefulWidget> createState() => _SequenceDialogState();
}

class _SequenceDialogState extends State<SequenceDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late final List<String> locations;
  DateTimeRange? dates;
  String? selectedLocation;
  String dateText = '';

  @override
  void initState() {
    locations = widget.locations;

    return super.initState();
  }

  void updateDateText() {
    String res;
    if (dates != null) {
      final String firstText = DateFormat.yMd(context.locale.toString()).format(dates!.start);
      final String lastText = DateFormat.yMd(context.locale.toString()).format(dates!.end);
      res = '$firstText - $lastText';
    } else {
      res = 'dates_dialog'.tr();
    }
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
                  Text('${'new.fem.upper'.tr()} ${'sequences.sequence.lower'.plural(1)}'),
                  Text(
                    '${'add.upper'.tr()} ${'articles.a.fem.lower'.tr()} ${'new.fem.lower'.tr()} ${'sequences.sequence.lower'.plural(1)}.',
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
                  child: TextFormField(
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
                    onPressed: pickDate,
                    icon: const Icon(Icons.calendar_month),
                    label: Text(dateText),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButtonFormField<String>(
                  isExpanded: true,
                  hint: Text('attributes.position.upper'.tr()),
                  items: locations.map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  value: selectedLocation,
                  onChanged: (String? value) {
                    setState(() {
                      selectedLocation = value;
                    });
                  },
                  decoration: InputDecoration(
                    labelText: 'locations.location.upper'.plural(1),
                    border: const OutlineInputBorder(),
                    isDense: true,
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

  void pickDate() async {
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
    final Sequence newSequence = Sequence.insert(
      episode: widget.episode,
      number: widget.number,
      title: titleController.text,
      description: descriptionController.text,
      startDate: dates?.start ?? DateTime.now(),
      endDate: dates?.end ?? DateTime.now(),
    );
    Navigator.pop(context, newSequence);
  }
}
