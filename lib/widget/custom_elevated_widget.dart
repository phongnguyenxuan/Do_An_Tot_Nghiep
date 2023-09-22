import 'package:flutter/material.dart';

class CustomElevatedWidget extends StatelessWidget {
  const CustomElevatedWidget({
    super.key, 
    required this.backGroundColor, 
    required this.shadowColor, 
    required this.elevation,
    required this.child,
    this.padding,
    this.borderRadius, 
    this.border,
    this.revert = false, 
    this.margin,
  });

  final Color backGroundColor;
  final Color shadowColor;
  final double elevation;
  final BorderRadiusGeometry? borderRadius;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final bool revert;
  final BoxBorder? border;
  final EdgeInsetsGeometry? margin;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding:revert ? EdgeInsets.only(top: elevation) : EdgeInsets.only(bottom: elevation),
      margin: margin,
      decoration: BoxDecoration(
        color: shadowColor,
        borderRadius: borderRadius,
        border: border
      ),
      clipBehavior: Clip.antiAlias,
      child: Container(
        padding: padding?.add(EdgeInsets.only(top: elevation)),
        decoration: BoxDecoration(
          color: backGroundColor,
          borderRadius: borderRadius
        ),
        child: child,
      ),
    );
  }
}