import 'package:cached_network_image/cached_network_image.dart';
import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:clients/core/widgets/shimmers/circle_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomAvatar extends StatelessWidget {
  const CustomAvatar({
    super.key,
    required this.imageUrl,
    required this.radius,
    this.shape = BoxShape.circle,
  });

  final String? imageUrl;
  final double radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final double size = radius * 2;

    Widget avatarContent = (imageUrl == null || imageUrl!.isEmpty)
        ? SvgPicture.asset(
            Assets.assetsSvgSukonWBlueBackground,
            fit: BoxFit.cover,
            width: size,
            height: size,
          )
        : CachedNetworkImage(
            imageUrl: imageUrl!,
            cacheKey: imageUrl,
            fit: BoxFit.cover,
            width: size,
            height: size,
            progressIndicatorBuilder: (context, child, loadingProgress) {
              return CircleShimmer(size: size);
            },
            errorWidget: (context, error, stackTrace) {
              return SvgPicture.asset(
                Assets.assetsSvgSukonWBlueBackground,
                fit: BoxFit.cover,
                width: size,
                height: size,
              );
            },
          );

    if (shape == BoxShape.circle) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: context.colors.borderColor,
        child: ClipOval(child: avatarContent),
      );
    } else {
      return Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: context.colors.borderColor,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(8.r),
        ),
        clipBehavior: Clip.hardEdge,
        child: avatarContent,
      );
    }
  }
}
