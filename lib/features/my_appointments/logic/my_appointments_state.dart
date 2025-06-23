part of 'my_appointments_cubit.dart';

sealed class MyAppointmentsState extends Equatable {
  const MyAppointmentsState();

  @override
  List<Object> get props => [];
}

final class MyAppointmentsInitial extends MyAppointmentsState {}
