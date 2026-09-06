import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/UI/bloc/app/app_bloc.dart';
import '../../presentation/UI/bloc/app/app_state.dart';

class AppContext {
  AppContext(this.context);
  final BuildContext context;
  // Unified state BLoC: exposes app-wide theme and language state to widgets.
  AppState get language => context.read<AppBloc>().state;
  AppState get languageWatch => context.watch<AppBloc>().state;
  AppState get theme => context.read<AppBloc>().state;
  AppState get themeWatch => context.watch<AppBloc>().state;
}
