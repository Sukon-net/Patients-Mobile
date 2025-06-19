// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'appointment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Appointment _$AppointmentFromJson(Map<String, dynamic> json) => Appointment(
      id: (json['id'] as num).toInt(),
      date: json['date'] as String,
      startTime: json['start_time'] as String,
      duration: (json['duration'] as num).toInt(),
      status: $enumDecode(_$StatusEnumMap, json['status']),
      complaint: json['complaint'] as String? ?? "",
      doctor: Doctor.fromJson(json['doctor'] as Map<String, dynamic>),
      patient: User.fromJson(
          Appointment._readPatient(json, 'patient') as Map<String, dynamic>),
      rate: (json['rate'] as num?)?.toDouble() ?? 0.0,
    );

Map<String, dynamic> _$AppointmentToJson(Appointment instance) =>
    <String, dynamic>{
      'id': instance.id,
      'date': instance.date,
      'start_time': instance.startTime,
      'duration': instance.duration,
      'status': _$StatusEnumMap[instance.status]!,
      'complaint': instance.complaint,
      'doctor': instance.doctor,
      'patient': instance.patient,
      'rate': instance.rate,
    };

const _$StatusEnumMap = {
  Status.pending: 'pending',
  Status.confirmed: 'confirmed',
  Status.cancelled: 'cancelled',
  Status.completed: 'completed',
};
