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
          id: $checkedConvert('id', (v) => v as String),
          number: $checkedConvert('number', (v) => v as int),
          title: $checkedConvert('title', (v) => v as String),
          description: $checkedConvert('description', (v) => v as String?),
          startDate:
              $checkedConvert('start_date', (v) => DateTime.parse(v as String)),
          endDate:
              $checkedConvert('end_date', (v) => DateTime.parse(v as String)),
          location: $checkedConvert(
              'location', (v) => v == null ? null : Location.fromJson(v)),
          shots: $checkedConvert('shots',
              (v) => (v as List<dynamic>?)?.map(Shot.fromJson).toList()),
        );
        return val;
      },
      fieldKeyMap: const {'startDate': 'start_date', 'endDate': 'end_date'},
    );

Map<String, dynamic> _$SequenceToJson(Sequence instance) => <String, dynamic>{
      'number': instance.number,
      'title': instance.title,
      'description': instance.description,
      'start_date': instance.startDate.toIso8601String(),
      'end_date': instance.endDate.toIso8601String(),
      'location': instance.location,
      'shots': instance.shots,
    };
