import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import '../provider/auth_provider.dart';
import 'package:jobhive/component/SearchBar.dart' as custom_search;
import 'package:jobhive/component/profile/posts.dart';
import 'package:jobhive/component/profile/about.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late PageController _pageController;
  int _currentIndex = 0;
  Uint8List? userImage;

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

  final List<Widget> _screens = [
    const ProfilePosts(),
    const ProfileAbout(),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentIndex);
    _loadImage();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    AuthProvider authProvider = Provider.of<AuthProvider>(context);

    String userName =
        authProvider.user!.firstName + " " + authProvider.user!.lastName;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 75,
                  backgroundImage: userImage != null
                      ? MemoryImage(userImage!)
                      : AssetImage('assets/jobhive.png') as ImageProvider,
                ),
                const SizedBox(height: 20),
                Text(
                  userName,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // Handle posts button press
                        setState(() {
                          _currentIndex = 0;
                        });
                      },
                      child: Text('Posts'),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // Handle about button press
                        setState(() {
                          _currentIndex = 1;
                        });
                      },
                      child: Text('About'),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: _screens[_currentIndex],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
