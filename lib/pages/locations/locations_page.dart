import 'package:cpm/common/actions/add_action.dart';
import 'package:cpm/common/actions/delete_action.dart';
import 'package:cpm/common/placeholders/request_placeholder.dart';
import 'package:cpm/common/widgets/info_tile.dart';
import 'package:cpm/l10n/gender.dart';
import 'package:cpm/models/location/location.dart';
import 'package:cpm/pages/locations/location_dialog.dart';
import 'package:cpm/providers/locations/locations.dart';
import 'package:cpm/utils/constants/constants.dart';
import 'package:cpm/utils/constants/paddings.dart';
import 'package:cpm/utils/snack_bar/custom_snack_bar.dart';
import 'package:cpm/utils/snack_bar/snack_bar_manager.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:maps_launcher/maps_launcher.dart';

class LocationsPage extends ConsumerStatefulWidget {
  const LocationsPage({super.key});

  @override
  ConsumerState<LocationsPage> createState() => _LocationsState();
}

class _LocationsState extends ConsumerState<LocationsPage> {
  Future<void> _edit(Location location) async {
    final editedLocation = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return LocationDialog(location: location);
      },
    );
    if (editedLocation is Location) {
      final edited = await ref.read(locationsProvider.notifier).edit(editedLocation);
      SnackBarManager().show(
        edited
            ? getInfoSnackBar(
                localizations.snack_bar_edit_success_item(localizations.item_location, Gender.male.name),
              )
            : getErrorSnackBar(
                localizations.snack_bar_edit_fail_item(localizations.item_location, Gender.male.name),
              ),
      );
    }
  }

  void _openMap(Location location) {
    MapsLauncher.launchQuery(location.position!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => AddAction<Location>().add(context, ref),
        child: const Icon(Icons.add),
      ),
      body: ref.watch(locationsProvider).when(
        data: (List<Location> locations) {
          return ListView.separated(
            itemBuilder: (BuildContext context, int index) {
              final location = locations[index];

              return InfoTile(
                edit: () => _edit(location),
                delete: () => DeleteAction<Location>().delete(context, ref, id: location.id),
                leadingIcon: Icons.image,
                title: location.getName,
                subtitle: location.position,
                trailing: [
                  IconButton(
                    icon: const Icon(Icons.map),
                    onPressed:
                        location.position != null && location.position!.isNotEmpty ? () => _openMap(location) : null,
                  ),
                ],
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return Padding(padding: Paddings.padding4.vertical);
            },
            itemCount: locations.length,
            padding: Paddings.custom.fab,
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
