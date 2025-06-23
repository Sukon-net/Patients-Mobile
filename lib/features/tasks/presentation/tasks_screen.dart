import 'package:clients/features/tasks/logic/tasks_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TasksCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: Column(
          children: [
            Text("Tasks"),
          ],
          ),
        ),
      ),
    );
  }
}