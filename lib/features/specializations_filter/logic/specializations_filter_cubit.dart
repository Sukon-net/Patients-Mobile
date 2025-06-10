import 'package:clients/features/home/model/doctor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../data/repository/specializations_filter_repo.dart';

part 'specializations_filter_state.dart';

class SpecializationsFilterCubit extends Cubit<SpecializationsFilterState> {
  SpecializationsFilterCubit(this.specializationId, this._filterRepo)
      : super(const SpecializationsFilterState()) {
    changeSelectedIndex(specializationId);
  }

  final int specializationId;
  final SpecializationsFilterRepo _filterRepo;

  Future<void> getDoctors({String? specialization}) async {
    emit(state.copyWith(status: SpecializationsFilterStatus.loading));
    await _filterRepo.getDoctors(specialization: specialization).then((result) {
      result.fold(
        (error) => emit(
          state.copyWith(
            status: SpecializationsFilterStatus.error,
            errorMessage:
                error.message.isNotEmpty ? error.message : "Unknown Error",
          ),
        ),
        (doctors) => emit(
          state.copyWith(
            status: SpecializationsFilterStatus.success,
            doctors: doctors,
          ),
        ),
      );
    });
  }

  void changeSelectedIndex(int index, [String? specialization]) {
    emit(state.copyWith(
      selectedIndex: index,
      status: SpecializationsFilterStatus.loading,
    ));
    if (index == 0) {
      getDoctors();
    } else {
      getDoctors(specialization: specialization);
    }
  }
}
