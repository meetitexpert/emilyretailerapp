// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_root.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

userRoot _$userRootFromJson(Map<String, dynamic> json) =>
    userRoot()..user = User.fromJson(json['data'] as Map<String, dynamic>);

Map<String, dynamic> _$userRootToJson(userRoot instance) => <String, dynamic>{
      'data': instance.user,
    };
