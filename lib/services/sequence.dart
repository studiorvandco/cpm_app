import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/sequence.dart';
import '../utils.dart';
import 'api.dart';

class SequenceService {
  final API api = API();

  Future<List<dynamic>> getAll(String projectId, String episodeID) async {
    try {
      final Response response = await get(Uri.parse('${api.sequences}/$projectId/$episodeID'),
          headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token});

      if (response.body.isNotEmpty && response.statusCode == 200) {
        final List<dynamic> sequencesJson = json.decode(response.body) as List<dynamic>;
        final List<Sequence> sequences = sequencesJson.map((sequence) => Sequence.fromJson(sequence)).toList();
        return <dynamic>[true, sequences, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('SequenceService getAll request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, <Sequence>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, <Sequence>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> add(String projectID, String episodeID, Sequence sequence) async {
    try {
      final Response response = await post(Uri.parse('${api.sequences}/$projectID/$episodeID'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(sequence));

      if (response.statusCode == 201) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('SequenceService add request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> edit(String projectID, String episodeID, Sequence sequence) async {
    try {
      final Response response = await put(Uri.parse('${api.sequences}/$projectID/$episodeID/${sequence.id}'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          },
          body: jsonEncode(sequence));

      if (response.statusCode == 204) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('SequenceService edit request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List<dynamic>> delete(String projectID, String episodeID, String sequenceID) async {
    try {
      final Response response = await http.delete(Uri.parse('${api.sequences}/$projectID/$episodeID/$sequenceID'),
          headers: <String, String>{
            'accept': '*/*',
            'Content-Type': 'application/json',
            api.authorization: api.bearer + token
          });

      if (response.statusCode == 204) {
        return <dynamic>[true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('SequenceService delete request error: ${response.statusCode} ${response.reasonPhrase}');
        return <dynamic>[false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());
      return <dynamic>[false, 408, 'error.timeout'.tr()];
    }
  }
}
