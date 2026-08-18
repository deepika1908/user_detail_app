import '../../../../models/user.dart';

enum UsersStatus {
  initial,
  loading,
  success,
  failure,
}

class UsersState {
  const UsersState({
    this.status = UsersStatus.initial,
    this.users = const [],
    this.searchText = '',
    this.errorMessage,
  });

  final UsersStatus status;
  final List<User> users;
  final String searchText;
  final String? errorMessage;

  List<User> get filteredUsers {
    final query = searchText.trim().toLowerCase();

    if (query.isEmpty) {
      return users;
    }

    return users
        .where(
          (user) => '${user.firstName} ${user.lastName}'
              .toLowerCase()
              .contains(query),
        )
        .toList();
  }

  UsersState copyWith({
    UsersStatus? status,
    List<User>? users,
    String? searchText,
    String? errorMessage,
  }) {
    return UsersState(
      status: status ?? this.status,
      users: users ?? this.users,
      searchText: searchText ?? this.searchText,
      errorMessage: errorMessage,
    );
  }
}