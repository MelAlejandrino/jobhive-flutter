import 'package:flutter/material.dart';
import 'provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/auth_check_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        home: AuthCheckScreen(),
      ),
    );
  }
}