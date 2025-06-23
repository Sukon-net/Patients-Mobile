import 'package:clients/features/home/data/repository/home_repository.dart';
import 'package:clients/features/home/model/appointment.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final HomeRepository _repository;

  Future<void> getSpecializations() async {
    if (isClosed) return;
    emit(state.copyWith(specializationsStatus: SpecializationsStatus.loading));

    final result = await _repository.getSpecializations();

    if (isClosed) return;
    result.fold(
      (error) {
        if (isClosed) return;
        emit(state.copyWith(
          specializationsStatus: SpecializationsStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        ));
      },
      (specializations) {
        if (isClosed) return;
        emit(state.copyWith(
          specializationsStatus: SpecializationsStatus.success,
          specializations: specializations,
        ));
      },
    );
  }

  Future<void> getTopRatedDoctors() async {
    if (isClosed) return;
    emit(state.copyWith(topRatedDocStatus: TopRatedDocStatus.loading));

    final result = await _repository.getTopRatedDoctors();

    if (isClosed) return;
    result.fold(
      (error) {
        if (isClosed) return;
        emit(state.copyWith(
          topRatedDocStatus: TopRatedDocStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        ));
      },
      (topRatedDocs) {
        if (isClosed) return;
        emit(state.copyWith(
          topRatedDocStatus: TopRatedDocStatus.success,
          topRatedDoctors: topRatedDocs,
        ));
      },
    );
  }

  Future<void> getUpcomingAppointments() async {
    if (isClosed) return;
    emit(state.copyWith(appointmentsStatus: AppointmentsStatus.loading));

    final result = await _repository.getUpcomingAppointments();

    if (isClosed) return;
    result.fold(
      (error) {
        if (isClosed) return;
        emit(state.copyWith(
          appointmentsStatus: AppointmentsStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        ));
      },
      (appointments) {
        if (isClosed) return;
        emit(state.copyWith(
          appointmentsStatus: AppointmentsStatus.success,
          appointments: appointments,
        ));
      },
    );
  }
}
