import 'package:cpm/models/project/link.dart';
import 'package:cpm/widgets/details_panes/links/LinkEditor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/project/project.dart';
import '../../../providers/projects.dart';
import '../../../utils/constants_globals.dart';

class LinksTab extends ConsumerStatefulWidget {
  const LinksTab({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LinksEditorState();
}

class _LinksEditorState extends ConsumerState<LinksTab> {
  void _edit(Project project) {
    ref.read(projectsProvider.notifier).edit(project);
    ref.read(currentProjectProvider.notifier).set(project);
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        return Padding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 8, top: 8, left: 8, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              if (project.links != null)
                ListView.separated(
                  shrinkWrap: true,
                  itemCount: project.links!.length,
                  itemBuilder: (BuildContext context, int index) {
                    var link = project.links![index];

                    return LinkEditor(
                      link: link,
                      edit: (newLink) {
                        project.links?[index] = newLink;
                        _edit(project);
                      },
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Padding(
                      padding: EdgeInsets.symmetric(vertical: 4),
                    );
                  },
                ),
              IconButton.filledTonal(
                onPressed: () {
                  project.links?.add(const Link.empty());
                  _edit(project);
                },
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        );
      },
      error: (Object error, StackTrace stackTrace) {
        return requestPlaceholderError;
      },
      loading: () {
        return requestPlaceholderLoading;
      },
    );
  }
}
