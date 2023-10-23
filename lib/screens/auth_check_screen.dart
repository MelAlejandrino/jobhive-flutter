import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'HomeScreen.dart';
import 'Signin.dart';
class AuthCheckScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    if (authProvider.user == null) {
      return SignInScreen();
    } else {
      return HomeScreen();
    }
  }
}