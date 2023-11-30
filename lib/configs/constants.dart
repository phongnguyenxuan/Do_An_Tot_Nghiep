import 'package:hive/hive.dart';

import '../generated/l10n.dart';

const String kfontFamily = "SofiaPro";
const String boxAppSettingName = "app_setting";
const String boxPlayDataName = "play_data";
const String memoHighScoreDataName = "memo_highscsore";
const String findPairHighScoreDataName = "find_pair_highscsore";
const String mathHighScoreDataName = "math_highscsore";
const String speedMatchHighScoreDataName = "speed_match_highscsore";
const List<String> supportedLanguage = ["en", "vi"];
const  String defaultLanguage = 'en';
const bool defaultAudio = true;
var translate = S.current;

//FIND PAIR
const Map<int, int> levelConfig = {
  1 : 3,
  2 : 4,
  3 : 4,
  4 : 6,
  5 : 6,
  6 : 6,
  7 : 8,
  8 : 8,
  9 : 9,
  10 : 9,
  11 : 10,
  12 : 10,
  13 : 12,
  14 : 12,
  15 : 14,
  16 : 14,
  17 : 15,
  18 : 15,
  19 : 18,
  20 : 18,
  21 : 18,
  22 : 20,
  23 : 20,
};
const Map<int,int> showAllConfig = {
  3 : 6,
  4 : 3,
  6 : 4,
  8 : 4,
  9 : 4,
  10 : 5,
  12 : 5,
  14 : 5,
  15 : 6,
  18 : 6,
  20 : 6,
};

const Map<int,int> levelColConfig = {
  3 : 3,
  4 : 4,
  6 : 3,
  8 : 4,
  9 : 3,
  10 : 4,
  12 : 4,
  14 : 4,
  15 : 5,
  18 : 6,
  20 : 7,
};

const Map<int, int> levelTimeConfig = {
  3 : 6,
  4 : 6,
  6 : 8,
  8 : 10,
  9 : 20,
  10 : 25,
  12 : 30,
  14 : 35,
  15 : 40,
  18 : 45,
  20 : 45,
};

List<dynamic> imageUrlList = [
    "assets/images/default_cards/1.png",
    "assets/images/default_cards/2.png",
    "assets/images/default_cards/3.png",
    "assets/images/default_cards/4.png",
    "assets/images/default_cards/5.png",
    "assets/images/default_cards/6.png",
    "assets/images/default_cards/7.png",
    "assets/images/default_cards/8.png",
    "assets/images/default_cards/9.png",
    "assets/images/default_cards/10.png",
    "assets/images/default_cards/11.png",
    "assets/images/default_cards/12.png",
    "assets/images/default_cards/13.png",
    "assets/images/default_cards/14.png",
    "assets/images/default_cards/15.png",
    "assets/images/default_cards/16.png",
    "assets/images/default_cards/17.png",
    "assets/images/default_cards/18.png",
    "assets/images/default_cards/19.png",
    "assets/images/default_cards/20.png",
    "assets/images/default_cards/21.png",
    "assets/images/default_cards/22.png",
    "assets/images/default_cards/23.png",
    "assets/images/default_cards/24.png",
    "assets/images/default_cards/25.png",
    "assets/images/default_cards/26.png",
    "assets/images/default_cards/27.png",
    "assets/images/default_cards/28.png",
    "assets/images/default_cards/29.png",
    "assets/images/default_cards/30.png",
    "assets/images/default_cards/31.png",
    "assets/images/default_cards/32.png",
    "assets/images/default_cards/33.png",
  ];

final boxPlayData = Hive.box(boxPlayDataName);

String correctSound = "correct";
String clickSound = "click";
String pickSound = "pick";
String highScoreSound = "highscore";
String countdownSound = "countdown";
String bgSound = "bg_music";