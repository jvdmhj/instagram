import 'package:flutter/material.dart';
import 'package:instagram/model/user.dart';
import 'package:instagram/resources/auth_methodes.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMetodes _authMetodes = AuthMetodes();
  User get getuser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMetodes.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
