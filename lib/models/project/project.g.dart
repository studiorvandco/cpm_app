// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => Project(
      id: json['id'] as int,
      projectType: $enumDecode(_$ProjectTypeEnumMap, json['projectType']),
      title: json['title'] as String?,
      description: json['description'] as String?,
      startDate: json['startDate'] == null ? null : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null ? null : DateTime.parse(json['endDate'] as String),
      director: json['director'] as String?,
      writer: json['writer'] as String?,
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'projectType': _$ProjectTypeEnumMap[instance.projectType]!,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'director': instance.director,
      'writer': instance.writer,
    };

const _$ProjectTypeEnumMap = {
  ProjectType.unknown: 'Unknown',
  ProjectType.movie: 'Movie',
  ProjectType.series: 'Series',
};
