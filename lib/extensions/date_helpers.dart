import 'package:easy_localization/easy_localization.dart';

extension DateHelpers on DateTime {
  // ignore: non_constant_identifier_names
  String get Hm {
    return DateFormat.Hm().format(this);
  }

  String get yMd {
    return DateFormat.yMd().add_jm().format(this);
  }
}
