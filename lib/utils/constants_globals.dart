import 'package:calendar_view/calendar_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/event.dart';
import '../pages/episodes.dart';
import '../pages/projects.dart';
import '../widgets/request_placeholder.dart';

String token = '';

final supabase = Supabase.instance.client;

enum Logos {
  cpmLight('assets/logos/cpm_light_1024.png'),
  cpmDark('assets/logos/cpm_dark_1024.png'),
  rvandcoLight('assets/logos/rvandco_light_2048.png'),
  rvandcoDark('assets/logos/cpm_dark_1024.png'),
  cameraLight('assets/logos/camera_light_2048.png'),
  cameraDark('assets/logos/rvandco_dark_2048.png');

  const Logos(this.value);

  final String value;
}

enum Preferences { theme, locale, authenticated, token }

enum HomePage { projects, episodes, sequences, shots, planning }

enum MenuAction { edit, delete }

final RequestPlaceholder requestPlaceholderError = RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
const RequestPlaceholder requestPlaceholderLoading = RequestPlaceholder(placeholder: CircularProgressIndicator());

const Divider divider = Divider(height: 0, thickness: 1, indent: 16, endIndent: 16);

final GlobalKey<ProjectsState> projectsStateKey = GlobalKey();
final GlobalKey<EpisodesState> episodesStateKey = GlobalKey();

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

final GlobalKey<MonthViewState<Event>> calendarMonthKey = GlobalKey<MonthViewState<Event>>();
final GlobalKey<WeekViewState<Event>> calendarWeekKey = GlobalKey<WeekViewState<Event>>();
final GlobalKey<DayViewState<Event>> calendarDayKey = GlobalKey<DayViewState<Event>>();

int getColumnsCount(BoxConstraints constraints) {
  if (constraints.maxWidth < 750) {
    return 1;
  } else if (constraints.maxWidth < 1500) {
    return 2;
  } else {
    return 3;
  }
}
