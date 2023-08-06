import 'package:cpm/extensions/date_helpers.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:flutter/material.dart';

import '../../utils/unique_color.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({super.key, required this.sequence});

  final Sequence sequence;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: '${sequence.startDate?.Hm} - ${sequence.endDate?.Hm}',
      waitDuration: const Duration(seconds: 1),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Theme.of(context).colorScheme.surface,
        ),
        child: Padding(
          padding: const EdgeInsets.all(4.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Badge(
                    label: Text(
                      sequence.getNumber,
                      style: TextStyle(color: UniqueColor().getTextColor),
                    ),
                    backgroundColor: UniqueColor().getColor,
                  ),
                  const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                  Expanded(
                    child: Text(
                      sequence.getTitle,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Text(sequence.getDescription),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
