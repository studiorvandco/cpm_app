import 'package:json_annotation/json_annotation.dart';

@JsonEnum(valueField: 'index')
enum ProjectType {
  movie,
  series,
  unknown,
}
