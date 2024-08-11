import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:solosavour/NewRegister/NewLogin.dart';
import 'package:solosavour/animation/animation.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData icon;
  final bool obscureText;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.icon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.grey[200],
          hintText: hintText,
          prefixIcon: Icon(icon, color: Colors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(
              color: Colors.grey,
            ),
          ),
        ),
      ),
    );
  }
}

class NewSignupScreen extends StatefulWidget {
  const NewSignupScreen({
    super.key,
  });

  @override
  _NewSignupScreenState createState() => _NewSignupScreenState();
}

class _NewSignupScreenState extends State<NewSignupScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final bool _obscureText = true;
  bool _isLoading = false;

  File? _image;
  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10, top: 50),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 800),
                  child: RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: 'Solo',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            letterSpacing: 1,
                            color: Colors.black,
                          ),
                        ),
                        TextSpan(
                          text: 'Savour',
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                            fontFamily: "Urbanist-VariableFont_wght.ttf",
                            letterSpacing: 1,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 1400),
                child: Text(
                  "SignUp now",
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 1600),
                child: Text(
                  "Please join us by creating account",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        _pickImage(ImageSource.gallery);
                      },
                      child: AnimatedContainerWithDelay(
                        delay: const Duration(milliseconds: 1800),
                        child: SizedBox(
                          width: 120.w,
                          height: 100.h,
                          child: ClipOval(
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.blue, // Border color
                                  width: 2.0, // Border width
                                ),
                              ),
                              child: _image != null
                                  ? Image.file(
                                      _image!,
                                      fit: BoxFit.cover,
                                    )
                                  : Image.asset(
                                      'assets/images/user.png',
                                      fit: BoxFit.cover,
                                    ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    SizedBox(
                      height: 50.h,
                      child: AnimatedContainerWithDelay(
                        delay: const Duration(milliseconds: 1500),
                        child: CustomTextField(
                          controller: firstNameController,
                          hintText: 'First Name',
                          icon: Icons.person,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50.h,
                      child: AnimatedContainerWithDelay(
                        delay: const Duration(milliseconds: 1700),
                        child: CustomTextField(
                          controller: lastNameController,
                          hintText: 'Last Name',
                          icon: Icons.person,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50.h,
                      child: AnimatedContainerWithDelay(
                        delay: const Duration(milliseconds: 1900),
                        child: CustomTextField(
                          controller: phoneNumberController,
                          hintText: 'Phone Number',
                          icon: Icons.phone,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50.h,
                      child: AnimatedContainerWithDelay(
                        delay: const Duration(milliseconds: 2100),
                        child: CustomTextField(
                          controller: emailController,
                          hintText: 'Email',
                          icon: Icons.email,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      height: 50.h,
                      child: AnimatedContainerWithDelay(
                        delay: const Duration(milliseconds: 2300),
                        child: CustomTextField(
                          controller: passwordController,
                          hintText: 'Password',
                          icon: Icons.lock,
                          obscureText: _obscureText,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 40.h,
                width: 250.w,
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 2500),
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _register,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: _isLoading
                          ? const CircularProgressIndicator()
                          : Text(
                              'Register',
                              style: TextStyle(
                                fontSize: 15.sp,
                                fontFamily: "Urbanist-VariableFont_wght.ttf",
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ),
              ),
              AnimatedContainerWithDelay(
                delay: const Duration(milliseconds: 2700),
                child: Text(
                  'OR',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: Colors.black,
                    fontFamily: "Urbanist-VariableFont_wght.ttf",
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                height: 40.h,
                width: 250.w,
                child: AnimatedContainerWithDelay(
                  delay: const Duration(milliseconds: 2900),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: const NewLoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontFamily: "Urbanist-VariableFont_wght.ttf",
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _register() async {
    try {
      setState(() {
        _isLoading = true;
      });

      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // Check if userCredential is null, meaning the user is already registered
      if (userCredential.user == null) {
        // User is already registered
        Fluttertoast.showToast(
          msg: "User is already registered",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );
        setState(() {
          _isLoading = false;
        });
        return;
      }

      String userId = userCredential.user!.uid;

      Reference storageReference = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('$userId.jpg');
      await storageReference.putFile(_image!);

      String imageUrl = await storageReference.getDownloadURL();

      await FirebaseFirestore.instance.collection('Users').doc(userId).set({
        'firstName': firstNameController.text.trim(),
        'lastName': lastNameController.text.trim(),
        'phoneNumber': phoneNumberController.text.trim(),
        'email': emailController.text.trim(),
        'profileImage': imageUrl,
      });

      setState(() {
        _isLoading = false;
      });

      Fluttertoast.showToast(
        msg: "Account created",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.blue,
        textColor: Colors.white,
      );

      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const NewLoginScreen()),
      );
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
      print('Error registering user: $e');
    }
  }
}
