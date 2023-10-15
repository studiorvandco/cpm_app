import 'package:freezed_annotation/freezed_annotation.dart';

part 'starter_model.freezed.dart';
part 'starter_model.g.dart';

@freezed
class StarterModel with _$StarterModel {
  const factory StarterModel({
    required String label,
  }) = _StarterModel;

  factory StarterModel.fromJson(Map<String, Object?> json)
  => _$StarterModelFromJson(json);
}
