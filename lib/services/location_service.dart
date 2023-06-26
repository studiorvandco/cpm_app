import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/location/location.dart';
import '../utils/constants_globals.dart';

class LocationService {
  Future<List> getLocations() async {
    try {
      final Response response = await get(
        Uri.parse(api.locations),
        headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token},
      );

      if (response.statusCode == 200) {
        final List membersJson = json.decode(response.body) as List;
        final List<Location> locations = membersJson.map((location) => Location.fromJson(location)).toList();

        return [true, locations, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());

        return [false, <Location>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, <Location>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List> addLocation(Location location) async {
    try {
      final Response response = await post(
        Uri.parse(api.locations),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(location),
      );

      if (response.statusCode == 201) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> editLocation(Location location) async {
    try {
      final Response response = await put(
        Uri.parse('${api.locations}/${location.id}'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(location),
      );

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> deleteLocation(String id) async {
    try {
      final Response response = await delete(Uri.parse('${api.locations}/$id'), headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
        api.authorization: api.bearer + token,
      });

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.body);

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }
}
