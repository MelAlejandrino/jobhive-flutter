import 'package:flutter/material.dart';

class Post extends StatefulWidget {
  const Post({super.key});

  @override
  State<Post> createState() => _PostState();
}

class _PostState extends State<Post> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(body:               Text(
                'Post Screen',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),),
    );
  }
}