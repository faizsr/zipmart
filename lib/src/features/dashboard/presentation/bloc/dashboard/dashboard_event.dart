part of 'dashboard_bloc.dart';

@immutable
sealed class DashboardEvent {}

class FetchProductsEvent extends DashboardEvent {}

class FetchCategoriesEvent extends DashboardEvent {}
