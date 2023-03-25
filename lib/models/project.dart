import 'episode.dart';

enum ProjectType { movie, series, placeholder }

class Project implements Comparable<Project> {
  Project({required this.id,
    required this.projectType,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    this.shotsTotal,
    this.shotsCompleted,
    this.director,
    this.writer,
    this.episodes});

  factory Project.fromJson(json) {
    final ProjectType projectType = (json['isFilm'] as bool) ? ProjectType.movie : ProjectType.series;

    return Project(
      id: json['Id'].toString(),
      projectType: projectType,
      title: json['Title'].toString(),
      description: json['Description'].toString(),
      startDate: DateTime.parse(json['BeginDate'].toString()),
      endDate: DateTime.parse(json['EndDate'].toString()),
      shotsTotal: json['ShotsTotal'] as int,
      shotsCompleted: json['ShotsCompleted'] as int,
      episodes: <Episode>[],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isFilm': projectType == ProjectType.movie,
      'isSeries': projectType == ProjectType.series,
      'title': title,
      'description': description,
      'beginDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'shotsTotal': shotsTotal ?? 0,
      'shotsCompleted': shotsCompleted ?? 0,
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
