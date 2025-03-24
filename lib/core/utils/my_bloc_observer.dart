import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';

class MyBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    log('BlocObserver: onChange: bloc: $bloc, change: $change');
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    log('BlocObserver: onClose: bloc: $bloc');
  }

  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    log('BlocObserver: onCreate: bloc: $bloc');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    log('BlocObserver: onError: bloc: $bloc, error: $error, stackTrace: $stackTrace');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    log('BlocObserver: onEvent: bloc: $bloc, event: $event');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    log('BlocObserver: onTransition: bloc: $bloc, transition: $transition');
  }
}
