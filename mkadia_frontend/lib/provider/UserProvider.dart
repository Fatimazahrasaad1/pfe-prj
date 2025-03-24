import 'package:flutter/material.dart';
import 'package:mkadia/models/user.dart';
import 'package:mkadia/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  String? _token;

  User? get user => _user;
  String? get token => _token;

  void setUser(User user) {
    _user = user;
    notifyListeners();
  }

  void setToken(String token) {
    _token = token;
    notifyListeners();
  }

  Future<void> login(String email, String password) async {
    try {
      final response = await AuthService.login(email, password);

      _user = User.fromJson(response['user']);
      _token = response['token'];

      notifyListeners();
    } catch (e) {
      print('Login error: $e');
      rethrow;
    }
  }

  Future<void> register(String name, String email, String password, String role) async {
    try {
      final response = await AuthService.register(name, email, password, role);

      _user = User.fromJson(response['user']);
      _token = response['token'];

      notifyListeners();
    } catch (e) {
      print('Registration error: $e');
      rethrow;
    }
  }

  Future<void> fetchUser() async {
    try {
      if (_token == null) throw Exception('No token available');

      final userData = await AuthService.fetchUser(_token!);
      _user = User.fromJson(userData);

      notifyListeners();
    } catch (e) {
      print('Fetch user error: $e');
      rethrow;
    }
  }

  void logout() {
    _user = null;
    _token = null;
    notifyListeners();
  }
}
