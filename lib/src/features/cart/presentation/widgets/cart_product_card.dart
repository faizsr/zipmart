import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/line_md.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/features/cart/domain/entities/cart_entity.dart';
import 'package:zipmart/src/features/cart/presentation/bloc/cart/cart_bloc.dart';

class CartProductCard extends StatelessWidget {
  const CartProductCard({super.key, required this.cartItem});

  final CartEntity cartItem;

  void onUpdateCartQuantity(int quantity, BuildContext context) {
    context.read<CartBloc>().add(
      AddToCartEvent(product: cartItem.product, quantity: quantity),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          padding: EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: CachedNetworkImage(
            imageUrl: cartItem.product.image,
            placeholder: (context, url) =>
                Container(color: AppColors.lightGrey),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        hSpace8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                cartItem.product.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              vSpace4,
              Text(
                '\$${cartItem.product.price}',
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ],
          ),
        ),
        hSpace20,
        _buildQuantityAdjuster(context),
      ],
    );
  }

  Widget _buildQuantityAdjuster(BuildContext context) {
    return Container(
      height: 28,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              onUpdateCartQuantity(cartItem.quantity - 1, context);
            },
            child: Container(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
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
              onUpdateCartQuantity(cartItem.quantity + 1, context);
            },
            child: Container(
              color: AppColors.transparent,
              padding: EdgeInsets.fromLTRB(8, 0, 8, 0),
              child: Iconify(LineMd.plus, size: 16),
            ),
          ),
        ],
      ),
    );
  }
}
