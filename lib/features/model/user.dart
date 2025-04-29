// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  final int id;
  @JsonKey(name: 'first_name')
  final String? firstName;
  @JsonKey(name: 'last_name')
  final String? lastName;
  final String? email;
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

  const User({
    this.firstName,
    this.lastName,
    this.email,
    this.gender,
    this.phoneNum,
    this.dateOfBirth,
    this.isActive = true,
    this.hasCompletedSignup = true,
    this.isEmailVerified = true,
    this.id = 0,
    this.avatar = "",
  });

  static const guest = User(firstName: "Guest");

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        id,
        firstName,
        lastName,
        email,
        gender,
        phoneNum,
        dateOfBirth,
        isActive,
        isEmailVerified,
        hasCompletedSignup,
        avatar,
      ];

  User copyWith({
    int? id,
    String? firstName,
    String? lastName,
    String? email,
    Gender? gender,
    String? phoneNum,
    DateTime? dateOfBirth,
    bool? isActive,
    bool? isEmailVerified,
    bool? hasCompletedSignup,
    String? avatar,
  }) {
    return User(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      gender: gender ?? this.gender,
      phoneNum: phoneNum ?? this.phoneNum,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      isActive: isActive ?? this.isActive,
      isEmailVerified: isEmailVerified ?? this.isEmailVerified,
      hasCompletedSignup: hasCompletedSignup ?? this.hasCompletedSignup,
      avatar: avatar ?? this.avatar,
    );
  }
}

enum Gender {
  @JsonValue('male')
  male,
  @JsonValue('female')
  female,
}
