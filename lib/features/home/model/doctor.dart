import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:json_annotation/json_annotation.dart';

part 'doctor.g.dart';

@JsonSerializable()
class Doctor {
  final int id;
  @JsonKey(name: "first_name")
  final String firstName;
  @JsonKey(name: "last_name")
  final String lastName;
  final String role;
  final String? title;
  final String? avatar;
  final String? bio;
  final List<Specialization> specializations;
  @JsonKey(name: "session_usd_price")
  final double? sessionUSDPrice;
  @JsonKey(name: "session_egp_price")
  final double? sessionEGPPrice;
  @JsonKey(name: "available_slots")
  final List<Appointment>? availableSlots;
  final int comment;
  final double? rating;
  final int? ratingCount;
  @JsonKey(name: "years_of_experience")
  final String yearOfExperience;

  const Doctor({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.role,
    this.title,
    this.bio,
    this.avatar = '',
    this.availableSlots,
    required this.specializations,
    this.yearOfExperience = "0",
    this.sessionUSDPrice,
    this.sessionEGPPrice,
    this.ratingCount,
    this.comment = 0,
    this.rating = 0,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);
}
