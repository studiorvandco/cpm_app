import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../models/project.dart';
import '../../providers/episodes.dart';
import '../../providers/navigation.dart';
import '../../providers/projects.dart';
import '../../utils.dart';

class ProjectCard extends ConsumerStatefulWidget {
  const ProjectCard({super.key, required this.project});

  final Project project;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ProjectCardState();
}

class _ProjectCardState extends ConsumerState<ProjectCard> {
  @override
  Widget build(BuildContext context) {
    Icon favIcon = widget.project.favorite
        ? Icon(Icons.star, color: Theme.of(context).colorScheme.primary)
        : const Icon(Icons.star_border);
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.zero, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
          onPressed: () => openProject(widget.project),
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
              Row(children: <Widget>[
                SizedBox(
                  height: 80,
                  width: 80,
                  child: Image.asset('assets/images/en-sursis.png'),
                ),
                const Padding(padding: EdgeInsets.only(right: 16)),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        widget.project.title,
                        style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Padding(padding: EdgeInsets.only(bottom: 4)),
                      Text(
                        widget.project.description,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const Padding(padding: EdgeInsets.only(right: 16)),
                IconButton(
                    onPressed: () {
                      toggleFavorite();
                      setState(() {
                        favIcon = const Icon(Icons.star);
                      });
                    },
                    icon: favIcon),
                IconButton(onPressed: () => openPlanning(widget.project), icon: const Icon(Icons.event))
              ]),
              const SizedBox(height: 8),
              LinearProgressIndicator(value: widget.project.getProgress()),
            ]),
          )),
    );
  }

  void toggleFavorite() {
    /*
    if (widget.project.favorite) {
      final List<String> favorites = widget.favNotifier.favoriteProjects;
      favorites.remove(widget.project.id);
      widget.favNotifier.favoriteProjects = favorites;
    } else {
      final List<String> favorites = widget.favNotifier.favoriteProjects;
      favorites.add(widget.project.id);
      widget.favNotifier.favoriteProjects = favorites;
    }
    widget.project.favorite = !widget.project.favorite;
    */
  }

  void openProject(Project project) {
    ref.read(currentProjectProvider.notifier).set(project);
    if (project.isMovie() && project.episodes != null && project.episodes!.length > 1) {
      ref.read(currentEpisodeProvider.notifier).set(project.episodes![0]);
    }
    ref.read(homePageNavigationProvider.notifier).set(project.isMovie() ? HomePage.sequences : HomePage.episodes);
  }

  void openPlanning(Project project) {
    ref.read(currentProjectProvider.notifier).set(project);
    ref.read(homePageNavigationProvider.notifier).set(HomePage.planning);
  }
}
