import 'package:flutter/material.dart';

class ProfileProvider extends ChangeNotifier {
  String _profileImagePath = "assets/images/cat.jpeg";

  String get profileImagePath => _profileImagePath;

  void updateProfileImage(String newPath) {
    _profileImagePath = newPath;
    notifyListeners();
  }
}
