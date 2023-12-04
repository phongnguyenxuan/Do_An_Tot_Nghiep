import 'dart:async';
import 'dart:math';
import 'package:do_an_tot_nghiep/configs/basic_config.dart';
import 'package:do_an_tot_nghiep/extensions/list_extension.dart';
import 'package:do_an_tot_nghiep/extensions/num_extension.dart';
import 'package:do_an_tot_nghiep/services/audio_service.dart';
import 'package:do_an_tot_nghiep/services/firestore_services.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../configs/constants.dart';
import '../configs/level_config.dart';
import '../functions/power_memo_function.dart';
import '../models/card_model.dart';
import '../models/level_model.dart';
import '../models/questions_model.dart';
import '../screens/result/result_screen.dart';

class AppState extends ChangeNotifier {
//variable
  final boxAppData = Hive.box(boxAppSettingName);
  final boxPlayData = Hive.box(boxPlayDataName);

//? APP SETTING
  late String _appLanguage;
  late bool _appAudio;

  AppState() {
    _appLanguage = boxAppData.get("language") ?? defaultLanguage;
    _appAudio = boxAppData.get("audio") ?? defaultAudio;
  }

  bool get appAudio {
    return _appAudio;
  }

  set appAudio(bool audio) {
    _appAudio = audio;
    boxAppData.put("audio", audio);
    notifyListeners();
  }

  String get appLanguage {
    return _appLanguage;
  }

  set appLanguage(String language) {
    _appLanguage = language;
    boxAppData.put("language", language);
    notifyListeners();
  }

  Future<void> playSound(String path) async {
    if (_appAudio) {
      AudioService.audioCache.load('$path.mp3');
      AudioService.playShortAudio('$path.mp3');
    }
  }

  playExtraSound(String path) async {
    if (_appAudio) {
      AudioService.audioCache.load('$path.mp3');
      AudioService.playExtraAudio('$path.mp3');
    }
  }

  playBGSound(String path) async {
    if (_appAudio) {
      AudioService.audioCache.load('$path.mp3');
      AudioService.playBGAudio('$path.mp3');
    }
  }

//? MEMORY MATRIX
  late int _memoHighScore =
      boxPlayData.get(memoHighScoreDataName, defaultValue: 0);
  late List<int> _listCorrectBlock = [];
  late int _numberBlockCorrect = 3;
  late LevelModel _levelModel;
  int _currentPlayingIndex = 1;
  bool _isShowCorrect = false;
  bool _isAnimatedGrid = false;
  bool _isPrepareGrid = false;
  Timer? _timer;
  final List<int> _listPickBlockCorrect = [];
  int _indexBlockPickWrong = -1;
  bool _cancelTimer = false;
  bool _canPickBlock = true;
  int _memoScore = 0;
  int _bonus = 0;

  int get memoHighScore => _memoHighScore;
  bool get isShowCorrect => _isShowCorrect;
  bool get isAnimatedGrid => _isAnimatedGrid;
  bool get isPrepareGrid => _isPrepareGrid;
  List<int> get listPickBlockCorrect => _listPickBlockCorrect;
  int get indexBlockPickWrong => _indexBlockPickWrong;
  bool get cancelTimer => _cancelTimer;
  bool get canPickBlock => _canPickBlock;
  int get memoScore => _memoScore;
  LevelModel get levelModel => _levelModel;
  List<int> get listCorrectBlock => _listCorrectBlock;
  int get bonus => _bonus;
  int get currentPlayingIndex => _currentPlayingIndex;

  void generateBlock({int level = 1}) async {
    _isShowCorrect = false;
    _isAnimatedGrid = false;
    _isPrepareGrid = false;
    _listPickBlockCorrect.clear();
    _indexBlockPickWrong = -1;
    _levelModel = LevelConfig.getLevel(level - 1);
    _numberBlockCorrect = _levelModel.correctedCell;
    int blockCount;
    do {
      blockCount = _levelModel.blockCount;
    } while (_numberBlockCorrect ~/ blockCount == 1);
    _listCorrectBlock = PowerMemoFunctions.generatePlayData(
        _levelModel.column, _levelModel.row, _numberBlockCorrect, blockCount);
    notifyListeners();
  }

  void clearMemoState() {
    _isShowCorrect = false;
    _isAnimatedGrid = false;
    _isPrepareGrid = false;
    _listPickBlockCorrect.clear();
    _indexBlockPickWrong = -1;
    _currentPlayingIndex = 1;
    _memoScore = 0;
  }

  void showCorrectBlock() async {
    _isAnimatedGrid = true;
    _isPrepareGrid = true;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 100));
    _isPrepareGrid = false;
    notifyListeners();
    await Future.delayed(const Duration(milliseconds: 1500));
    _isShowCorrect = true;
    notifyListeners();
    _timer = Timer(const Duration(milliseconds: 2000), () {
      _isShowCorrect = false;
      _isAnimatedGrid = false;
      notifyListeners();
    });
  }

  void onPickBlock(int index, BuildContext context) {
    if (_isShowCorrect) return;

    if (_listPickBlockCorrect.contains(index)) return;

    if (_listCorrectBlock.contains(index)) {
      playSound(correctSound);
      _listPickBlockCorrect.add(index);
      listScore.add(1);
      _memoScore += 10;
      notifyListeners();
      if (_listPickBlockCorrect.length == _listCorrectBlock.length) {
        listScore.clear();
        listScore.add(1);
        _canPickBlock = false;
        _cancelTimer = true;
        _bonus = 50;
        _memoScore += bonus;
        _timer = Timer(const Duration(milliseconds: 1500), () {
          _indexBlockPickWrong = -1;
          _listPickBlockCorrect.clear();
          _currentPlayingIndex = _currentPlayingIndex + 1;
          generateBlock(level: _currentPlayingIndex);
          showCorrectBlock();
          _canPickBlock = true;
          _cancelTimer = false;
          _bonus = 0;
        });
        notifyListeners();
      }
      if (_memoScore > _memoHighScore) {
        _memoHighScore = _memoScore;
        boxPlayData.put(memoHighScoreDataName, _memoScore);
      }
    } else {
      playSound(pickSound);
      AudioService.stopBGAudio();
      _canPickBlock = false;
      _indexBlockPickWrong = index;
      _cancelTimer = true;
      _isShowCorrect = true;
      _timer = Timer(const Duration(milliseconds: 2000), () {
        _canPickBlock = true;
        _isShowCorrect = false;
        showResult();
      });
      notifyListeners();
    }
  }

  Future<void> showResult() async {
    boxPlayData.put("memo", _memoScore);
    setTotalScore();
    await navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
        builder: (_) => ResultScreen(
              title: "Memory Matrix",
              grade: _memoScore,
              highscore: _memoHighScore,
              newRecord: (_memoScore >= _memoHighScore),
            ),
        settings: const RouteSettings(name: ResultScreen.id)));
  }

  set memoScore(int value) {
    _score = max(value, 0);
    notifyListeners();
  }

  set record(int score) {
    if (score <= _memoHighScore) return;
    _memoHighScore = score;
    boxPlayData
        .put(memoHighScoreDataName, score)
        .then((value) => setTotalScore());
    notifyListeners();
  }

//?  FIND PAIR
  int _level = 1;
  int _pairCount = 0;
  int _score = 0;
  late int _findPairHighScore =
      boxPlayData.get(findPairHighScoreDataName, defaultValue: 0);
  int _findPairScore = 0;
  int _streak = 0;
  int? _previousCardPlay;
  int? _currentCardPlay;
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
      playSound(pickSound);
      _playList[index].isFlipped = true;
      notifyListeners();
      //Chờ animation kết thúc
      await Future.delayed(const Duration(milliseconds: 200));

      //Check nếu không có thẻ nào được mở
      if (_previousCardPlay == null) {
        _previousCardPlay = index;
      } else {
        // Check nếu hai thẻ trùng nhau
        if (_playList[index] == _playList[_previousCardPlay!]) {
          playSound(correctSound);
          _playList[index].isVisible = false;
          _playList[_previousCardPlay!].isVisible = false;
          _streak++;
          streak > 5
              ? score += 10 + 5 * (5 - 1)
              : score += 10 + 5 * (_streak - 1);
          _findPairScore = _findPairScore + score;
          if (_findPairScore > _findPairHighScore) {
            _findPairHighScore = _findPairScore;
            boxPlayData.put(findPairHighScoreDataName, _findPairScore);
          }
          // Nếu không còn thẻ
          if (!_playList.any((element) => element.isVisible)) {
            _cancelTimer = true;
            _timer?.cancel();
            _level++;
            await Future.delayed(const Duration(milliseconds: 500));
            fetchLevelData(level);
          }
        } else {
          _cancelTimer = false;
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
    // _cancelTimer = false;
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
    _cancelTimer = true;
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
          _cancelTimer = false;
        }
        _isShowingCard = true;
        timer.cancel();
        notifyListeners();
      }
    });
    return;
  }

  Future<void> showResultFindPair(BuildContext context) async {
    boxPlayData.put("findpair", _findPairScore);
    setTotalScore();
    await navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
        builder: (_) => ResultScreen(
              title: "Find Pairs",
              grade: _findPairScore,
              highscore: _findPairHighScore,
              newRecord: (_findPairScore >= _findPairHighScore),
            ),
        settings: const RouteSettings(name: ResultScreen.id)));
  }

  void fetchLevelData(int level) {
    _pairCount = levelConfig[level] ?? 3;
    _levelTime = levelTimeConfig[level] ?? 10;
    resetPlayState();
    _playList = generatePlayList();
    showAllCard();
  }

  //? Math game
  final List<QuestionModel> playList = [];
  late int _mathHighScore =
      boxPlayData.get(mathHighScoreDataName, defaultValue: 0);

  int get mathHighScore => _mathHighScore;

  set mathHighScore(int value) {
    if (value <= _mathHighScore) return;
    _mathHighScore = value;
    boxPlayData.put(mathHighScoreDataName, value);
    // setTotalScore();
    notifyListeners();
  }

  void generatePlayData() {
    List<QuestionModel> list = [];
    var startNumber = 0;
    var endNumber = 20;
    while (list.length < 150) {
      int firstNumber =
          Random().nextInt(endNumber - startNumber + 1) + startNumber;
      int secondNumber =
          Random().nextInt(endNumber - startNumber + 1) + startNumber;
      var math = ["×", "÷", "+", "−"];
      var element = math[Random().nextInt(math.length)];
      int result = 0;
      print("number:$firstNumber  $secondNumber $element");
      switch (element) {
        case "×":
          result = (firstNumber * secondNumber);
          break;
        case "÷":
          if (secondNumber == 0) {
            secondNumber =
                Random().nextInt(endNumber - startNumber + 1) + startNumber;
          }
          firstNumber = firstNumber * secondNumber;
          result = (firstNumber / secondNumber).round();
          break;
        case "+":
          result = (firstNumber + secondNumber);
          break;
        case "−":
          secondNumber =
              Random().nextInt(firstNumber - startNumber + 1) + startNumber;
          result = (firstNumber - secondNumber);
          break;
      }
      var question = QuestionModel(
          firstNumber: firstNumber,
          secondNumber: secondNumber,
          math: element,
          result: result);
      list.add(question);
    }
    playList.clear();
    playList.addAll(list);
  }

  List<int> generateListAnswer(int index) {
    List<int> list = [];
    list.add(playList[index].result.round());
    var range = list[0].getRandomRange();
    while (list.length < 4) {
      var value = (list[0] - (Random().nextInt(range * 2) - range));
      if (list.contains(value)) continue;
      list.add(value);
    }
    list.shuffle();
    return list;
  }

  //? Speed Match
  List<String> listShapes = ["circle", "square", "triangle", "heart"];
  String _type = "";
  String _currentType = "";
  bool _isFlip = false;
  int _speedMatchScore = 0;
  bool _canPick = true;
  final List<int> _listScore = [1];
  bool _isShowing = false;
  late int _speedHighScore =
      boxPlayData.get(speedMatchHighScoreDataName, defaultValue: 0);

  String get type => _type;
  String get currentType => _currentType;
  bool get isFlip => _isFlip;
  int get speedMatchScore => _speedMatchScore;
  bool get canPick => _canPick;
  List<int> get listScore => _listScore;
  bool get isShowing => _isShowing;
  int get speedHighScore => _speedHighScore;

  Future<void> randomType() async {
    await Future.delayed(const Duration(milliseconds: 600));
    _type = listShapes[Random().nextInt(listShapes.length)];
    notifyListeners();
  }

  void delay() {
    _type = listShapes[Random().nextInt(listShapes.length)];
    _isShowing = true;
    _canPick = false;
    notifyListeners();
    Future.delayed(const Duration(seconds: 2), () {
      _isShowing = false;
      _currentType = _type;
      flipCard();
      randomType();
      debugPrint("current: $currentType");
    });
  }

  Future<void> onPickAnswer(bool isTrue) async {
    // score = currentType.compareTo(type).toString();
    if (_currentType.compareTo(_type) == 0 && isTrue == true) {
      playSound(correctSound);
      _streak++;
      _listScore.add(1);
      streak > 5 ? score += 10 + 5 * (5 - 1) : score += 10 + 5 * (_streak - 1);
    } else if (_currentType.compareTo(_type) != 0 && isTrue == false) {
      playSound(correctSound);
      _streak++;
      _listScore.add(1);
      streak > 5 ? score += 10 + 5 * (5 - 1) : score += 10 + 5 * (_streak - 1);
    } else {
      _streak = 0;
      score = 0;
      _listScore.clear();
      _listScore.add(1);
    }
    _speedMatchScore = _speedMatchScore + score;
    _currentType = _type;
    flipCard();
    randomType();
    if (navigatorKey.currentContext!.mounted) {
      notifyListeners();
    }
  }

  Future flipCard() async {
    // Lật thẻ
    //Chờ animation kết thúc
    _canPick = false;
    await Future.delayed(const Duration(milliseconds: 300));
    _isFlip = !_isFlip;
    _canPick = true;
    notifyListeners();
  }

  void resetSpeedMatchState() {
    _speedMatchScore = 0;
    _streak = 0;
    _score = 0;
    _type = "";
    _currentType = "";
    _listScore.clear();
    _listScore.add(1);
  }

  void setSpeedHighScore() {
    if (_speedMatchScore > _speedHighScore) {
      _speedHighScore = _speedMatchScore;
      boxPlayData.put(speedMatchHighScoreDataName, _speedMatchScore);
    }
  }

  Future<void> showResultSpeedMatch(BuildContext context) async {
    boxPlayData.put("speedMatch", _speedMatchScore);
    setTotalScore();
    await navigatorKey.currentState?.pushReplacement(MaterialPageRoute(
        builder: (_) => ResultScreen(
              title: "Speed Match",
              grade: _speedMatchScore,
              highscore: _speedHighScore,
              newRecord: (_speedMatchScore >= _speedHighScore),
            ),
        settings: const RouteSettings(name: ResultScreen.id)));
  }

  //? Total score

  late int _totalScoree = ((boxPlayData.get("memo", defaultValue: 0) +
              boxPlayData.get("findpair", defaultValue: 0) +
              mathHighScore +
              speedHighScore) /
          4)
      .round();
  int get totalScore => _totalScoree;

  set totalScore(int score) {
    _totalScoree = 0;
    notifyListeners();
  }

  late List<int> _listTotalScore = boxPlayData.get("listScore",
      defaultValue: List<int>.empty(growable: true));
  List<int> get listTotalScore => _listTotalScore;
  late int _maxScore = 0;

  void setTotalScore() async {
    final FireStoreServices fireStoreServices = FireStoreServices();
    if (_listTotalScore.isEmpty) {
      _listTotalScore.add(0);
    }
    _totalScoree = ((await boxPlayData.get("memo", defaultValue: 0) +
                (await boxPlayData.get("findpair", defaultValue: 0)) +
                (await boxPlayData.get("math", defaultValue: 0)) +
                (await boxPlayData.get("speedMatch", defaultValue: 0))) /
            4)
        .round();
    if (!FirebaseAuth.instance.currentUser!.isAnonymous && _totalScoree != 0) {
      fireStoreServices.updateScoreToServer(score: _totalScoree);
    }
    _listTotalScore.add(_totalScoree);
    if (_listTotalScore.length > 4) {
      _listTotalScore.removeAt(0);
    }
    await boxPlayData.put("listScore", _listTotalScore);
    _listTotalScore = await boxPlayData.get("listScore");
    notifyListeners();
  }

  int maxTotalScore() {
    List<int> clone = List<int>.from(_listTotalScore);
    clone.sort((a, b) => a.compareTo(b));
    _maxScore = clone.last;
    return _maxScore;
  }
}
