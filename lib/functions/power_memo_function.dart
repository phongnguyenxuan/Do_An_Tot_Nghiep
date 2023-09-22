class PowerMemoFunctions {
  static List<int> generatePlayData(int col, int row, int cellCount, int chunkCount) {

    ///get margin list    
    ///ex:
    /// 0, 1, 2, 3, 4
    /// 5, 6, 7, 8, 9
    ///10,11,12,13,14
    ///15,16,17,18,19
    ///20,21,22,23,24
    ///
    ///will return 0,1,2,3,4,5,9,10,14,15,19,20,21,22,23,24
    var marginList = _margin(col, row);
  
    //get size of each block
    var blockLengthList = _calculateBlockCell(cellCount, chunkCount);
    
    var count = 0;
    do {
      count ++;
      List<int> blockedCell = [];
      List<int> listCell = [];
      blockLengthList.shuffle();
      marginList.shuffle();
      for(var i = 0; i< chunkCount; i++) {
        int chunkSize = blockLengthList[i];
        List<int> chunk = [];
        try {
          chunk.add(marginList.where((element) => !blockedCell.contains(element)).first);
        } catch(e) {
          break;
        }
        blockedCell.add(chunk.first);
        int index = 0;
        do {
          var list = _calculateNextCell(chunk[index], blockedCell, col, row );       
          index ++;
          if(list.isEmpty) continue;
          chunk.addAll(list);
          chunk = chunk.toSet().toList();
        } while(chunk.length < chunkSize && index < chunk.length);
        if(chunk.length < chunkSize) {
          break;
        }
        if(chunk.length > chunkSize) {
          chunk.removeRange(chunkSize, chunk.length);
        }
        for(var cell in chunk) {
          blockedCell.addAll(_calculateNextCell(cell, [], col, row));
        }
        blockedCell = blockedCell.toSet().toList();
        listCell.addAll(chunk);
      }
      if(listCell.length == cellCount) return listCell;
    } while(count < 100);
    return [];
  }


  static List<int> _margin(int col, int row) {
    final List<int> list = [];
    list.addAll(List.generate(col, (e) => e));
    list.addAll(List.generate(col, (e) => col*(row - 1 ) + e));
    for(var i = 1; i<= row - 2; i++) {
      list.add(i * col +1);
      list.add(i* col + col);
    }
    list.sort((a,b) => a.compareTo(b));
    return list;
  }

  static List<int> _calculateBlockCell(int cellCount, int blockCount) {
    List<int> list = [];
    int cellPerBlock = cellCount ~/ blockCount;
    int remainder = cellCount % blockCount;
    for(int i = 0; i< remainder; i++) {
      list.add(cellPerBlock + 1);
    }
    for(int i = remainder; i< blockCount; i++) {
      list.add(cellPerBlock);
    }
    
    return list;
  }

  static List<int> _calculateNextCell(int currentCell, List<int> exceptionList, int col, int row,) {
    List<int> nextValues = [currentCell + 1, currentCell - 1, currentCell + row, currentCell - row];
    if((currentCell + 1 ) % row == 0) nextValues.remove(currentCell +1);
    if(currentCell % row == 0) nextValues.remove(currentCell -1);
    nextValues.removeWhere((element) => element < 0 || exceptionList.contains(element) || element > col * row -1);
    nextValues.shuffle();
    return nextValues;
  }
}