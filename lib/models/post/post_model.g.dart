// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PostModel _$$_PostModelFromJson(Map<String, dynamic> json) => _$_PostModel(
      id: json['id'] as String,
      userId: json['userId'] as String,
      imgUrl: json['imgUrl'] as String,
      caption: json['caption'] as String,
      createdAt: json['createdAt'],
    );

Map<String, dynamic> _$$_PostModelToJson(_$_PostModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'imgUrl': instance.imgUrl,
      'caption': instance.caption,
      'createdAt': instance.createdAt,
    };
