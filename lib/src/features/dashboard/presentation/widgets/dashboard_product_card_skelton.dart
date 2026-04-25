import 'package:flutter/material.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/responsive_helper.dart';
import 'package:zipmart/src/core/widgets/loading_skelton.dart';

class DashboardProductCardSkelton extends StatelessWidget {
  const DashboardProductCardSkelton({super.key});

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
            ),
          ),
          vSpace12,
          LoadingSkelton(),
          vSpace12,
          LoadingSkelton(width: w * 0.1),
          vSpace12,
          LoadingSkelton(width: w * 0.2),
        ],
      ),
    );
  }
}
