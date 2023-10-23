import 'package:flutter/material.dart';

class Notifications extends StatefulWidget {
  const Notifications({super.key});

  @override
  State<Notifications> createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body:               Text(
                'Notifications Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),),
    );
  }
}