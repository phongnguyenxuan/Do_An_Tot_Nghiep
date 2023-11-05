import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../configs/style_config.dart';
import '../../../models/questions_model.dart';
import '../../../provider/app_state.dart';
import '../../../widget/custom_button.dart';

class MathPlayWidget extends StatefulWidget {
  const MathPlayWidget({
    super.key,
    required this.index,
    required this.question,
    required this.onPlayCorrect,
  });

  final int index;
  final QuestionModel question;
  final Function(bool isCorrect, int result) onPlayCorrect;

  @override
  State<MathPlayWidget> createState() => _MathPlayWidget();
}

class _MathPlayWidget extends State<MathPlayWidget>
    with SingleTickerProviderStateMixin {
  final List<int> _inCorrectAnswer = [];
  late List<int> _listAnswer;
  bool _isAnswerCorrect = false;
  bool _isAnswerInCorrect = false;
  Timer? timer;
  int streak = 0;
  int score = 0;

  void _onPickAnswer(int answer) {
    if (_isAnswerCorrect) return;
    if (answer == widget.question.result) {
      setState(() {
        _isAnswerCorrect = true;
      });
      Future.delayed(const Duration(milliseconds: 300))
          .then((value) => widget.onPlayCorrect.call(true, answer));
    } else {
      if (_isAnswerInCorrect) {
        setState(() {
          _isAnswerCorrect = false;
        });
      }
      widget.onPlayCorrect.call(false, answer);
      _isAnswerInCorrect = true;
      if (timer?.isActive ?? false) timer?.cancel();
      setState(() {});
      timer = Timer(const Duration(milliseconds: 300), () {
        if (!mounted) return;
        setState(() {
          _isAnswerInCorrect = false;
        });
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _listAnswer = context.read<AppState>().generateListAnswer(widget.index);
  }

  @override
  void didUpdateWidget(covariant MathPlayWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    _inCorrectAnswer.clear();
    _listAnswer = context.read<AppState>().generateListAnswer(widget.index);
    _isAnswerCorrect = false;
  }

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          child: Container(
            width: double.maxFinite,
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: const Color(0xFFdc9668),
              border: Border.all(color: kColorBlack, width: 2),
              borderRadius: BorderRadius.circular(15)
            ),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutExpo,
              width: double.maxFinite,
              padding: const EdgeInsets.all(50),
              decoration: BoxDecoration(
                border: Border.all(color: kColorBlack, width: 2),
                  color: _isAnswerCorrect
                      ? kColorGreen
                      : _isAnswerInCorrect
                          ? kColorRed
                          : kButtonColor,
                  borderRadius: BorderRadius.circular(15)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "${widget.question.firstNumber} ",
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: kColorBlack),
                  ),
                  Text(
                    widget.question.math,
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: kColorBlack),
                  ),
                  Text(
                    " ${widget.question.secondNumber} = ",
                    style: TextStyle(
                        fontSize: 30.sp,
                        fontWeight: FontWeight.bold,
                        color: kColorBlack),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: _isAnswerCorrect ? 0 : 8,
                        vertical: _isAnswerCorrect ? 5.5 : 8),
                    height: 46.sp,
                    decoration: _isAnswerCorrect
                        ? null
                        : BoxDecoration(
                            color: kColorWhite,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: kDisableColor)),
                    child: _isAnswerCorrect
                        ? Text(
                            widget.question.result.toString(),
                            style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                color: kColorBlack),
                          )
                        : Icon(
                            Icons.question_mark,
                            color: kBorderColor,
                            size: 30.sp,
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 0,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                mainAxisSpacing: 10,
                crossAxisSpacing: 20,
                childAspectRatio: 159 / 119,
                children: _listAnswer
                    .map((e) => CustomButton(
                        onPress: () => _onPickAnswer(e),
                        borderRadius: BorderRadius.circular(16),
                        buttonBorder:
                            Border.all(color: kColorBlack, width: 2),
                        color: _inCorrectAnswer.contains(e)
                            ? kColorRed
                            : _isAnswerCorrect && e == widget.question.result
                                ? kColorGreen
                                : kColorWhite,
                        shadowColor: _inCorrectAnswer.contains(e)
                            ? kShadowRed
                            : _isAnswerCorrect && e == widget.question.result
                                ? kShadowGreen
                                : kShadowColor2,
                        child: Center(
                          child: Text(
                            e.toString(),
                            style: TextStyle(
                                color: _isAnswerCorrect && e == widget.question.result
                                    ? kColorWhite
                                    : kColorBlack,
                                fontSize: 26.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        )))
                    .toList(),
              ),
            ],
          ),
        )
      ],
    );
  }
}