import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/line_md.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/widgets/k_filled_button.dart';

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
        children: [
          Container(
            padding: EdgeInsets.all(12),
            color: AppColors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '18 min',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      '3 item',
                      style: Theme.of(
                        context,
                      ).textTheme.bodySmall?.copyWith(color: AppColors.grey),
                    ),
                  ],
                ),

                Divider(color: AppColors.lightGrey),
                vSpace8,

                // product cart
                buildProductTile(context),
                vSpace12,
                buildProductTile(context),
                vSpace12,
                buildProductTile(context),
              ],
            ),
          ),

          vSpace16,

          // Bill details
          Container(
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

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Item Total',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                    Text(
                      '\$180',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
                vSpace4,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery fee',
                      style: Theme.of(
                        context,
                      ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                    ),
                    Text('\$5', style: Theme.of(context).textTheme.titleMedium),
                  ],
                ),

                Divider(color: AppColors.lightGrey),
                vSpace4,

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'To Pay',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '\$185',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),

      bottomNavigationBar: Container(
        color: AppColors.white,
        padding: EdgeInsets.fromLTRB(16, 16, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Deliver to:', style: Theme.of(context).textTheme.titleMedium),
            Text(
              'Kozhikode, Kerala, India:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            vSpace12,
            KFilledButton(text: 'Proceed to Pay', onPressed: () {}),
          ],
        ),
      ),
    );
  }

  Row buildProductTile(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        hSpace8,
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Product title',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text('\$60.0', style: Theme.of(context).textTheme.titleMedium),
          ],
        ),
        Spacer(),
        Container(
          height: 26,
          decoration: BoxDecoration(
            color: AppColors.lightGrey,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Iconify(LineMd.minus, size: 16),
              ),
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  color: AppColors.white,
                  alignment: Alignment.center,
                  margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
                  child: Text('1'),
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                child: Iconify(LineMd.plus, size: 16),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
