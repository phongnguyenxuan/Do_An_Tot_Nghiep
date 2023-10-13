import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../configs/style_config.dart';
import '../../../models/card_model.dart';
import '../../../provider/app_state.dart';
import '../../../widget/custom_elevated_widget.dart';

class PlayCard extends StatelessWidget {
  const PlayCard({super.key, required this.id});
  final int id;

  @override
  Widget build(BuildContext context) {
    final CardModel model = context.read<AppState>().findPairPlayList[id];
    return Selector<AppState, Tuple2<bool,bool>>(
      selector: (ctx, state) => Tuple2(state.findPairPlayList[id].isFlipped, state.findPairPlayList[id].isVisible),
      builder: (ctx, value, _) {
        if(!value.item2) return const SizedBox();
        return AnimatedSwitcher(
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          duration: const Duration( milliseconds: 200,),
          transitionBuilder: (Widget child, Animation<double> animation) {
            final rotate = Tween(begin: pi, end: 0.0).animate(animation);
            return AnimatedBuilder(
              animation: rotate,
              child: child,
              builder: (BuildContext context,Widget? child) {
                return Transform(
                  transform: Matrix4.rotationY(min(rotate.value, pi / 2)),
                  transformHitTests: false,
                  alignment: Alignment.center,
                  child: child,
                );
              }
            );
          },
          child: value.item1 ? 
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.white,
              border: Border.all(color: kColorStroke, width: 2),
            ),
            child: Image.asset(
              model.imageUrl
            ),
          ) 
          : GestureDetector(
            onTap: () {
              if(value.item1) return;
              ctx.read<AppState>().onFlipCard(id);
            },
            child: CustomElevatedWidget(
              backGroundColor: Colors.white,
              shadowColor: const Color(0xFFE4C36A),
              elevation: 5,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(color: kColorStroke, width: 2),
              child: Container(),
            )
          ),
        );
      }
    );
  }
}