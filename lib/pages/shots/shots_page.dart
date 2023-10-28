import 'package:cpm/common/dialogs/confirm_dialog.dart';
import 'package:cpm/common/grid_view.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/projects/project_actions.dart';
import 'package:cpm/common/widgets/projects/project_header.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/sequence/sequence.dart';
import 'package:cpm/models/shot/shot.dart';
import 'package:cpm/pages/shots/shot_card.dart';
import 'package:cpm/providers/projects/projects.dart';
import 'package:cpm/providers/sequences/sequences.dart';
import 'package:cpm/providers/shots/shots.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/extensions/list_extensions.dart';
import 'package:cpm/utils/platform_manager.dart';
import 'package:cpm/utils/routes/router_route.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ShotsPage extends ConsumerStatefulWidget {
  const ShotsPage({super.key});

  @override
  ConsumerState<ShotsPage> createState() => _ShotsState();
}

class _ShotsState extends ConsumerState<ShotsPage> {
  Future<void> _delete(Sequence? sequence) async {
    if (sequence != null) {
      showConfirmationDialog(context, sequence.getTitle).then((bool? result) async {
        if (result ?? false) {
          final deleted = await ref.read(projectsProvider.notifier).delete(sequence.id);
          SnackBarManager().show(
            deleted
                ? getInfoSnackBar(
                    localizations.snack_bar_delete_success_item(localizations.item_project, Gender.male.name),
                  )
                : getErrorSnackBar(
                    localizations.snack_bar_delete_fail_item(localizations.item_project, Gender.male.name),
                  ),
          );
          if (context.mounted) {
            context.pushNamed(RouterRoute.projects.name);
          }
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => add<Shot>(
          context,
          ref,
          parentId: ref.read(currentSequenceProvider).value!.id,
          index: ref.read(shotsProvider).value!.getNextIndex<Sequence>(),
        ),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(shotsProvider).when(
        data: (List<Shot> shots) {
          final sequence = ref.watch(currentSequenceProvider).unwrapPrevious().valueOrNull;

          final header = ProjectHeader.sequence(
            delete: () => _delete(sequence),
            title: sequence?.title,
            description: sequence?.description,
            startDate: sequence?.startDate,
            endDate: sequence?.endDate,
          );

          final body = LayoutBuilder(
            builder: (context, constraints) {
              return AlignedGridView.count(
                crossAxisCount: getColumnsCount(constraints),
                itemCount: shots.length,
                itemBuilder: (context, index) {
                  return ShotCard(shots[index]);
                },
                padding: Paddings.withFab(Paddings.padding8.all),
              );
            },
          );

          return PlatformManager().isMobile
              ? NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverToBoxAdapter(
                        child: header,
                      ),
                    ];
                  },
                  body: body,
                )
              : Column(
                  children: [
                    header,
                    Expanded(child: body),
                  ],
                );
        },
        error: (Object error, StackTrace stackTrace) {
          return requestPlaceholderError;
        },
        loading: () {
          return requestPlaceholderLoading;
        },
      ),
    );
  }
}
