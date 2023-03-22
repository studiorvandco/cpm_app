import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../models/project.dart';
import '../services/episode.dart';

part 'currents.g.dart';

@Riverpod(keepAlive: true)
class CurrentProject extends _$CurrentProject {
  @override
  FutureOr<Project> build() {
    return Project(
        id: '',
        projectType: ProjectType.placeholder,
        title: '',
        description: '',
        startDate: DateTime.now(),
        endDate: DateTime.now());
  }

  void set(Project project) {
    state = AsyncData<Project>(project);
  }
}

@riverpod
class CurrentEpisodes extends _$CurrentEpisodes {
  @override
  FutureOr<List<Episode>> build() {
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      final List<dynamic> result = await EpisodeService().getEpisodes(project.id);
      return result[1] as List<Episode>;
    }, error: (Object error, StackTrace stackTrace) {
      return <Episode>[];
    }, loading: () {
      return <Episode>[];
    });
  }

  Future<Map<String, dynamic>> get() {
    state = const AsyncLoading<List<Episode>>();
    return ref.watch(currentProjectProvider).when(data: (Project project) async {
      final List<dynamic> result = await EpisodeService().getEpisodes(project.id);
      state = AsyncData<List<Episode>>(result[1] as List<Episode>);
      return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
    }, error: (Object error, StackTrace stackTrace) {
      return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
    }, loading: () {
      return Future<Map<String, dynamic>>(() => <String, dynamic>{'succeeded': false, 'code': -1});
    });
  }
}
