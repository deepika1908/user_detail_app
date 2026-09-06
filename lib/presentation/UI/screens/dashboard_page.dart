import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'users_page.dart';
import 'profile_page.dart';
import '../widgets/settings_dialog.dart';
import '../../../providers/language_provider.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/constants/app_icons.dart';
import '../../../localization/app_string.dart';
import '../widgets/common_app_bar.dart';
import '../bloc/app/app_bloc.dart';
import '../bloc/app/app_event.dart';
import '../bloc/app/app_state.dart';

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
    // Unified state BLoC: drives the dashboard tab and localized content.
    return BlocBuilder<AppBloc, AppState>(
      builder: (blocContext, state) {
        final languageProvider = state;
        return Scaffold(
          appBar: buildAppBar(
              title: state.selectedDashboardIndex == 0
                ? languageProvider.text(AppStringKeys.users)
                : languageProvider.text(AppStringKeys.myProfile),
            automaticallyImplyLeading: false,
            actionIcon: AppIcons.settings,
            onActionPressed: _openSettings,
          ),
            body: _buildBody(languageProvider, state.selectedDashboardIndex),
          bottomNavigationBar: _buildBottomNavigationBar(
            blocContext,
            languageProvider,
              state.selectedDashboardIndex,
          ),
        );
      },
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
    showDialog(context: context, builder: (_) => const SettingsDialog());
  }

  Widget _buildBody(LanguageProvider languageProvider, int selectedIndex) {
    final pages = _getPages();

    return Column(
      children: [
        if (selectedIndex == 0) _buildWelcomeSection(languageProvider),

        Expanded(child: pages[selectedIndex]),
      ],
    );
  }

  Widget _buildWelcomeSection(LanguageProvider languageProvider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      color: AppColors.primary,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${languageProvider.text(AppStringKeys.welcome)}, ${widget.firstName} 👋",
            style: AppTextStyles.largeText.copyWith(
              fontWeight: FontWeight.bold,
              color: AppColors.white,
            ),
          ),

          const SizedBox(height: 5),

          Text(
            languageProvider.text(AppStringKeys.userDashboard),
            style: AppTextStyles.smallText.copyWith(color: AppColors.white),
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
        // Unified state BLoC: stores the selected dashboard tab.
        blocContext.read<AppBloc>().add(AppDashboardTabChanged(index));
      },
    );
  }
}
