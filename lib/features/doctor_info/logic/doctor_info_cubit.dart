import 'package:clients/features/doctor_info/data/repository/doctor_info_repository.dart';
import 'package:clients/features/home/model/doctor.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'doctor_info_state.dart';

class DoctorInfoCubit extends Cubit<DoctorInfoState> {
  DoctorInfoCubit(this._doctorInfoRepository) : super(const DoctorInfoState());

  final DoctorInfoRepository _doctorInfoRepository;

  Future<void> getDoctorInfo(int id) async {
    // if (FlavorConfig.isDevelopment()) {
    //   emit(
    //     state.copyWith(
    //       status: DoctorInfoStatus.success,
    //       doctor: Doctor(
    //           firstName: "احمد",
    //           lastName: "حمدي",
    //           role: "طبيب نفسي",
    //           title: "د/",
    //           bio:
    //               "هذا الطبيب المتخصص في الأمراض النفسية والعصبية وكذلك علاج الادمان محترف ومختبر. لديه الكثير من الخبرة في معالجة المرضى.مشهور تتتتتتتتتتتتتتتتتتتتتتتتتتتتتتتتتتتت",
    //           availableSlots: [
    //             Appointment(day: "1", startTime: "1", endTime: "1")
    //           ]),
    //     ),
    //   );
    // }
    //TODO: remove comments after finish ^_^

    emit(state.copyWith(status: DoctorInfoStatus.loading));
    await _doctorInfoRepository.getDoctorInfo(id).then((result) {
      result.fold(
        (error) => emit(state.copyWith(
          status: DoctorInfoStatus.error,
          errorMessage:
              error.message.isNotEmpty ? error.message : "Unknown Error",
        )),
        (doctor) => emit(state.copyWith(
          status: DoctorInfoStatus.success,
          doctor: doctor,
        )),
      );
    });
  }

  void onAddToFavClicked() {
    //TODO: link add to favourite with api
    emit(state.copyWith(isFavourite: !state.isFavourite));
  }
}
