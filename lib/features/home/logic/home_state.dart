part of 'home_cubit.dart';

enum HomeStatus { loading, error, success }

enum SpecializationsStatus { loading, success, error }

class HomeState extends Equatable {
  final HomeStatus status;
  final SpecializationsStatus specializationsStatus;
  final String errorMessage;
  final List<Specialization>? specializations;

  const HomeState({
    this.specializationsStatus = SpecializationsStatus.loading,
    this.status = HomeStatus.loading,
    this.errorMessage = "",
    this.specializations,
  });

  @override
  List<Object?> get props =>
      [status, errorMessage, specializations, specializationsStatus];

  HomeState copyWith({
    HomeStatus? status,
    SpecializationsStatus? specializationsStatus,
    String? errorMessage,
    List<Specialization>? specializations,
  }) {
    return HomeState(
      status: status ?? this.status,
      specializationsStatus:
          specializationsStatus ?? this.specializationsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      specializations: specializations ?? this.specializations,
    );
  }
}
