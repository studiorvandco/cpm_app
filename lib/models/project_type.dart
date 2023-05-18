enum ProjectType {
  placeholder(-1),
  movie(0),
  series(1),
  ;

  final int type;

  const ProjectType(this.type);

  factory ProjectType.fromIndex(int index) {
    switch (index) {
      case 0:
        return ProjectType.movie;
      case 1:
        return ProjectType.series;
      default:
        throw Exception('Unknown ProjectType index: $index');
    }
  }
}
