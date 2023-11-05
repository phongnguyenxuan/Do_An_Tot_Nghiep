import 'dart:async';
import 'package:flutter/material.dart';
import '../configs/style_config.dart';

class TimerWidget extends StatefulWidget {
  const TimerWidget({super.key, required this.onTimerEnd, this.reBuild = true, this.countTime = 0, required this.isSubmit});
  final VoidCallback onTimerEnd;
  final bool reBuild;
  final int countTime;
  final bool isSubmit;

  @override
  State<TimerWidget> createState() => _TimerWidgetState();
}

class _TimerWidgetState extends State<TimerWidget> {

  Timer?  _timer;
  late final int _totalTime = widget.countTime;
  late int _time;


  void initData() {
    _timer?.cancel();
    _time = _totalTime * 1000;
    _timer = Timer.periodic(
      const Duration(milliseconds: 1), 
      (timer) {
        if(!mounted) return;
        _time --;
        if(_time > 0) {
          setState(() {});
          widget.isSubmit ? _timer?.cancel() : null;
        } else {
          widget.onTimerEnd.call();
          _timer?.cancel();
        }
      }
    );
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  @override
  void didUpdateWidget(covariant TimerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.reBuild) {
      initData();
    }
  }

  @override
  void dispose() {
    super.dispose();
    _timer?.cancel();
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: LinearProgressIndicator(
        value: _time/(_totalTime * 1000),
        color: kColorOrange,
        backgroundColor: Colors.transparent,
        minHeight: 4,
      ),
    
    );
  }
}