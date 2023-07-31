import 'package:easy_localization/easy_localization.dart';

extension DateHelpers on DateTime {
  String get Hm {
    return DateFormat.Hm().format(this);
  }

  String get test {
    return DateFormat.yMd().add_jm().format(this);
  }
}
