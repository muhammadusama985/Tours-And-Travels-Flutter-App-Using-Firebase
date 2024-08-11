import 'package:flutter/material.dart';
import 'package:solosavour/NewAccountSelection/NewAccountSelection.dart';
import 'package:solosavour/NewProfile/profile2.dart';
import 'package:solosavour/UserAllServices.dart';

class newAccountSelection1 extends StatefulWidget {
  const newAccountSelection1({super.key});

  @override
  _NewWelcomeScreenState createState() => _NewWelcomeScreenState();
}

class _NewWelcomeScreenState extends State<newAccountSelection1> {
  int _currentIndex = 0;

  final List<Widget> _tabs = [
    const NewAccountSelection(),
    const UserAllServices(),
    const profile2(),
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
              icon: Icon(Icons.person),
              label: 'All bookings',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.trending_up),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}

class TrendingTab extends StatelessWidget {
  const TrendingTab({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Trending '),
    );
  }
}
