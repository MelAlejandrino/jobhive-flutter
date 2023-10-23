import '../models/User.dart';

class AuthService {
  Future<User?> signIn() async {
    String userId = "example_user_id";
    String authToken = "example_auth_token";
    var authenticationIsSuccessful = true;

    if (authenticationIsSuccessful) {
      return User(id: userId, token: authToken);
    } else {
      return null;
    }
  }
}