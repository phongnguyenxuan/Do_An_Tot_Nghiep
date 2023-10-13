import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../configs/style_config.dart';
import '../../widget/custom_text.dart';

class ScoreOverlay extends StatefulWidget {
  const ScoreOverlay(
      {super.key,
      required this.score,
      required this.streak,
      required this.bonus});
  final int score;
  final int streak;
  final int bonus;
  @override
  State<ScoreOverlay> createState() => _ScoreOverlayState();
}

class _ScoreOverlayState extends State<ScoreOverlay> {
  int _score = 0;
  double _opacity = 0;
  double dy = 0;
  Timer? _timer;
  @override
  void didUpdateWidget(covariant ScoreOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.score < widget.score) {
      _timer?.cancel();
      _opacity = 1;
      dy = -0.75;
      if (widget.streak > 1) {
        _score = 10 + (widget.streak - 1) * 5;
      }
      if (widget.streak > 5) {
        _score = 10 + (5 - 1) * 5;
      } else if (widget.bonus > 0) {
        _score = widget.bonus;
      } else {
        _score = 10;
      }
      _timer = Timer(const Duration(milliseconds: 900), () {
        if (!mounted) return;
        setState(() {
          _opacity = 0;
          dy = 0;
        });
      });
      // Future.delayed(const Duration(milliseconds: 500));
      //   setState(() {
      //   dy = 0;
      // });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Visibility(
        visible: widget.score > 0,
        child: AnimatedOpacity(
          opacity: _opacity,
          curve: Curves.easeIn,
          duration: const Duration(milliseconds: 500),
          child: AnimatedAlign(
            curve: Curves.easeInOutSine,
            alignment: Alignment(0, dy),
            duration: const Duration(milliseconds: 400),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Visibility(
                  visible: (widget.streak > 1 || widget.bonus != 0),
                  child: CustomText(
                    title: widget.bonus != 0 ? "Bounus" : widget.streak > 5 ? "x5" : "x${widget.streak}",
                    fontSize: 35.sp,
                    strokeWidth: 3,
                    strokeColor: kColorOrange,
                    color: const Color(0xFF836B41),
                  ),
                ),
                CustomText(
                  title: "+ $_score",
                  fontSize: 30.sp,
                  strokeWidth: 2,
                  color: const Color(0xFFFFBA00),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
