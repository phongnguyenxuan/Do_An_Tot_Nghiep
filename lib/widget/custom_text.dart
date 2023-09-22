// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../configs/style_config.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final double strokeWidth;
  final Color color;
  final Color? strokeColor;
  const CustomText({
    Key? key,
    required this.title, required this.fontSize, required this.strokeWidth, required this.color, this.strokeColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child: Stack(
          children: <Widget>[
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  foreground: Paint()
                    ..color = strokeColor != null ? strokeColor! : kColorStroke
                    ..style = PaintingStyle.stroke
                    ..strokeWidth = strokeWidth,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize.sp),
            ),
            Text(
              title,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: color,
                  fontWeight: FontWeight.w400,
                  fontSize: fontSize.sp),
            ),
          ],
        ),
    );
  }
}
