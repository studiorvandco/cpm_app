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
          projectType: $checkedConvert('project_type', (v) => $enumDecode(_$ProjectTypeEnumMap, v)),
          title: $checkedConvert('title', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String),
          startDate: $checkedConvert('start_date', (v) => DateTime.parse(v as String)),
          endDate: $checkedConvert('end_date', (v) => DateTime.parse(v as String)),
          shotsTotal: $checkedConvert('shots_total', (v) => v as int?),
          shotsCompleted: $checkedConvert('shots_completed', (v) => v as int?),
          director: $checkedConvert('director', (v) => v as String?),
          writer: $checkedConvert('writer', (v) => v as String?),
          links: $checkedConvert('links', (v) => (v as List<dynamic>?)?.map(Link.fromJson).toList() ?? const []),
          episodes: $checkedConvert('episodes', (v) => (v as List<dynamic>?)?.map(Episode.fromJson).toList()),
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
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'shots_total': instance.shotsTotal,
      'shots_completed': instance.shotsCompleted,
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
