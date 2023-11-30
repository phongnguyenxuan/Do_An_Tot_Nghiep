import 'package:do_an_tot_nghiep/configs/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const Color kColorPrimary = Color(0xFFFFDB7A);
const Color kBorderColor = Color(0xFF836B41);
const Color kButtonColor = Color(0xFFFFF2D4);
const Color kShadowColor = Color(0xFFE4C36A);
const Color kShadowColor2 = Color(0xFFE7D7BE);
const Color kShadowColor3 = Color(0xFF67A67E);
const Color kColorWhite = Color(0xFFFEFDF7);
const Color kColorBlack = Color.fromARGB(255, 15, 15, 15);
const Color kDisableColor = Color(0xFF968B7E);
const Color kColorGreen = Color(0xFF73C08F);
const Color kColorBlue = Color(0xFF2089E4);
const Color kColorRed = Color(0xFFFE6C56);
const Color kColorLightPrimary = Color(0xFFF9F5EC);
const Color kShadowGreen = Color.fromARGB(255, 70, 114, 86);
const Color kShadowRed = Color.fromARGB(255, 172, 69, 54);
const Color kColorAmber = Color(0xFFFEB704);
const Color kColorGrey = Color(0xFFDFDFDF);
const Color kColorStroke = Color(0xFF836B41);
const Color kColorGreenOpacity = Color(0xFFE1FFEC);
const Color kColorOrangeLight = Color(0xFFFFF4E5);
const Color kColorBrightCyan = Color(0xFF28D9FF);
const Color kShadowBrightCyan = Color(0xFF00A8CD);
const Color kColorRank = Color.fromARGB(255, 240, 231, 180);

const Color kColorOrange = Color(0xFFFEB704);
const Color kTextColorOrange = Color(0xFFF1B81A);
const Color kTextColorBrown = Color(0xFF836B41);
const Color kTextColorBlack = Color(0xFF363637);

const MaterialColor primaryMaterialColor = MaterialColor(0xFFFFDB7A, {
  50: Color(0x1AFFDB7A),
  100: Color(0x33FFDB7A),
  200: Color(0x4DFFDB7A),
  300: Color(0x66FFDB7A),
  400: Color(0x80FFDB7A),
  500: Color(0x99FFDB7A),
  600: Color(0xB3FFDB7A),
  700: Color(0xCCFFDB7A),
  800: Color(0xE6FFDB7A),
  900: Color(0xFFFFDB7A),
});

TextStyle k45SizeBlackColorStyle = TextStyle(
    fontFamily: kfontFamily,
    fontSize: 35.sp,
    color: kColorBlack,
    fontWeight: FontWeight.w700);

TextStyle k45SizePrimaryColorStyle = TextStyle(
    fontFamily: kfontFamily,
    fontSize: 35.sp,
    color: kColorPrimary,
    shadows: const [Shadow(color: kColorBlack, blurRadius: 1)],
    fontWeight: FontWeight.w700);

TextStyle k25SizeBlackColorStyle = TextStyle(
    fontFamily: kfontFamily,
    fontSize: 23.sp,
    color: kColorBlack,
    fontWeight: FontWeight.w700,
    height: 1.5);

TextStyle k15SizeW400BlackColorStyle = TextStyle(
  fontFamily: kfontFamily,
  fontSize: 15.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w200,
);

TextStyle k17SizeW500BlackColorStyle = TextStyle(
    fontFamily: kfontFamily,
    fontSize: 17.sp,
    color: kColorBlack,
    fontWeight: FontWeight.w600,
    height: 1.2);

TextStyle k13SizeW200BlackColorStyle = TextStyle(
  fontFamily: kfontFamily,
  fontSize: 13.sp,
  color: kColorBlack,
  fontWeight: FontWeight.w200,
);

TextStyle kappBarStyle = TextStyle(
  fontFamily: kfontFamily,
  color: Colors.black,
  fontWeight: FontWeight.w400,
  fontSize: 18.sp,
);

TextStyle knormalTextStyle = TextStyle(
  fontFamily: kfontFamily,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
  fontSize: 15.sp,
);

TextStyle k18BlackTextStyle = TextStyle(
  fontSize: 18.sp,
  fontWeight: FontWeight.w700,
  color: kColorBlack,
  fontFamily: kfontFamily
);

TextStyle k16BlackTextStyle = TextStyle(
  fontFamily: kfontFamily,
  color: kColorBlack,
  fontWeight: FontWeight.w500,
  fontSize: 16.sp,
);
