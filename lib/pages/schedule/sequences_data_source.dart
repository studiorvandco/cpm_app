import 'package:cpm/models/sequence/sequence.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class SequencesDataSource extends CalendarDataSource {
  SequencesDataSource(List<Sequence> sequences) {
    appointments = sequences;
  }

  @override
  DateTime getStartTime(int index) {
    return (appointments![index] as Sequence).getStartDate;
  }

  @override
  DateTime getEndTime(int index) {
    return (appointments![index] as Sequence).getEndDate;
  }

  @override
  String getSubject(int index) {
    return (appointments![index] as Sequence).getTitle;
  }

  @override
  String getNotes(int index) {
    return (appointments![index] as Sequence).getDescription;
  }

  @override
  String getLocation(int index) {
    return '15 chemin de la colline, 74000 Annecy, France';
  }

  @override
  Color getColor(int index) {
    return Colors.blue;
  }

  @override
  bool isAllDay(int index) {
    return false;
  }
}