import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../constants.dart';
import '../globals.dart';
import '../models/event.dart';
import '../models/project.dart';
import '../models/sequence.dart';
import '../providers/projects.dart';
import '../providers/sequences.dart';
import '../widgets/request_placeholder.dart';

class Planning extends ConsumerStatefulWidget {
  const Planning({super.key});

  @override
  ConsumerState<Planning> createState() => _PlanningState();
}

class _PlanningState extends ConsumerState<Planning> with TickerProviderStateMixin {
  View view = View.week;

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(data: (Project project) {
      return ref.watch(currentSequencesProvider).when(data: (List<Sequence> sequences) {
        CalendarControllerProvider.of<Event>(context).controller.addAll(<CalendarEventData<Event>>[
          ...sequences.map((Sequence sequence) {
            return CalendarEventData<Event>(
                event: Event(title: sequence.title, description: sequence.description ?? ''),
                title: sequence.title,
                date: sequence.startDate,
                startTime: sequence.startDate,
                endTime: sequence.endDate);
          })
        ]);
        switch (view) {
          case View.month:
            return Expanded(child: _buildMonthView(project));
          case View.week:
            return Expanded(child: _buildWeekView(project));
          case View.day:
            return Expanded(child: _buildDayView(project));
        }
      }, error: (Object error, StackTrace stackTrace) {
        return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
      }, loading: () {
        return const RequestPlaceholder(placeholder: CircularProgressIndicator());
      });
    }, error: (Object error, StackTrace stackTrace) {
      return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
    }, loading: () {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    });
  }

  HeaderStyle _buildHeader() {
    return HeaderStyle(
        decoration: BoxDecoration(color: Theme.of(context).colorScheme.surface),
        leftIcon: Row(
          children: <Widget>[
            IconButton(
                onPressed: () {
                  switch (view) {
                    case View.month:
                      calendarMonthKey.currentState?.previousPage();
                      break;
                    case View.week:
                      calendarWeekKey.currentState?.previousPage();
                      break;
                    case View.day:
                      calendarDayKey.currentState?.previousPage();
                      break;
                  }
                },
                icon: const Icon(Icons.chevron_left)),
            const Padding(padding: EdgeInsets.only(right: 8)),
            IconButton(
                onPressed: () {
                  switch (view) {
                    case View.month:
                      calendarMonthKey.currentState?.nextPage();
                      break;
                    case View.week:
                      calendarWeekKey.currentState?.nextPage();
                      break;
                    case View.day:
                      calendarDayKey.currentState?.nextPage();
                      break;
                  }
                },
                icon: const Icon(Icons.chevron_right))
          ],
        ),
        rightIcon: DropdownButton<View>(
          focusColor: Colors.transparent,
          value: view,
          items: <DropdownMenuItem<View>>[
            DropdownMenuItem<View>(
                value: View.month,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_view_month),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text('planning.date.month.upper'.tr()),
                  ],
                )),
            DropdownMenuItem<View>(
                value: View.week,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_view_week),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text('planning.date.week.upper'.tr()),
                  ],
                )),
            DropdownMenuItem<View>(
                value: View.day,
                child: Row(
                  children: <Widget>[
                    const Icon(Icons.calendar_view_day),
                    const Padding(padding: EdgeInsets.only(right: 8)),
                    Text('planning.date.day.upper'.tr()),
                  ],
                ))
          ],
          onChanged: (View? newView) {
            setState(() {
              view = newView!;
            });
          },
        ));
  }

  LayoutBuilder _buildMonthView(Project project) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return MonthView<Event>(
        key: calendarMonthKey,
        headerStyle: _buildHeader(),
        minMonth: project.startDate,
        maxMonth: project.endDate,
        initialMonth: DateTime.now(),
        onPageChange: (DateTime date, int pageIndex) => print('$date, $pageIndex'),
        onCellTap: (List<CalendarEventData<Object?>> events, DateTime date) {
          print(events);
        },
        onEventTap: (CalendarEventData<Object?> event, DateTime date) => print(event),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildWeekView(Project project) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return WeekView<Event>(
        key: calendarWeekKey,
        headerStyle: _buildHeader(),
        minDay: project.startDate,
        maxDay: project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger<Event>(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) => print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }

  LayoutBuilder _buildDayView(Project project) {
    return LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
      return DayView<Event>(
        key: calendarDayKey,
        headerStyle: _buildHeader(),
        minDay: project.startDate,
        maxDay: project.endDate,
        initialDay: DateTime.now(),
        eventArranger: const SideEventArranger<Event>(),
        onEventTap: (List<CalendarEventData<Object?>> events, DateTime date) => print(events),
        onDateLongPress: (DateTime date) => print(date),
        width: constraints.maxWidth,
      );
    });
  }
}
