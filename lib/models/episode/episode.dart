import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../sequence/sequence.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode extends BaseModel {
  int project;
  int number;
  String? title;
  String? description;
  String? director;
  String? writer;
  List<Sequence>? sequences;

  String get getTitle => title ?? 'Untitled';

  String get getDescription => description ?? '';

  Episode({
    required super.id,
    required this.project,
    required this.number,
    this.title,
    this.description,
    this.director,
    this.writer,
    this.sequences,
  });

  Episode.insert({
    required this.project,
    required this.number,
    this.title,
    this.description,
    this.director,
    this.writer,
    this.sequences,
  }) : super(id: -1);

  Episode.empty()
      : project = -1,
        number = -1,
        super(id: -1);

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
