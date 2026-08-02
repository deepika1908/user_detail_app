import 'package:flutter/material.dart';
import "../core/theme/app_colors.dart";
import '../core/theme/app_input_decorator.dart';
import '../data/user_data.dart';
import 'user_details_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String searchText = "";
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredUsers = users.where((user) {
      return user.name
          .toLowerCase()
          .contains(searchText.toLowerCase());
    }).toList();

    return Column(
      children: [
        _buildSearchBar(),

        Expanded(
          child: _buildUsersList(filteredUsers),
        ),
      ],
    );
  }

  /// Search Bar
  Widget _buildSearchBar() {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: AppInputDecoration.textField(
          hintText: "Search users...",
          icon: Icons.search,
          filled: true,
          fillColor: colorScheme.surface,
        ),
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
      ),
    );
  }

  /// Users List
  Widget _buildUsersList(List<dynamic> filteredUsers) {
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        return _buildUserCard(filteredUsers[index]);
      },
    );
  }

  /// Single User Card
  Widget _buildUserCard(dynamic user) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 8,
      ),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: colorScheme.surfaceContainerHighest,
          child: Text(
            user.name[0],
            style: const TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => UserDetailsPage(user: user),
            ),
          );
        },
      ),
    );
  }
}
