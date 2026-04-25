import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/features/cart/domain/entities/cart_entity.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';

class CartBillDetailCard extends StatelessWidget {
  const CartBillDetailCard({super.key});

  double _calculateItemTotal(List<CartEntity> cartItems) {
    return cartItems.fold(0.0, (total, item) {
      return total + (item.product.price * item.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          final itemTotal = _calculateItemTotal(state.cartItems);
          final deliveryFee = 5.0;
          final totalToPay = itemTotal + deliveryFee;

          return Container(
            padding: EdgeInsets.all(12),
            color: AppColors.white,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bill Details',
                  style: Theme.of(context).textTheme.titleSmall,
                ),
                Divider(color: AppColors.lightGrey),
                vSpace4,
                _buildBillRow(
                  context,
                  'Item Total',
                  '₹${itemTotal.toStringAsFixed(2)}',
                ),
                vSpace4,
                _buildBillRow(
                  context,
                  'Delivery fee',
                  '₹${deliveryFee.toStringAsFixed(2)}',
                ),
                Divider(color: AppColors.lightGrey),
                vSpace4,
                _buildBillRow(
                  context,
                  'To Pay',
                  '₹${totalToPay.toStringAsFixed(2)}',
                  valueStyle: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _buildBillRow(
    BuildContext context,
    String label,
    String value, {
    TextStyle? valueStyle,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style:
              valueStyle ??
              Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
        ),
        Text(value, style: Theme.of(context).textTheme.titleMedium),
      ],
    );
  }
}
