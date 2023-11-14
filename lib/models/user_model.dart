// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class UserModel {
  final String? uid;
  final String? userName;
  final String? photoURL;
  final String? email;
  int? score;
  UserModel({
    required this.uid,
    required this.userName,
    required this.photoURL,
    required this.email,
    this.score,
  });

  UserModel copyWith({
    String? uid,
    String? userName,
    String? photoURL,
    String? email,
    int? score,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      userName: userName ?? this.userName,
      email: email ?? this.email,
      photoURL: photoURL ?? this.photoURL,
      score: score ?? this.score,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'userName': userName,
      'photoURL': photoURL,
      'score': score,
      'email' : email,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
      uid: map?['uid'] as String,
      userName: map?['userName'] as String,
      photoURL: map?['photoURL'] as String,
      email: map?['email'] as String,
      score: map?['score'] != null ? map!['score'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(uid: $uid, userName: $userName, photoURL: $photoURL, score: $score)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.userName == userName &&
        other.photoURL == photoURL &&
        other.score == score;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        userName.hashCode ^
        photoURL.hashCode ^
        score.hashCode;
  }
}
