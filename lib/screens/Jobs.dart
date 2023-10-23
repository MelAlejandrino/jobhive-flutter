import 'package:flutter/material.dart';

class Jobs extends StatefulWidget {
  const Jobs({super.key});

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body:               Text(
                'Jobs Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),),
    );
  }
}