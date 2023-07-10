import 'package:cpm/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'link.g.dart';

@JsonSerializable()
class Link extends BaseModel {
  int project;
  String? label;
  String? url;

  String get getLabel => label ?? 'Unlabeled';

  String get getUrl => url ?? '';

  Link({
    required super.id,
    required this.project,
    this.label,
    this.url,
  });

  Link.insert({
    required this.project,
    this.label,
    this.url,
  }) : super(id: -1);

  Link.empty()
      : project = -1,
        super(id: -1);

  factory Link.fromJson(Map<String, dynamic> json) => _$LinkFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LinkToJson(this);
}
