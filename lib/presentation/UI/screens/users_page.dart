import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/extensions/context_extension.dart';
import '../../../core/routes/app_routes.dart';
import '../../../core/styles/screen_text_styles.dart';
import '../../../core/theme/app_input_decorator.dart';
import '../../../localization/app_string.dart';
import '../../../models/user.dart';
import '../bloc/users/users_bloc.dart';
import '../bloc/users/users_event.dart';
import '../bloc/users/users_state.dart';

class UsersPage extends StatefulWidget { const UsersPage({super.key}); @override State<UsersPage> createState() => _UsersPageState(); }
class _UsersPageState extends State<UsersPage> {
  final _search = TextEditingController();
  @override void dispose() { _search.dispose(); super.dispose(); }
  @override Widget build(BuildContext context) => BlocProvider(
    create: (_) => UsersBloc()..add(const UsersRequested()),
    child: BlocBuilder<UsersBloc, UsersState>(builder: (blocContext, state) => Column(children: [
      Padding(padding: const EdgeInsets.all(16), child: TextField(controller: _search, onChanged: (value) => blocContext.read<UsersBloc>().add(UserSearchChanged(value)), decoration: AppInputDecoration.textField(hintText: AppContext(blocContext).language.text(AppStringKeys.searchUsers), icon: Icons.search))),
      Expanded(child: _body(state)),
    ])),
  );
  Widget _body(UsersState state) {
    if (state.status == UsersStatus.initial || state.status == UsersStatus.loading) return const Center(child: CircularProgressIndicator());
    if (state.status == UsersStatus.failure) return Center(child: Text('${AppContext(context).language.text(AppStringKeys.error)}: ${state.errorMessage}'));
    return ListView.builder(itemCount: state.filteredUsers.length, itemBuilder: (_, index) => _card(state.filteredUsers[index]));
  }
  Widget _card(User user) => Card(margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8), child: ListTile(leading: CircleAvatar(child: Text(user.firstName[0], style: ScreenTextStyles.userInitial)), title: Text('${user.firstName} ${user.lastName}', style: ScreenTextStyles.detailValue), trailing: const Icon(Icons.arrow_forward_ios), onTap: () => Navigator.pushNamed(context, AppRoutes.userDetails, arguments: UserDetailsRouteArguments(user))));
}
