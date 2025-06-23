import 'package:clients/features/more/logic/more_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MoreCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text("More"),
            ],
          ),
        ),
      ),
    );
  }
}