import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'my_appointments_state.dart';

class MyAppointmentsCubit extends Cubit<MyAppointmentsState> {
  MyAppointmentsCubit() : super(MyAppointmentsInitial());
}
