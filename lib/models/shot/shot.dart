import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'shot.g.dart';

@JsonSerializable()
class Shot extends BaseModel {
  int sequence;
  int number;
  String? value;
  String? description;
  bool completed;

  String get getDescription => description ?? '';

  Shot({
    required super.id,
    required this.sequence,
    required this.number,
    this.value,
    this.description,
    required this.completed,
  });

  Shot.insert({
    required this.sequence,
    required this.number,
    this.value,
    this.description,
    required this.completed,
  }) : super(id: -1);

  Shot.empty()
      : sequence = -1,
        number = -1,
        completed = false,
        super(id: -1);

  factory Shot.fromJson(Map<String, dynamic> json) => _$ShotFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$ShotToJson(this);
}
