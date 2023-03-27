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
    final List<dynamic> result = await ProjectService().getAll();
    state = AsyncValue<List<Project>>.data(result[1] as List<Project>);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
  }

  Future<Map<String, dynamic>> add(Project newProject) async {
    final List<dynamic> result = await ProjectService().add(newProject);
    await get(); // Get the projects in order to get the new project's ID
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Project editedProject) async {
    final List<dynamic> result = await ProjectService().edit(editedProject);
    state = AsyncData<List<Project>>(<Project>[
      for (final Project project in state.value ?? <Project>[])
        if (project.id != editedProject.id) project else editedProject,
    ]);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String projectID) async {
    final List<dynamic> result = await ProjectService().delete(projectID);
    state = AsyncData<List<Project>>(<Project>[
      for (final Project project in state.value ?? <Project>[])
        if (project.id != projectID) project,
    ]);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}

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
