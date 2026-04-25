import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipmart/src/core/network/network_response.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';
import 'package:zipmart/src/features/dashboard/domain/usecases/fetch_categories_usecase.dart';
import 'package:zipmart/src/features/dashboard/domain/usecases/fetch_products_usecase.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final FetchProductsUsecase fetchProductsUsecase;
  final FetchCategoriesUsecase fetchCategoriesUsecase;

  List<ProductEntity> _products = [];
  List<String> _categories = [];

  DashboardBloc({
    required this.fetchProductsUsecase,
    required this.fetchCategoriesUsecase,
  }) : super(DashboardInitial()) {
    on<FetchProductsEvent>(_onFetchProductsEvent);
    on<FetchCategoriesEvent>(_onFetchCategoriesEvent);
  }

  FutureOr<void> _onFetchProductsEvent(
    FetchProductsEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final response = await fetchProductsUsecase.call();
      if (response.type == NetworkResponseType.success) {
        _products = response.data ?? [];
        emit(DashboardLoaded(categories: _categories, products: _products));
      } else {
        emit(DashboardFailed());
      }
    } catch (e) {
      emit(DashboardFailed());
    }
  }

  FutureOr<void> _onFetchCategoriesEvent(
    FetchCategoriesEvent event,
    Emitter<DashboardState> emit,
  ) async {
    emit(DashboardLoading());
    try {
      final response = await fetchCategoriesUsecase.call();
      if (response.type == NetworkResponseType.success) {
        _categories = response.data ?? [];
        emit(DashboardLoaded(categories: _categories, products: _products));
      } else {
        emit(DashboardFailed());
      }
    } catch (e) {
      emit(DashboardFailed());
    }
  }
}
