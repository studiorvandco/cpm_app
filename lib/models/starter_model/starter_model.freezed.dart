// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'starter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

StarterModel _$StarterModelFromJson(Map<String, dynamic> json) {
  return _StarterModel.fromJson(json);
}

/// @nodoc
mixin _$StarterModel {
  String get label => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $StarterModelCopyWith<StarterModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $StarterModelCopyWith<$Res> {
  factory $StarterModelCopyWith(
          StarterModel value, $Res Function(StarterModel) then) =
      _$StarterModelCopyWithImpl<$Res, StarterModel>;
  @useResult
  $Res call({String label});
}

/// @nodoc
class _$StarterModelCopyWithImpl<$Res, $Val extends StarterModel>
    implements $StarterModelCopyWith<$Res> {
  _$StarterModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_value.copyWith(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$StarterModelImplCopyWith<$Res>
    implements $StarterModelCopyWith<$Res> {
  factory _$$StarterModelImplCopyWith(
          _$StarterModelImpl value, $Res Function(_$StarterModelImpl) then) =
      __$$StarterModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String label});
}

/// @nodoc
class __$$StarterModelImplCopyWithImpl<$Res>
    extends _$StarterModelCopyWithImpl<$Res, _$StarterModelImpl>
    implements _$$StarterModelImplCopyWith<$Res> {
  __$$StarterModelImplCopyWithImpl(
      _$StarterModelImpl _value, $Res Function(_$StarterModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? label = null,
  }) {
    return _then(_$StarterModelImpl(
      label: null == label
          ? _value.label
          : label // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$StarterModelImpl implements _StarterModel {
  const _$StarterModelImpl({required this.label});

  factory _$StarterModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$StarterModelImplFromJson(json);

  @override
  final String label;

  @override
  String toString() {
    return 'StarterModel(label: $label)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$StarterModelImpl &&
            (identical(other.label, label) || other.label == label));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, label);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$StarterModelImplCopyWith<_$StarterModelImpl> get copyWith =>
      __$$StarterModelImplCopyWithImpl<_$StarterModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$StarterModelImplToJson(
      this,
    );
  }
}

abstract class _StarterModel implements StarterModel {
  const factory _StarterModel({required final String label}) =
      _$StarterModelImpl;

  factory _StarterModel.fromJson(Map<String, dynamic> json) =
      _$StarterModelImpl.fromJson;

  @override
  String get label;
  @override
  @JsonKey(ignore: true)
  _$$StarterModelImplCopyWith<_$StarterModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
