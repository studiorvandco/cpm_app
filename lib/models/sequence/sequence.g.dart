// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Sequence _$SequenceFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Sequence',
      json,
      ($checkedConvert) {
        final val = Sequence(
          id: $checkedConvert('id', (v) => v as int?),
          index: $checkedConvert('index', (v) => v as String?),
          episode: $checkedConvert('episode', (v) => v as int?),
          title: $checkedConvert('title', (v) => v as String?),
          description: $checkedConvert('description', (v) => v as String?),
          startDate: $checkedConvert('start_date', (v) => v == null ? null : DateTime.parse(v as String)),
          endDate: $checkedConvert('end_date', (v) => v == null ? null : DateTime.parse(v as String)),
          location: $checkedConvert('location', (v) => v == null ? null : Location.fromJson(v as Map<String, dynamic>)),
          shotsTotal: $checkedConvert('shots_total', (v) => v as int?),
          shotsCompleted: $checkedConvert('shots_completed', (v) => v as int?),
        );
        return val;
      },
      fieldKeyMap: const {
        'startDate': 'start_date',
        'endDate': 'end_date',
        'shotsTotal': 'shots_total',
        'shotsCompleted': 'shots_completed'
      },
    );

Map<String, dynamic> _$SequenceToJson(Sequence instance) => <String, dynamic>{
      'episode': instance.episode,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate?.toIso8601String(),
      'end_date': instance.endDate?.toIso8601String(),
      'location': idToJson(instance.location),
    };
