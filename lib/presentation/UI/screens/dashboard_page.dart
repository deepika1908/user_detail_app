import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'users_page.dart';
import 'profile_page.dart';
import '../widgets/settings_dialog.dart';
import '../../../providers/language_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/constants/app_icons.dart';
import '../../../localization/app_string.dart';
import '../widgets/common_app_bar.dart';
import '../bloc/dashboard/dashboard_bloc.dart';
import '../bloc/dashboard/dashboard_event.dart';
import '../bloc/dashboard/dashboard_state.dart';
import '../bloc/settings/settings_bloc.dart';

class DashboardPage extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String phone;
  final String email;
  final String dob;

  const DashboardPage({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.phone,
    required this.email,
    required this.dob,
  });

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    final languageProvider = context.watch<SettingsBloc>().state;

    return BlocProvider(
      create: (_) => DashboardBloc(),
      child: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (blocContext, state) {
          return Scaffold(
            appBar: buildAppBar(
              title: state.selectedIndex == 0
                  ? languageProvider.text(AppStringKeys.users)
                  : languageProvider.text(AppStringKeys.myProfile),
              automaticallyImplyLeading: false,
              actionIcon: AppIcons.settings,
              onActionPressed: _openSettings,
            ),
            body: _buildBody(languageProvider, state.selectedIndex),
            bottomNavigationBar: _buildBottomNavigationBar(
              blocContext,
              languageProvider,
              state.selectedIndex,
            ),
          );
        },
      ),
    );
  }

List<Widget> _getPages() {
  return [
    const UsersPage(),
    ProfilePage(
      firstName: widget.firstName,
      lastName: widget.lastName,
      phone: widget.phone,
      email: widget.email,
      dob: widget.dob,
    ),
  ];
}

void _openSettings() {
  showDialog(
    context: context,
    builder: (_) => const SettingsDialog(),
  );
}

Widget _buildBody(
  LanguageProvider languageProvider,
  int selectedIndex,
) {
  final pages = _getPages();

  return Column(
    children: [
      if (selectedIndex == 0)
        _buildWelcomeSection(languageProvider),

      Expanded(
        child: pages[selectedIndex],
      ),
    ],
  );
}

Widget _buildWelcomeSection(
  LanguageProvider languageProvider,
) {
  return Container(
    width: double.infinity,
    padding: const EdgeInsets.all(16),
    color: AppColors.primary,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${languageProvider.text(AppStringKeys.welcome)}, ${widget.firstName} 👋",
          style: ScreenTextStyles.welcomeTitle,
        ),

        const SizedBox(height: 5),

        Text(
          languageProvider.text(AppStringKeys.userDashboard),
          style: ScreenTextStyles.welcomeSubtitle,
        ),
      ],
    ),
  );
}

Widget _buildBottomNavigationBar(
  BuildContext blocContext,
  LanguageProvider languageProvider,
  int selectedIndex,
) {
  return NavigationBar(
    selectedIndex: selectedIndex,
    indicatorColor: AppColors.primary,
    height: 70,

    destinations: [
      NavigationDestination(
        icon: const Icon(AppIcons.peopleOutline),
        selectedIcon: const Icon(AppIcons.people),
        label: languageProvider.text(AppStringKeys.users),
      ),

      NavigationDestination(
        icon: const Icon(AppIcons.personOutline),
        selectedIcon: const Icon(AppIcons.person),
        label: languageProvider.text(AppStringKeys.profile),
      ),
    ],

    onDestinationSelected: (index) {
      // BLoC: Sends the selected tab event to DashboardBloc.
      blocContext.read<DashboardBloc>().add(DashboardTabChanged(index));
    },
  );
}}
