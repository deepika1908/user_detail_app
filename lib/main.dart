import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'localization/app_string.dart';
import 'presentation/UI/bloc/app/app_bloc.dart';
import 'presentation/UI/bloc/app/app_state.dart';

void main() => runApp(
  // Unified state BLoC: provides all app state to the widget tree.
  BlocProvider(create: (_) => AppBloc(), child: const MyApp()),
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) =>
      // Unified state BLoC: rebuilds the app when theme or language changes.
      BlocBuilder<AppBloc, AppState>(
        builder: (context, settings) => MaterialApp.router(
          debugShowCheckedModeBanner: false,
          title: settings.text(AppStringKeys.userManagement),
          themeMode: settings.themeMode,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: AppRoutes.router,
        ),
      );
}
