import 'dart:ui';

import 'package:cpm/utils/platform_identifier.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../models/project/project.dart';
import '../../providers/navigation.dart';
import '../../providers/projects.dart';
import '../../utils/constants_globals.dart';
import '../custom_snack_bars.dart';
import '../dialogs/confirm_dialog.dart';
import '../icon_label.dart';
import '../info_sheets/project_info_sheet.dart';

class ProjectInfoHeader extends ConsumerStatefulWidget {
  const ProjectInfoHeader({super.key});

  @override
  ConsumerState<ProjectInfoHeader> createState() => _InfoHeaderProjectState();
}

class _InfoHeaderProjectState extends ConsumerState<ProjectInfoHeader> {
  String _getDateText(BuildContext context, Project project) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(project.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(project.endDate);

    return '$firstText - $lastText';
  }

  @override
  Widget build(BuildContext context) {
    final ScrollController scrollController = ScrollController();

    return ref.watch(currentProjectProvider).when(
      data: (Project project) {
        return FilledButton(
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background,
          ),
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: ClipRect(
                  child: ShaderMask(
                    shaderCallback: (Rect rect) {
                      return LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: <Color>[
                          Colors.transparent,
                          Colors.black.withOpacity(0.2),
                          Colors.black.withOpacity(0.2),
                          Colors.transparent,
                        ],
                      ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                    },
                    blendMode: BlendMode.dstIn,
                    child: ImageFiltered(
                      imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                      child: const FittedBox(fit: BoxFit.cover, child: null),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(
                        child: Text(
                          project.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () => delete(project),
                        icon: const Icon(Icons.delete),
                        color: Colors.red,
                      ),
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        project.description,
                        style: Theme.of(context).textTheme.bodyMedium,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 16)),
                    IconLabel(
                      text: _getDateText(context, project),
                      icon: Icons.event,
                      iconColor: Theme.of(context).iconTheme.color,
                      textStyle: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Row(children: <Widget>[
                      if (project.director != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.movie)),
                      ],
                      if (project.writer != null) ...<Widget>[
                        const Padding(padding: EdgeInsets.only(bottom: 8)),
                        const Flexible(child: Icon(Icons.description)),
                      ],
                    ]),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    Row(
                      children: [
                        const Icon(Icons.link),
                        const Padding(padding: EdgeInsets.symmetric(horizontal: 2)),
                        Expanded(
                          child: SizedBox(
                            height: 42,
                            child: project.links != null
                                ? Scrollbar(
                                    controller: scrollController,
                                    thickness: PlatformIdentifier().isDesktop() ? 4 : 0,
                                    child: ListView.builder(
                                      controller: scrollController,
                                      scrollDirection: Axis.horizontal,
                                      itemCount: project.links!.length,
                                      itemBuilder: (BuildContext context, int index) {
                                        var link = project.links![index];

                                        return TextButton(
                                          onPressed: link.url.isNotEmpty && Uri.tryParse(link.url)!.isAbsolute
                                              ? () {
                                                  launchUrlString(link.url, mode: LaunchMode.externalApplication);
                                                }
                                              : null,
                                          child: Text(link.label),
                                        );
                                      },
                                    ),
                                  )
                                : null,
                          ),
                        ),
                      ],
                    ),
                    const Padding(padding: EdgeInsets.only(bottom: 8)),
                    LinearProgressIndicator(
                      value: project.progress,
                      backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                    ),
                  ],
                ),
              ),
            ],
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              showDragHandle: true,
              builder: (BuildContext context) {
                return const ProjectInfoSheet();
              },
            );
          },
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

  Future<void> delete(Project project) async {
    showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) async {
      if (result ?? false) {
        final Map<String, dynamic> result = await ref.read(projectsProvider.notifier).delete(project.id);
        if (context.mounted) {
          final bool succeeded = result['succeeded'] as bool;
          final int code = result['code'] as int;
          final String message = succeeded ? 'snack_bars.project.deleted'.tr() : 'snack_bars.project.not_deleted'.tr();
          ScaffoldMessenger.of(context)
              .showSnackBar(CustomSnackBars().getModelSnackBar(context, succeeded, code, message: message));
        }
        ref.read(navigationProvider.notifier).set(HomePage.projects);
      }
    });
  }
}
