import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part "user_model.g.dart";

@freezed
class UserModel with _$UserModel {
  const UserModel._();

  const factory UserModel({
    required String id,
    required String email,
    required String username,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, Object?> json) =>
      _$UserModelFromJson(json);
}