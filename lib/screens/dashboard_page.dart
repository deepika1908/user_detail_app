import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'users_page.dart';
import 'profile_page.dart';
import '../widgets/settings_dialog.dart';
import '../providers/language_provider.dart';
import '../core/theme/app_colors.dart';
import '../core/constants/app_sizes.dart';
import '../core/theme/app_text_styles.dart';

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
  int currentIndex = 0;


@override
Widget build(BuildContext context) {
  final languageProvider = Provider.of<LanguageProvider>(context);

  return Scaffold(
    backgroundColor: AppColors.scaffoldBackground,

    appBar: _buildAppBar(languageProvider),

    body: _buildBody(languageProvider),

    bottomNavigationBar: _buildBottomNavigationBar(languageProvider),
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

PreferredSizeWidget _buildAppBar(
  LanguageProvider languageProvider,
) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    backgroundColor: AppColors.primary,
    foregroundColor: AppColors.white,
    centerTitle: true,

    title: Text(
      currentIndex == 0
          ? languageProvider.text("users")
          : languageProvider.text("my_profile"),
      style: const TextStyle(
        fontWeight: FontWeight.bold,
      ),
    ),

    actions: [
      IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () {
          showDialog(
            context: context,
            builder: (_) => const SettingsDialog(),
          );
        },
      ),
    ],
  );
}

Widget _buildBody(
  LanguageProvider languageProvider,
) {
  final pages = _getPages();

  return Column(
    children: [
      if (currentIndex == 0)
        _buildWelcomeSection(languageProvider),

      Expanded(
        child: pages[currentIndex],
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
          "${languageProvider.text("welcome")}, ${widget.firstName} 👋",
          style: const TextStyle(
            color: AppColors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),

        const SizedBox(height: 5),

        Text(
          languageProvider.text("user_dashboard"),
          style: const TextStyle(
            color: AppColors.white,
          ),
        ),
      ],
    ),
  );
}

Widget _buildBottomNavigationBar(
  LanguageProvider languageProvider,
) {
  return NavigationBar(
    selectedIndex: currentIndex,
    indicatorColor: AppColors.primary,
    height: 70,

    destinations: [
      NavigationDestination(
        icon: const Icon(Icons.people_outline),
        selectedIcon: const Icon(Icons.people),
        label: languageProvider.text("users"),
      ),

      NavigationDestination(
        icon: const Icon(Icons.person_outline),
        selectedIcon: const Icon(Icons.person),
        label: languageProvider.text("profile"),
      ),
    ],

    onDestinationSelected: (index) {
      setState(() {
        currentIndex = index;
      });
    },
  );
}}