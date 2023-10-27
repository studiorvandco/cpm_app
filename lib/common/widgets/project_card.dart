import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:flutter/material.dart';

class ProjectCard extends StatelessWidget {
  const ProjectCard.project({
    super.key,
    required this.open,
    required this.title,
    required this.description,
    required this.progress,
    this.progressText,
    required this.trailing,
  })  : type = Project,
        leading = null;

  const ProjectCard.episode({
    super.key,
    required this.open,
    required this.leading,
    required this.title,
    required this.description,
    required this.progress,
    this.progressText,
  })  : type = Episode,
        trailing = null;

  const ProjectCard.sequence({
    super.key,
    required this.open,
    required this.leading,
    required this.title,
    required this.description,
    required this.progress,
    this.progressText,
  })  : type = Sequence,
        trailing = null;

  final Function() open;

  final Type type;
  final String? leading;
  final String? title;
  final String? description;
  final double progress;
  final String? progressText;
  final List<Widget>? trailing;

  @override
  Widget build(BuildContext context) {
    final noTitle = title == null || title!.isEmpty;
    final noDescription = description == null || description!.isEmpty;

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: open,
        child: Padding(
          padding: Paddings.padding8.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noTitle ? 'Untitled' : title!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontStyle: noTitle ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  ...?trailing,
                ],
              ),
              Padding(padding: Paddings.padding4.vertical),
              Text(
                noDescription ? 'No description' : description!,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: noDescription ? const TextStyle(fontStyle: FontStyle.italic) : null,
              ),
              Padding(padding: Paddings.padding8.vertical),
              Row(
                children: [
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                    ),
                  ),
                  if (progressText != null) ...[
                    Padding(padding: Paddings.padding4.horizontal),
                    Text(
                      progressText!,
                      style: Theme.of(context).textTheme.labelSmall,
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
