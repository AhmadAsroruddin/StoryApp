// To parse this JSON data, do
//
//     final login = loginFromJson(jsonString);

import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'login.g.dart';


Login loginFromJson(String str) => Login.fromJson(json.decode(str));

String loginToJson(Login data) => json.encode(data.toJson());

@JsonSerializable()
class Login {
  Login({
    required this.error,
    required this.message,
    required this.loginResult,
  });

  bool error;
  String message;
  LoginResult loginResult;

  factory Login.fromJson(Map<String, dynamic> json) => _$LoginFromJson(json);

  Map<String, dynamic> toJson() => _$LoginToJson(this);
}

@JsonSerializable()
class LoginResult {
  LoginResult({
    required this.userId,
    required this.name,
    required this.token,
  });

  String userId;
  String name;
  String token;

  factory LoginResult.fromJson(Map<String, dynamic> json) =>
      _$LoginResultFromJson(json);

  Map<String, dynamic> toJson() => _$LoginResultToJson(this);
}
