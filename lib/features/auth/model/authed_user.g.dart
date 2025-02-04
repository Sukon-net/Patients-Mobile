// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'authed_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthedUser _$AuthedUserFromJson(Map<String, dynamic> json) => AuthedUser(
      token: json['token'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthedUserToJson(AuthedUser instance) =>
    <String, dynamic>{
      'token': instance.token,
      'user': instance.user,
    };
