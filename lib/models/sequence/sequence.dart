import 'package:cpm/extensions/time_of_day_extensions.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
import '../location/location.dart';

part 'sequence.g.dart';

@JsonSerializable()
class Sequence extends BaseModel {
  int episode;
  int index;
  @JsonKey(defaultValue: -1, includeToJson: false)
  int number;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;
  @JsonKey(includeFromJson: false, includeToJson: false)
  Location? location;

  String get getNumber => number.toString();

  String get getTitle => title ?? 'Untitled';

  String get getDescription => description ?? '';

  DateTime get getDate => startDate ?? DateTime.now();

  TimeOfDay get getStartTime =>
      startDate != null ? TimeOfDay(hour: startDate!.hour, minute: startDate!.minute) : TimeOfDay.now();

  TimeOfDay get getEndTime =>
      endDate != null ? TimeOfDay(hour: endDate!.hour, minute: endDate!.minute) : TimeOfDay.now().hourLater;

  Sequence({
    required super.id,
    required this.episode,
    required this.index,
    required this.number,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.location,
  });

  Sequence.insert({
    required this.episode,
    required this.index,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
  })  : number = -1,
        super(id: -1);

  Sequence.empty()
      : episode = -1,
        index = -1,
        number = -1,
        super(id: -1);

  factory Sequence.fromJson(json) => _$SequenceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SequenceToJson(this);
}
