// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstName: json['first_name'] as String?,
      lastName: json['last_name'] as String?,
      email: json['email'] as String?,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
      phoneNum: json['mobile'] as String?,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      isActive: json['is_active'] as bool? ?? true,
      hasCompletedSignup: json['has_completed_signup'] as bool? ?? true,
      isEmailVerified: json['is_email_verified'] as bool? ?? true,
      id: (json['id'] as num?)?.toInt() ?? 0,
      avatar: json['avatar'] as String? ?? "",
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'gender': _$GenderEnumMap[instance.gender],
      'mobile': instance.phoneNum,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'is_active': instance.isActive,
      'is_email_verified': instance.isEmailVerified,
      'has_completed_signup': instance.hasCompletedSignup,
      'avatar': instance.avatar,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
