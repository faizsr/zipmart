part of 'cart_bloc.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

class CartLoadedState extends CartState {
  final List<CartEntity> cartItems;

  CartLoadedState({required this.cartItems});
}
