
const String boxAppSettingName = "app_setting";
const String boxPlayDataName = "play_data";
const List<String> supportedLanguage = ['en','vi'];
const  String defaultLanguage = 'en';
const Map<String, String> languageCodeToName = {
  "en" : "English",
  "vi" : "Tiếng Việt",
};

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
};
const Map<int,int> showAllConfig = {
  3 : 6,
  4 : 3,
  6 : 5,
  8 : 6,
  9 : 7,
  10 : 8,
  12 : 9,
  14 : 10,
  15 : 11,
  18 : 12,
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
  18 : 6
};

const Map<int, int> levelTimeConfig = {
  3 : 5,
  4 : 6,
  6 : 8,
  8 : 10,
  9 : 50,
  10 : 60,
  12 : 100,
  14 : 100,
  15 : 120,
  18 : 120,
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