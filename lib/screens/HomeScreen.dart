import 'package:flutter/material.dart';
import 'Home.dart';
import 'Jobs.dart';
import 'Notifications.dart';
import 'Post.dart';
import 'Profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late PageController _pageController;
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Home(),
    const Notifications(),
    PostStatusPage(),
    const Jobs(),
    const Profile(),
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: PageView(
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          children: _screens,
        ),
        bottomNavigationBar: BottomNavigationBar(
          selectedItemColor: const Color.fromARGB(255, 218, 196, 0),
          unselectedItemColor: Colors.black.withOpacity(0.60),
          currentIndex: _currentIndex,
          onTap: (index) {
            _pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          },
          items: [
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 0 ? Icons.home : Icons.home_outlined,
                size: 36.0,
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 1
                    ? Icons.notifications
                    : Icons.notifications_outlined,
                size: 36.0,
              ),
              label: 'Notifications',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 2
                    ? Icons.add_circle
                    : Icons.add_circle_outline,
                size: 36.0,
              ),
              label: 'Post',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 3 ? Icons.work : Icons.work_outline,
                size: 36.0,
              ),
              label: 'Jobs',
            ),
            BottomNavigationBarItem(
              icon: Icon(
                _currentIndex == 4 ? Icons.person : Icons.person_outline,
                size: 36.0,
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
