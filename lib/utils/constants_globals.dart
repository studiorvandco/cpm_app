import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';

import '../models/event.dart';
import '../pages/episodes.dart';
import '../pages/projects.dart';
import '../services/api.dart';

String token = '';

final API api = API();

enum Logos {
  cpm_light('assets/logos/cpm_light_1024.png'),
  cpm_dark('assets/logos/cpm_dark_1024.png'),
  rvandco_light('assets/logos/cpm_dark_1024.png'),
  rvandco_dark('assets/logos/rvandco_light_2048.png'),
  camera_light('assets/logos/rvandco_dark_2048.png'),
  camera_dark('assets/logos/camera_light_2048.png');

  const Logos(this.value);

  final String value;
}

enum Preferences { theme, locale, authenticated, token }

enum HomePage { projects, episodes, sequences, shots, planning }

enum CalendarView { month, week, day }

const Divider divider = Divider(height: 0, thickness: 1, indent: 16, endIndent: 16);

final GlobalKey<ProjectsState> projectsStateKey = GlobalKey();
final GlobalKey<EpisodesState> episodesStateKey = GlobalKey();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<MonthViewState<Event>> calendarMonthKey = GlobalKey<MonthViewState<Event>>();
final GlobalKey<WeekViewState<Event>> calendarWeekKey = GlobalKey<WeekViewState<Event>>();
final GlobalKey<DayViewState<Event>> calendarDayKey = GlobalKey<DayViewState<Event>>();
