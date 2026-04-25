import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/ep.dart';
import 'package:zipmart/src/config/router/app_routes.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/features/cart/domain/entities/cart_entity.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';

class FloatingCartBanner extends StatelessWidget {
  const FloatingCartBanner({super.key});

  double _calculateItemTotal(List<CartEntity> cartItems) {
    return cartItems.fold(0.0, (total, item) {
      return total + (item.product.price * item.quantity);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        double totalPrice = 0;
        final hasItems = state is CartLoadedState && state.cartItems.isNotEmpty;

        if (state is CartLoadedState) {
          final itemTotal = _calculateItemTotal(state.cartItems);
          final deliveryFee = 50.0;
          totalPrice = itemTotal + deliveryFee;
        }

        return AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          reverseDuration: Duration(milliseconds: 300),
          switchInCurve: Curves.elasticOut,
          switchOutCurve: Curves.easeInBack,
          transitionBuilder: (child, animation) {
            return ScaleTransition(
              scale: animation,
              child: FadeTransition(opacity: animation, child: child),
            );
          },
          child: hasItems
              ? GestureDetector(
                  key: ValueKey('cart_button_visible'),
                  onTap: () => context.push(AppRoutes.cart),
                  child: Container(
                    margin: EdgeInsets.fromLTRB(16, 16, 16, 24),
                    padding: EdgeInsets.fromLTRB(12, 8, 12, 8),
                    decoration: BoxDecoration(
                      color: AppColors.blue,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(height: 36, width: 1, color: AppColors.white),
                        hSpace8,
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Your Cart',
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.lightGrey),
                            ),
                            Text(
                              '${state.cartItems.length} item  - ₹$totalPrice',
                              style: Theme.of(context).textTheme.titleSmall
                                  ?.copyWith(color: AppColors.white),
                            ),
                          ],
                        ),
                        Spacer(),
                        Iconify(Ep.right, color: AppColors.white),
                      ],
                    ),
                  ),
                )
              : SizedBox(key: ValueKey('cart_button_hidden')),
        );
      },
    );
  }
}
