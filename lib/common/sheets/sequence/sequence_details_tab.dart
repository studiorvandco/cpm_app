import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SequenceDetailsTab extends ConsumerStatefulWidget {
  const SequenceDetailsTab({super.key});

  @override
  ConsumerState<SequenceDetailsTab> createState() => _ProjectDetailsTabState();
}

class _ProjectDetailsTabState extends ConsumerState<SequenceDetailsTab> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  DateTime? date = DateTime.now();
  TimeOfDay? startTime = TimeOfDay.now();
  TimeOfDay? endTime = TimeOfDay.now().hourLater;
  Location? location;

  @override
  void initState() {
    super.initState();

    final sequence = ref.read(currentSequenceProvider).value;
    title.text = sequence?.title ?? '';
    description.text = sequence?.description ?? '';
    date = sequence?.getDate;
    startTime = sequence?.getStartTime;
    endTime = sequence?.getEndTime;
    location = sequence?.location;
  }

  Future<void> _pickDateTime(Sequence sequence) async {
    await showDatePicker(
      context: context,
      initialDate: date ?? DateTime.now(),
      firstDate: DateTime.now().hundredYearsBefore,
      lastDate: DateTime.now().hundredYearsLater,
    ).then((pickedDate) async {
      if (pickedDate == null) return;

      await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      ).then((pickedStartTime) async {
        if (pickedStartTime == null) return;

        await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        ).then((pickedEndTime) {
          if (pickedEndTime == null) return;

          date = pickedDate;
          startTime = pickedStartTime;
          endTime = pickedEndTime;
          _edit(sequence);
        });
      });
    });
  }

  void _onLocationSelected(Sequence sequence, Location? newLocation) {
    if (newLocation == null) return;

    location = newLocation;
    _edit(sequence);
  }

  void _onSubmitted(Sequence sequence) {
    if (title.text == sequence.title &&
        description.text == sequence.description &&
        location == sequence.location &&
        date == sequence.getDate &&
        startTime == sequence.getStartTime &&
        endTime == sequence.getEndTime) return;

    _edit(sequence);
  }

  void _edit(Sequence sequence) {
    sequence.title = title.text;
    sequence.description = description.text;
    if (date != null && startTime != null) {
      sequence.startDate = DateTime(date!.year, date!.month, date!.day, startTime!.hour, startTime!.minute);
    }
    if (date != null && endTime != null) {
      sequence.endDate = DateTime(date!.year, date!.month, date!.day, endTime!.hour, endTime!.minute);
    }
    if (location != null) {
      sequence.location = Location(
        id: location!.id,
        name: location!.name,
        position: location!.position,
      );
    }

    ref.read(sequencesProvider.notifier).edit(sequence, location?.id);
    ref.read(currentSequenceProvider.notifier).set(sequence);
  }

  @override
  Widget build(BuildContext context) {
    print(ref.read(locationsProvider).value);
    return ref.watch(currentSequenceProvider).when(
      data: (sequence) {
        return Column(
          children: [
            Row(
              children: [
                OutlinedButton.icon(
                  icon: const Icon(Icons.calendar_month),
                  label: Text('${date?.yMd} | ${startTime?.format(context)} - ${endTime?.format(context)}'),
                  onPressed: () => _pickDateTime(sequence),
                ),
                Padding(padding: Paddings.padding8.horizontal),
                Expanded(
                  child: ref.watch(locationsProvider).when(
                    data: (locations) {
                      return DropdownButtonFormField<Location>(
                        isExpanded: true,
                        hint: Text(localizations.dialog_field_position),
                        value: location,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          isDense: true,
                        ),
                        items: locations.map<DropdownMenuItem<Location>>((location) {
                          return DropdownMenuItem<Location>(
                            value: location,
                            child: Text(location.getName),
                          );
                        }).toList(),
                        onChanged: (location) => _onLocationSelected(sequence, location),
                      );
                    },
                    loading: () {
                      return requestPlaceholderLoading;
                    },
                    error: (Object error, StackTrace stackTrace) {
                      return requestPlaceholderError;
                    },
                  ),
                ),
              ],
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(sequence) : null,
              child: TextField(
                controller: title,
                textInputAction: TextInputAction.next,
                style: Theme.of(context).textTheme.titleMedium,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_title,
                ),
                onSubmitted: (_) => _onSubmitted(sequence),
              ),
            ),
            Padding(padding: Paddings.padding8.vertical),
            Focus(
              onFocusChange: (hasFocus) => !hasFocus ? _onSubmitted(sequence) : null,
              child: TextField(
                controller: description,
                decoration: InputDecoration.collapsed(
                  hintText: localizations.dialog_field_description,
                ),
                keyboardType: TextInputType.multiline,
                minLines: 3,
                maxLines: null,
                onSubmitted: (_) => _onSubmitted(sequence),
              ),
            ),
          ],
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
}
