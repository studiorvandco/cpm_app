import 'dart:ui';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../dialogs/confirm_dialog.dart';
import '../../models/project.dart';
import '../../providers/navigation.dart';
import '../../providers/projects.dart';
import '../../utils/constants_globals.dart';
import '../icon_label.dart';
import '../info_sheets/project.dart';
import '../request_placeholder.dart';
import '../snack_bars.dart';

class InfoHeaderProject extends ConsumerStatefulWidget {
  const InfoHeaderProject({super.key});

  @override
  ConsumerState<InfoHeaderProject> createState() => _InfoHeaderProjectState();
}

class _InfoHeaderProjectState extends ConsumerState<InfoHeaderProject> {
  @override
  Widget build(BuildContext context) {
    return ref.watch(currentProjectProvider).when(data: (Project project) {
      return FilledButton(
        style: ElevatedButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const ContinuousRectangleBorder(),
            backgroundColor: Theme.of(context).colorScheme.background),
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
                      Colors.transparent
                    ],
                  ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(sigmaX: 3, sigmaY: 3),
                  child: const FittedBox(fit: BoxFit.cover, child: null),
                ),
              ),
            )),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
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
                      )
                    ],
                  ),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Text(project.description, maxLines: 2, overflow: TextOverflow.ellipsis)),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  IconLabel(text: _getDateText(context, project), icon: Icons.event),
                  Row(children: <Widget>[
                    if (project.director != null) ...<Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      const Flexible(child: Icon(Icons.movie_outlined))
                    ],
                    if (project.writer != null) ...<Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 8)),
                      const Flexible(child: Icon(Icons.description_outlined))
                    ]
                  ]),
                  const Padding(padding: EdgeInsets.only(bottom: 8)),
                  LinearProgressIndicator(
                    value: project.getProgress(),
                    backgroundColor: Theme.of(context).colorScheme.onPrimaryContainer,
                  )
                ],
              ),
            ),
            //_getCardContent(context),
          ],
        ),
        onPressed: () {
          showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (BuildContext context) {
                return const InfoSheetProject();
              });
        },
      );
    }, error: (Object error, StackTrace stackTrace) {
      return RequestPlaceholder(placeholder: Text('error.request_failed'.tr()));
    }, loading: () {
      return const RequestPlaceholder(placeholder: CircularProgressIndicator());
    });
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
              .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
        }
        ref.read(homePageNavigationProvider.notifier).set(HomePage.projects);
      }
    });
  }

  String _getDateText(BuildContext context, Project project) {
    final String firstText = DateFormat.yMd(context.locale.toString()).format(project.startDate);
    final String lastText = DateFormat.yMd(context.locale.toString()).format(project.endDate);
    return '$firstText - $lastText';
  }
}
