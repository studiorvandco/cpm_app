import 'dart:async';

import 'package:cpm/services/config/supabase_table.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/project/project.dart';
import 'base_provider.dart';

part 'projects.g.dart';

@riverpod
class Projects extends _$Projects with BaseProvider {
  final SupabaseTable table = SupabaseTable.project;

  @override
  FutureOr<List<Project>> build() {
    get();

    return <Project>[];
  }

  Future<void> get() async {
    state = const AsyncLoading<List<Project>>();
    final List<Project> projects = await selectProjectService.selectProjects();
    state = AsyncData<List<Project>>(projects);
  }

  Future<void> add(Project newProject) async {
    await insertService.insert(table, newProject);
    await get(); // Get the projects in order to get the new project's ID
  }

  Future<void> edit(Project editedProject) async {
    await updateService.update(table, editedProject);
    state = AsyncData<List<Project>>(<Project>[
      for (final Project project in state.value ?? <Project>[])
        if (project.id != editedProject.id) project else editedProject,
    ]);
  }

  Future<void> delete(int? id) async {
    await deleteService.delete(table, id);
    state = AsyncData<List<Project>>(<Project>[
      for (final Project project in state.value ?? <Project>[])
        if (project.id != id) project,
    ]);
  }
}

@Riverpod(keepAlive: true)
class CurrentProject extends _$CurrentProject {
  @override
  FutureOr<Project> build() {
    return Future.value(null);
  }

  void set(Project project) {
    state = AsyncData<Project>(project);
  }
}
