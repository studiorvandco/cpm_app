import 'package:easy_localization/easy_localization.dart';

// ignore_for_file: non_constant_identifier_names

extension DateTimeExtensions on DateTime {
  String get Hm {
    return DateFormat.Hm().format(this);
  }

  String get yMd {
    return DateFormat.yMd().add_jm().format(this);
  }

  DateTime get hundredYearsBefore {
    return subtract(const Duration(days: 36500));
  }

  DateTime get hundredYearsLater {
    return add(const Duration(days: 36500));
  }
}
