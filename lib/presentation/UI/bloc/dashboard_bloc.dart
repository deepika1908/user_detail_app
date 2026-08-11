import 'package:flutter_bloc/flutter_bloc.dart';

abstract class DashboardEvent {}

class DashboardTabChanged extends DashboardEvent {
  DashboardTabChanged(this.index);

  final int index;
}

class DashboardState {
  const DashboardState({this.selectedIndex = 0});

  final int selectedIndex;
}

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardTabChanged>((event, emit) {
      emit(DashboardState(selectedIndex: event.index));
    });
  }
}
