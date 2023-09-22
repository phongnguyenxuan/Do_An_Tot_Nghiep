class CardModel {

  final int id;
  final String imageUrl;
  bool isVisible = true;
  bool isFlipped = false;

  CardModel({
    required this.id,
    required this.imageUrl,
  });
  
  @override
  operator == (Object other) => other is CardModel && other.id == id && other.imageUrl == imageUrl && other.isFlipped == isFlipped;

  @override
  String toString() {
    return "$id : $imageUrl";
  } 
}