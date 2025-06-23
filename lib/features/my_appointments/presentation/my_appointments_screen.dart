import 'package:clients/features/my_appointments/logic/my_appointments_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyAppointmentsScreen extends StatelessWidget {
  const MyAppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MyAppointmentsCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Center(child: Text("My Appointments")),
            ],
          ),
        ),
      ),
    );
  }
}
