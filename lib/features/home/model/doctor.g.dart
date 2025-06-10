// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'doctor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Doctor _$DoctorFromJson(Map<String, dynamic> json) => Doctor(
      id: (json['id'] as num).toInt(),
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      role: json['role'] as String,
      title: json['title'] as String? ?? '',
      bio: json['bio'] as String?,
      avatar: json['avatar'] as String? ?? '',
      availableSlotsCount: (json['available_slots_count'] as num?)?.toInt(),
      specializations: (json['specializations'] as List<dynamic>?)
          ?.map((e) => Specialization.fromJson(e as Map<String, dynamic>))
          .toList(),
      yearsOfExperience: json['years_of_experience'] == null
          ? 0
          : Doctor._stringToInt(json['years_of_experience']),
      sessionUSDPrice: (json['session_usd_price'] as num?)?.toDouble() ?? 0.0,
      sessionEGPPrice: (json['session_egp_price'] as num?)?.toDouble() ?? 0.0,
      comment: (json['comment'] as num?)?.toInt() ?? 0,
      rating: (json['average_rating'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$DoctorToJson(Doctor instance) => <String, dynamic>{
      'id': instance.id,
      'first_name': instance.firstName,
      'last_name': instance.lastName,
      'role': instance.role,
      'title': instance.title,
      'avatar': instance.avatar,
      'bio': instance.bio,
      'specializations': instance.specializations,
      'session_usd_price': instance.sessionUSDPrice,
      'session_egp_price': instance.sessionEGPPrice,
      'available_slots_count': instance.availableSlotsCount,
      'comment': instance.comment,
      'average_rating': instance.rating,
      'years_of_experience': instance.yearsOfExperience,
    };
