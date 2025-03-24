import 'package:flutter/material.dart';

class PrivacySettingsProvider extends ChangeNotifier {
  bool _isDataSharingEnabled = true;
  bool _isLocationEnabled = true;
  bool _isNotificationsEnabled = true;

  bool get isDataSharingEnabled => _isDataSharingEnabled;
  bool get isLocationEnabled => _isLocationEnabled;
  bool get isNotificationsEnabled => _isNotificationsEnabled;

  void setDataSharingEnabled(bool value) {
    _isDataSharingEnabled = value;
    notifyListeners();
  }

  void setLocationEnabled(bool value) {
    _isLocationEnabled = value;
    notifyListeners();
  }

  void setNotificationsEnabled(bool value) {
    _isNotificationsEnabled = value;
    notifyListeners();
  }
}