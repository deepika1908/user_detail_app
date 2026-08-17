sealed class DashboardEvent {
  const DashboardEvent();
}

final class DashboardTabChanged extends DashboardEvent {
  const DashboardTabChanged(this.index);

  final int index;
}
