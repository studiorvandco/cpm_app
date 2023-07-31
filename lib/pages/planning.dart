import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../models/sequence/sequence.dart';
import '../providers/sequences/sequences.dart';
import '../utils/constants_globals.dart';

class Planning extends ConsumerStatefulWidget {
  const Planning({super.key});

  @override
  ConsumerState<Planning> createState() => _PlanningState();
}

class _PlanningState extends ConsumerState<Planning> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(sequencesProvider).when(
      data: (List<Sequence> sequences) {
        return Expanded(
          child: SfCalendar(
            firstDayOfWeek: 1,
            showNavigationArrow: true,
            showTodayButton: true,
            view: CalendarView.schedule,
            allowedViews: [
              CalendarView.schedule,
              CalendarView.day,
              CalendarView.week,
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
  }
}
