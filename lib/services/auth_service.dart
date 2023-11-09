import '../models/User.dart';
import 'dart:typed_data'; // Import the necessary library for Uint8List

class AuthService {
  Future<User?> signIn({
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
    var authenticationIsSuccessful = true;

    if (authenticationIsSuccessful) {
      return User(
        id: userId,
        email: email,
        firstName: firstName,
        imageLink: imageBytes,
        lastName: lastName,
        password: password,
        timestamp: timestamp,
        uid: uid,
        username: username,
      );
    } else {
      return null;
    }
  }
}
