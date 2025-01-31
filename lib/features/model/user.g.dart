// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      gender: $enumDecode(_$GenderEnumMap, json['gender']),
      phoneNum: json['mobile'] as String,
      dateOfBirth: DateTime.parse(json['date_of_birth'] as String),
      isActive: json['is_active'] as bool,
      hasCompletedSignup: json['has_completed_signup'] as bool,
      isEmailVerified: json['is_email_verified'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'gender': _$GenderEnumMap[instance.gender]!,
      'mobile': instance.phoneNum,
      'date_of_birth': instance.dateOfBirth.toIso8601String(),
      'is_active': instance.isActive,
      'is_email_verified': instance.isEmailVerified,
      'has_completed_signup': instance.hasCompletedSignup,
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
