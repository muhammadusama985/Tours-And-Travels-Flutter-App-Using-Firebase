import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:marquee/marquee.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/FoodCatagories/FoodCatagories.dart';
import 'package:solosavour/NewDataScreens/rideData1.dart';
import 'package:solosavour/Room/RoomView.dart';
import 'package:solosavour/StuffCatagories/CatagoryStuff/catagoriesstuff.dart';
import 'package:solosavour/communityChat/ChatRoomScreen.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  // ignore: unused_field
  late Animation<Offset> _slideAnimation;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    getUserData();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _slideAnimation = Tween<Offset>(
      begin: const Offset(-1.0, 0.0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _pageController = PageController();
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    _pageController.dispose();
    super.dispose();
  }

  final List<String> imagePaths = [
    'assets/images/sliderimage/slider1.jpg',
    'assets/images/sliderimage/slider2.jpeg',
    'assets/images/slider5.jpg',
    'assets/images/slider1.jpg',
    'assets/images/sliderimage/slider5.jpg',
  ];

  int _currentPage = 0;
  late String _imageUrl = '';
  String _firstName = '';

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // Check if the user signed in with Google
      if (user.providerData
          .any((userInfo) => userInfo.providerId == 'google.com')) {
        // Fetch data from the Google user object
        String? displayName = user.displayName;
        String? photoURL = user.photoURL;

        if (displayName != null) {
          setState(() {
            _firstName = displayName;
          });
        }
        if (photoURL != null) {
          setState(() {
            _imageUrl = photoURL;
          });
        }
      } else {
        // If not signed in with Google, fetch data from Firestore
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('Users')
            .doc(user.uid)
            .get();
        if (userSnapshot.exists) {
          setState(() {
            _firstName = userSnapshot['firstName'];
            _imageUrl = userSnapshot['profileImage'];
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Prevent navigating back using the back button
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, top: 20),
                child: Container(
                  height: 100.h,
                  width: double.infinity, // Set width to occupy available space
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 60.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.blue,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: _imageUrl.isNotEmpty
                              ? Image.network(
                                  _imageUrl,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/user.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      SizedBox(
                        height: 50.h,
                        child: FadeTransition(
                          opacity: _fadeAnimation,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hey👋,',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: "Urbanist-VariableFont_wght.ttf",
                                ),
                              ),
                              Text(
                                _firstName,
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.blue),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: 20.w), // Adjusted width for spacing
                      CircleAvatar(
                        radius: 25,
                        backgroundColor: Colors.white,
                        child: IconButton(
                          icon: const Icon(
                            Icons.chat_sharp,
                            size: 30,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ChatRoomScreen()),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 10),
                child: Column(
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        'Find ',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22.sp,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: FadeTransition(
                        opacity: _fadeAnimation,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: 'best places ',
                                style: TextStyle(
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                    color: Colors.black,
                                    fontSize: 20.sp),
                              ),
                              TextSpan(
                                text: 'with us !',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 20.sp,
                                    fontFamily:
                                        "Urbanist-VariableFont_wght.ttf",
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10.0),
                          border: Border.all(
                            color: Colors.grey,
                            width: 2.0,
                          ),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, color: Colors.grey[600]),
                            const SizedBox(width: 10.0),
                            const Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Container(
                      color: Colors.black,
                      height: 30,
                      child: Marquee(
                        text:
                            '"Embark on Solo Adventures with SoloSavour - Your Companion to Exotic Destinations!"',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            color: Colors.white),
                        scrollAxis: Axis.horizontal,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        blankSpace: 20.0,
                        velocity: 100.0,
                        pauseAfterRound: const Duration(seconds: 1),
                        startPadding: 10.0,
                        accelerationDuration: const Duration(seconds: 1),
                        accelerationCurve: Curves.linear,
                        textDirection: TextDirection.ltr,
                        decelerationDuration: const Duration(milliseconds: 500),
                        decelerationCurve: Curves.easeOut,
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Categories',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildListItem(
                              'assets/images/car.png',
                              'Rides',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const ridedata1(),
                                  ),
                                );
                              },
                            ),
                          ),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildListItem(
                              'assets/images/icons/hotel.png',
                              'Rooms',
                              () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RoomListView()),
                                );
                              },
                            ),
                          ),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildListItem(
                              'assets/images/icons/meal.png',
                              'Food',
                              () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const FoodCatagories()));
                              },
                            ),
                          ),
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: _buildListItem(
                              'assets/images/icons/gadet.png',
                              'Stuff',
                              () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.rightToLeft,
                                        child: const StuffCatagories()));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'Gallery',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(height: 5.h),
                    Column(
                      children: [
                        Container(
                          height: 170.h,
                          width: 400.w,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.grey),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: PageView.builder(
                              controller: _pageController,
                              itemCount: imagePaths.length,
                              onPageChanged: (int page) {
                                setState(() {
                                  _currentPage = page;
                                });
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return Image.asset(
                                  imagePaths[index],
                                  fit: BoxFit.cover,
                                );
                              },
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        _buildPageIndicator(),
                      ],
                    ),
                    // Align(
                    //   alignment: Alignment.centerLeft,
                    //   child: Text(
                    //     'Packages',
                    //     style: TextStyle(
                    //         color: Colors.black,
                    //         fontFamily: "Urbanist-VariableFont_wght.ttf",
                    //         fontSize: 16.sp,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    // ),
                    // SizedBox(height: 5.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPageIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        imagePaths.length,
        (index) => Container(
          width: 8.0,
          height: 8.0,
          margin: const EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: _currentPage == index ? Colors.blueAccent : Colors.grey,
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(String imagePath, String itemName, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 100.h,
        width: 80.w,
        margin: const EdgeInsets.symmetric(horizontal: 2.0),
        decoration: BoxDecoration(
          color: const Color.fromARGB(255, 109, 182, 241),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              height: 60.h,
              width: 60.w,
            ),
            SizedBox(height: 5.h),
            Text(
              itemName,
              style: TextStyle(
                color: Colors.white,
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
