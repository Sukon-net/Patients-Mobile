part of 'specializations_filter_cubit.dart';

enum SpecializationsFilterStatus {
  initial,
  loading,
  success,
  error,
}

class SpecializationsFilterState extends Equatable {
  const SpecializationsFilterState({
    this.status = SpecializationsFilterStatus.initial,
    this.errorMessage = "",
    this.doctors,
    this.selectedIndex = 0,
  });

  final SpecializationsFilterStatus status;
  final String errorMessage;
  final List<Doctor>? doctors;
  final int selectedIndex;

  @override
  List<Object?> get props => [status, errorMessage, doctors, selectedIndex];

  SpecializationsFilterState copyWith({
    SpecializationsFilterStatus? status,
    String? errorMessage,
    List<Doctor>? doctors,
    int? selectedIndex,
  }) {
    return SpecializationsFilterState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      doctors: doctors ?? this.doctors,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}
