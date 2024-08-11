import 'package:flutter/material.dart';
import 'package:solosavour/NewHomeScreen/NewHomeScreen.dart';
import 'package:solosavour/NewProfile/NewProfile.dart';
import 'package:solosavour/PackageScreen/packagescreen.dart';
import 'package:solosavour/trending.dart';

class NewWelcomeScreen extends StatefulWidget {
  const NewWelcomeScreen({super.key});

  @override
  _NewWelcomeScreenState createState() => _NewWelcomeScreenState();
}

class _NewWelcomeScreenState extends State<NewWelcomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const MainHomeScreen(),
    const TrendingTab(),
    const PackageScreen(),
    const NewProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _tabs[_currentIndex],
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.blue,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Trending',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.deblur_outlined),
              label: 'Packages',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
