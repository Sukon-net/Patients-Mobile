part of 'doctor_info_cubit.dart';

enum DoctorInfoStatus {
  initial,
  loading,
  success,
  error,
}

class DoctorInfoState extends Equatable {
  final DoctorInfoStatus status;
  final Doctor? doctor;
  final bool isFavourite;
  final String errorMessage;

  const DoctorInfoState({
    this.status = DoctorInfoStatus.initial,
    this.doctor,
    this.isFavourite = false,
    this.errorMessage = "",
  });

  @override
  List<Object?> get props => [status, doctor, isFavourite, errorMessage];

  DoctorInfoState copyWith({
    DoctorInfoStatus? status,
    Doctor? doctor,
    bool? isFavourite,
    String? errorMessage,
  }) {
    return DoctorInfoState(
      status: status ?? this.status,
      doctor: doctor ?? this.doctor,
      isFavourite: isFavourite ?? this.isFavourite,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
