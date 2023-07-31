import 'package:cpm/models/sequence/sequence.dart';
import 'package:flutter/material.dart';

class AppointmentTile extends StatelessWidget {
  const AppointmentTile({super.key, required this.sequence});

  final Sequence sequence;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.green[600],
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
                  label: Text(sequence.getNumber),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                ),
                const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                Expanded(
                  child: Text(
                    sequence.getTitle,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Expanded(
                  child: Text(
                    '${sequence.getStartDate} - ${sequence.getEndDate}',
                    overflow: TextOverflow.ellipsis,
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
    );
  }
}
