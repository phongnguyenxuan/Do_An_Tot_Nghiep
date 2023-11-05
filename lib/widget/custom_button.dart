import 'package:flutter/material.dart';

import '../configs/style_config.dart';

class CustomButton extends StatefulWidget {
  const CustomButton({
    this.onPress,
    required this.child,
    this.color = kColorPrimary,
    this.minWidth = 0,
    this.minHeight = 0,
    this.shadowColor = Colors.grey,
    this.elevation = 5,
    this.enabled = true,
    this.borderRadius,
    this.buttonBorder,
    super.key,
    this.padding,
    this.width,
    this.height, this.margin,
  });

  final VoidCallback? onPress;
  final Widget child;
  final Color color;
  final Color shadowColor;
  final double minWidth;
  final double minHeight;
  final double elevation;
  final bool enabled;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? buttonBorder;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {

  bool _onButtonTapDown = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (details) {
        setState(() {
          _onButtonTapDown = true;
        });
      },
      onTapUp: (details) async {
        widget.onPress?.call();
        
        await Future.delayed(const Duration(milliseconds: 100), () {
          _onButtonTapDown = false;
          if(!mounted) return;
          setState(() {});
        });
      },
      onTapCancel: () {
        setState(() {
          _onButtonTapDown = false;
        });
      },
      child: Padding(
        padding: widget.margin ?? EdgeInsets.zero,
        child: Container(
          margin: _onButtonTapDown || !widget.enabled ? EdgeInsets.only(top: widget.elevation) : null,
          padding: _onButtonTapDown || !widget.enabled ?  
            null : 
            EdgeInsets.only(bottom: widget.elevation,),
          decoration: BoxDecoration(
            color: _onButtonTapDown || !widget.enabled ? widget.color : widget.shadowColor,
            borderRadius: widget.borderRadius,
            border: widget.buttonBorder
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            padding: widget.padding,
            width: widget.width,
            height: widget.height,
            constraints: BoxConstraints(
              minWidth: widget.minWidth,
              minHeight: widget.minHeight,
            ),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: widget.color,
              borderRadius: widget.borderRadius
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.child
              ],
            ),
          ),
        ),
      ),
    );
  }
}