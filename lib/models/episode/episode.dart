import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

import '../sequence/sequence.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode extends BaseModel {
  int number;
  String title;
  String description;
  String? director;
  String? writer;
  List<Sequence>? sequences;

  Episode({
    super.id,
    required this.number,
    required this.title,
    required this.description,
    this.director,
    this.writer,
    this.sequences,
  });

  Episode.empty()
      : number = -1,
        title = '',
        description = '',
        super();

  factory Episode.fromJson(Map<String, dynamic> json) => _$EpisodeFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
