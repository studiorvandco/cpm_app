import 'package:json_annotation/json_annotation.dart';

import '../location/location.dart';
import '../shot/shot.dart';

part 'sequence.g.dart';

@JsonSerializable()
class Sequence {
  @JsonKey(includeToJson: false)
  final String id;
  int number;
  String title;
  String? description;
  DateTime startDate;
  DateTime endDate;
  Location? location;
  List<Shot>? shots;

  Sequence({
    required this.id,
    required this.number,
    required this.title,
    this.description,
    required this.startDate,
    required this.endDate,
    this.location,
    this.shots,
  });

  factory Sequence.fromJson(json) => _$SequenceFromJson(json);

  Map<String, dynamic> toJson() => _$SequenceToJson(this);
}
