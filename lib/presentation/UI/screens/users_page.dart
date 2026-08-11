import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/theme/app_input_decorator.dart';
import '../../../core/service/api_service.dart';
import '../../../models/user.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/extensions/context_extension.dart';
import '../../../localization/app_string.dart';
import '../bloc/users_bloc.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _searchController = TextEditingController();
  final ApiService _apiService = ApiService();
  late Future<List<User>> _usersFuture;

  @override
  void initState() {
    super.initState();
    _usersFuture = _apiService.fetchUsers();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => UsersBloc(),
      child: BlocBuilder<UsersBloc, UsersState>(
        builder: (blocContext, state) {
          return Column(
            children: [
              _buildSearchBar(blocContext),
              Expanded(
                child: FutureBuilder<List<User>>(
                  future: _usersFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return Center(
                        child: Text(
                          '${AppContext(context).language.text(AppStringKeys.error)}: ${snapshot.error}',
                        ),
                      );
                    }

                    final users = snapshot.data ?? [];
                    final filteredUsers = users.where((user) {
                      final name = '${user.firstName} ${user.lastName}';
                      return name.toLowerCase().contains(
                        state.searchText.toLowerCase(),
                      );
                    }).toList();

                    return _buildUsersList(filteredUsers);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  /// Search Bar
  Widget _buildSearchBar(BuildContext blocContext) {
    final colorScheme = Theme.of(blocContext).colorScheme;

    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: _searchController,
        decoration: AppInputDecoration.textField(
          hintText: AppContext(blocContext).language.text(
            AppStringKeys.searchUsers,
          ),
          icon: Icons.search,
          filled: true,
          fillColor: colorScheme.surface,
        ),
        onChanged: (value) {
          blocContext.read<UsersBloc>().add(UserSearchChanged(value));
        },
      ),
    );
  }

  /// Users List
  Widget _buildUsersList(List<User> filteredUsers) {
    return ListView.builder(
      itemCount: filteredUsers.length,
      itemBuilder: (context, index) {
        return _buildUserCard(filteredUsers[index]);
      },
    );
  }

  /// Single User Card
  Widget _buildUserCard(User user) {
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
            user.firstName[0],
            style: ScreenTextStyles.userInitial,
          ),
        ),
        title: Text(
          '${user.firstName} ${user.lastName}',
          style: ScreenTextStyles.detailValue,
        ),
        trailing: const Icon(Icons.arrow_forward_ios),
        onTap: () {
          Navigator.pushNamed(
            context,
            AppRoutes.userDetails,
            arguments: UserDetailsRouteArguments(user),
          );
        },
      ),
    );
  }
}
