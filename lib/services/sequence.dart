import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/sequence.dart';
import '../utils.dart';
import 'api.dart';

class SequenceService {
  final API api = API();

  Future<List<dynamic>> getSequences(String projectId, String episodeID) async {
    try {
      final Response response = await get(Uri.parse('${api.sequences}/$projectId/$episodeID'),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      if (response.body.isNotEmpty && response.statusCode == 200) {
        final List<dynamic> sequencesJson = json.decode(response.body) as List<dynamic>;
        final List<Sequence> sequences = sequencesJson.map((sequence) => Sequence.fromJson(sequence)).toList();
        return <dynamic>[true, sequences, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint(response.toString());
        return <dynamic>[false, <Sequence>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, <Sequence>[], 408, 'error.timeout'.tr()];
    }
  }
}
