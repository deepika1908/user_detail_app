import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/UI/bloc/settings/settings_bloc.dart';
import '../../presentation/UI/bloc/settings/settings_state.dart';

class AppContext {
  AppContext(this.context);
  final BuildContext context;
  SettingsState get language => context.read<SettingsBloc>().state;
  SettingsState get languageWatch => context.watch<SettingsBloc>().state;
  SettingsState get theme => context.read<SettingsBloc>().state;
  SettingsState get themeWatch => context.watch<SettingsBloc>().state;
}
