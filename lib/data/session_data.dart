import 'dart:convert';

class SessionData {
  SessionData({required this.userId, required this.token});

  factory SessionData.fromMap(Map<String, dynamic> map) => SessionData(
        userId: map['id'],
        token: map['token'],
      );

  factory SessionData.fromJson(String str) =>
      SessionData.fromMap(json.decode(str));

  int userId;
  String token;

  Map<String, dynamic> toMap() => {
        'userId': userId,
        'token': token,
      };

  String toJson() => json.encode(toMap());
}
