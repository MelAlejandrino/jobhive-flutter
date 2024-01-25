import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../provider/auth_provider.dart';
import 'package:http/http.dart' as http;
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
    print(userName);
    print(authProvider.user!.lastName);

    if (userImage == null) {
      _loadImage();
    }

    return MaterialApp(
        home: Scaffold(
            appBar: custom_search.SearchBar() as PreferredSizeWidget?,
            body: Container(
                child: Column(
              children: [
                Row(
                  children: [
                    ClipOval(
                      child: userImage != null
                          ? Image.memory(
                              userImage!,
                              width: 150,
                              height: 150,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/jobhive.png',
                              width: 150,
                              height: 150,
                              fit: BoxFit.contain,
                            ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      userName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                NavigationBar(
                  onDestinationSelected: (int index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  indicatorColor: Colors.amber,
                  selectedIndex: _currentIndex,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
                  destinations: const <Widget>[
                    NavigationDestination(
                      icon: Text('Posts'),
                      label: 'Posts',
                    ),
                    NavigationDestination(
                      icon: Text('About'),
                      label: 'About',
                    ),
                  ],
                ),
                Flexible(
                  child: IndexedStack(
                    index: _currentIndex,
                    children: _screens,
                  ),
                )
              ],
            ))));
  }
}
