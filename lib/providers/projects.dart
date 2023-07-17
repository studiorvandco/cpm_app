import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/project/link.dart';
import '../models/project/project.dart';
import '../services/config/supabase_table.dart';
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
    List<Project> projects = await selectProjectService.selectProjects();
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
class CurrentProject extends _$CurrentProject with BaseProvider {
  final SupabaseTable linkTable = SupabaseTable.link;

  @override
  FutureOr<Project> build() {
    return Future.value(null);
  }

  Future<void> set(Project project) async {
    project.links = await selectLinkService.selectLinks(project.id);
    state = AsyncData<Project>(project);
  }

  Future<void> addLink(Link newLink) async {
    await insertService.insert(linkTable, newLink);
    if (state.value != null) {
      await set(state.value!); // Get the new list of links
    }
  }

  Future<void> editLink(Link editedLink) async {
    await updateService.update(linkTable, editedLink);
    if (state.value != null) {
      await set(state.value!); // Get the new list of links
    }
  }

  Future<void> deleteLink(int? id) async {
    await deleteService.delete(linkTable, id);
    if (state.value != null) {
      await set(state.value!); // Get the new list of links
    }
  }
}
