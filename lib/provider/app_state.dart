import 'dart:async';
import 'dart:math';

import 'package:do_an_tot_nghiep/extensions/list_extension.dart';
import 'package:do_an_tot_nghiep/extensions/num_extension.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../configs/constants.dart';
import '../configs/level_config.dart';
import '../functions/power_memo_function.dart';
import '../models/card_model.dart';
import '../models/level_model.dart';
import '../models/questions_model.dart';

class AppState extends ChangeNotifier {
//variable
  late final boxAppData = Hive.box(boxAppSettingName);
  late final boxPlayData = Hive.box(boxPlayDataName);

//? MEMORY MATRIX
  late int _record = boxPlayData.get("record", defaultValue: 0);
  late List<int> listCorrectBlock = [];
  late int _numberBlockCorrect = 3;
  late LevelModel levelModel;

  int get record => _record;

  void generateBlock({int level = 1}) async{
    levelModel = LevelConfig.getLevel(level - 1);
    _numberBlockCorrect = levelModel.correctedCell;
    int blockCount;
    do {
      blockCount = levelModel.blockCount;
    } while (_numberBlockCorrect ~/ blockCount == 1);
    listCorrectBlock = PowerMemoFunctions.generatePlayData(
        levelModel.column, levelModel.row, _numberBlockCorrect, blockCount);
    notifyListeners();
  }

  set record(int level) {
    if (level <= _record) return;
    _record = level;
    boxPlayData.put("record", level);
    notifyListeners();
  }

//?  FIND PAIR
  int _level = 1;
  int _pairCount = 0;
  int _score = 0;
  late int _findPairHighScore = boxPlayData.get("findpair", defaultValue: 0);
  int _findPairScore = 0;
  int _streak = 0;
  int? _previousCardPlay;
  int? _currentCardPlay;
  Timer? _timer;
  List<CardModel> _playList = <CardModel>[];
  bool _isShowingCard = false;
  int _levelTime = 0;

  int get level => _level;
  int get score => _score;
  int get findPairScore => _findPairScore;
  int get showTime => showAllConfig[_pairCount] ?? 4;
  int get streak => _streak;
  int get colCount => levelColConfig[_pairCount] ?? 2;
  int get rowCount => (_pairCount * 2) ~/ colCount;
  int get levelTime => _levelTime;
  bool get isShowingCard => _isShowingCard;
  int get findPairHighScore => _findPairHighScore;
  List<CardModel> get findPairPlayList => _playList;
  set score(int value) {
    _score = max(value, 0);
    notifyListeners();
  }

  List<CardModel> generatePlayList() {
    var randomListUrl = imageUrlList.randomList(length: _pairCount);
    if (randomListUrl.length < _pairCount) {
      randomListUrl +=
          imageUrlList.randomList(length: _pairCount - randomListUrl.length);
    }
    List<CardModel> list = randomListUrl
        .map((e) => CardModel(id: randomListUrl.indexOf(e), imageUrl: e))
        .toList();
    list += randomListUrl
        .map((e) => CardModel(id: randomListUrl.indexOf(e), imageUrl: e))
        .toList();
    list.shuffle();
    return list;
  }

  Future onFlipCard(int index) async {
    if (!_playList[index].isVisible) return;
    _currentCardPlay = index;
    await Future.delayed(const Duration(milliseconds: 10));

    if (_currentCardPlay == index) {
      // Lật thẻ
      _playList[index].isFlipped = true;
      // _audioState?.playClickSound();
      notifyListeners();
      //Chờ animation kết thúc
      await Future.delayed(const Duration(milliseconds: 200));

      //Check nếu không có thẻ nào được mở
      if (_previousCardPlay == null) {
        _previousCardPlay = index;
      } else {
        // Check nếu hai thẻ trùng nhau
        if (_playList[index] == _playList[_previousCardPlay!]) {
          //  _audioState?.playCorrectSound();
          _playList[index].isVisible = false;
          _playList[_previousCardPlay!].isVisible = false;
          _streak++;
          score += 10 + 5 * (_streak - 1);
          _findPairScore = _findPairScore + score;
          if (_findPairScore > _findPairHighScore) {
            _findPairHighScore = _findPairScore;
            boxPlayData.put("findpair", _findPairScore);
          }
          // Nếu không còn thẻ
          if (!_playList.any((element) => element.isVisible)) {
            //  _audioState?.playFinishSound();
            _timer?.cancel();
            _level++;
            await Future.delayed(const Duration(milliseconds: 500));
            fetchLevelData(level);
          }
        } else {
          _playList[index].isFlipped = false;
          _playList[_previousCardPlay!].isFlipped = false;
          _streak = 0;
        }
        _previousCardPlay = null;
      }
      await Future.delayed(const Duration(milliseconds: 200));
      notifyListeners();
    } else {
      _currentCardPlay = null;
      return;
    }
  }

  void resetPlayState() {
    _currentCardPlay = null;
    _previousCardPlay = null;
    _levelTime = levelTimeConfig[_pairCount] ?? 10;
    _isShowingCard = false;
    for (var element in _playList) {
      element.isFlipped = false;
      element.isVisible = true;
    }
    _streak = 0;
    score = 0;
    _playList.shuffle();
    _playList = _playList.map((e) => e).toList();
    notifyListeners();
    _timer?.cancel();
  }

  void clearPlayState() {
    _findPairScore = 0;
    _level = 1;
    fetchLevelData(level);
  }

  void showAllCard() {
    // hien thi cac cap
    for (var element in _playList) {
      element.isFlipped = true;
      element.isVisible = true;
    }
    //
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (showTime == timer.tick) {
        for (var element in _playList) {
          element.isFlipped = false;
        }
        _isShowingCard = true;
        timer.cancel();
        notifyListeners();
      }
    });
    return;
  }

  void fetchLevelData(int level) {
    _pairCount = levelConfig[level] ?? 3;
    _levelTime = levelTimeConfig[level] ?? 10;
    resetPlayState();
    _playList = generatePlayList();
    showAllCard();
  }

  AppState() {
    fetchLevelData(level);
  }

  //? Math game
  final List<QuestionModel> playList = [];
  late int _mathHighScore = boxPlayData.get("math", defaultValue: 0);

  int get mathHighScore => _mathHighScore;

  set mathHighScore(int value) {
    if (value <= _mathHighScore) return;
    _mathHighScore = value;
    boxPlayData.put("math", value);
    notifyListeners();
  }
  
  void generatePlayData({bool shouldNotifyListener = true}) {
    List<QuestionModel> list = [];
    var startNumber = 0;
    var endNumber = 99;
    while(list.length < 100) {
      int firstNumber = Random().nextInt(endNumber - startNumber +1) + startNumber;
      int secondNumber = Random().nextInt(endNumber - startNumber +1) + startNumber;
      var math = ["×", "÷", "+", "−"];
      var element = math[Random().nextInt(math.length)];
      int result = 0;
      switch(element) {
        case "×":
          result = firstNumber * secondNumber;
          break;
        case "÷":
        firstNumber = firstNumber * secondNumber;
        result = (firstNumber  / secondNumber).round();
          break;
        case "+":
          result = firstNumber + secondNumber;
          break;
        case "−":
          result = firstNumber - secondNumber;
          break; 
      }
      var question = QuestionModel(firstNumber: firstNumber, secondNumber: secondNumber, math: element, result: result);
      if(!list.contains(question)) list.add(question);
    }
    playList.clear();
    playList.addAll(list);
  }

  List<int> generateListAnswer(int index) {
    List<int> list = [];
      list.add(playList[index].result.round());
    var range = list[0].getRandomRange();
    while(list.length < 4) {
      var value = (list[0] - (Random().nextInt(range * 2) - range));
      if(list.contains(value)) continue;
      list.add(value);
    }
    list.shuffle();
    return list;
  }  
}
