import 'package:clients/features/home/data/repository/home_repository.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._repository) : super(const HomeState());

  final HomeRepository _repository;

  Future<void> getSpecializations() async {
    emit(state.copyWith(specializationsStatus: SpecializationsStatus.loading));
    final result = await _repository.getSpecializations();
    result.fold(
      (error) {
        emit(state.copyWith(
          specializationsStatus: SpecializationsStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        ));
      },
      (specializations) {
        emit(state.copyWith(
          specializationsStatus: SpecializationsStatus.success,
          specializations: specializations,
        ));
      },
    );
  }

  Future<void> getTopRatedDoctors() async {
    emit(state.copyWith(topRatedDocStatus: TopRatedDocStatus.loading));
    final result = await _repository.getTopRatedDoctors();
    print("🩵 result: ${result}");
    result.fold(
      (error) {
        print("🔴 Error emitted: ${error.message}");
        emit(state.copyWith(
          topRatedDocStatus: TopRatedDocStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        ));
      },
      (topRatedDocs) {
        print("🟢 Success emitted with ${topRatedDocs.length} items");
        emit(state.copyWith(
          topRatedDocStatus: TopRatedDocStatus.success,
          topRatedDoctors: topRatedDocs,
        ));
      },
    );
  }
}
