import 'package:flutter/material.dart';
import "../core/theme/app_colors.dart";
import '../data/user_data.dart';
import 'user_details_page.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  String searchText = "";

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
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search users...",
          prefixIcon: const Icon(Icons.search),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
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
          backgroundColor: AppColors.white,
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