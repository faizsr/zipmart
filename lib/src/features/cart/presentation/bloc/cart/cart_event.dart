part of 'cart_bloc.dart';

@immutable
sealed class CartEvent {}

class AddToCartEvent extends CartEvent {
  final ProductEntity product;
  final int quantity;

  AddToCartEvent({required this.product, required this.quantity});
}
