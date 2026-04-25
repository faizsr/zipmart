import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:iconify_flutter/iconify_flutter.dart';
import 'package:iconify_flutter/icons/gg.dart';
import 'package:zipmart/src/core/constants/app_constants.dart';
import 'package:zipmart/src/core/constants/app_icons.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';
import 'package:zipmart/src/core/widgets/k_rich_text.dart';

class DashboardHeader extends StatefulWidget {
  const DashboardHeader({super.key});

  @override
  State<DashboardHeader> createState() => _DashboardHeaderState();
}

class _DashboardHeaderState extends State<DashboardHeader> {
  Color foregroundColor = AppColors.white;
  Color backgroundColor = AppColors.blue;
  String selectedCategory = 'All';

  void getColorFromWord(String word) {
    if (word == 'All') {
      foregroundColor = AppColors.white;
      backgroundColor = AppColors.blue;
    } else {
      int hash = word.hashCode;
      final hsl = HSLColor.fromAHSL(1.0, (hash % 360).toDouble(), 0.6, 0.5);
      final color = hsl.toColor();
      backgroundColor = getLightColor(color);
      foregroundColor = getDarkColor(color);
    }

    selectedCategory = word;
    setState(() {});
  }

  Color getLightColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness + 0.25).clamp(0.0, 1.0)).toColor();
  }

  Color getDarkColor(Color color) {
    final hsl = HSLColor.fromColor(color);
    return hsl.withLightness((hsl.lightness - 0.25).clamp(0.0, 1.0)).toColor();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return SliverAppBar(
      pinned: true,
      toolbarHeight: 140,
      expandedHeight: 200,
      backgroundColor: backgroundColor,
      foregroundColor: foregroundColor,
      flexibleSpace: FlexibleSpaceBar(
        expandedTitleScale: 1,
        background: AnimatedContainer(
          color: backgroundColor,
          duration: Durations.medium1,
          alignment: Alignment.topCenter,
          padding: EdgeInsets.fromLTRB(16, topPadding, 16, 0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '21 Min',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: foregroundColor,
                      fontSize: 20,
                    ),
                  ),
                  KRichText(
                    text1: 'To Home: ',
                    text2: 'Kozhikode, Kerala, India',
                    text1Style: Theme.of(
                      context,
                    ).textTheme.titleSmall?.copyWith(color: foregroundColor),
                    text2Style: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.copyWith(color: foregroundColor),
                  ),
                ],
              ),
              CircleAvatar(
                backgroundColor: foregroundColor,
                child: Icon(CupertinoIcons.person_fill, color: backgroundColor),
              ),
            ],
          ),
        ),
        titlePadding: EdgeInsets.all(0),
        title: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsetsGeometry.fromLTRB(16, 16, 16, 20),
              child: TextFormField(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: EdgeInsets.fromLTRB(12, 0, 12, 0),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  hintText: '''Search for "Men's Tshirt"''',
                  hintStyle: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: AppColors.grey),
                ),
              ),
            ),

            // category list
            SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(8, 0, 8, 16),
              scrollDirection: Axis.horizontal,
              child: Row(
                spacing: 16,
                children: [
                  buildCategoryCard(icon: Gg.shopping_bag, title: 'All'),
                  buildCategoryCard(
                    icon: AppIcons.electronics,
                    title: 'Electronics',
                  ),
                  buildCategoryCard(icon: AppIcons.jewelery, title: 'Jewelery'),
                  buildCategoryCard(
                    icon: AppIcons.mensFashion,
                    title: 'Mens Fashion',
                  ),
                  buildCategoryCard(
                    icon: AppIcons.womensFashion,
                    title: 'Womens Fashion',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryCard({required String icon, required String title}) {
    return GestureDetector(
      onTap: () => getColorFromWord(title),
      child: Container(
        constraints: BoxConstraints(minWidth: 56),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Iconify(
              icon,
              color: selectedCategory == title
                  ? foregroundColor
                  : foregroundColor.withValues(alpha: 0.7),
            ),
            vSpace2,
            Text(
              title,
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                color: selectedCategory == title
                    ? foregroundColor
                    : foregroundColor.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
