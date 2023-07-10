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
          id: $checkedConvert('id', (v) => v as int),
          projectType: $checkedConvert(
              'project_type', (v) => $enumDecode(_$ProjectTypeEnumMap, v)),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          startDate: $checkedConvert('start_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
          endDate: $checkedConvert('end_date',
              (v) => v == null ? null : DateTime.parse(v as String)),
          shotsTotal: $checkedConvert('shots_total', (v) => v as int?),
          shotsCompleted: $checkedConvert('shots_completed', (v) => v as int?),
          director: $checkedConvert('director', (v) => v as String?),
          writer: $checkedConvert('writer', (v) => v as String?),
          links: $checkedConvert(
              'links',
              (v) =>
                  (v as List<dynamic>?)
                      ?.map((e) => Link.fromJson(e as Map<String, dynamic>))
                      .toList() ??
                  const []),
        );
        return val;
      },
      fieldKeyMap: const {
        'projectType': 'project_type',
        'startDate': 'start_date',
        'endDate': 'end_date',
        'shotsTotal': 'shots_total',
        'shotsCompleted': 'shots_completed'
      },
    );

Map<String, dynamic> _$ProjectToJson(Project instance) => <String, dynamic>{
      'project_type': _$ProjectTypeEnumMap[instance.projectType]!,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'shots_total': instance.shotsTotal,
      'shots_completed': instance.shotsCompleted,
      'director': instance.director,
      'writer': instance.writer,
      'links': instance.links,
    };

const _$ProjectTypeEnumMap = {
  ProjectType.unknown: 'Unknown',
  ProjectType.movie: 'Movie',
  ProjectType.series: 'Series',
};
