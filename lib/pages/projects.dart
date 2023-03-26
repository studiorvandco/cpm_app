import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../dialogs/new_project.dart';
import '../models/project.dart';
import '../providers/navigation.dart';
import '../providers/projects.dart';
import '../utils/constants_globals.dart';
import '../widgets/cards/project.dart';
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
            body: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                return ref.watch(projectsProvider).when(data: (List<Project> projects) {
                  return MasonryGridView.count(
                    itemCount: projects.length,
                    padding: const EdgeInsets.only(bottom: kFloatingActionButtonMargin + 64, top: 4, left: 4, right: 4),
                    itemBuilder: (BuildContext context, int index) {
                      return ProjectCard(project: projects[index]);
                    },
                    crossAxisCount: getColumnsCount(constraints),
                    mainAxisSpacing: 2,
                    crossAxisSpacing: 2,
                  );
                }, error: (Object error, StackTrace stackTrace) {
                  return requestPlaceholderError;
                }, loading: () {
                  return requestPlaceholderLoading;
                });
              },
            ),
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
