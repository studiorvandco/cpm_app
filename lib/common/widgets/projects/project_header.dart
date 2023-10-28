import 'package:cpm/common/menus/menu_action.dart';
import 'package:cpm/models/episode/episode.dart';
import 'package:cpm/models/project/link.dart';
import 'package:cpm/models/project/project.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/pages/episodes/episode_info_sheet.dart';
import 'package:cpm/pages/projects/project_info_sheet.dart';
import 'package:cpm/pages/sequences/sequence_info_sheet.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/constants/radiuses.dart';
import 'package:cpm/utils/extensions/date_time_extensions.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectHeader extends StatelessWidget {
  const ProjectHeader.project({
    super.key,
    required this.delete,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
    this.director,
    this.writer,
    this.links,
  }) : type = Project;

  const ProjectHeader.episode({
    super.key,
    required this.delete,
    this.title,
    this.description,
  })  : type = Episode,
        startDate = null,
        endDate = null,
        director = null,
        writer = null,
        links = null;

  const ProjectHeader.sequence({
    super.key,
    required this.delete,
    this.title,
    this.description,
    this.startDate,
    this.endDate,
  })  : type = Sequence,
        director = null,
        writer = null,
        links = null;

  final Function() delete;

  final Type type;
  final String? title;
  final String? description;
  final DateTime? startDate;
  final DateTime? endDate;
  final String? director;
  final String? writer;
  final List<Link>? links;

  void _onMenuSelected(BuildContext context, MenuAction action) {
    switch (action) {
      case MenuAction.edit:
        _showSheet(context);
      case MenuAction.delete:
        delete();
    }
  }

  void _showSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      showDragHandle: true,
      builder: (BuildContext context) {
        switch (type) {
          case const (Project):
            return const ProjectInfoSheet();
          case const (Episode):
            return const EpisodeInfoSheet();
          case const (Sequence):
            return const SequenceInfoSheet();
          default:
            throw Exception();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    final noTitle = title == null || title!.isEmpty;
    final noDescription = description == null || description!.isEmpty;
    final noDates = startDate == null || endDate == null;
    final noDirector = director == null || director!.isEmpty;
    final noWriter = writer == null || writer!.isEmpty;
    final noLinks = links == null || links!.isEmpty;

    return Card(
      margin: Paddings.custom.zero,
      shape: RoundedRectangleBorder(borderRadius: Radiuses.radius0.circular),
      child: InkWell(
        onTap: () => _showSheet(context),
        child: Padding(
          padding: Paddings.padding8.all,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noTitle ? localizations.projects_no_title : title!,
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontStyle: noTitle ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  PopupMenuButton(
                    icon: Icon(
                      Icons.more_horiz,
                      color: Theme.of(context).colorScheme.onBackground,
                    ),
                    itemBuilder: (BuildContext context) {
                      return MenuAction.values.map((action) {
                        return PopupMenuItem<MenuAction>(
                          value: action,
                          child: ListTile(
                            leading: Icon(action.icon),
                            title: Text(action.title),
                            contentPadding: Paddings.custom.zero,
                          ),
                        );
                      }).toList();
                    },
                    onSelected: (action) => _onMenuSelected(context, action),
                  ),
                ],
              ),
              Padding(padding: Paddings.padding4.vertical),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      noDescription ? localizations.projects_no_description : description!,
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontStyle: noDescription ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(padding: Paddings.padding8.vertical),
              Row(
                children: [
                  const Icon(Icons.calendar_month_outlined),
                  Padding(padding: Paddings.padding4.horizontal),
                  Expanded(
                    child: Text(
                      noDates ? localizations.projects_no_dates : '${startDate?.yMd} - ${endDate?.yMd}',
                      style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            fontStyle: noDates ? FontStyle.italic : null,
                          ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              Padding(padding: Paddings.padding4.vertical),
              if (type == Project) ...[
                Row(
                  children: [
                    const Icon(Icons.movie_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: Text(
                        noDirector ? localizations.projects_no_director : director!,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontStyle: noDirector ? FontStyle.italic : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(padding: Paddings.padding4.vertical),
              ],
              if (type == Project) ...[
                Row(
                  children: [
                    const Icon(Icons.description_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: Text(
                        noWriter ? localizations.projects_no_writer : writer!,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontStyle: noWriter ? FontStyle.italic : null,
                            ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
                Padding(padding: Paddings.padding4.vertical),
              ],
              if (type == Project)
                Row(
                  children: [
                    const Icon(Icons.link_outlined),
                    Padding(padding: Paddings.padding4.horizontal),
                    Expanded(
                      child: noLinks
                          ? Text(
                              localizations.projects_no_links,
                              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                                    fontStyle: FontStyle.italic,
                                  ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            )
                          : SizedBox(
                              height: 42,
                              child: Scrollbar(
                                controller: scrollController,
                                thickness: !PlatformManager().isMobile ? 4 : 0,
                                child: ListView.builder(
                                  controller: scrollController,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: links?.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final link = links![index];

                                    return TextButton(
                                      onPressed: link.getUrl.isNotEmpty && Uri.tryParse(link.getUrl)!.isAbsolute
                                          ? () {
                                              launchUrlString(link.getUrl, mode: LaunchMode.externalApplication);
                                            }
                                          : null,
                                      child: Text(link.getLabel),
                                    );
                                  },
                                ),
                              ),
                            ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
