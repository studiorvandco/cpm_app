// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'project.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Project _$ProjectFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Project',
      json,
      ($checkedConvert) {
        final val = Project(
          id: $checkedConvert('id', (v) => v as String),
          projectType: $checkedConvert(
              'projectType', (v) => $enumDecode(_$ProjectTypeEnumMap, v)),
          title: $checkedConvert('title', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          startDate:
              $checkedConvert('startDate', (v) => DateTime.parse(v as String)),
          endDate:
              $checkedConvert('endDate', (v) => DateTime.parse(v as String)),
          shotsTotal: $checkedConvert('shotsTotal', (v) => v as int?),
          shotsCompleted: $checkedConvert('shotsCompleted', (v) => v as int?),
          director: $checkedConvert('director', (v) => v as String?),
          writer: $checkedConvert('writer', (v) => v as String?),
          links: $checkedConvert(
              'links',
              (v) => (v as Map<String, dynamic>?)?.map(
                    (k, e) => MapEntry(k, e as String),
                  )),
          episodes: $checkedConvert('episodes',
              (v) => (v as List<dynamic>?)?.map(Episode.fromJson).toList()),
        );
        return val;
      },
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'id': instance.id,
      'projectType': _$ProjectTypeEnumMap[instance.projectType]!,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'shotsTotal': instance.shotsTotal,
      'shotsCompleted': instance.shotsCompleted,
      'director': instance.director,
      'writer': instance.writer,
      'links': instance.links,
      'episodes': instance.episodes,
    };

const _$ProjectTypeEnumMap = {
  ProjectType.movie: 0,
  ProjectType.series: 1,
  ProjectType.placeholder: 2,
};
