

abstract class BaseModel {
  final int? id;

  const BaseModel({this.id});

  Map<String, dynamic> toJson();
}
