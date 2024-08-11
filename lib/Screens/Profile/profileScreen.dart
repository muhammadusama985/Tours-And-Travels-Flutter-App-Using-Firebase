import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:solosavour/Screens/RegistrationScreens/loginscreen.dart';

class ProfileManagement extends StatefulWidget {
  const ProfileManagement({
    super.key,
  });

  @override
  State<ProfileManagement> createState() => _ProfileManagementState();
}

class _ProfileManagementState extends State<ProfileManagement> {
  late String _profileImageUrl = '';

  @override
  void initState() {
    super.initState();
    _fetchUserData();
  }

  Future<void> _fetchUserData() async {
    try {
      // Fetch user data from Firestore
      DocumentSnapshot userDataSnapshot = await FirebaseFirestore.instance
          .collection('SolortripUserData')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();

      if (userDataSnapshot.exists) {
        // If user data exists, extract the profile image URL
        Map<String, dynamic>? userData =
            userDataSnapshot.data() as Map<String, dynamic>?;

        if (userData != null) {
          setState(() {
            _profileImageUrl =
                userData['imageUrl'] ?? ''; // Assign profile image URL
          });
        }
      } else {
        // Handle case where user data doesn't exist
        print('User data does not exist');
      }
    } catch (e) {
      // Handle errors while fetching user data
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan.shade200,
      appBar: AppBar(
        backgroundColor: Colors.cyan.shade200,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Colors.cyan.shade200,
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 100,
                  backgroundColor: Colors.white,
                  backgroundImage: _profileImageUrl.isNotEmpty
                      ? NetworkImage(_profileImageUrl) // Load image from URL
                      : const AssetImage('assets/images/images.png')
                          as ImageProvider,
                ),
                const SizedBox(height: 20),
                buildContainer("Privacy and Policy", Icons.security,
                    () => const LoginScreen()),
                const SizedBox(height: 20),
                buildContainer(
                    "Share App", Icons.share, () => const LoginScreen()),
                const SizedBox(height: 20),
                buildContainer(
                    "Rate This App", Icons.star, () => const LoginScreen()),
                const SizedBox(height: 20),
                buildContainer("About Us", Icons.info, () {}),
                const SizedBox(height: 20),
                buildContainer(
                    "Feedback", Icons.feedback, () => const LoginScreen()),
                const SizedBox(height: 20),
                buildContainer(
                    "Log Out", Icons.logout, () => const LoginScreen()),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainer(String title, IconData icon, Function() onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 300,
        height: 50,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
              ),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Urbanist-VariableFont_wght.ttf',
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Icon(
                icon,
                color: Colors.cyan.shade200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
