// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sequence_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SequenceLocation _$SequenceLocationFromJson(Map<String, dynamic> json) => SequenceLocation(
      id: json['id'] as int,
      sequence: json['sequence'] as int,
      location: json['location'] as int,
    );

Map<String, dynamic> _$SequenceLocationToJson(SequenceLocation instance) => <String, dynamic>{
      'sequence': instance.sequence,
      'location': instance.location,
    };
