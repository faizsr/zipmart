import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/fa_solid.dart';
import 'package:iconify_flutter/icons/line_md.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/responsive_helper.dart';
import 'package:zipmart/src/core/widgets/k_rich_text.dart';
import 'package:zipmart/src/features/dashboard/domain/entities/product_entity.dart';

class DashboardProductCard extends StatelessWidget {
  const DashboardProductCard({super.key, required this.product});

  final ProductEntity product;

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
              child: Image(image: NetworkImage(product.image)),
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
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              KRichText(
                text1: '\$',
                text2: '${product.price}',
                text1Style: Theme.of(context).textTheme.titleMedium,
                text2Style: TextStyle(fontSize: 20, color: AppColors.black),
              ),

              Container(
                height: 26,
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    // Container(
                    //   padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                    //   child: Iconify(LineMd.minus, size: 16),
                    // ),
                    // AspectRatio(
                    //   aspectRatio: 1,
                    //   child: Container(
                    //     color: AppColors.white,
                    //     alignment: Alignment.center,
                    //     margin: EdgeInsets.fromLTRB(0, 2, 0, 2),
                    //     child: Text('1'),
                    //   ),
                    // ),
                    Container(
                      padding: EdgeInsets.fromLTRB(6, 0, 6, 0),
                      child: Iconify(LineMd.plus, size: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
