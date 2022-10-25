import 'package:flutter/material.dart';
import '../../res/colors.dart';
import '../../res/dimen.dart';

class CustomText extends StatelessWidget {
  final String title;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final FontStyle fontStyle;
  final TextDecoration decoration;
  final TextOverflow? overflow;
  final int? maxLines;

  const CustomText({
    super.key,
    required this.title,
    this.color = AppColors.black,
    this.fontSize = AppDimen.size14,
    this.fontWeight = FontWeight.w400,
    this.textAlign = TextAlign.left,
    this.fontStyle = FontStyle.normal,
    this.decoration = TextDecoration.none,
    this.overflow,
    this.maxLines,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      textAlign: textAlign,
      style: TextStyle(
        color: color,
        fontSize: fontSize,
        fontWeight: fontWeight,
        fontStyle: fontStyle,
        decoration: decoration,
        overflow: overflow,
      ),
      maxLines: maxLines,
    );
  }
}
