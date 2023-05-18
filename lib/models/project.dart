import 'episode.dart';
import 'project_type.dart';

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
  bool favorite = false;

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

  factory Project.fromJson(json) {
    return Project(
      id: json['id'].toString(),
      projectType: ProjectType.values[(json['project_type'])],
      title: json['title'].toString(),
      description: json['description'].toString(),
      startDate: DateTime.parse(json['begin_date'].toString()),
      endDate: DateTime.parse(json['end_date'].toString()),
      shotsTotal: json['shots_total'] as int,
      shotsCompleted: json['shots_completed'] as int,
      episodes: <Episode>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'project_type': projectType.index,
      'title': title,
      'description': description,
      'begin_date': startDate.toIso8601String(),
      'end_date': endDate.toIso8601String(),
      'shots_total': shotsTotal ?? 0,
      'shots_completed': shotsCompleted ?? 0,
      'episodes': episodes,
    };
  }

  void toggleFavorite() {
    favorite = !favorite;
  }

  double getProgress() {
    if (shotsCompleted == null || shotsTotal == null || shotsTotal == 0) {
      return 0.0;
    }

    return shotsCompleted! / shotsTotal!;
  }

  bool isMovie() {
    return projectType == ProjectType.movie;
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
