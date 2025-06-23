import 'package:clients/features/messages/logic/messages_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MessagesCubit(),
      child: const Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Text("Messages"),
            ],
          ),
        ),
      ),
    );
  }
}