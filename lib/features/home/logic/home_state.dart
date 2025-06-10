part of 'home_cubit.dart';

enum TopRatedDocStatus { loading, error, success }

enum SpecializationsStatus { loading, success, error }

class HomeState extends Equatable {
  final TopRatedDocStatus topRatedDocStatus;
  final SpecializationsStatus specializationsStatus;
  final String errorMessage;
  final List<Specialization>? specializations;
  final List<Doctor>? topRatedDoctors;

  const HomeState({
    this.specializationsStatus = SpecializationsStatus.loading,
    this.topRatedDocStatus = TopRatedDocStatus.loading,
    this.errorMessage = "",
    this.specializations,
    this.topRatedDoctors,
  });

  @override
  List<Object?> get props => [
        topRatedDocStatus,
        topRatedDoctors,
        specializationsStatus,
        specializations,
        errorMessage,
      ];

  HomeState copyWith({
    TopRatedDocStatus? topRatedDocStatus,
    SpecializationsStatus? specializationsStatus,
    String? errorMessage,
    List<Specialization>? specializations,
    List<Doctor>? topRatedDoctors,
  }) {
    return HomeState(
      topRatedDocStatus: topRatedDocStatus ?? this.topRatedDocStatus,
      specializationsStatus:
          specializationsStatus ?? this.specializationsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      specializations: specializations ?? this.specializations,
      topRatedDoctors: topRatedDoctors ?? this.topRatedDoctors,
    );
  }
}
