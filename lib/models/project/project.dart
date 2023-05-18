import 'package:json_annotation/json_annotation.dart';

import '../episode.dart';
import 'project_type.dart';

part 'project.g.dart';

@JsonSerializable()
class Project implements Comparable<Project> {
  final String id;
  ProjectType projectType;
  String title;
  String description;
  DateTime startDate;
  DateTime endDate;
  int? shotsTotal;
  int? shotsCompleted;
  String? director;
  String? writer;
  List<Episode>? episodes;

  @JsonKey(includeFromJson: false, includeToJson: false)
  bool favorite = false;

  bool get isMovie {
    return projectType == ProjectType.movie;
  }

  double get progress {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return 0.0;
    }

    return shotsCompleted! / shotsTotal!;
  }

  Project({
    required this.id,
    required this.projectType,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.shotsTotal,
    this.shotsCompleted,
    this.director,
    this.writer,
    this.episodes,
  });

  factory Project.fromJson(json) => _$ProjectFromJson(json);

  Map<String, dynamic> toJson() => _$ProjectToJson(this);

  void toggleFavorite() {
    favorite = !favorite;
  }

  @override
  int compareTo(Project other) {
    if (favorite == other.favorite) {
      return other.startDate.compareTo(startDate);
    } else if (favorite) {
      return -1;
    } else {
      return 1;
    }
  }
}
