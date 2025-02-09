import 'package:clients/core/constants/assets.dart';
import 'package:clients/features/model/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.imageUrl,
    required this.size,
    required this.borderColor,
    required this.gender,
    required this.backgroundColor,
  });

  final String imageUrl;
  final double size;
  final Color borderColor;
  final Color backgroundColor;
  final Gender gender;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: borderColor, width: 2),
        color: backgroundColor,
      ),
      child: ClipOval(
        child: Image.network(
          imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Image.asset(
              gender == Gender.male
                  ? Assets.assetsBoyAvatar
                  : Assets.assetsGirlAvatar,
              width: 15.w,
              height: 15.w,
            );
          },
        ),
      ),
    );
  }
}
