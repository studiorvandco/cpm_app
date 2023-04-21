import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

import '../models/episode.dart';
import '../utils/constants_globals.dart';

class EpisodeService {
  Future<List> getAll(String projectId) async {
    try {
      final Response response = await get(
        Uri.parse('${api.episodes}/$projectId'),
        headers: <String, String>{'accept': 'application/json', api.authorization: api.bearer + token},
      );

      if (response.body.isNotEmpty && response.statusCode == 200) {
        final List episodesJson = json.decode(response.body) as List;
        final List<Episode> episodes = episodesJson.map((episode) => Episode.fromJson(episode)).toList();

        return [true, episodes, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('EpisodeService getAll request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, <Episode>[], response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, <Episode>[], 408, 'error.timeout'.tr()];
    }
  }

  Future<List> add(String projectID, Episode episode) async {
    try {
      final Response response = await post(Uri.parse('${api.episodes}/$projectID'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(episode),);

      if (response.statusCode == 201) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('EpisodeService add request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> edit(String projectID, Episode episode) async {
    try {
      final Response response = await put(Uri.parse('${api.episodes}/$projectID/${episode.id}'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },
        body: jsonEncode(episode),);

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('EpisodeService edit request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }

  Future<List> delete(String projectID, String episodeID) async {
    try {
      final Response response = await http.delete(Uri.parse('${api.episodes}/$projectID/$episodeID'),
        headers: <String, String>{
          'accept': '*/*',
          'Content-Type': 'application/json',
          api.authorization: api.bearer + token,
        },);

      if (response.statusCode == 204) {
        return [true, response.statusCode, response.reasonPhrase];
      } else {
        debugPrint('EpisodeService delete request error: ${response.statusCode} ${response.reasonPhrase}');

        return [false, response.statusCode, response.reasonPhrase];
      }
    } catch (exception, stackTrace) {
      debugPrint(stackTrace.toString());

      return [false, 408, 'error.timeout'.tr()];
    }
  }
}
