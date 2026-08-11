import 'package:flutter_bloc/flutter_bloc.dart';

abstract class UsersEvent {}

class UserSearchChanged extends UsersEvent {
  UserSearchChanged(this.searchText);

  final String searchText;
}

class UsersState {
  const UsersState({this.searchText = ''});

  final String searchText;
}

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc() : super(const UsersState()) {
    on<UserSearchChanged>((event, emit) {
      emit(UsersState(searchText: event.searchText));
    });
  }
}
