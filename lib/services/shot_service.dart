import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/shot.dart';
import '../utils/constants_globals.dart';

class ShotService {
  Future<List> getAll(String projectId, String episodeID, String sequenceID) async {
    try {
      final Response response = await get(
        Uri.parse('${api.shots}/$projectId/$episodeID/$sequenceID'),
        headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token},
      );

      if (response.body.isNotEmpty && response.statusCode == 200) {
        final List shotsJson = json.decode(response.body) as List;
        final List<Shot> sequences = shotsJson.map((shot) => Shot.fromJson(shot)).toList();

        return [true, sequences, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ShotService getAll request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, <Shot>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, <Shot>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List> add(String projectID, String episodeID, String sequenceID, Shot shot) async {
    try {
      final Response response = await post(
        Uri.parse('${api.shots}/$projectID/$episodeID/$sequenceID'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(shot),
      );

      if (response.statusCode == 201) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ShotService add request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> edit(String projectID, String episodeID, String sequenceID, Shot shot) async {
    try {
      final Response response = await put(
        Uri.parse('${api.shots}/$projectID/$episodeID/$sequenceID/${shot.id}'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(shot),
      );

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ShotService edit request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> delete(String projectID, String episodeID, String sequenceID, String shotID) async {
    try {
      final Response response = await http.delete(
        Uri.parse('${api.shots}/$projectID/$episodeID/$sequenceID/$shotID'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
      );

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('ShotService delete request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }
}
