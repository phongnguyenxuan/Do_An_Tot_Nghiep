import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:do_an_tot_nghiep/provider/app_state.dart';
import 'package:do_an_tot_nghiep/widget/custom_appbar.dart';
import 'package:do_an_tot_nghiep/widget/custom_button.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../configs/basic_config.dart';
import '../../configs/style_config.dart';

class StatusScreen extends StatefulWidget {
  const StatusScreen({Key? key}) : super(key: key);
  static const String id = "status screen";

  @override
  State<StatusScreen> createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
  List<int> totalScore = [];
  List<int> showingTooltipOnSpots = [];
  @override
  void initState() {
    totalScore = context.read<AppState>().listTotalScore;
    showingTooltipOnSpots =
        List<int>.generate(totalScore.length, (index) => index);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kColorWhite,
      appBar: CustomAppBar(title: translate.history),
      body: Builder(
        builder: (context) {
          if (totalScore.isEmpty) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                    child: Image.asset(
                  "assets/images/empty.png",
                  width: 150.w,
                )),
                SizedBox(
                  height: 15.h,
                ),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        text: "${translate.noRes}\n",
                        style: k25SizeBlackColorStyle,
                        children: [
                          TextSpan(
                              text: translate.couldntFind,
                              style: k15SizeW400BlackColorStyle)
                        ]))
              ],
            );
          }
          return mainBody(context);
        },
      ),
    );
  }

  SingleChildScrollView mainBody(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        children: [
          SizedBox(
            height: 100.h,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 45),
            child: AspectRatio(
                aspectRatio: 1.7,
                child: LineChart(
                  mainData(),
                  curve: Curves.fastLinearToSlowEaseIn,
                  duration: const Duration(milliseconds: 1000),
                )),
          ),
          SizedBox(
            height: 50.h,
          ),
          CustomButton(
            onPress: () {
              navigatorKey.currentState?.pop();
            },
            minHeight: 60.h,
            elevation: 5,
            borderRadius: BorderRadius.circular(16),
            color: Colors.white,
            shadowColor: kShadowColor2,
            minWidth: double.maxFinite,
            margin: const EdgeInsets.all(30),
            buttonBorder: Border.all(color: kBorderColor, width: 2),
            child: Text(translate.continuew, style: k18BlackTextStyle),
          ),
        ],
      ),
    );
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = knormalTextStyle;
    Widget text;
    if (value.toInt() == totalScore.length - 1) {
      text = Text(translate.currentw, style: style);
    } else {
      text = Text('${value.toInt() + 1}', style: style);
    }

    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 3,
      child: text,
    );
  }

  LineChartData mainData() {
    final lineBarsData = [
      LineChartBarData(
        spots: List<FlSpot>.generate(totalScore.length,
            (index) => FlSpot(index.toDouble(), totalScore[index].toDouble())),
        dashArray: [20, 10],
        isCurved: false,
        color: kColorPrimary,
        barWidth: 5,
        isStrokeCapRound: true,
        dotData: FlDotData(
          show: true,
          getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
              radius: 4,
              color: kColorPrimary,
              strokeWidth: 2,
              strokeColor: kColorStroke),
        ),
      ),
    ];

    final tooltipsOnBar = lineBarsData[0];

    return LineChartData(
        clipData: const FlClipData.none(),
        showingTooltipIndicators: showingTooltipOnSpots.map((index) {
          return ShowingTooltipIndicators([
            LineBarSpot(
              tooltipsOnBar,
              lineBarsData.indexOf(tooltipsOnBar),
              tooltipsOnBar.spots[index],
            ),
          ]);
        }).toList(),
        lineTouchData: LineTouchData(
          enabled: true,
          handleBuiltInTouches: false,
          touchTooltipData: LineTouchTooltipData(
            tooltipBgColor: const Color.fromRGBO(96, 125, 139, 1),
            tooltipRoundedRadius: 5,
            getTooltipItems: (List<LineBarSpot> lineBarsSpot) {
              return lineBarsSpot.map((lineBarSpot) {
                return LineTooltipItem(
                  lineBarSpot.y.toString(),
                  const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                );
              }).toList();
            },
          ),
        ),
        titlesData: FlTitlesData(
          show: true,
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              interval: 1,
              getTitlesWidget: bottomTitleWidgets,
            ),
          ),
          leftTitles: const AxisTitles(
            axisNameWidget: SizedBox(),
            sideTitles: SideTitles(
              showTitles: false,
            ),
          ),
          rightTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
          topTitles: const AxisTitles(
            sideTitles: SideTitles(showTitles: false),
          ),
        ),
        borderData: FlBorderData(
          show: true,
          border: Border.all(
            width: 2,
            color: kBorderColor,
          ),
        ),
        minX: 0,
        maxX: (totalScore.length - 1).toDouble(),
        minY: 0,
        maxY: context.read<AppState>().maxTotalScore().toDouble(),
        lineBarsData: lineBarsData);
  }
}
