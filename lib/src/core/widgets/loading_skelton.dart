import 'package:flutter/material.dart';
import 'package:zipmart/src/core/styles/app_colors.dart';

class LoadingSkelton extends StatelessWidget {
  const LoadingSkelton({
    super.key,
    this.height,
    this.width,
    this.color,
    this.shape = BoxShape.rectangle,
  });

  final double? height, width;
  final Color? color;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 10,
      width: width,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: shape == BoxShape.circle
            ? BorderRadius.circular(200)
            : BorderRadius.circular(10),
      ),
    );
  }
}
