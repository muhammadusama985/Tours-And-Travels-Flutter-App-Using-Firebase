import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:share_plus/share_plus.dart';
import 'package:solosavour/animation/animation.dart';

class profile2 extends StatefulWidget {
  const profile2({super.key});

  @override
  State<profile2> createState() => _profile2();
}

class _profile2 extends State<profile2> {
  late String _imageUrl = '';
  String _firstName = '';
  bool _userDataFetched = false;
  late String _phoneNumber = '';
  late String _email = '';
  late String? appNamespace;

  @override
  void initState() {
    super.initState();
    _getAppNamespace();
    if (!_userDataFetched) {
      getUserData();
    }
  }

  Future<void> _getAppNamespace() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() => appNamespace = packageInfo.packageName);
  }

  Future<void> onShare(BuildContext context) async {
    if (appNamespace == null) {
      return;
    }
    final box = context.findRenderObject() as RenderBox?;
    String linkToShare =
        "https://play.google.com/store/apps/details?id=$appNamespace";
    String text = "Check out this link: $linkToShare";
    String subject = "Sharing with Friends";

    try {
      await Share.share(
        text,
        subject: subject,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
      );
    } catch (e) {
      print("Error sharing: $e");
    }
  }

  void logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Logout"),
          content: const Text("Are you sure you want to log out?"),
          actions: [
            ElevatedButton.icon(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              icon: const Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              label: const Text(
                'No',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton.icon(
              onPressed: () {
                FirebaseAuth.instance.signOut(); // Sign out the user
                Navigator.of(context).popUntil((route) => route.isFirst);
                // Pop until reaching the first route, which is the loginSignupScreen
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              icon: const Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: const Text(
                'Yes',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> getUserData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('Users2')
          .doc(user.uid)
          .get();
      if (userSnapshot.exists) {
        setState(() {
          _firstName = userSnapshot['firstName'];
          _imageUrl = userSnapshot['profileImage'];
          _phoneNumber = userSnapshot['phoneNumber'];
          _email = userSnapshot['email'];
          _userDataFetched = true;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: Colors.white,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            top: 0,
            child: Container(
              height: 300,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30.0),
                  bottomRight: Radius.circular(30.0),
                ),
              ),
            ),
          ),
          Positioned(
            top: 50,
            right: 10,
            child: IconButton(
              icon: const Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: logout,
            ),
          ),
          Positioned(
            top: 100,
            left: 20,
            child: AnimatedContainerWithDelay(
              delay: const Duration(milliseconds: 800),
              child: Text(
                'Welcome Back,\n$_firstName',
                style: TextStyle(
                  fontSize: 25.sp,
                  fontFamily: "Urbanist-VariableFont_wght.ttf",
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Positioned(
            top: 220,
            left: 30,
            child: Column(
              children: [
                AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 1200),
                  child: Container(
                    height: 150,
                    width: 120,
                    decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: _imageUrl.isNotEmpty
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              _imageUrl,
                              fit: BoxFit.cover,
                            ),
                          )
                        : const Placeholder(),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 400,
            left: 30,
            child: Column(
              children: [
                const SizedBox(height: 10),
                AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 1400),
                  child: CustomContainer(
                    text: 'First Name',
                    iconColor: Colors.blue,
                    icon: Icons.person,
                    actualValues: _firstName,
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 1600),
                  child: CustomContainer(
                    text: 'Email',
                    iconColor: Colors.blue,
                    icon: Icons.email,
                    actualValues: _email,
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 1800),
                  child: CustomContainer(
                    text: 'Phone Number',
                    icon: Icons.phone,
                    iconColor: Colors.blue,
                    actualValues: _phoneNumber,
                  ),
                ),
                const SizedBox(height: 10),
                AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 2000),
                  child: GestureDetector(
                    onTap: () => onShare(context),
                    child: const CustomContainer(
                      text: 'Share App',
                      icon: Icons.share,
                      iconColor: Colors.green,
                      actualValues: 'Share with your circle',
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const AnimatedContainerWithDelay(
                  delay: Duration(milliseconds: 2200),
                  child: CustomContainer(
                    text: 'Rate App',
                    icon: Icons.star,
                    iconColor: Colors.yellow,
                    actualValues: 'Give rating to app!',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final String text;
  final IconData icon;
  final String actualValues;
  final Color iconColor;

  const CustomContainer({
    super.key,
    required this.text,
    required this.icon,
    required this.actualValues,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250.w,
      height: 50.h, // Increased height to accommodate the column
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 7,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          const SizedBox(width: 10),
          Icon(
            icon,
            color: iconColor,
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 15.sp,
                  fontFamily: "Urbanist-VariableFont_wght.ttf",
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 5),
              Text(
                actualValues,
                style: TextStyle(
                    fontSize: 13.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                    color: Colors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
