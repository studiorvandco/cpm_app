import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../globals.dart';
import '../models/shot.dart';
import 'api.dart';

class ShotService {
  final API api = API();

  Future<List<dynamic>> getShots(String projectId, String episodeID, String sequenceID) async {
    try {
      final Response response = await get(Uri.parse('${api.shots}/$projectId/$episodeID/$sequenceID'),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      if (response.body.isNotEmpty && response.statusCode == 200) {
        final List<dynamic> shotsJson = json.decode(response.body) as List<dynamic>;
        final List<Shot> sequences = shotsJson.map((shot) => Shot.fromJson(shot)).toList();
        return <dynamic>[true, sequences, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, <Shot>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, <Shot>[], 408, 'error.timeout'.tr()];
    }
  }
}
