import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_model.freezed.dart';
part "post_model.g.dart";

@freezed
class PostModel with _$PostModel {
  const PostModel._();

  const factory PostModel({
    required String id,
    required String userId,
    required String imgUrl,
    required String caption,
    required dynamic createdAt,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, Object?> json) =>
      _$PostModelFromJson(json);
}
