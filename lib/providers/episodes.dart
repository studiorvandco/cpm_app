import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/episode.dart';
import '../services/episode.dart';

part 'episodes.g.dart';

@riverpod
class Episodes extends _$Episodes {
  @override
  FutureOr<void> build() {}

  Future<Map<String, dynamic>> add(String projectID, Episode episode) async {
    final List<dynamic> result = await EpisodeService().addEpisode(projectID, episode);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }

  Future<Map<String, dynamic>> edit(Episodes project) async {
    /*
    final List<dynamic> result = await EpisodeService().editEpisode(project);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
    */
    return {};
  }

  Future<Map<String, dynamic>> delete(String projectID, String episodeID) async {
    final List<dynamic> result = await EpisodeService().deleteEpisode(projectID, episodeID);
    return <String, dynamic>{'succeeded': result[0] as bool, 'code': result[1] as int};
  }
}
