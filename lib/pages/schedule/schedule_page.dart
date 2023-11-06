import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/schedule/appointment_tile.dart';
import 'package:cpm/pages/schedule/sequences_data_source.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SchedulePage extends ConsumerStatefulWidget {
  const SchedulePage({super.key});

  @override
  ConsumerState<SchedulePage> createState() => _ScheduleState();
}

class _ScheduleState extends ConsumerState<SchedulePage> {
  final CalendarController _calendarController = CalendarController();

  void _open(CalendarTapDetails? details) {
    if (details == null || details.appointments == null || details.appointments!.isEmpty) return;

    ref.read(currentSequenceProvider.notifier).set(details.appointments!.first as Sequence);
    context.pushNamed(RouterRoute.shots.name);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(sequencesProvider).when(
      data: (sequences) {
        return SfCalendar(
          controller: _calendarController,
          dataSource: SequencesDataSource(sequences),
          firstDayOfWeek: 1,
          showNavigationArrow: true,
          showTodayButton: true,
          allowedViews: const [
            CalendarView.schedule,
            CalendarView.day,
            CalendarView.week,
          ],
          appointmentBuilder: (context, details) {
            return AppointmentTile(sequence: details.appointments.first as Sequence);
          },
          onTap: _open,
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
