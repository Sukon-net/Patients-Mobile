import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/my_appointments/data/repository/my_appointments_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_appointments_state.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  MyAppointmentsCubit(this._repo) : super(const MyAppointmentsState());

  final MyAppointmentsRepo _repo;

  Future<void> getMyAppointments({String? stateFilter}) async {
    emit(state.copyWith(status: MyAppointmentsStatus.loading));
    final result = await _repo.getMyAppointments(state: stateFilter);
    result.fold(
      (error) => emit(state.copyWith(
        status: MyAppointmentsStatus.error,
        errorMessage: error.message.isNotEmpty ? error.message : "Unknown Error",
      )),
      (appointments) => emit(state.copyWith(
        status: MyAppointmentsStatus.success,
        appointments: appointments,
      )),
    );
  }
}
