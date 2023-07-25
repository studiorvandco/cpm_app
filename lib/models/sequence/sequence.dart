import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
import '../location/location.dart';
import '../shot/shot.dart';

part 'sequence.g.dart';

@JsonSerializable()
class Sequence extends BaseModel {
  int episode;
  int number;
  String? title;
  String? description;
  DateTime? startDate;
  DateTime? endDate;

  String get getTitle => title ?? 'Untitled';

  String get getDescription => description ?? '';

  DateTime get getStartDate => startDate ?? DateTime.now();

  DateTime get getEndDate => endDate ?? DateTime.now();

  Sequence({
    required super.id,
    required this.episode,
    required this.number,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
  });

  Sequence.insert({
    required this.episode,
    required this.number,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
  }) : super(id: -1);

  Sequence.empty()
      : episode = -1,
        number = -1,
        super(id: -1);

  factory Sequence.fromJson(json) => _$SequenceFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$SequenceToJson(this);
}
