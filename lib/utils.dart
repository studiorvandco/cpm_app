import 'package:calendar_view/calendar_view.dart';
import 'package:cpm/pages/episodes.dart';
import 'package:cpm/pages/projects.dart';
import 'package:flutter/material.dart';

import 'models/event.dart';

String token = '';

enum HomePage { projects, episodes, sequences, shots, planning }

enum CalendarView { month, week, day }

const Divider divider = Divider(height: 0, thickness: 1, indent: 16, endIndent: 16);

final GlobalKey<ProjectsState> projectsStateKey = GlobalKey();
final GlobalKey<EpisodesState> episodesStateKey = GlobalKey();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<MonthViewState<Event>> calendarMonthKey = GlobalKey<MonthViewState<Event>>();
final GlobalKey<WeekViewState<Event>> calendarWeekKey = GlobalKey<WeekViewState<Event>>();
final GlobalKey<DayViewState<Event>> calendarDayKey = GlobalKey<DayViewState<Event>>();
