import 'package:flutter/material.dart';
import 'Home.dart';
import 'Jobs.dart';
import 'Notifications.dart';
import 'Post.dart';
import 'Profile.dart';
import 'package:phosphor_flutter/phosphor_flutter.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Notifications(),
    PostStatusPage(),
    const Jobs(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 218, 196, 0),
          unselectedItemColor: Colors.black.withOpacity(0.60),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.house(),
                  size: 36.0,
                ),
                label: 'Home'),
            BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.bell(),
                  size: 36.0,
                ), label: 'Notifications'),
            BottomNavigationBarItem(
                icon: PhosphorIcon(
                  PhosphorIcons.plusCircle(),
                  size: 36.0,
                ), label: 'Post'),
            BottomNavigationBarItem(icon: PhosphorIcon(
                  PhosphorIcons.briefcase(),
                  size: 36.0,
                ), label: 'Jobs'),
            BottomNavigationBarItem(icon: PhosphorIcon(
                  PhosphorIcons.house(),
                  size: 36.0,
                ), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
