import 'dart:math';

class LevelModel {
  final int column;
  final int row;
  final int _minCorrectedCell;
  final int _maxCorrectedCell;
  final int _minBlockCount;
  final int _maxBlockCount;

  const LevelModel({
      required this.column, 
      required this.row,
      required int minCorrectedCell,
      required int maxCorrectedCell,
      required int minBlockCount,
      required int maxBlockCount,
    }
  ) : _minCorrectedCell = minCorrectedCell,
    _maxCorrectedCell = maxCorrectedCell,
    _minBlockCount = minBlockCount,
    _maxBlockCount = maxBlockCount;

  int get total => column * row;
  int get correctedCell => (_maxCorrectedCell != _minCorrectedCell) ? Random().nextInt(_maxCorrectedCell - _minCorrectedCell + 1) + _minCorrectedCell : _maxCorrectedCell;
  int get blockCount => (_maxBlockCount != _minBlockCount) ? Random().nextInt(_maxBlockCount - _minBlockCount + 1) + _minBlockCount : _maxBlockCount;

}