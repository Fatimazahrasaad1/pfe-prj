import 'package:flutter/material.dart';

class PasswordProvider extends ChangeNotifier {
  String _oldPassword = '';
  String _newPassword = '';
  String _confirmPassword = '';

  String get oldPassword => _oldPassword;
  String get newPassword => _newPassword;
  String get confirmPassword => _confirmPassword;

  void setOldPassword(String value) {
    _oldPassword = value;
    notifyListeners();
  }

  void setNewPassword(String value) {
    _newPassword = value;
    notifyListeners();
  }

  void setConfirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }

  bool validatePasswords() {
    return _newPassword == _confirmPassword;
  }
}