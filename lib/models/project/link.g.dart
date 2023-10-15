// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'link.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Link _$LinkFromJson(Map<String, dynamic> json) => Link(
      id: json['id'] as int,
      project: json['project'] as int,
      index: json['index'] as int?,
      label: json['label'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$LinkToJson(Link instance) => <String, dynamic>{
      'project': instance.project,
      'index': instance.index,
      'label': instance.label,
      'url': instance.url,
    };
