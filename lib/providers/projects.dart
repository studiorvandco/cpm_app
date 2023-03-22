import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/project.dart';
import '../services/project.dart';

part 'projects.g.dart';

@riverpod
class Projects extends _$Projects {
  @override
  FutureOr<List<Project>> build() {
    get();
    return <Project>[];
  }

  Future<Map<String, dynamic>> get() async {
    state = const AsyncLoading<List<Project>>();
    final List<dynamic> result = await ProjectService().getProjects();
    state = AsyncValue<List<Project>>.data(result[1] as List<Project>);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
  }

  Future<Map<String, dynamic>> add(Project project) async {
    final List<dynamic> result = await ProjectService().addProject(project);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Project project) async {
    final List<dynamic> result = await ProjectService().editProject(project);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String projectID) async {
    final List<dynamic> result = await ProjectService().deleteProject(projectID);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
