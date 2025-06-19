import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/model/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'appointment.g.dart';

@JsonSerializable()
class Appointment {
  final int id;
  final String date;
  @JsonKey(name: "start_time")
  final String startTime;
  final int duration;
  final Status status;
  final String? complaint;
  final Doctor doctor;
  @JsonKey(name: "patient", readValue: _readPatient)
  final User patient;
  final double? rate;

  const Appointment({
    required this.id,
    required this.date,
    required this.startTime,
    required this.duration,
    required this.status,
    this.complaint = "",
    required this.doctor,
    required this.patient,
    this.rate = 0.0,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) =>
      _$AppointmentFromJson(json);

  Map<String, dynamic> toJson() => _$AppointmentToJson(this);

  String get endTimeString {
    // Assumes startTime is in "HH:mm" format
    final parts = startTime.split(':');
    if (parts.length != 2) return startTime;
    final startHour = int.tryParse(parts[0]) ?? 0;
    final startMinute = int.tryParse(parts[1]) ?? 0;
    final totalMinutes = startHour * 60 + startMinute + duration;
    final endHour = (totalMinutes ~/ 60) % 24;
    final endMinute = totalMinutes % 60;
    return '${endHour.toString().padLeft(2, '0')}:${endMinute.toString().padLeft(2, '0')}';
  }

  static Object? _readPatient(Map<dynamic, dynamic> json, String key) {
    return json["patient"]["user"];
  }
}

enum Status {
  pending,
  confirmed,
  cancelled,
  completed,
}
