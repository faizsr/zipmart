import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipmart/src/features/cart/domain/entities/cart_entity.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitial()) {
    on<AddToCartEvent>(_onAddToCartEvent);
  }

  final List<CartEntity> _cartItems = [];

  FutureOr<void> _onAddToCartEvent(
    AddToCartEvent event,
    Emitter<CartState> emit,
  ) {
    final existingIndex = _cartItems.indexWhere(
      (element) => element.product.id == event.product.id,
    );

    if (existingIndex >= 0) {
      if (event.quantity == 0) {
        _cartItems.removeAt(existingIndex);
      } else {
        _cartItems[existingIndex] = CartEntity(
          quantity: event.quantity,
          product: event.product,
        );
      }
    } else {
      final cart = CartEntity(quantity: event.quantity, product: event.product);
      _cartItems.add(cart);
    }

    emit(CartLoadedState(cartItems: List.from(_cartItems)));
  }
}
