import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link extends BaseModel {
  final String label;
  final String url;

  Link(this.label, this.url);

  Link.empty()
      : label = '',
        url = '';

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
