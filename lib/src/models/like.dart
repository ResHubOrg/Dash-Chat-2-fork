import 'package:cloud_firestore/cloud_firestore.dart';

import '../extensions/map_extensions.dart';

class Like {
  Like({
    this.userId = '',
    this.userType,
    this.userName,
    this.date,
  });

  factory Like.fromMap(Map<String, dynamic> json) {
    return Like(
      userId: json.getValueOrDefault<String>('userId', ''),
      userType: json.getValueOrDefault<String>('userType', ''),
      userName: json.getValueOrDefault<String>('userName', ''),
      date: dateTimeFromTimeStamp(
        time: json.getValueOrNull<Timestamp>('date'),
      ),
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
  DateTime? date;
}

DateTime? dateTimeFromTimeStamp({Timestamp? time}) {
  if (time == null) {
    return null;
  }
  return DateTime.fromMicrosecondsSinceEpoch(time.microsecondsSinceEpoch);
}