// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'complete_profile_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompleteProfileRequest _$CompleteProfileRequestFromJson(
        Map<String, dynamic> json) =>
    CompleteProfileRequest(
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      dateOfBirth: json['date_of_birth'] == null
          ? null
          : DateTime.parse(json['date_of_birth'] as String),
      phoneNumber: json['mobile'] as String,
      gender: $enumDecodeNullable(_$GenderEnumMap, json['gender']),
    );

Map<String, dynamic> _$CompleteProfileRequestToJson(
        CompleteProfileRequest instance) =>
    <String, dynamic>{
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'email': instance.email,
      'date_of_birth': instance.dateOfBirth?.toIso8601String(),
      'mobile': instance.phoneNumber,
      'gender': _$GenderEnumMap[instance.gender],
    };

const _$GenderEnumMap = {
  Gender.male: 'male',
  Gender.female: 'female',
};
