import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jobhive/firebase_options.dart';
import 'provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'screens/auth_check_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AuthProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(), // Use SplashScreen as the initial screen
      ),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Add a delay to simulate a 3-second splash screen
    Timer(Duration(seconds: 3), () {
      // Navigate to the main screen after the splash screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AuthCheckScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: Tween<double>(begin: 0, end: 1).animate(
            CurvedAnimation(
              curve: Curves.easeInOut,
              parent: ModalRoute.of(context)!.animation!,
            ),
          ),
          child: Image.asset('assets/jobhive.png',
          width: 200.0,
          height: 200.0,
          ), // Change the path accordingly
        ),
      ),
    );
  }
}
