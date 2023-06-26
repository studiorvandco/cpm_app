import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/location/location.dart';
import '../services/location_service.dart';

part 'locations.g.dart';

@riverpod
class Locations extends _$Locations {
  @override
  FutureOr<List<Location>> build() {
    get();

    return <Location>[];
  }

  Future<Map<String, dynamic>> get() async {
    state = const AsyncLoading<List<Location>>();
    final List result = await LocationService().getLocations();
    state = AsyncData<List<Location>>(result[1] as List<Location>);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
  }

  Future<Map<String, dynamic>> add(Location location) async {
    final List result = await LocationService().addLocation(location);
    await get(); // Get the locations in order to get the new location's ID

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Location editedLocation) async {
    final List result = await LocationService().editLocation(editedLocation);
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != editedLocation.id) location else editedLocation,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String locationID) async {
    final List result = await LocationService().deleteLocation(locationID);
    state = AsyncData<List<Location>>(<Location>[
      for (final Location location in state.value ?? <Location>[])
        if (location.id != locationID) location,
    ]);

    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
