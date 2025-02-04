import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  final int id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String email;
  @JsonKey(name: 'gender')
  final Gender? gender;
  @JsonKey(name: 'mobile')
  final String? phoneNum;
  @JsonKey(name: 'date_of_birth')
  final DateTime? dateOfBirth;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_email_verified')
  final bool isEmailVerified;
  @JsonKey(name: 'has_completed_signup')
  final bool hasCompletedSignup;
  final String avatar;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phoneNum,
    required this.dateOfBirth,
    required this.isActive,
    required this.hasCompletedSignup,
    required this.isEmailVerified,
    required this.id,
    required this.avatar,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

enum Gender {
  male,
  female,
}
