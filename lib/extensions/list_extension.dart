import 'dart:math';

extension ListExtension on List {
    // function to get random {length} element from list 
  List randomList(
    {
    List? exceptionIndex,
    required int length,
  }) {
    final tempList = toList();
    final List result = [];
    //return empty list if length is 0
    if(length == 0) return [];
    // if have unwanted element => remove it from list
    if(exceptionIndex != null ) tempList.removeWhere((element) => exceptionIndex.contains(element));
    //return all list remain if list don't have enough 
    if(tempList.length < length) return tempList;
    // start random until have enough element
    do {
      result.add(tempList.removeAt(Random().nextInt(tempList.length)));
    } while (result.length < length);
    return result;
  }
}