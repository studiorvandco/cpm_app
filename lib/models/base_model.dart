import 'package:equatable/equatable.dart';

abstract class BaseModel extends Equatable {
  final int id;

  const BaseModel({
    required this.id,
  });

  Map<String, dynamic> toJson();

  @override
  List<Object> get props => [id];
}
