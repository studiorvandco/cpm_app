// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Link',
      json,
      ($checkedConvert) {
        final val = Link(
          $checkedConvert('label', (v) => v as String),
          $checkedConvert('url', (v) => v as String),
        );
        return val;
      },
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'label': instance.label,
      'url': instance.url,
    };
