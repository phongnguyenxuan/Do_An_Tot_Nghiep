// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class QuestionModel {
  final int firstNumber;
  final int secondNumber;
  final String math;
  final int result;
  
  QuestionModel({
    required this.firstNumber,
    required this.secondNumber,
    required this.math,
    required this.result,
  });

  QuestionModel copyWith({
    int? firstNumber,
    int? secondNumber,
    String? math,
    int? result,
  }) {
    return QuestionModel(
      firstNumber: firstNumber ?? this.firstNumber,
      secondNumber: secondNumber ?? this.secondNumber,
      math: math ?? this.math,
      result: result ?? this.result,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'firstNumber': firstNumber,
      'secondNumber': secondNumber,
      'math': math,
      'result': result,
    };
  }

  factory QuestionModel.fromMap(Map<String, dynamic> map) {
    return QuestionModel(
      firstNumber: map['firstNumber'] as int,
      secondNumber: map['secondNumber'] as int,
      math: map['math'] as String,
      result: map['result'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuestionModel.fromJson(String source) => QuestionModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'QuestionModel(firstNumber: $firstNumber, secondNumber: $secondNumber, math: $math, result: $result)';
  }

  @override
  bool operator ==(covariant QuestionModel other) {
    if (identical(this, other)) return true;
  
    return 
      other.firstNumber == firstNumber &&
      other.secondNumber == secondNumber &&
      other.math == math &&
      other.result == result;
  }

  @override
  int get hashCode {
    return firstNumber.hashCode ^
      secondNumber.hashCode ^
      math.hashCode ^
      result.hashCode;
  }
}
