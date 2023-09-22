import 'dart:math';

extension IntExtend on int {
  int getRandomRange() {
    if(this < 10) return 5;
    return pow(10, toString().length - 1) ~/ 2;
  }
}
extension NumExtension on num {
  double roundTo5() {
    // num a = round();
    // a = a / 10;
    return ((round() / 10 * 2).round() / 2) * 10;
  }
}