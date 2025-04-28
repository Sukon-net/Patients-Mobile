import 'package:clients/features/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complete_profile_request.g.dart';

@JsonSerializable()
class CompleteProfileRequest {
  final String firstName;
  final String lastName;
  final String email;
  final DateTime? dateOfBirth;
  final String phoneNumber;
  final Gender? gender;

  CompleteProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
  });

  factory CompleteProfileRequest.fromJson(Map<String, dynamic> json) =>
      _$CompleteProfileRequestFromJson(json);

  Map<String, dynamic> toJson() => _$CompleteProfileRequestToJson(this);
}
