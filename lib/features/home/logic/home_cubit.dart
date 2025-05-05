import 'package:clients/features/home/data/repository/specializations_repository.dart';
import 'package:clients/features/home/model/specialization.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit(this._specializationsRepository) : super(const HomeState());

  final SpecializationsRepository _specializationsRepository;

  Future<void> getSpecializations() async {
    emit(state.copyWith(specializationsStatus: SpecializationsStatus.loading));
    final result = await _specializationsRepository.getSpecializations();
    result.fold(
      (error) {
        print("🔴 Error emitted: ${error.message}");
        emit(state.copyWith(
          specializationsStatus: SpecializationsStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        ));
      },
      (specializations) {
        print("🟢 Success emitted with ${specializations.length} items");
        emit(state.copyWith(
          specializationsStatus: SpecializationsStatus.success,
          specializations: specializations,
        ));
      },
    );
  }
}
