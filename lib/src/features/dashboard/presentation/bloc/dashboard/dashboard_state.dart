part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardState {}

final class DashboardInitial extends DashboardState {}

class DashboardLoading extends DashboardState {}

class DashboardLoaded extends DashboardState {
  final List<String> categories;
  final List<ProductEntity> products;

  DashboardLoaded({required this.categories, required this.products});
}

class DashboardFailed extends DashboardState {}
