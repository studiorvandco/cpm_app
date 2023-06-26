import 'package:json_annotation/json_annotation.dart';

import '../sequence/sequence.dart';

part 'episode.g.dart';

@JsonSerializable()
class Episode {
  @JsonKey(includeToJson: false)
  final String id;
  int number;
  String title;
  String description;
  String? director;
  String? writer;
  List<Sequence>? sequences;

  Episode({
    required this.id,
    required this.number,
    required this.title,
    required this.description,
    this.director,
    this.writer,
    this.sequences,
  });

  Episode.empty()
      : id = '-1',
        number = -1,
        title = '',
        description = '';

  factory Episode.fromJson(json) => _$EpisodeFromJson(json);

  Map<String, dynamic> toJson() => _$EpisodeToJson(this);
}
