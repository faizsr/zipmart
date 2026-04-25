import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa_solid.dart';
import 'package:iconify_flutter/icons/line_md.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/responsive_helper.dart';
import 'package:zipmart/src/core/widgets/k_rich_text.dart';
import 'package:zipmart/src/features/cart/domain/entities/cart_entity.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';

class DashboardProductCard extends StatelessWidget {
  const DashboardProductCard({super.key, required this.product});

  final ProductEntity product;

  void onUpdateCartQuantity(int quantity, BuildContext context) {
    context.read<CartBloc>().add(
      AddToCartEvent(product: product, quantity: quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isPhone = ResponsiveHelper.isPhone(context);
    bool isTablet = ResponsiveHelper.isTablet(context);

    double w = ResponsiveHelper.getWidth(context);

    return Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.only(left: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.lightGrey),
      ),
      width:
          (w /
              (isPhone
                  ? 2
                  : isTablet
                  ? 4
                  : 6)) -
          24,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AspectRatio(
            aspectRatio: 1,

            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: product.image,
                placeholder: (context, url) =>
                    Container(color: AppColors.lightGrey),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),
          vSpace12,
          Text(
            product.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontSize: 18),
          ),
          Row(
            children: [
              Iconify(FaSolid.star, size: 14, color: Color(0xffFDCC0D)),
              hSpace4,
              Text(
                '${product.ratingRate} (${product.ratingCount})',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          vSpace2,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KRichText(
                text1: '₹',
                text2: '${product.price}',
                text1Style: Theme.of(context).textTheme.titleSmall,
                text2Style: TextStyle(fontSize: 20, color: AppColors.black),
              ),

              // button to update product quantity in cart
              buildCartQuantityAdjuster(),
            ],
          ),
        ],
      ),
    );
  }

  BlocBuilder<CartBloc, CartState> buildCartQuantityAdjuster() {
    return BlocBuilder<CartBloc, CartState>(
      builder: (context, state) {
        CartEntity? cartItem;
        if (state is CartLoadedState) {
          final index = state.cartItems.indexWhere(
            (c) => c.product.id == product.id,
          );
          if (index >= 0) cartItem = state.cartItems[index];
        }

        return Container(
          height: 26,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              if (state is CartLoadedState && cartItem != null) ...[
                GestureDetector(
                  onTap: () {
                    onUpdateCartQuantity(cartItem!.quantity - 1, context);
                  },
                  child: Container(
                    padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: Iconify(LineMd.minus, size: 16),
                  ),
                ),
                AspectRatio(
                  aspectRatio: 1,
                  child: Container(
                    color: AppColors.white,
                    alignment: Alignment.center,
                    margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    child: Text('${cartItem.quantity}'),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    onUpdateCartQuantity(cartItem!.quantity + 1, context);
                  },
                  child: Container(
                    color: AppColors.transparent,
                    padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: Iconify(LineMd.plus, size: 16),
                  ),
                ),
              ] else ...[
                GestureDetector(
                  onTap: () => onUpdateCartQuantity(1, context),
                  child: Container(
                    color: AppColors.transparent,
                    padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                    child: Iconify(LineMd.plus, size: 16),
                  ),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
