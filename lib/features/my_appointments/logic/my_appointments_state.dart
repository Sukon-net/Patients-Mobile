part of 'my_appointments_cubit.dart';

enum MyAppointmentsStatus {
  loading,
  success,
  error,
}

class MyAppointmentsState extends Equatable {
  final MyAppointmentsStatus status;
  final List<Appointment>? appointments;
  final String errorMessage;

  const MyAppointmentsState({
    this.status = MyAppointmentsStatus.loading,
    this.appointments,
    this.errorMessage = '',
  });


  @override
  List<Object?> get props => [status, appointments, errorMessage];

  MyAppointmentsState copyWith({
    MyAppointmentsStatus? status,
    List<Appointment>? appointments,
    String? errorMessage,
  }) {
    return MyAppointmentsState(
      status: status ?? this.status,
      appointments: appointments ?? this.appointments,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}