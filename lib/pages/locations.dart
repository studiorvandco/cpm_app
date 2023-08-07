import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../exceptions/invalid_direction.dart';
import '../models/location/location.dart';
import '../providers/locations/locations.dart';
import '../utils/constants_globals.dart';
import '../utils/snack_bar_manager/custom_snack_bar.dart';
import '../utils/snack_bar_manager/snack_bar_manager.dart';
import '../widgets/dialogs/confirm_dialog.dart';
import '../widgets/dialogs/location_dialog.dart';
import '../widgets/tiles/location_tile.dart';

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
          onPressed: () => add(),
          child: const Icon(Icons.add),
        ),
        body: ref.watch(locationsProvider).when(
          data: (List<Location> locations) {
            return ListView.separated(
              itemBuilder: (BuildContext context, int index) {
                return ClipRRect(
                  clipBehavior: Clip.hardEdge,
                  child: Dismissible(
                    key: UniqueKey(),
                    background: deleteBackground(),
                    secondaryBackground: editBackground(),
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
                          throw InvalidDirection('error.direction'.tr());
                      }
                    },
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
              itemCount: locations.length,
            );
          },
          error: (Object error, StackTrace stackTrace) {
            return requestPlaceholderError;
          },
          loading: () {
            return requestPlaceholderLoading;
          },
        ),
      ),
    );
  }

  Future<void> add() async {
    Location? location = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return const LocationDialog();
      },
    );

    if (location != null) {
      await ref.read(locationsProvider.notifier).add(location);
      if (context.mounted) {
        SnackBarManager().show(
          context,
          CustomSnackBar.getInfoSnackBar('snack_bars.location.added'.tr()),
        );
      }
    }
  }

  Future<void> edit(Location location) async {
    Location? editedLocation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocationDialog(location: location);
      },
    );
    if (editedLocation != null) {
      await ref.read(locationsProvider.notifier).edit(editedLocation);
      if (context.mounted) {
        SnackBarManager().show(
          context,
          CustomSnackBar.getInfoSnackBar('snack_bars.location.edited'.tr()),
        );
      }
    }
  }

  Future<void> delete(Location location) async {
    await ref.read(locationsProvider.notifier).delete(location.id);
    if (context.mounted) {
      SnackBarManager().show(
        context,
        CustomSnackBar.getInfoSnackBar('snack_bars.location.deleted'.tr()),
      );
    }
  }
}
