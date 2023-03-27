import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/invalid_direction.dart';
import '../models/location.dart';
import '../providers/locations.dart';
import '../utils/constants_globals.dart';
import '../widgets/dialogs/confirm.dart';
import '../widgets/dialogs/new_edit_location.dart';
import '../widgets/snack_bars.dart';
import '../widgets/tiles/location.dart';

class Locations extends ConsumerStatefulWidget {
  const Locations({super.key});

  @override
  ConsumerState<Locations> createState() => _LocationsState();
}

class _LocationsState extends ConsumerState<Locations> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: add,
          child: const Icon(Icons.add),
        ),
        body: ref.watch(locationsProvider).when(data: (List<Location> locations) {
          return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: Dismissible(
                    key: UniqueKey(),
                    onDismissed: (DismissDirection direction) {
                      switch (direction) {
                        case DismissDirection.startToEnd:
                          delete(locations[index]);
                          break;
                        case DismissDirection.endToStart:
                        case DismissDirection.vertical:
                        case DismissDirection.horizontal:
                        case DismissDirection.up:
                        case DismissDirection.down:
                        case DismissDirection.none:
                          throw InvalidDirectionException('error.direction'.tr());
                      }
                    },
                    confirmDismiss: (DismissDirection dismissDirection) async {
                      switch (dismissDirection) {
                        case DismissDirection.endToStart:
                          edit(locations[index]);
                          return false;
                        case DismissDirection.startToEnd:
                          return await showConfirmationDialog(context, 'delete.lower'.tr()) ?? false;
                        case DismissDirection.horizontal:
                        case DismissDirection.vertical:
                        case DismissDirection.up:
                        case DismissDirection.down:
                        case DismissDirection.none:
                          assert(false);
                      }
                      return false;
                    },
                    background: deleteBackground(),
                    secondaryBackground: editBackground(),
                    child: LocationTile(
                      location: locations[index],
                      onEdit: (Location location) {
                        edit(location);
                      },
                      onDelete: (Location location) {
                        showConfirmationDialog(context, 'delete.lower'.tr()).then((bool? result) {
                          if (result ?? false) {
                            delete(location);
                          }
                        });
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return divider;
              },
              itemCount: locations.length);
        }, error: (Object error, StackTrace stackTrace) {
          return requestPlaceholderError;
        }, loading: () {
          return requestPlaceholderLoading;
        }),
      ),
    );
  }

  Future<void> add() async {
    final dynamic location = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return ProviderScope(parent: ProviderScope.containerOf(context), child: const LocationDialog(edit: false));
        });
    if (location is Location) {
      final Map<String, dynamic> result = await ref.read(locationsProvider.notifier).add(location);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.location.added'.tr() : 'snack_bars.location.not_added'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }

  Future<void> edit(Location location) async {
    final dynamic editedLocation = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return LocationDialog(
            edit: true,
            id: location.id,
            name: location.name,
            position: location.position,
          );
        });
    if (editedLocation is Location) {
      final Map<String, dynamic> result = await ref.read(locationsProvider.notifier).edit(editedLocation);
      if (context.mounted) {
        final bool succeeded = result['succeeded'] as bool;
        final int code = result['code'] as int;
        final String message = succeeded ? 'snack_bars.location.edited'.tr() : 'snack_bars.location.not_edited'.tr();
        ScaffoldMessenger.of(context)
            .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
      }
    }
  }

  Future<void> delete(Location location) async {
    final Map<String, dynamic> result = await ref.read(locationsProvider.notifier).delete(location.id);
    if (context.mounted) {
      final bool succeeded = result['succeeded'] as bool;
      final int code = result['code'] as int;
      final String message = succeeded ? 'snack_bars.location.deleted'.tr() : 'snack_bars.location.not_deleted'.tr();
      ScaffoldMessenger.of(context)
          .showSnackBar(CustomSnackBar().getModelSnackBar(context, succeeded, code, message: message));
    }
  }
}
