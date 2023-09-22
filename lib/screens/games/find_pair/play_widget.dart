import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';

import '../../../models/card_model.dart';
import '../../../provider/app_state.dart';
import 'play_card.dart';

class PlayWidget extends StatefulWidget {
  const PlayWidget({super.key});

  @override
  State<PlayWidget> createState() => _PlayWidgetState();
}

class _PlayWidgetState extends State<PlayWidget> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:  EdgeInsets.symmetric(horizontal: 5.w,vertical: 15.h),
      child: Selector<AppState, Tuple3<int,int, List<CardModel>>>(
        selector: (ctx, state) => Tuple3(state.colCount, state.rowCount, state.findPairPlayList),
        builder: (context, value, _) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              value.item1, 
              (colIndex) => Flexible(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 12.w * 2 / value.item1),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      value.item2, 
                      (rowIndex) => Flexible(
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 12.w * 2 / value.item1),
                          child: AspectRatio(
                            aspectRatio:  1 / 1,
                            child: 
                            PlayCard(
                              id: rowIndex * value.item1 + colIndex,
                            ),
                          ),
                        ),
                      )
                    ),
                  ),
                ),
              )
            ),
          );
        }
      ),
    );
  }
}