import 'package:clients/features/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'complete_profile_request.g.dart';

@JsonSerializable()
class CompleteProfileRequest {
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String email;
  @JsonKey(name: 'date_of_birth')
  final DateTime? dateOfBirth;
  @JsonKey(name: 'mobile')
  final String phoneNumber;
  @JsonKey(name: 'gender')
  final Gender? gender;

  CompleteProfileRequest({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.phoneNumber,
    required this.gender,
  });

  Map<String, dynamic> toJson() => {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'date_of_birth': dateOfBirth?.toIso8601String().split('T')[0],
        'mobile': phoneNumber,
        'gender': gender?.name,
      };
}
