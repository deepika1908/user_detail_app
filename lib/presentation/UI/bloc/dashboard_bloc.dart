import 'package:flutter_bloc/flutter_bloc.dart';

// BLoC: Events are actions sent from the dashboard screen.
abstract class DashboardEvent {}

class DashboardTabChanged extends DashboardEvent {
  DashboardTabChanged(this.index);

  final int index;
}

// BLoC: State stores the selected bottom navigation tab.
class DashboardState {
  const DashboardState({this.selectedIndex = 0});

  final int selectedIndex;
}

// BLoC: This class changes dashboard state when an event is added.
class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc() : super(const DashboardState()) {
    on<DashboardTabChanged>((event, emit) {
      emit(DashboardState(selectedIndex: event.index));
    });
  }
}
