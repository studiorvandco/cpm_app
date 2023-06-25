import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link {
  final String label;
  final String url;

  const Link(this.label, this.url);

  const Link.empty()
      : label = '',
        url = '';

  factory Link.fromJson(json) => _$LinkFromJson(json);

  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
