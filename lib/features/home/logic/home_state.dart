part of 'home_cubit.dart';

enum TopRatedDocStatus { loading, error, success }

enum SpecializationsStatus { loading, success, error }

enum AppointmentsStatus { loading, success, error }

class HomeState extends Equatable {
  final AppointmentsStatus appointmentsStatus;
  final TopRatedDocStatus topRatedDocStatus;
  final SpecializationsStatus specializationsStatus;
  final String errorMessage;
  final List<Specialization>? specializations;
  final List<Doctor>? topRatedDoctors;
  final List<Appointment>? appointments;

  const HomeState({
    this.appointmentsStatus = AppointmentsStatus.loading,
    this.specializationsStatus = SpecializationsStatus.loading,
    this.topRatedDocStatus = TopRatedDocStatus.loading,
    this.errorMessage = "",
    this.appointments,
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
        appointmentsStatus,
        appointments,
      ];

  HomeState copyWith({
    TopRatedDocStatus? topRatedDocStatus,
    SpecializationsStatus? specializationsStatus,
    String? errorMessage,
    List<Specialization>? specializations,
    List<Doctor>? topRatedDoctors,
    AppointmentsStatus? appointmentsStatus,
    List<Appointment>? appointments,
  }) {
    return HomeState(
      topRatedDocStatus: topRatedDocStatus ?? this.topRatedDocStatus,
      specializationsStatus:
          specializationsStatus ?? this.specializationsStatus,
      errorMessage: errorMessage ?? this.errorMessage,
      specializations: specializations ?? this.specializations,
      topRatedDoctors: topRatedDoctors ?? this.topRatedDoctors,
      appointmentsStatus: appointmentsStatus ?? this.appointmentsStatus,
      appointments: appointments ?? this.appointments,
    );
  }
}
