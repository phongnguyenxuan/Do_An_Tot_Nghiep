import '../models/level_model.dart';

class LevelConfig {
  
  static LevelModel getLevel(int level) {
    if(level >= 48) return _level48;
    if(level >= 38) return _level38;
    if(level >= 28) return _level28;
    return _levelConfig[level];
  }

  static const List<LevelModel> _levelConfig = [
    _level0,
    _level1,
    _level2,
    _level3,
    _level4,
    _level5,
    _level6,
    _level7,
    _level8,
    _level9,
    _level10,
    _level11,
    _level12,
    _level13,
    _level14,
    _level15,
    _level16,
    _level17,
    _level18,
    _level19,
    _level20,
    _level21,
    _level22,
    _level23,
    _level24,
    _level25,
    _level26,
    _level27,
    _level28,
    _level38,
    _level48,
  ];

  static const LevelModel _level0 = LevelModel(
    column: 3, 
    row: 3, 
    minCorrectedCell: 3, 
    maxCorrectedCell: 3, 
    minBlockCount: 1, 
    maxBlockCount: 1
  );
  static const LevelModel _level1 = LevelModel(
    column: 3, 
    row: 3, 
    minCorrectedCell: 4, 
    maxCorrectedCell: 4, 
    minBlockCount: 2, 
    maxBlockCount: 2
  );
  static const LevelModel _level2 = LevelModel(
    column: 3, 
    row: 4, 
    minCorrectedCell: 4, 
    maxCorrectedCell: 4, 
    minBlockCount: 2, 
    maxBlockCount: 2
  );
  static const LevelModel _level3 = LevelModel(
    column: 3, 
    row: 4, 
    minCorrectedCell: 5, 
    maxCorrectedCell: 5, 
    minBlockCount: 2, 
    maxBlockCount: 2
  );
  static const LevelModel _level4 = LevelModel(
    column: 4, 
    row: 4, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 8, 
    minBlockCount: 1, 
    maxBlockCount: 2
  );
  static const LevelModel _level5 = LevelModel(
    column: 4, 
    row: 4, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 8, 
    minBlockCount: 1, 
    maxBlockCount: 2
  );
  static const LevelModel _level6 = LevelModel(
    column: 4, 
    row: 4, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 8, 
    minBlockCount: 1, 
    maxBlockCount: 2
  );
  static const LevelModel _level7 = LevelModel(
    column: 4, 
    row: 5, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 9, 
    minBlockCount: 2, 
    maxBlockCount: 4
  );
  static const LevelModel _level8 = LevelModel(
    column: 4, 
    row: 5, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 9, 
    minBlockCount: 2, 
    maxBlockCount: 4
  );
  static const LevelModel _level9 = LevelModel(
    column: 4, 
    row: 5, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 9, 
    minBlockCount: 2, 
    maxBlockCount: 4
  );
  static const LevelModel _level10 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 7, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level11 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 7, 
    maxCorrectedCell: 7, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level12 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 8, 
    maxCorrectedCell: 8, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level13 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 10, 
    maxCorrectedCell: 10, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level14 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 9, 
    maxCorrectedCell: 9, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level15 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 11, 
    maxCorrectedCell: 11, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level16 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 12, 
    maxCorrectedCell: 12, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level17 = LevelModel(
    column: 5, 
    row: 5, 
    minCorrectedCell: 9, 
    maxCorrectedCell: 9, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level18 = LevelModel(
    column: 5, 
    row: 6, 
    minCorrectedCell: 9, 
    maxCorrectedCell: 9, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level19 = LevelModel(
    column: 5, 
    row: 6, 
    minCorrectedCell: 10, 
    maxCorrectedCell: 10, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level20 = LevelModel(
    column: 5, 
    row: 6, 
    minCorrectedCell: 8, 
    maxCorrectedCell: 8, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level21 = LevelModel(
    column: 5, 
    row: 6, 
    minCorrectedCell: 11, 
    maxCorrectedCell: 11, 
    minBlockCount: 1, 
    maxBlockCount: 4
  );
  static const LevelModel _level22 = LevelModel(
    column: 5, 
    row: 6, 
    minCorrectedCell: 13, 
    maxCorrectedCell: 13, 
    minBlockCount: 1, 
    maxBlockCount: 2
  );
  static const LevelModel _level23 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 10, 
    maxCorrectedCell: 10, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );
  static const LevelModel _level24 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 12, 
    maxCorrectedCell: 12, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );
  static const LevelModel _level25 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 13, 
    maxCorrectedCell: 13, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );
  static const LevelModel _level26 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 10, 
    maxCorrectedCell: 10, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );
  static const LevelModel _level27 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 13, 
    maxCorrectedCell: 13, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );
  static const LevelModel _level28 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 12, 
    maxCorrectedCell: 12, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );

  static const LevelModel _level38 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 14, 
    maxCorrectedCell: 14, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );

  static const LevelModel _level48 = LevelModel(
    column: 6, 
    row: 6, 
    minCorrectedCell: 15, 
    maxCorrectedCell: 15, 
    minBlockCount: 1, 
    maxBlockCount: 5
  );

}