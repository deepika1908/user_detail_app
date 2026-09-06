import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/styles/text_styles.dart';
import '../../../core/styles/app_colors.dart';
import '../../../core/styles/app_input_decorator.dart';
import '../../../localization/app_string.dart';
import '../../../models/user.dart';
import '../bloc/app/app_bloc.dart';
import '../bloc/app/app_event.dart';
import '../bloc/app/app_state.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final _search = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Unified state BLoC: loads the shared user list when this tab opens.
    context.read<AppBloc>().add(const AppUsersRequested());
  }

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      // Unified state BLoC: rebuilds the list for loading, search, and errors.
      BlocBuilder<AppBloc, AppState>(
        builder: (blocContext, state) => Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: TextField(
                controller: _search,
                onChanged: (value) {
                  // Unified state BLoC: filters the shared user list.
                  blocContext.read<AppBloc>().add(AppUserSearchChanged(value));
                },
                decoration: AppInputDecoration.textField(
                  hintText: AppContext(
                    blocContext,
                  ).language.text(AppStringKeys.searchUsers),
                  icon: Icons.search,
                ),
              ),
            ),
            Expanded(child: _body(state)),
          ],
        ),
      );

  Widget _body(AppState state) {
    if (state.usersStatus == UsersStatus.initial ||
        state.usersStatus == UsersStatus.loading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.usersStatus == UsersStatus.failure) {
      return Center(
        child: Text(
          '${AppContext(context).language.text(AppStringKeys.error)}: '
          '${state.usersErrorMessage}',
        ),
      );
    }

    return ListView.builder(
      itemCount: state.filteredUsers.length,
      itemBuilder: (_, index) {
        return _card(state.filteredUsers[index]);
      },
    );
  }

  Widget _card(User user) => Card(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    child: ListTile(
      leading: CircleAvatar(
        child: Text(
          user.firstName[0],
          style: AppTextStyles.smallText.copyWith(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        '${user.firstName} ${user.lastName}',
        style: AppTextStyles.smallText.copyWith(fontWeight: FontWeight.w600),
      ),
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: () {
        context.push(
          AppRoutes.userDetails,
          extra: UserDetailsRouteArguments(user),
        );
      },
    ),
  );
}
