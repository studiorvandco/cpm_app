import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import 'models/event.dart';

const Divider divider = Divider(height: 0, thickness: 1, indent: 16, endIndent: 16);

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<MonthViewState<Event>> calendarMonthKey = GlobalKey<MonthViewState<Event>>();
final GlobalKey<WeekViewState<Event>> calendarWeekKey = GlobalKey<WeekViewState<Event>>();
final GlobalKey<DayViewState<Event>> calendarDayKey = GlobalKey<DayViewState<Event>>();
