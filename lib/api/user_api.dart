import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:portfolio/main.dart';
import 'package:portfolio/models/user.dart';

class UserAPI with ChangeNotifier {
  User? _currentUser;
  final _authState = StreamController<User?>();
  late final _authStateQueue = _authState.stream.asBroadcastStream();
  static UserAPI? _instance;
  UserAPI._internal() {
    loginCookie();
  }

  Stream<User?> get authStateQueue async* {
    yield _currentUser;
    yield* _authStateQueue;
  }

  User? get currentUser => _currentUser;
  static UserAPI get instance => _instance ??= UserAPI._internal();
  factory UserAPI() => instance;

  set pushUser(User? newUser) {
    _currentUser = newUser;
    _authState.add(newUser);
    notifyListeners();
  }

  void loginCookie() {
    final url = Uri.parse('${MyApp.monitorUrl}/login/cookies');

    http.get(url).timeout(const Duration(seconds: 5)).then((res) {
      if (res.statusCode != 202) return;
      pushUser = User.fromRawJson(res.body);
    }).onError((error, stackTrace) {
      print('\x1b[41m$error\x1b[0m');
    });
  }

  void logout() {
    final url = Uri.parse('${MyApp.monitorUrl}/logout');
    http.get(url).then((value) => pushUser = null);
  }

  Future<http.Response> login(
      String email, String password, String cfToken) async {
    final url = Uri.parse('${MyApp.monitorUrl}/login');
    try {
      final res = await http.post(url,
          body: jsonEncode({'email': email, 'password': password}),
          headers: {
            'Content-Type': 'application/json',
            'cf-turnstile-response': cfToken
          }).timeout(const Duration(seconds: 5));
      if (res.statusCode == 202) {
        pushUser = User.fromRawJson(res.body);
      }
      return res;
    } catch (e) {
      return http.Response('$e', 408);
    }
  }

  Future<http.Response> signUp(String email, String password) async {
    final url = Uri.parse('${MyApp.monitorUrl}/register');
    try {
      return http.post(url,
          body: jsonEncode({'email': email, 'password': password}),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(const Duration(seconds: 5));
    } catch (e) {
      return http.Response('$e', 408);
    }
  }

  Future<http.Response> sayHello(
      String name, String email, String message) async {
    final url = Uri.parse('${MyApp.monitorUrl}/profile/post');
    try {
      return http.post(url,
          body: jsonEncode({'email': email, 'name': name, 'message': message}),
          headers: {
            'Content-Type': 'application/json'
          }).timeout(const Duration(seconds: 5));
    } catch (e) {
      return http.Response('$e', 408);
    }
  }
}
