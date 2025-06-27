import 'package:clients/core/networking/failures.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/my_appointments/data/datasource/my_appointments_service.dart';
import 'package:dartz/dartz.dart';

abstract class MyAppointmentsRepo {
  Future<Either<BackendFailure, List<Appointment>>> getMyAppointments(
      {String? state});
}

class MyAppointmentsRepoImpl extends MyAppointmentsRepo {
  final MyAppointmentsService _service;

  MyAppointmentsRepoImpl({required MyAppointmentsService service}) : _service = service;
  
  @override
  Future<Either<BackendFailure, List<Appointment>>> getMyAppointments(
      {String? state}) {
    return _service.getMyAppointments(state: state);
  }
}