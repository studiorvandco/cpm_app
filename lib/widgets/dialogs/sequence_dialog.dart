import 'package:cpm/extensions/date_helpers.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/utils/constants_globals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/location/location.dart';

class SequenceDialog extends ConsumerStatefulWidget {
  const SequenceDialog({super.key, required this.episode, required this.index});

  final int episode;
  final int index;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SequenceDialogState();
}

class _SequenceDialogState extends ConsumerState<SequenceDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;
  Location? location;

  @override
  Widget build(BuildContext context) {
    return ref.watch(locationsProvider).when(
      data: (locations) {
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
                        onPressed: () => pickDate(),
                        icon: const Icon(Icons.calendar_month),
                        label: Text('${startDate?.yMd} - ${endDate?.yMd}'),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: DropdownButtonFormField<Location>(
                      isExpanded: true,
                      hint: Text('attributes.position.upper'.tr()),
                      items: locations.map<DropdownMenuItem<Location>>((Location location) {
                        return DropdownMenuItem<Location>(
                          value: location,
                          child: Text(location.getName),
                        );
                      }).toList(),
                      value: location,
                      onChanged: (Location? value) {
                        setState(() {
                          location = value;
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
      },
      loading: () {
        return requestPlaceholderLoading;
      },
      error: (error, stackTrace) {
        return requestPlaceholderError;
      },
    );
  }

  Future<void> pickDate() async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365 * 100)),
    );

    if (selectedDate == null) {
      return;
    }

    if (context.mounted) {
      final TimeOfDay? startTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(selectedDate),
      );

      if (startTime == null) {
        return;
      }

      if (context.mounted) {
        final TimeOfDay? endTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.fromDateTime(selectedDate),
        );

        if (endTime == null) {
          return;
        }

        setState(() {
          startDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            startTime.hour,
            startTime.minute,
          );
          endDate = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            endTime.hour,
            endTime.minute,
          );
        });
      }
    }
  }

  void submit() {
    final Sequence newSequence = Sequence.insert(
      episode: widget.episode,
      index: widget.index,
      title: titleController.text,
      description: descriptionController.text,
      startDate: startDate ?? DateTime.now(),
      endDate: endDate ?? DateTime.now(),
    );
    Navigator.pop(context, newSequence);
  }
}
