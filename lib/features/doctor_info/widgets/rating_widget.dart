import 'package:clients/core/constants/assets.dart';
import 'package:clients/core/theme/text_styles.dart';
import 'package:clients/core/utils/extensions/context_theme_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class RatingWidget extends StatefulWidget {
  RatingWidget({super.key, required this.ratingValue});

  double ratingValue;

  @override
  State<RatingWidget> createState() => _RatingWidgetState();
}

class _RatingWidgetState extends State<RatingWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsetsDirectional.only(end: 8.w),
          child: Text(
            "${widget.ratingValue}",
            style: TextStyles.size14Weight400.copyWith(
              color: context.colors.grayColor,
            ),
          ),
        ),
        RatingBar.builder(
          initialRating: widget.ratingValue,
          itemSize: 16.r,
          unratedColor: context.colors.unRatedStarColor,
          textDirection: TextDirection.ltr,
          allowHalfRating: true,
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.w),
          itemBuilder: (context, _) => SvgPicture.asset(
            Assets.assetsStarIcon,
            color: context.colors.yellowStarColor,
          ),
          onRatingUpdate: (rating) {
            setState(() {
              widget.ratingValue = rating;
            });
          },
        ),
      ],
    );
  }
}
