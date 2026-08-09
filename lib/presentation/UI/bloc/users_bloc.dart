import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC: Events are actions sent from the users screen.
abstract class UsersEvent {}

class UserSearchChanged extends UsersEvent {
  UserSearchChanged(this.searchText);

  final String searchText;
}

// BLoC: State stores the current user search text.
class UsersState {
  const UsersState({this.searchText = ''});

  final String searchText;
}

// BLoC: This class changes search state when an event is added.
class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<UserSearchChanged>((event, emit) {
      emit(UsersState(searchText: event.searchText));
    });
  }
}
