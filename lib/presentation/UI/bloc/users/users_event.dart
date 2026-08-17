sealed class UsersEvent {
  const UsersEvent();
}

final class UsersRequested extends UsersEvent {
  const UsersRequested();
}

final class UserSearchChanged extends UsersEvent {
  const UserSearchChanged(this.searchText);

  final String searchText;
}
