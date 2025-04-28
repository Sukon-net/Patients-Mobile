import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  final String day;
  @JsonValue("start_time")
  final String startTime;
  @JsonValue("end_time")
  final String endTime;

  Appointment({
    required this.day,
    required this.startTime,
    required this.endTime,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);
}
