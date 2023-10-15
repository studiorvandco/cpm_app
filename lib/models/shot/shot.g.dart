// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'shot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Shot _$ShotFromJson(Map<String, dynamic> json) => Shot(
      id: json['id'] as int,
      sequence: json['sequence'] as int,
      index: json['index'] as int,
      number: json['number'] as int,
      value: $enumDecodeNullable(_$ShotValueEnumMap, json['value']),
      description: json['description'] as String?,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$ShotToJson(Shot instance) => <String, dynamic>{
      'sequence': instance.sequence,
      'index': instance.index,
      'value': _$ShotValueEnumMap[instance.value],
      'description': instance.description,
      'completed': instance.completed,
    };

const _$ShotValueEnumMap = {
  ShotValue.full: 'full',
  ShotValue.mediumFull: 'medium_full',
  ShotValue.cowboy: 'cowboy',
  ShotValue.medium: 'medium',
  ShotValue.mediumCloseup: 'medium_closeup',
  ShotValue.closeup: 'closeup',
  ShotValue.extremeCloseup: 'extreme_closeup',
  ShotValue.insert: 'insert',
  ShotValue.sequence: 'sequence',
  ShotValue.landscape: 'landscape',
  ShotValue.drone: 'drone',
  ShotValue.other: 'other',
};
