import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link extends BaseModel {
  final String label;
  final String url;

  Link({
    required super.id,
    required this.label,
    required this.url,
  });

  Link.insert({
    required this.label,
    required this.url,
  }) : super(id: -1);

  Link.empty()
      : label = '',
        url = '',
        super(id: -1);

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
