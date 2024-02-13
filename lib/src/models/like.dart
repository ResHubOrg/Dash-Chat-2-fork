import 'package:cloud_firestore/cloud_firestore.dart';

import '../extensions/map_extensions.dart';

class Like {
  Like({
    required this.userId,
    this.userType,
    this.userName,
    required this.date,
  });

  factory Like.fromMap(Map<String, dynamic> json) {
    return Like(
      userId: json.getValueOrDefault<String>('userId', ''),
      userType: json.getValueOrDefault<String>('userType', ''),
      userName: json.getValueOrDefault<String>('userName', ''),
      date: json.getValueOrNull<Timestamp>('date'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'userType': userType,
      'userName': userName,
      'date': date,
    };
  }

  String userId;
  String? userType;
  String? userName;
  Timestamp? date;
}
