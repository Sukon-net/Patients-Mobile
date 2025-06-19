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
  final List<Specialization>? specializations;
  @JsonKey(name: "session_usd_price", fromJson: _stringToDouble)
  final double? sessionUSDPrice;
  @JsonKey(name: "session_egp_price", fromJson: _stringToDouble)
  final double? sessionEGPPrice;
  @JsonKey(name: "available_slots_count")
  final int? availableSlotsCount;
  final int? comment;
  @JsonKey(name: "average_rating")
  final double? rating;
  @JsonKey(name: "years_of_experience", fromJson: _stringToInt)
  final int yearsOfExperience;

  const Doctor({
    required this.id,
    required this.firstName,
    this.lastName = '',
    required this.role,
    this.title = '',
    this.bio,
    this.avatar = '',
    this.availableSlotsCount,
    required this.specializations,
    this.yearsOfExperience = 0,
    this.sessionUSDPrice = 0.0,
    this.sessionEGPPrice = 0.0,
    this.comment = 0,
    this.rating = 0,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) => _$DoctorFromJson(json);

  Map<String, dynamic> toJson() => _$DoctorToJson(this);

  static int _stringToInt(dynamic value) => int.tryParse(value.toString()) ?? 0;
  static double _stringToDouble(dynamic value) =>
      double.tryParse(value.toString()) ?? 0.0;

  String get fullName => "$firstName $lastName";
  String get fullNameWithTitle => "$title $fullName";
}
