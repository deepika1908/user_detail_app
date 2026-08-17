import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'localization/app_string.dart';
import 'presentation/UI/bloc/settings/settings_bloc.dart';
import 'presentation/UI/bloc/settings/settings_state.dart';

void main() => runApp(BlocProvider(create: (_) => SettingsBloc(), child: const MyApp()));

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) => BlocBuilder<SettingsBloc, SettingsState>(
    builder: (context, settings) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: settings.text(AppStringKeys.userManagement),
      themeMode: settings.themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      initialRoute: AppRoutes.login,
      onGenerateRoute: AppRoutes.onGenerateRoute,
    ),
  );
}
