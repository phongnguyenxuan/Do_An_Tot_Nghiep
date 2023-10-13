import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/app_state.dart';

class AnimatedCard extends StatelessWidget {
  const AnimatedCard({super.key, required this.child, required this.alignment, required this.radians, required this.duration});
  final Widget child;
  final Alignment alignment;
  final double radians;
  final Duration duration;
  @override
  Widget build(context) {
    return Selector<AppState,bool>(
      selector: (ctx, state) => state.isFlip,
      builder: (ctx, value, _) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          duration: duration,
          transitionBuilder: (Widget child, Animation<double> animation) {
            final rotate = Tween(begin: pi, end: 0.0).animate(animation);
            return AnimatedBuilder(
              animation: rotate,
              child: child,
              builder: (context,Widget? child) {
                return Transform(
                  transform: Matrix4.rotationY(min(rotate.value, radians)),
                  transformHitTests: false,
                  alignment: alignment,
                  child: child,
                );
              }
            );
          },
          child: value
              ? Container(
                  key: const ValueKey<int>(1),
                  child: child,
                )
              : Container(
                  key: const ValueKey<int>(2),
                  child: child,
                ),
        ),
      ],
    );
      }
    );
  }
}