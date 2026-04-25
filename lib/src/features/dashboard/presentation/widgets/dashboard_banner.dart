import 'package:flutter/material.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/utils/responsive_helper.dart';

class DashboardBanner extends StatelessWidget {
  const DashboardBanner({super.key});

  @override
  Widget build(BuildContext context) {
    bool isPhone = ResponsiveHelper.isPhone(context);
    bool isTablet = ResponsiveHelper.isTablet(context);

    double h = ResponsiveHelper.getHeight(context);

    return SliverToBoxAdapter(
      child: MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          children: [
            SizedBox(
              height:
                  h *
                  (isPhone
                      ? 0.25
                      : isTablet
                      ? 0.4
                      : 0.7),
              child: CarouselView(
                itemSnapping: true,
                padding: const EdgeInsets.all(16),
                itemExtent: double.infinity,
                scrollDirection: Axis.horizontal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                children: List<Widget>.generate(3, (int index) {
                  return Container(color: AppColors.lightGrey);
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
