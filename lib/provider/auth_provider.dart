import 'package:flutter/material.dart';
import '../models/User.dart';
import '../services/auth_service.dart';
import 'dart:typed_data';

class AuthProvider with ChangeNotifier {
  User? _user;

  User? get user => _user;

  Future<void> signIn({
    required String userId,
    required String email,
    required String firstName,
    required String imageBytes,
    required String lastName,
    required String password,
    required DateTime timestamp,
    required String uid,
    required String username,
  }) async {
    AuthService authService = AuthService();
    User? user = await authService.signIn(
      userId: userId,
      email: email,
      firstName: firstName,
      imageBytes: imageBytes,
      lastName: lastName,
      password: password,
      timestamp: timestamp,
      uid: uid,
      username: username,
    );

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
