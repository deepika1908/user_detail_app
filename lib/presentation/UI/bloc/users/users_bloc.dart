import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/service/api_service.dart';
import 'users_event.dart';
import 'users_state.dart';

class UsersBloc extends Bloc<UsersEvent, UsersState> {
  UsersBloc({ApiService? apiService}) : _apiService = apiService ?? ApiService(), super(const UsersState()) {
    on<UsersRequested>(_onUsersRequested);
    on<UserSearchChanged>((event, emit) => emit(state.copyWith(searchText: event.searchText)));
  }

  final ApiService _apiService;

  Future<void> _onUsersRequested(UsersRequested event, Emitter<UsersState> emit) async {
    emit(state.copyWith(status: UsersStatus.loading));
    try {
      final users = await _apiService.fetchUsers();
      emit(state.copyWith(status: UsersStatus.success, users: users));
    } catch (_) {
      emit(state.copyWith(status: UsersStatus.failure, errorMessage: 'Could not load users'));
    }
  }
}
