import 'package:flutter/material.dart';
import 'package:jobhive/provider/auth_provider.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:jobhive/repository/post_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

class PostStatusPage extends StatefulWidget {
  const PostStatusPage({super.key});

  @override
  _PostStatusPageState createState() => _PostStatusPageState();
}

class _PostStatusPageState extends State<PostStatusPage> {
  @override
  void initState() {
    super.initState();
    _loadImage();
  }

  void dispose() {
    statusController.dispose();
    super.dispose();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final PostRepository firestorePost = PostRepository();

  TextEditingController statusController = TextEditingController();
  String? selectedPrivacyStatus = 'Public';
  Uint8List? userImage;

  Future<void> _addPost(BuildContext context) async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    try {
      if (statusController.text.isNotEmpty) {
        String userUid = authProvider.user!.uid;
        String user_name =
            authProvider.user!.firstName + " " + authProvider.user!.lastName;
        String user_photo = authProvider.user!.imageLink;
        String caption = statusController.text.trim();
        String postUid =
            FirebaseFirestore.instance.collection('posts').doc().id;
        await firestorePost.addPost(
          userUid,
          caption,
          postUid,
          user_name,
          user_photo,
          selectedPrivacyStatus ?? 'defaultPrivacy',
        );
        statusController.clear();
      }
    } catch (e) {
      print('Error during registration: ${e.toString()}');
    }
  }

  Future<void> _loadImage() async {
    AuthProvider authProvider =
        Provider.of<AuthProvider>(context, listen: false);
    if (authProvider.user != null) {
      String imageUrl = authProvider.user!.imageLink;
      try {
        http.Response response = await http.get(Uri.parse(imageUrl));
        if (response.statusCode == 200) {
          Uint8List imageData = response.bodyBytes;
          setState(() {
            userImage = imageData;
          });
        } else {
          print('Failed to load image: ${response.statusCode}');
        }
      } catch (e) {
        print('Error loading image: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    String userName =
        authProvider.user!.firstName + " " + authProvider.user!.lastName;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1.0,
        title: Text('Create Post', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        actions: <Widget>[
          Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(right: 8.0), // Add right padding here
                child: ElevatedButton(
                  onPressed: () {
                    _addPost(context);
                  },
                  child: Text('Post',
                      style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white)), // Adjust the font size
                  style: ButtonStyle(
                    padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                        EdgeInsets.all(7.0)), // Adjust the padding
                    minimumSize: MaterialStateProperty.all<Size>(
                        Size(60, 20)), // Set the minimum size
                    backgroundColor: MaterialStateProperty.all<Color>(
                        Colors.black), // Set the background color to blue
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      
      body: SingleChildScrollView(child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Card(
              elevation: 4.0,
              color: Colors.white,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        ClipOval(
                          child: userImage != null
                              ? Image.memory(
                                  userImage!,
                                  width: 48.0,
                                  height: 48.0,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/jobhive.png',
                                  width: 48.0,
                                  height: 48.0,
                                  fit: BoxFit.contain,
                                ),
                        ),
                        SizedBox(width: 8.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Text(
                                  userName,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(width: 8.0),
                                DropdownButton<String>(
                                  value: selectedPrivacyStatus,
                                  items: <String?>[
                                    'Public',
                                    'Friends',
                                    'Only Me'
                                  ].map((String? value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Row(
                                        children: <Widget>[
                                          if (value == 'Public')
                                            Icon(Icons.public,
                                                color:
                                                    Colors.grey), // Public icon
                                          if (value == 'Friends')
                                            Icon(Icons.group,
                                                color: Colors
                                                    .grey), // Friends icon
                                          if (value == 'Only Me')
                                            Icon(Icons.lock,
                                                color: Colors
                                                    .grey), // Only Me icon
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      selectedPrivacyStatus = newValue;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 50.0),
                    TextField(
                      controller: statusController,
                      decoration:
                          InputDecoration(labelText: "Start typing ..."),
                      maxLines: null,
                      keyboardType: TextInputType
                          .multiline,
                    ),
                    SizedBox(height: 16.0),
                    Row(
                      children: <Widget>[
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.image), // Icon 1
                        ),
                        SizedBox(width: 16.0), // Spacing
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.calendar_month), // Icon 2
                        ),
                        SizedBox(width: 16.0), // Spacing
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.leaderboard_rounded), // Icon 3
                        ),
                        SizedBox(width: 16.0), // Spacing
                        InkWell(
                          onTap: () {},
                          child: Icon(Icons.more_horiz), // Icon 4
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16.0),
          ],
        ),
      ),
    ));
  }
}
