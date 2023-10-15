// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Episode _$EpisodeFromJson(Map<String, dynamic> json) => Episode(
      id: json['id'] as int,
      project: json['project'] as int,
      index: json['index'] as int,
      number: json['number'] as int,
      title: json['title'] as String?,
      description: json['description'] as String?,
      director: json['director'] as String?,
      writer: json['writer'] as String?,
    );

Map<String, dynamic> _$EpisodeToJson(Episode instance) => <String, dynamic>{
      'project': instance.project,
      'index': instance.index,
      'title': instance.title,
      'description': instance.description,
      'director': instance.director,
      'writer': instance.writer,
    };
