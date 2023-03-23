import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../dialogs/new_project.dart';
import '../models/project.dart';
import '../providers/navigation.dart';
import '../providers/projects.dart';
import '../utils.dart';
import '../widgets/cards/project.dart';
import '../widgets/request_placeholder.dart';
import '../widgets/snack_bars.dart';
import 'episodes.dart';
import 'planning.dart';
import 'sequences.dart';
import 'shots.dart';

class Projects extends ConsumerStatefulWidget {
  const Projects({required Key key}) : super(key: key);

  @override
  ConsumerState<Projects> createState() => ProjectsState();
}

class ProjectsState extends ConsumerState<Projects> {
  @override
  Widget build(BuildContext context) {
    switch (ref.watch(homePageNavigationProvider)) {
      case HomePage.projects:
        return Expanded(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: add,
              child: const Icon(Icons.add),
            ),
            body: ref.watch(projectsProvider).when(data: (List<Project> projects) {
              return ListView(
                  padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64),
                  children: <ProjectCard>[
                    ...projects.map((Project project) {
                      return ProjectCard(project: project);
                    })
                  ]);
            }, error: (Object error, StackTrace stackTrace) {
              return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
            }, loading: () {
              return const RequestPlaceholder(placeholder: CircularProgressIndicator());
            }),
          ),
        );
      case HomePage.episodes:
        return Episodes(key: episodesStateKey);
      case HomePage.sequences:
        return const Sequences();
      case HomePage.shots:
        return const Shots();
      case HomePage.planning:
        return const Planning();
    }
  }

  /*
  void getFavorites(ModelFav favNotifier) {
    final List<String> favorites = favNotifier.favoriteProjects;
    for (final String id in favorites) {
      for (final Project project in projects) {
        if (id == project.id) {
          project.favorite = true;
        }
      }
    }
    projects.sort();
  }
  */

  Future<void> add() async {
    final dynamic project = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return const NewProjectDialog();
        });
    if (project is Project) {
      final Map<String, dynamic> result = await ref.read(projectsProvider.notifier).add(project);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.project.added'.tr() : 'snack_bars.project.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }
}
