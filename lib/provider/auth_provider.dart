import 'package:flutter/material.dart';
import '../models/User.dart';
import '../services/auth_service.dart';
class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> signIn() async {
    AuthService authService = AuthService();
    User? user = await authService.signIn();

    if (user != null) {
      _user = user;
      notifyListeners();
    }
  }

  void signOut() {
    _user = null;
    notifyListeners();
  }
}
