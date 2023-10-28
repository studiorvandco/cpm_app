import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/models/member/member.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/utils/constants/constants.dart';

String item<T>() {
  switch (T) {
    case const (Project):
      return localizations.item_project;
    case const (Episode):
      return localizations.item_episode;
    case const (Sequence):
      return localizations.item_sequence;
    case const (Shot):
      return localizations.item_shot;
    case const (Member):
      return localizations.item_member;
    case const (Location):
      return localizations.item_location;
    default:
      throw TypeError();
  }
}

Gender gender<T>() {
  switch (T) {
    case const (Project):
      return Gender.male;
    case const (Episode):
      return Gender.male;
    case const (Sequence):
      return Gender.female;
    case const (Shot):
      return Gender.male;
    case const (Member):
      return Gender.male;
    case const (Location):
      return Gender.male;
    default:
      throw TypeError();
  }
}