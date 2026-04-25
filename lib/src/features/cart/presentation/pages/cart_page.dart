import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:zipmart/src/features/cart/presentation/widgets/cart_bill_detail_card.dart';
import 'package:zipmart/src/features/cart/presentation/widgets/cart_product_card.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf1f0f5),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: Icon(CupertinoIcons.arrow_left),
        ),
        title: Text('Cart', style: TextStyle(fontSize: 18)),
        titleSpacing: 0,
      ),

      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [_buildCartSummary(context), vSpace16, CartBillDetailCard()],
      ),

      bottomNavigationBar: _buildDeliveryBar(context),
    );
  }

  Widget _buildCartSummary(BuildContext context) {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        if (state is CartLoadedState) {
          return Container(
            padding: EdgeInsets.all(12),
            color: AppColors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '21 min',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '${state.cartItems.length} item',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),
                Divider(color: AppColors.lightGrey),
                vSpace8,

                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: state.cartItems.length,
                  separatorBuilder: (context, index) => vSpace12,
                  itemBuilder: (context, index) {
                    return CartProductCard(cartItem: state.cartItems[index]);
                  },
                ),
              ],
            ),
          );
        }
        return SizedBox();
      },
    );
  }

  Widget _buildDeliveryBar(BuildContext context) {
    return Container(
      color: AppColors.white,
      padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Deliver to:', style: Theme.of(context).textTheme.titleMedium),
          Text(
            'Kozhikode, Kerala, India',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          vSpace12,
          KFilledButton(text: 'Proceed to Pay', onPressed: () {}),
        ],
      ),
    );
  }
}
