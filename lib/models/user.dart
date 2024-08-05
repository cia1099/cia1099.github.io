import 'dart:convert';

class User {
  final String accessToken;
  final String tokenType;
  final String email;

  User(
      {required this.accessToken,
      required this.tokenType,
      required this.email});

  factory User.fromRawJson(String str) => User.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory User.fromJson(Map<String, dynamic> json) => User(
        accessToken: json["access_token"],
        tokenType: json["token_type"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "access_token": accessToken,
        "token_type": tokenType,
        "email": email,
      };
}
