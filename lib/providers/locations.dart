import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/location.dart';
import '../services/location.dart';

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
    final List<dynamic> result = await LocationService().getLocations();
    state = AsyncValue<List<Location>>.data(result[1] as List<Location>);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[2] as int};
  }

  Future<Map<String, dynamic>> add(Location location) async {
    final List<dynamic> result = await LocationService().addLocation(location);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Location location) async {
    final List<dynamic> result = await LocationService().editLocation(location);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> delete(String id) async {
    final List<dynamic> result = await LocationService().deleteLocation(id);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
