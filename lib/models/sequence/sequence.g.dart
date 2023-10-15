// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sequence _$SequenceFromJson(Map<String, dynamic> json) => Sequence(
      id: json['id'] as int,
      episode: json['episode'] as int,
      index: json['index'] as int,
      number: json['number'] as int? ?? -1,
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
    );

Map<String, dynamic> _$SequenceToJson(Sequence instance) => <String, dynamic>{
      'episode': instance.episode,
      'index': instance.index,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
    };
